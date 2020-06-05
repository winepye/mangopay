package kr.co.smartdatacorp.web.controller.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.FileUtil;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.file.FileCriteria;
import kr.co.smartdatacorp.core.vo.file.FileVo;
import kr.co.smartdatacorp.web.bean.util.AsyncMethodBean;
import kr.co.smartdatacorp.web.bean.util.FileMeta;
import kr.co.smartdatacorp.web.bean.util.WebUtil;

@RequestMapping("/common/file")
@Controller
public class FileController extends BaseController{

    @Resource(name = "asyncMethodBean")
    private AsyncMethodBean asyncMethodBean;

    @Resource(name = "fileService")
    private FileService fileService;


    LinkedList<FileMeta> files = new LinkedList<FileMeta>();

    FileMeta fileMeta = null;
    //String uploadPath = messageSource.getMessage("reportupload.editor.image", new String[0], Locale.KOREA);
    String uploadPath;

    protected static final Log logger = LogFactory.getLog(FileController.class);

    /**
     * 파일 업로드(AJAX)
     *
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/uploadAjax.do", method = RequestMethod.POST)
	@ResponseBody
    public Map<String,Object> uploadFileAjax(  @RequestParam(required = false) Integer atchFileGrpSeq
                            ,@RequestParam(required = true) String fileTypeCd
                            ,@RequestParam("file") MultipartFile file
                            ,@RequestParam(value = "file_maxVolume" , required = false) Integer maxVolume
                            ,@RequestParam(value = "fileAllowExtType" , required = false) String fileAllowExtType
                            ,@RequestParam(value = "viewMode" , required = false) String viewMode
                            ,HttpServletRequest request
                            ,HttpServletResponse response
                          ) throws Exception {
	    Map<String,Object> result = new HashMap<String,Object>();

	    Double megaByteSize=file.getSize()*0.00000095367;

	    if(file.getOriginalFilename().lastIndexOf(".") < 0){
            result.put("msg", "파일 형식에 맞지 않습니다.");
            return result;
        }

	    String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toUpperCase();

	    //확장자 체크
	    if(fileAllowExtType!=null&&fileAllowExtType!=""){
	        Field field = Constants.class.getField(fileAllowExtType);
	        String[] fileAllowExtList = ( String[])field.get(null);

	        boolean isAllowExt = false;
	        for(String allowExt : fileAllowExtList){
                if(ext.equals(allowExt.toUpperCase())){
                    isAllowExt= true;
                    break;
                }
            }
	        if(!isAllowExt){
	            result.put("msg", "허용되지 않은 확장자 입니다. ("+ext+")");
                return result;
	        }
	    }else{
	        String[] fileBanExtList = Constants.FILE_DEFAULT_EXT_BLOCK;
	        for(String banExt : fileBanExtList){
	            if(ext.equals(banExt.toUpperCase())){
	                result.put("msg", "허용되지 않은 확장자 입니다. ("+banExt+")");
	                return result;
	            }
	        }
	    }
	    //크기체크
	    if(maxVolume==null || maxVolume ==0||maxVolume>5){
	        maxVolume=5;
        }
	    maxVolume=10;

	    if(maxVolume < megaByteSize){
            result.put("msg", "최대 파일 용량("+maxVolume+ " MB)를 초과하였습니다.");
            return result;
        }

        FileVo fileVo = this.writeFile(atchFileGrpSeq, fileTypeCd, file,ext);

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        fileVo.setLoginSessionInfoFactory(loginSessionInfoFactory);


        fileVo = fileService.createFile(fileVo);

        result.put("result", fileVo);
        if(viewMode!=null&&viewMode.equals(Constants.VIEW_MODE_PDF)){


            String markerImgPath = request.getSession().getServletContext().getRealPath("")+System.getProperty("file.separator")+ messageSource.getMessage("file.watermark.path", new String[]{},Locale.KOREA);

        }
        return result;
    }

    /**
     * 파일 다운로드(AJAX)
     * @param  atchFileSeq
     * @throws Exception
     */
	@RequestMapping(value = "/downloadFile.do", method = {RequestMethod.POST,RequestMethod.GET})
	public void downloadFile(@RequestParam(value = "atchFileSeq" ,required = true) Integer atchFileSeq
	                        ,HttpServletResponse response
	                        ,HttpServletRequest request
	                        )throws Exception{

	    FileCriteria fileCriteria = new FileCriteria();
	    fileCriteria.setAtchFileSeq(atchFileSeq);
	    FileVo fileVo = fileService.getFile(fileCriteria);
	    String filename = fileVo.getFileOrgnNm();
	    System.out.println(request.getHeader("User-Agent"));
	    if(request.getHeader("User-Agent").contains("Trident")||request.getHeader("User-Agent").contains("MSIE")){
	        filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "\\ ");
	    }else if(request.getHeader("User-Agent").contains("Mozilla")) {
	        filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
	    }

