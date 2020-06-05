package kr.co.smartdatacorp.web.bean.interceptor;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.session.LoginSessionInfo;
import kr.co.smartdatacorp.core.bean.util.EgovStringUtil;
import kr.co.smartdatacorp.core.service.MenuService;
import kr.co.smartdatacorp.core.vo.menu.MenuGrpStructVo;

import antlr.collections.Enumerator;

/**
 * 프론트 인터셉터
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
public class FrontInterceptor extends HandlerInterceptorAdapter {

    @Autowired ObjectFactory<LoginSessionInfo> loginSessionInfoFactory;

    @Resource
    MenuService menuService;

    private String location = Constants.LOCATION_FRONT;

    private String errorUri = "";

    private static String redirectUri = "";
    //에러페이지에 보여줄 메세지
    private String msg = "";
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    boolean isPermittedURL = true;

	    String requestUri = request.getServletPath();
	    errorUri="";
	    if(requestUri.startsWith("/admin")) return isPermittedURL;
	    else if(requestUri.indexOf(".front_tlf")>-1||requestUri.indexOf("/homepage/")>-1 ||requestUri.indexOf("/m/")>-1
	            ||requestUri.indexOf("/rest/")>-1 ||requestUri.indexOf("/sample/")>-1 ||requestUri.indexOf("/Logout")>-1 ||requestUri.indexOf("/eventHtml/")>-1){
	        //로케이션 정보를 전달한다
	        request.setAttribute("reportLocation", location);
	        return isPermittedURL;
	    }

	    //로케이션 정보를 전달한다
        request.setAttribute("reportLocation", location);

		LoginSessionInfo loginSessionInfo = loginSessionInfoFactory.getObject();
		if(!loginSessionInfo.getIsLogin()&&loginSessionInfo.getMenuGrpStructVoList()==null){
            loginSessionInfo.setSessionUserTypeCd(Constants.USER_TYPE_CD_COMPANY);
          //로그인 성공 후 메뉴 및 접근 url 셋팅
          menuService.processLoginMenu(loginSessionInfoFactory);

        }
		System.out.println(location+" Interceptor......................................Test");
		System.out.println(request.getServletPath());

		//현재 페이지 url을 전달한다 (jsp나 jstl의 리퀘스트객체는 타일의 영항을 받아 레이아웃을 리턴한다.)
        request.setAttribute("pageUrl", request.getServletPath());

        //권한체크
        if(!isUrlAccess(requestUri,request)){
            isPermittedURL = false;
        }

        if(!isPermittedURL){
            interceptorRedirect(request,response,msg,errorUri);
        }

		return isPermittedURL;
	}
	//접근권한 관리
    private boolean isUrlAccess(String requestUri ,HttpServletRequest request){
        LoginSessionInfo loginSessionInfo = loginSessionInfoFactory.getObject();
        boolean isAccess = false;
        msg = "접근 권한이 없는 화면입니다.";
        //메뉴 Object For
        List<MenuGrpStructVo> menuGrpStructVoList = loginSessionInfo.getMenuGrpStructVoList();

        if(menuGrpStructVoList == null||menuGrpStructVoList.size()==0) return isAccess;

        for(MenuGrpStructVo menuGrpStructVo:menuGrpStructVoList){
            if(menuGrpStructVo.getMenuUrl().equals(requestUri)&&menuGrpStructVo.getNodeYn().equals(Constants.YES_NO_Y)){
                    //탑메뉴와 왼쪽메뉴정보를 넘겨준다
                    request.setAttribute("topMenuGrpStructSeq",menuGrpStructVo.getTopMenuGrpStructSeq());
                    request.setAttribute("leftMenuSeq",menuGrpStructVo.getParentMenuGrpStructSeq());
                    request.setAttribute("currentUrl",requestUri);

                    //메뉴가 로그인이 필요한 메뉴인지 체크한다.
                    if(!loginSessionInfo.getIsLogin()&&menuGrpStructVo.getLoginYn().equals(Constants.YES_NO_Y)){
                        this.createErrorUrl(requestUri,request);
                        break;
                    }
                isAccess = true;
                break;
            }else if(menuGrpStructVo.getMenuUrl().equals(requestUri)&&menuGrpStructVo.getNodeYn().equals(Constants.YES_NO_N)){
                continue;
            }else if(menuGrpStructVo.getMenuUrl().equals(requestUri)){
                if(!loginSessionInfo.getIsLogin()&&menuGrpStructVo.getLoginYn().equals(Constants.YES_NO_Y)){

                    this.createErrorUrl(requestUri,request);
                    if(menuGrpStructVo.getMenuTypeCd().equals("MENU")){
                        isAccess = isUrlAccess2(menuGrpStructVoList,request,menuGrpStructVo.getBusinessTypeCd());
                    }
                    break;
                }
                if(menuGrpStructVo.getMenuTypeCd().equals("MENU")){
                    isAccess = isUrlAccess2(menuGrpStructVoList,request,menuGrpStructVo.getBusinessTypeCd());
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
    //에러페이지 이동을 위한 데이터를 만든다
    private void createErrorUrl(String requestUri,HttpServletRequest request){
        msg = "로그인이 필요한 서비스 입니다.";
        /*if(requestUri.indexOf("Ajax")>-1){
            requestUri = request.getContextPath()+"/myPage/main/myPage.do";
        }*/
        redirectUri = requestUri;
        errorUri = request.getContextPath()+"/login/login.do";
    }
    //에러페이지 이동
    private static void interceptorRedirect(HttpServletRequest request,HttpServletResponse response, String msg, String url) throws IOException {
        msg = ("".equals(msg) ? "" : "alert('"+msg+"');");
        url = ("".equals(url) ? request.getContextPath()+"/main/main.do'" : url);
        String ajaxCall = request.getHeader("x-requested-with");
        if (ajaxCall!=null&&ajaxCall.indexOf("XMLHttpRequest")>-1) {
            if(url.indexOf("login.do")>0)
                response.sendError(900);
            else
                response.sendError(901);
        }
            response.setContentType("text/html; charset=\"utf-8\"");
            response.getWriter().println("<html>");
            response.getWriter().println("  <form id = 'errorFrm' name='errorFrm' method = 'post' action = '"+url+"'>");

            if(!redirectUri.equals("")){
                response.getWriter().println("  <input type = 'hidden' name = 'searchRedirectUrl' value='"+redirectUri+"'>");
            }

            response.getWriter().println("  </form>");
            response.getWriter().println("</html>");
            response.getWriter().println("<script type=\"text/javascript\">"+msg+"document.errorFrm.submit();</script>");
            response.getWriter().flush();
            response.getWriter().close();
    }

}
