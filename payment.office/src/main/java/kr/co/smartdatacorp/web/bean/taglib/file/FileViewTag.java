package kr.co.smartdatacorp.web.bean.taglib.file;

import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.file.FileCriteria;
import kr.co.smartdatacorp.core.vo.file.FileVo;
/**
* 파일 업로드를 위한 Tag class <br />
*
* @author
*/
@SuppressWarnings("serial")
public class FileViewTag extends TagSupport  {
    String fileTypeCd;      //파일타입
    Integer atchFileGrpSeq; //파일그룹넘버
    String viewMode;       //뷰어모드
    String viewTitle = "[간편결제]";       //뷰어타이틀
    @Override
    public int doEndTag() throws JspException {
        WebApplicationContext ctx = RequestContextUtils.getWebApplicationContext(pageContext.getRequest(), pageContext.getServletContext());

        //스프링 빈 가져오기 & casting
        FileService fileService = (FileService)ctx.getBean("fileService");

        DecimalFormat df = new DecimalFormat("0.00");
        try {
            FileCriteria fileCriteria = new FileCriteria();

            fileCriteria.setAtchFileGrpSeq(atchFileGrpSeq);
            @SuppressWarnings("unchecked")
            List<FileVo> fileVoList = (List<FileVo>)fileService.getFileList(fileCriteria).get("fileVolist");

            JspWriter out = pageContext.getOut();

            String stStr = "";
            stStr += "<ul class=\"fileList\" id = fileView_"+fileTypeCd+">";
            stStr += "<table>";
            if(fileVoList!=null&&fileVoList.size()>0){

                int cnt = 0;
                for(FileVo fileVo:fileVoList){
                    if(fileVo.getFileTypeCd().equals(fileTypeCd)){

                        if(viewMode!=null && viewMode.equals(Constants.VIEW_MODE_PDF)){
                            stStr += "<tr>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            stStr += "<li>";
                            stStr +=fileVo.getFileOrgnNm();
                            stStr += "</li>";
                            stStr += "</td>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            stStr +="<a href = 'javascript:pdfViewerOpen("+fileVo.getAtchFileSeq()+",\""+viewTitle+"\")' class='btn_repo_view mgl20'>";
                            stStr +="리포트 보기</a>";
                            stStr += "</td>";
                            stStr += "</tr>";
                        }else if(viewMode!=null &&viewMode.equals(Constants.VIEW_MODE_PDF_FILE)){
                            stStr += "<tr>";
                          //stStr +="<a href = 'javascript:downloadFile("+fileVo.getAtchFileSeq()+")'>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            stStr += "<li>";
                            stStr +=fileVo.getFileOrgnNm();
                            stStr += "</li>";
                            stStr += "</td>";
                            //stStr +="<span>"+df.format(fileVo.getVolume()*0.000977)+"KB</span></a>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            stStr +="<a href = 'javascript:pdfViewerOpen("+fileVo.getAtchFileSeq()+",\""+viewTitle+"\")' class='btn_repo_view mgl20'>";
                            stStr +="리포트 보기</a>";
                            stStr +="<a href = 'javascript:downloadFile("+fileVo.getAtchFileSeq()+")' class='btn_repo_down mgl10'>";
                            stStr +="파일다운로드</a>";
                            stStr += "</td>";
                            stStr += "</tr>";

                        }else if(viewMode!=null &&viewMode.equals(Constants.VIEW_MODE_IMG_FILE)){
                            stStr += "<tr>";
                            //stStr +="<a href = 'javascript:downloadFile("+fileVo.getAtchFileSeq()+")'>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            stStr += "<li>";
                            stStr +=fileVo.getFileOrgnNm();
                            stStr += "</li>";
                            stStr += "</td>";
                            //stStr +="<span>"+df.format(fileVo.getVolume()*0.000977)+"KB</span></a>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            stStr +="<a href = 'javascript:imgViewerOpen("+fileVo.getAtchFileSeq()+",\""+viewTitle+"\")' class='btn_repo_view mgl20'>";
                            stStr +="이미지 보기</a>";
                            stStr +="<a href = 'javascript:downloadFile("+fileVo.getAtchFileSeq()+")' class='btn_repo_down mgl10'>";
                            stStr +="파일다운로드</a>";
                            stStr += "</td>";
                            stStr += "</tr>";
                        }else{
                            stStr += "<tr>";
                          //stStr +="<a href = 'javascript:downloadFile("+fileVo.getAtchFileSeq()+")'>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            stStr += "<li>";
                            stStr +=fileVo.getFileOrgnNm();
                            stStr += "</li>";
                            stStr += "</td>";
                            stStr += "<td class= 'fileAttchViewTd'>";
                            //stStr +="<span>"+df.format(fileVo.getVolume()*0.000977)+"KB</span></a>";
                            stStr +="<a href = 'javascript:downloadFile("+fileVo.getAtchFileSeq()+")' class='btn_repo_down mgl10'>";
                            stStr +="파일다운로드</a>";
                            stStr += "</td>";
                            stStr += "</tr>";
                        }
                        //stStr += "<a class='fileDelete2' href='javascript:deleteAtchFile("+fileVo.getAtchFileSeq()+")'><em>삭제</em></a>"
                         stStr += "</li>";
                         cnt ++;
                    }
                }
                /*if(cnt == 0)  stStr += "<tr><td class= 'fileAttchViewTd'><li>첨부된 파일이 없습니다.</li></td></tr>";*/
                if(cnt == 0)  stStr += "";
            }else{
                /*stStr += "<tr><td><li>첨부된 파일이 없습니다.</li></td></tr>";*/
                stStr += "";
            }
            stStr += "</table>";
            stStr += "</ul>";
            out.println(stStr);
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new JspException();
        }
        return EVAL_PAGE;
    }
    public String getFileTypeCd() {
        return fileTypeCd;
    }
    public void setFileTypeCd(String fileTypeCd) {
        this.fileTypeCd = fileTypeCd;
    }
    public Integer getAtchFileGrpSeq() {
        return atchFileGrpSeq;
    }
    public void setAtchFileGrpSeq(Integer atchFileGrpSeq) {
        this.atchFileGrpSeq = atchFileGrpSeq;
    }
    public String getViewMode() {
        return viewMode;
    }
    public void setViewMode(String viewMode) {
        this.viewMode = viewMode;
    }
    public String getViewTitle() {
        return viewTitle;
    }
    public void setViewTitle(String viewTitle) {
        this.viewTitle = viewTitle;
    }

}