	    response.setContentType("application/octet-stream; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setHeader("Content-Transfer-Encoding", "binary");
        try {
    	    File file = new File(fileVo.getPath()+fileVo.getFilePhysNm());
    	    FileCopyUtils.copy(new FileInputStream(file), response.getOutputStream());
        } catch (IOException e) {
            response.setContentType("text/html; charset=\"utf-8\"");
            response.getWriter().println("<script type=\"text/javascript\">alert('"+messageSource.getMessage("fail.common.cannotFindFile" ,new String[]{}, Locale.KOREA)+"');window.close();</script>");
            response.setHeader("Content-Disposition", "");
            response.setHeader("Content-Transfer-Encoding", "");
            response.getWriter().flush();
            response.getWriter().close();
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
	}

    /**
     * 파일 목록 조회(AJAX)
     *
     * @param FileCriteria //검색조건 vo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/getFileListAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getFileListAjax(FileCriteria fileCriteria) throws Exception {
        Map<String,Object> result = new HashMap<String,Object>();

        Map<String,Object> fileVolist = fileService.getFileList(fileCriteria);

        result.put("fileVolist", fileVolist);

        return result;
    }

    /**
     * 파일 삭제(AJAX)
     *
     * @return Map<String,Object>
     * @throws Exception
     */
	@RequestMapping(value = "/deleteAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> deleteFileAjax(@RequestParam(value = "atchFileSeq" ,required = true) Integer atchFileSeq
	                                        ,@RequestParam(value = "viewMode" ,required = true) String viewMode
	                                            ) throws Exception {
        Map<String,Object> result = new HashMap<String,Object>();

        FileVo fileVo = fileService.deleteFile(atchFileSeq);

        result.put("result", Constants.RESULT_SUCCESS);

        /*Ib System Ftp삭제 .....*/
        /*String reportPath= messageSource.getMessage("file.upload.dafaultPath", new String[]{},Locale.KOREA);
        String ibFtpPath= messageSource.getMessage("ftp.ibsystem.url", new String[]{},Locale.KOREA);
        String ibFtpid= messageSource.getMessage("ftp.ibsystem.id", new String[]{},Locale.KOREA);
        String ibFtpPwd= messageSource.getMessage("ftp.ibsystem.pwd", new String[]{},Locale.KOREA);
        String ibFtpPort= messageSource.getMessage("ftp.ibsystem.port", new String[]{},Locale.KOREA);
        asyncMethodBean.ftp_delete(fileVo, reportPath, ibFtpPath, ibFtpid, ibFtpPwd, ibFtpPort);*/

        /*if(viewMode.equals(Constants.VIEW_MODE_PDF)){
            Integer cnt = pdfImgFileService.deleteByAtchFileSeq(atchFileSeq);
            if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
            else result.put("result", Constants.RESULT_FAIL);
        }*/

        return result;
    }

    /**
     * 파일 쓰기(AJAX)
     *
     * @return FileVo
     * @throws Exception
     */
    private FileVo writeFile(Integer atchFileGrpSeq, String fileTypeCd, MultipartFile file,String ext) throws Exception{
        FileVo fileVo = new FileVo();

    	String  fileOrgnNm       = file.getOriginalFilename();
        String  fileContentType  = file.getContentType();
        String  fileMimeType     = (fileContentType.indexOf(".") > 1 ? fileContentType.substring(0,file.getContentType().indexOf(".")) : fileContentType);
        String  fileExt          = ext;
        Long    fileVolume       = file.getSize();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM", Locale.KOREA);
        String  filePhysNm       = System.currentTimeMillis() + fileOrgnNm.substring(fileOrgnNm.lastIndexOf("."));

        Date currentTime = new Date();
        String dTime = formatter.format(currentTime);
        String defaultPath = messageSource.getMessage("file.upload.dafaultPath", new String[]{},Locale.KOREA);
        if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") >= 0)
        {
        }else{
            defaultPath = defaultPath.split("D:")[1];
        }

        String  filePath         = defaultPath+System.getProperty("file.separator")+fileTypeCd+System.getProperty("file.separator") + dTime+System.getProperty("file.separator");

        fileVo.setAtchFileSeq   (null           );
        fileVo.setAtchFileGrpSeq(atchFileGrpSeq );
        fileVo.setFileTypeCd    (fileTypeCd     );
        fileVo.setMimeType      (fileMimeType   );
        fileVo.setExt           (fileExt        );
        fileVo.setVolume        (fileVolume     );
        fileVo.setFileOrgnNm    (fileOrgnNm     );
        fileVo.setFilePhysNm    (filePhysNm     );
        fileVo.setPath          (filePath       );

        //물리파일을 저장한다.
        FileUtil.writeFile(fileVo,file);
        return fileVo;
    }

    /**
     * 에디터이미지업로드(AJAX)
     *
     * @return LinkedList<FileMeta>
     * @throws Exception
     */
    @RequestMapping(value = "/uploadEditorImgAjax.do", method = RequestMethod.POST)
    public @ResponseBody LinkedList<FileMeta> uploadEditorImgAjax(
            MultipartHttpServletRequest request, HttpServletResponse response)
            throws Exception {
       // String targetPath = messageSource.getMessage("file.upload.dafaultPath", new String[]{},Locale.KOREA)+System.getProperty("file.separator")+"editor";

        String targetPath = messageSource.getMessage("file.upload.dafaultPath", new String[]{},Locale.KOREA)+"editor";
        if(System.getProperty("os.name").toUpperCase().indexOf("WINDOWS") >= 0)
        {
        }else{
            targetPath = targetPath.split("D:")[1];
        }

        uploadPath = targetPath;
        files.clear();
        String bufFileNameHead = "editor_";
        String bufFileName = bufFileNameHead + "_"
                + System.currentTimeMillis();
        // 1. build an iterator
        int uploadFileCount = request.getFileMap().size();
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;

        String[] arr_upload_fileList = new String[uploadFileCount];
        String uploadPathFinal = WebUtil.makeUserDir(uploadPath);
        String newFileName = "";

        int i = 0;

        // 2. get each file
        while (itr.hasNext()) {
            // 2.1 get next MultipartFile
            mpf = request.getFile(itr.next());

            // 테스트 페이지에서 파일 없음 처리
            if (mpf.getOriginalFilename().isEmpty())
                continue;

            logger.debug(mpf.getOriginalFilename() + " uploaded! "
                    + files.size());

            // 2.2 if files > 10 remove the first from the list
            if (files.size() >= 10)
                files.pop();
            String bufExt = mpf.getOriginalFilename().substring(
                    mpf.getOriginalFilename().lastIndexOf("."));
            newFileName = WebUtil.makeUserFile(uploadPath, bufFileNameHead,
                    bufFileName, bufExt);

            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM", Locale.KOREA);

            Date currentTime = new Date();
            String dTime = formatter.format(currentTime);

            // 2.3 create new fileMeta
            fileMeta = new FileMeta();
            fileMeta.setFileName(newFileName);
            fileMeta.setFileSize(mpf.getSize() / 1024 + " Kb");
            fileMeta.setFileType(mpf.getContentType());


            arr_upload_fileList[i] = newFileName;
            i++;

            try {
                fileMeta.setBytes(mpf.getBytes());

                FileVo fileVo = this.writeFile(null, "EDT", mpf,bufExt.toUpperCase());

                //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
                fileVo.setLoginSessionInfoFactory(loginSessionInfoFactory);


                fileVo = fileService.createFile(fileVo);
                fileMeta.setAtchFileSeq(fileVo.getAtchFileSeq());
                File dir = new File(uploadPathFinal);
                // copy file to local disk (make sure the path
                // "e.g. D:/temp/files" exists)
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(
                        uploadPathFinal + System.getProperty("file.separator")
                                + newFileName));

            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            // 2.4 add to files
            files.add(fileMeta);
        }
        return files;
    }
}