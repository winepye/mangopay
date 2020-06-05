package kr.co.smartdatacorp.web.controller.admin;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.session.LoginSessionInfo;
import kr.co.smartdatacorp.core.dao.PaymentDao;
import kr.co.smartdatacorp.core.service.MenuService;
import kr.co.smartdatacorp.core.service.PaymentService;
import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.board.BoardCriteria;
import kr.co.smartdatacorp.core.vo.code.CodeCriteria;
import kr.co.smartdatacorp.core.vo.code.CodeVo;
import kr.co.smartdatacorp.core.vo.login.LoginCriteria;
import kr.co.smartdatacorp.core.vo.user.UserCriteria;
import kr.co.smartdatacorp.web.controller.common.BaseController;

@RequestMapping("/admin/login")
@Controller("admin.loginController")
public class LoginController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(LoginController.class);

    @Resource(name = "userService")
    private UserService userService;

    @Resource(name = "menuService")
    MenuService menuService;


    /**
     * 관리자 로그인 화면
     * @param loginCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String loginAdmin(@ModelAttribute("loginCriteria") LoginCriteria loginCriteria
                                      ,Model model
                                      ) throws Exception{
        return "admin/login/login"+Constants.ADMIN_EMPTY;
    }

    /**
     * 관리자 로그인(AJAX)
     * @param loginCriteria
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/processAdminLoginAjax.do", method = RequestMethod.POST)
    @ResponseBody
	public Map<String,Object> processWebLoginAjax(@ModelAttribute("loginCriteria") LoginCriteria loginCriteria
	                                  ,HttpServletRequest request
                                      ,Model model
                                      ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

	    UserCriteria userCriteria = new UserCriteria();
	    userCriteria.setSearchUserId(loginCriteria.getSearchUserId());
	    userCriteria.setSearchUserPwd(loginCriteria.getSearchUserPwd());
	    userCriteria.setSessionUserId(loginCriteria.getSearchUserId());

	    log.debug("===> searchUserId"+loginCriteria.getSearchUserId());

	    log.debug("===> sessionUserId"+userCriteria.getSessionUserId());

        String loginIp = request.getHeader("HTTP_X_FORWARDED_FOR");
        if(loginIp == null || loginIp.length() == 0 || loginIp.toLowerCase().equals("unknown")){
            loginIp = request.getHeader("REMOTE_ADDR");
        }

        if(loginIp == null || loginIp.length() == 0 || loginIp.toLowerCase().equals("unknown")){
            loginIp = request.getRemoteAddr();
        }

        String loginResult = userService.processLogin(loginSessionInfoFactory, userCriteria, loginIp);


        if(loginResult.equals(Constants.LOGIN_RESULT_SUCCESS)) {
            result.put("result", Constants.RESULT_SUCCESS);

            //로그인 성공 후 메뉴 및 접근 url 셋팅
            menuService.processLoginMenu(loginSessionInfoFactory);
        }
        else{
            result.put("result", Constants.RESULT_FAIL);
        }

        return result;
    }

    /**
     * 관리자 로그아웃(AJAX)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/processAdminLogoutAjax.do", method = RequestMethod.POST)
    @ResponseBody
	public Map<String,Object> processAdminLogoutAjax(HttpServletRequest request, Model model) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        userService.logout(loginSessionInfoFactory);
        result.put("result", Constants.RESULT_SUCCESS);

        return result;
    }

}
