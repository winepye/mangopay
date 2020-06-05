package kr.co.smartdatacorp.web.bean.taglib.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.servlet.tags.HtmlEscapingAwareTag;

import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.user.UserCriteria;

/**
* 메뉴 네비게이션 TagLib
*
* @author
*/
public class UserSearchTag extends HtmlEscapingAwareTag {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    //유저 텍스트 박스의 아이디/네임
    private String searchUserNmAttr = "searchUserNm";
    //유저 셀렉트 박스의 아이디/네임
    private String searchUserSeqSelectAttr = "searchUserSeq";

    //유저 텍스트 박스의 value
    private String searchUserNm;
    //유저 셀렉트 박스의 value
    private String searchUserSeq;

    //기업명 인풋박스 css클래스(디폴트값 front)
    private String searchUserNmClass;
    //기업셀렉트박스 css클래스(디폴트값 front)
    private String searchUserSeqClass;
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

        String jspPath = "/WEB-INF/jsp/common/userSearch.jsp";

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();//HttpSession 객체 가져오기

        WebApplicationContext wContext = RequestContextUtils.getWebApplicationContext(request, request.getSession().getServletContext());

        UserService userService= (UserService)wContext.getBean("userService");



        /* 회원정보 조회 :S */
        UserCriteria userCriteria = new UserCriteria();
        /*userCriteria.setSearchUserTypeCd(Constants.USER_TYPE_CD_PARTNER);
        userCriteria.setPagingYn(Constants.YES_NO_N);
        userCriteria.setSearchUserStatusCd(Constants.USER_STATUS_CD_ACTIVE);
        List<EgovMap> userVoList = userService.getUserListEgovMap(userCriteria);*/
        //request.setAttribute("userVoList", userVoList); /* 회원정보 */
        ObjectMapper mapper = null;
        mapper = new ObjectMapper();
        /*String userVoListJson = mapper.writeValueAsString(userVoList);
        request.setAttribute("userVoListJson", userVoListJson);  회원정보 */
        /* 회원정보 조회 :E */

        request.setAttribute("searchUserNmAttr", searchUserNmAttr);
        request.setAttribute("searchUserSeqSelectAttr", searchUserSeqSelectAttr);
        request.setAttribute("searchUserNm", searchUserNm);
        request.setAttribute("searchUserSeq", searchUserSeq);
        request.setAttribute("searchUserNmClass", searchUserNmClass);
        request.setAttribute("searchUserSeqClass", searchUserSeqClass);

        pageContext.include(jspPath);

        return Tag.SKIP_BODY;
    }

    public String getSearchUserNmAttr() {
        return searchUserNmAttr;
    }

    public void setSearchUserNmAttr(String searchUserNmAttr) {
        this.searchUserNmAttr = searchUserNmAttr;
    }

    public String getSearchUserSeqSelectAttr() {
        return searchUserSeqSelectAttr;
    }

    public void setSearchUserSeqSelectAttr(String searchUserSeqSelectAttr) {
        this.searchUserSeqSelectAttr = searchUserSeqSelectAttr;
    }

    public String getSearchUserNm() {
        return searchUserNm;
    }

    public void setSearchUserNm(String searchUserNm) {
        this.searchUserNm = searchUserNm;
    }

    public String getSearchUserSeq() {
        return searchUserSeq;
    }

    public void setSearchUserSeq(String searchUserSeq) {
        this.searchUserSeq = searchUserSeq;
    }

    public String getSearchUserNmClass() {
        return searchUserNmClass;
    }

    public void setSearchUserNmClass(String searchUserNmClass) {
        this.searchUserNmClass = searchUserNmClass;
    }

    public String getSearchUserSeqClass() {
        return searchUserSeqClass;
    }

    public void setSearchUserSeqClass(String searchUserSeqClass) {
        this.searchUserSeqClass = searchUserSeqClass;
    }


}
