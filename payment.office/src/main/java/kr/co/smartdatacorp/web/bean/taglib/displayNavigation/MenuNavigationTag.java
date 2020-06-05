package kr.co.smartdatacorp.web.bean.taglib.displayNavigation;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;


import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.tags.HtmlEscapingAwareTag;

import kr.co.smartdatacorp.core.bean.constant.Constants;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
* 메뉴 네비게이션 TagLib
*
* @author
*/
public class MenuNavigationTag extends HtmlEscapingAwareTag {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    //메뉴 위치
    private String location;

    //현재 url
    private String currentUrl;
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
        if(location.equals(Constants.LOCATION_FRONT)) jspPath = "/WEB-INF/jsp/common/menuNavigationFront.jsp";
        else if(location.equals(Constants.LOCATION_ADMIN)) jspPath = "/WEB-INF/jsp/common/menuNavigationAdmin.jsp";

        request.setAttribute("currentUrl", currentUrl);
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

    public String getCurrentUrl() {
        return currentUrl;
    }

    public void setCurrentUrl(String currentUrl) {
        this.currentUrl = currentUrl;
    }

}
