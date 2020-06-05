package kr.co.smartdatacorp.web.bean.taglib.displayNavigation;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

import org.springframework.web.servlet.tags.HtmlEscapingAwareTag;

import kr.co.smartdatacorp.core.bean.constant.Constants;

/**
* 메뉴 네비게이션 TagLib
*
* @author
*/
public class JspTitleTag extends HtmlEscapingAwareTag {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    //메뉴 위치
    private String location = Constants.LOCATION_FRONT;

    //현재 url
    private String pageUrl;
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
        ServletRequest request = pageContext.getRequest();

        String jspPath = "";
        if(location.equals(Constants.LOCATION_FRONT)) jspPath = "/WEB-INF/jsp/common/jspTitleFront.jsp";

        request.setAttribute("pageUrl", pageUrl);
        request.setAttribute("reportLocation", location);

        pageContext.include(jspPath);

        return Tag.SKIP_BODY;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPageUrl() {
        return pageUrl;
    }

    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl;
    }



}
