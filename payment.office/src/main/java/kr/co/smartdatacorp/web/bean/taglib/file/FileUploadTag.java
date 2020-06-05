package kr.co.smartdatacorp.web.bean.taglib.file;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.co.smartdatacorp.core.bean.util.EgovStringUtil;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.file.FileCriteria;
import kr.co.smartdatacorp.core.vo.file.FileVo;
/**
* 파일 업로드를 위한 Tag class <br />
*
* @author
*/
@SuppressWarnings("serial")
public class FileUploadTag extends TagSupport  {
    String fileTypeCd;          //파일타입
    Integer atchFileGrpSeq;     //파일 순번
    Integer maxCount;           //총 갯수
    Integer maxVolume;          //최대용량

    String fileAllowExtType;    //허용 확장자 Constants Key

    String viewMode;            //저장할파일viewType별 선행할 작업이 있다면 해당파라미터를 이용한다.

    @Override
    public int doEndTag() throws JspException {
        try {
            JspWriter out = pageContext.getOut();

            String stStr = "<p class=\"posi_btn\">";
            stStr +=
                    "<div class=\"btn_addFile\" style = 'width:80px;margin-left:15px;margin-bottom:5px;cursor:pointer;' id = \"fileArea_"+fileTypeCd+"\">"
                    +"<input type=\"file\" style = 'position:absolute;margin:0;width:80px; padding:0;margin-left:0px;z-index:1;opacity:0;filter:alpha(opacity:0);cursor:pointer;-ms-filter:\"alpha(opacity=0)\"; -khtml-opacity:0; -moz-opacity:0;' class=\"Add_Files\" name = \"file_"+fileTypeCd+"\" id = \"file_"+fileTypeCd+"\""
                    + " onchange=\"commonFileUploadAjax('file_"+fileTypeCd+"','"+fileTypeCd+"',fileUploadCallback)\">"
                    +"<font style='cursor:pointer'>파일찾기</font>";
            if(this.maxCount!=null){
                stStr += "<input type='hidden' id = 'file_maxCount_"+fileTypeCd+"' value = '"+this.maxCount+"'>";
            }
            if(this.maxVolume!=null){
                stStr += "<input type='hidden' name = 'file_maxVolume_"+fileTypeCd+"' id = 'file_maxVolume_"+fileTypeCd+"' value = '"+this.maxVolume+"'>";
            }
            if(this.fileAllowExtType!=null){
                stStr += "<input type='hidden' name = 'fileAllowExtType' id = 'fileAllowExtType' value = '"+this.fileAllowExtType+"'>";
            }
            if(this.viewMode!=null){
                stStr += "<input type='hidden' name = 'viewMode' id = 'viewMode' value = '"+this.viewMode+"'>";
            }
            stStr +="</div>";
            if(this.atchFileGrpSeq!=null){
                stStr +=this.createFileArea();

                stStr+="<script type=\"text/javascript\">";
                stStr+="if($(\"input[name='atchFileGrpSeq']\").length>0){";
                stStr+="$(\"input[name='atchFileGrpSeq']\").each(function(i){";
                stStr+="if(i!=0) $(this).remove();";
                stStr+="})";
                stStr+="}";
                stStr+="</script>";
            }else{
                stStr += "<ul class=\"fileList\" id = fileView_"+fileTypeCd+">"
                        +""
                        + "</ul>";
            }

            out.println(stStr);
        }
        catch (IOException e) {
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
    public Integer getMaxCount() {
        return maxCount;
    }
    public void setMaxCount(Integer maxCount) {
        this.maxCount = maxCount;
    }

    public Integer getMaxVolume() {
        return maxVolume;
    }
    public void setMaxVolume(Integer maxVolume) {
        this.maxVolume = maxVolume;
    }
    public String getFileAllowExtType() {
        return fileAllowExtType;
    }
    public void setFileAllowExtType(String fileAllowExtType) {
        this.fileAllowExtType = fileAllowExtType;
    }
    public String getViewMode() {
        return viewMode;
    }
    public void setViewMode(String viewMode) {
        this.viewMode = viewMode;
    }
    public String createFileArea(){
        WebApplicationContext ctx = RequestContextUtils.getWebApplicationContext(pageContext.getRequest(), pageContext.getServletContext());

        //스프링 빈 가져오기 & casting
        FileService fileService = (FileService)ctx.getBean("fileService");

        DecimalFormat df = new DecimalFormat("0.00");

        String stStr = "";
        try {
            FileCriteria fileCriteria = new FileCriteria();

            fileCriteria.setAtchFileGrpSeq(atchFileGrpSeq);
            @SuppressWarnings("unchecked")
            List<FileVo> fileVoList = (List<FileVo>)fileService.getFileList(fileCriteria).get("fileVolist");


            stStr += "<ul  class=\"fileList\" id = fileView_"+fileTypeCd+">";
            if(fileVoList!=null&&fileVoList.size()>0){

                for(FileVo fileVo:fileVoList){
                    if(fileVo.getFileTypeCd().equals(fileTypeCd)){
                        stStr += "<li id = 'fileDetail_"+fileVo.getAtchFileSeq()+"'><a href = 'javascript:downloadFile("+fileVo.getAtchFileSeq()+")'>"
                                +fileVo.getFileOrgnNm()
                                +"</a><span>"+df.format(fileVo.getVolume()*0.000977)+"KB</span>";
                         stStr += "<a class='fileDelete' href='#this' onclick='javascript:deleteAtchFile("+fileVo.getAtchFileSeq()+",\""+EgovStringUtil.nvl(viewMode) +"\")'><em>삭제</em></a>";
                         stStr += "</li>";
                    }
                }
                stStr += "</ul>";
                stStr += "<input type = 'hidden' name = 'atchFileGrpSeq' id = 'atchFileGrpSeq'"
                        + " value = '"+this.atchFileGrpSeq+"'>";

            }else{
               // stStr += "첨부된 파일이 없습니다.";
                stStr += "";
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return stStr;
    }

}
