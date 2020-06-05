package kr.co.smartdatacorp.web.bean.interceptor;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.session.LoginSessionInfo;
import kr.co.smartdatacorp.core.bean.util.EgovStringUtil;
import kr.co.smartdatacorp.core.service.MenuService;
import kr.co.smartdatacorp.core.vo.menu.MenuGrpStructVo;

/**
 * 어드민 인터셉터
 * @author 이인희
 * @since 2016.05.16
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.05.16  이인희         최초 생성
 *  </pre>
 */
public class AdminInterceptor extends HandlerInterceptorAdapter {

    protected static final Log logger = LogFactory.getLog(AdminInterceptor.class);

    @Autowired ObjectFactory<LoginSessionInfo> loginSessionInfoFactory;

    @Resource
    MenuService menuService;

    private String location = Constants.LOCATION_ADMIN;

    private String errorUri = "";
    //에러페이지에 보여줄 메세지
    private String msg = "";
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    boolean isPermittedURL = true;
		LoginSessionInfo loginSessionInfo = loginSessionInfoFactory.getObject();
		String requestUri = request.getServletPath();
		errorUri="";

		//어드민 로케이션 정보를 전달한다
        request.setAttribute("reportLocation", location);
      //현재 페이지 url을 전달한다 (jsp나 jstl의 리퀘스트객체는 타일의 영항을 받아 레이아웃을 리턴한다.)
        request.setAttribute("pageUrl", request.getServletPath());

		if(requestUri.indexOf("Index.do")>-1||requestUri.indexOf("/login")>-1||requestUri.equals("/admin"))
            return isPermittedURL;
		if(!loginSessionInfo.getIsLogin()&&loginSessionInfo.getMenuGrpStructVoList()==null){
		    loginSessionInfo.setSessionUserTypeCd(Constants.USER_TYPE_CD_COMPANY);
		  //로그인 성공 후 메뉴 및 접근 url 셋팅
	        String menuResult = menuService.processLoginMenu(loginSessionInfoFactory);

	        if(!menuResult.equals(Constants.RESULT_SUCCESS)) {
	            msg = "사용 가능한 화면이 없습니다. 관리자에게 문의해주세요";
	            isPermittedURL = false;
	        }
		}

        //현재 페이지 url을 전달한다 (jsp나 jstl의 리퀘스트객체는 타일의 영항을 받아 레이아웃을 리턴한다.)
        request.setAttribute("currentUrl", request.getServletPath());

        // 1.권한 체크 및 메뉴ID 셋팅
        if(loginSessionInfo.getMenuGrpStructVoList()!=null){

            //권한체크
            if(!isUrlAccess(requestUri,request)){
                isPermittedURL = false;
            }

        }else{
            msg = "사용 가능한 화면이 없습니다. 관리자에게 문의해주세요";
            //조회할 메뉴가 없으면 접근권한 얼럿
            isPermittedURL = false;
        }

        if(!isPermittedURL){
            interceptorRedirect(request,response,msg,errorUri);
        }
		return isPermittedURL;
	}
	//접근권한 관리
	private boolean isUrlAccess(String requestUri/* , String urlAccessString*/,HttpServletRequest request){
	    LoginSessionInfo loginSessionInfo = loginSessionInfoFactory.getObject();
	    boolean isAccess = false;
	    msg = "접근 권한이 없는 화면입니다.";

	    //메뉴 Object For
	    List<MenuGrpStructVo> menuGrpStructVoList = loginSessionInfo.getMenuGrpStructVoList();

	    for(MenuGrpStructVo menuGrpStructVo:menuGrpStructVoList){
	        if(menuGrpStructVo.getMenuUrl().equals(requestUri)&& menuGrpStructVo.getNodeYn().equals(Constants.YES_NO_Y)){
	                //탑메뉴와 왼쪽메뉴정보를 넘겨준다
                    //메뉴가 로그인이 필요한 메뉴인지 체크한다.
                    if(!loginSessionInfo.getIsLogin()&menuGrpStructVo.getLoginYn().equals(Constants.YES_NO_Y)){
                        msg = "로그인이 필요한 서비스 입니다.";
                        errorUri = "/report/login/login.do";
                        break;
                    }
                    request.setAttribute("topMenuGrpStructSeq", menuGrpStructVo.getTopMenuGrpStructSeq());
                    request.setAttribute("leftMenuSeq", menuGrpStructVo.getParentMenuGrpStructSeq());
                    request.setAttribute("currentUrl",requestUri);
                isAccess = true;
                break;
	        }else if(menuGrpStructVo.getMenuUrl().equals(requestUri)&&menuGrpStructVo.getNodeYn().equals(Constants.YES_NO_N)){
	            continue;
	        }else if(menuGrpStructVo.getMenuUrl().equals(requestUri)){
                if(!loginSessionInfo.getIsLogin()&&menuGrpStructVo.getLoginYn().equals(Constants.YES_NO_Y)){
                    msg = "로그인이 필요한 서비스 입니다.";
                    errorUri = "/report/admin/login/login.do";
                    break;
                }
                if(menuGrpStructVo.getMenuTypeCd().equals("MENU")){
                    isAccess = isUrlAccess2(menuGrpStructVoList,request,EgovStringUtil.nvl(menuGrpStructVo.getBusinessTypeCd()));
                }
                isAccess = true;
                break;
            }

	    }
	    return isAccess;
	}
	//구조화 되지않은 메뉴일경우 업무구분으로 권한을 관리한다.
	private boolean isUrlAccess2(List<MenuGrpStructVo> menuGrpStructVoList,HttpServletRequest request,String businessTypeCd){
        boolean isAccess = false;
        for(MenuGrpStructVo menuGrpStructVo:menuGrpStructVoList){
            if(menuGrpStructVo.getBusinessTypeCd().equals(businessTypeCd)&&EgovStringUtil.nvl(menuGrpStructVo.getNodeYn()).equals(Constants.YES_NO_Y)){
                isAccess =isUrlAccess(menuGrpStructVo.getMenuUrl(),request);
                break;
            }
        }
        return isAccess;

    }

	//에러페이지 이동
	private void interceptorRedirect(HttpServletRequest request,HttpServletResponse response, String msg, String url) throws IOException {
	    LoginSessionInfo loginSessionInfo = loginSessionInfoFactory.getObject();
	    if(!loginSessionInfo.getIsLogin())
	        msg = "로그인이 필요한 서비스 입니다.";

        msg = ("".equals(msg) ? "" : "alert('"+msg+"');");
        url = ("".equals(url) ? "location.href='"+request.getContextPath()+"/admin/login/login.do'" : "location.href='"+url+"';");
        //url = ("".equals(url) ? "location.href='"+request.getContextPath()+"/admin/login/login.do'" : "");
        String ajaxCall = request.getHeader("x-requested-with");
        if (ajaxCall!=null&&ajaxCall.indexOf("XMLHttpRequest")>-1) {
            if(!loginSessionInfo.getIsLogin())
                response.sendError(905);
            else
                response.sendError(901);
        }
        response.setContentType("text/html; charset=\"utf-8\"");
        response.getWriter().println("<script type=\"text/javascript\">"+msg+url+"</script>");
        response.getWriter().flush();
        response.getWriter().close();
    }

}
