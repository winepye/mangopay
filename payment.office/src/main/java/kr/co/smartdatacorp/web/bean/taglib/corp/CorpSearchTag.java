package kr.co.smartdatacorp.web.bean.taglib.corp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.tags.HtmlEscapingAwareTag;

/**
* 메뉴 네비게이션 TagLib
*
* @author
*/
public class CorpSearchTag extends HtmlEscapingAwareTag {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    //기업명 텍스트 박스의 아이디/네임
    private String corpNmAttr = "corpNm";
    //기업명 셀렉트 박스의 아이디/네임
    private String corpInfoSeqSelectAttr = "corpInfoSeq";
    //검색 기업의 pool등록 여부
    private String searchPoolYn;
    //기업명 텍스트 박스의 value
    private String corpNm;
    //기업명 셀렉트 박스의 value
    private String corpInfoSeq;

    //기업명 인풋박스 css클래스(디폴트값 front)
    private String corpNmClass;
    //기업셀렉트박스 css클래스(디폴트값 front)
    private String corpInfoSeqClass;
    //기업 셀렉트 박스의 최상단 value값이 ""인 option의 텍스트
    private String firstSel;
    /**
     * 자원을 반환한다.
     */
    @Override
    public void release() {
        super.release();
    }

    @Override
    public int doEndTag() throws JspException {
        return super.doEndTag();
    }

    @Override
    protected int doStartTagInternal() throws Exception {

        String jspPath = "/WEB-INF/jsp/common/corpSearch.jsp";

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();//HttpSession 객체 가져오기

        WebApplicationContext wContext = RequestContextUtils.getWebApplicationContext(request, request.getSession().getServletContext());


        request.setAttribute("corpNmText", corpNmAttr);
        request.setAttribute("corpInfoSeqSelect", corpInfoSeqSelectAttr);
        request.setAttribute("corpNm", corpNm);
        request.setAttribute("corpInfoSeq", corpInfoSeq);
        request.setAttribute("corpNmClass", corpNmClass);
        request.setAttribute("corpInfoSeqClass", corpInfoSeqClass);
        request.setAttribute("firstSel", firstSel);

        pageContext.include(jspPath);

        return Tag.SKIP_BODY;
    }

    public String getCorpNmAttr() {
        return corpNmAttr;
    }

    public void setCorpNmAttr(String corpNmAttr) {
        this.corpNmAttr = corpNmAttr;
    }

    public String getCorpInfoSeqSelectAttr() {
        return corpInfoSeqSelectAttr;
    }

    public void setCorpInfoSeqSelectAttr(String corpInfoSeqSelectAttr) {
        this.corpInfoSeqSelectAttr = corpInfoSeqSelectAttr;
    }

    public String getCorpNm() {
        return corpNm;
    }

    public void setCorpNm(String corpNm) {
        this.corpNm = corpNm;
    }

    public String getCorpInfoSeq() {
        return corpInfoSeq;
    }

    public void setCorpInfoSeq(String corpInfoSeq) {
        this.corpInfoSeq = corpInfoSeq;
    }

    public String getSearchPoolYn() {
        return searchPoolYn;
    }

    public void setSearchPoolYn(String searchPoolYn) {
        this.searchPoolYn = searchPoolYn;
    }

    public String getCorpNmClass() {
        return corpNmClass;
    }

    public void setCorpNmClass(String corpNmClass) {
        this.corpNmClass = corpNmClass;
    }

    public String getCorpInfoSeqClass() {
        return corpInfoSeqClass;
    }

    public void setCorpInfoSeqClass(String corpInfoSeqClass) {
        this.corpInfoSeqClass = corpInfoSeqClass;
    }

    public String getFirstSel() {
        return firstSel;
    }

    public void setFirstSel(String firstSel) {
        this.firstSel = firstSel;
    }



}
