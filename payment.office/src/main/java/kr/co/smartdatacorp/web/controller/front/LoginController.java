package kr.co.smartdatacorp.web.controller.front;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.session.LoginSessionInfo;
import kr.co.smartdatacorp.core.service.MenuService;
import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.login.LoginCriteria;
import kr.co.smartdatacorp.core.vo.popup.PopupCriteria;
import kr.co.smartdatacorp.core.vo.user.UserCriteria;
import kr.co.smartdatacorp.web.controller.common.BaseController;

@RequestMapping("/login")
@Controller("front.loginController")
public class LoginController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(LoginController.class);

    @Resource(name = "userService")
    private UserService userService;

    @Resource(name = "menuService")
    MenuService menuService;


    /**
     * 회원 로그인 화면
     *
     * @param LoginCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/login.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String loginWeb(@ModelAttribute("loginCriteria") LoginCriteria loginCriteria
                                      ,Model model
                                      ) throws Exception{
        return "login/login"+Constants.FRONT_M;
    }

    /**
     * 회원 로그인(AJAX)
     * 로그인이 성공했으면 등급변경내용 중 회원이 확인하지 않은 목록을 가져와서 팝업으로 제공함
     *
     * @param LoginCriteria
     * @return String
     * @throws Exception
     */
	@RequestMapping(value = "/processWebLoginAjax.do", method = RequestMethod.POST)
    @ResponseBody
	public Map<String,Object> processWebLoginAjax(@ModelAttribute("loginCriteria") LoginCriteria loginCriteria
	                                  ,HttpServletRequest request
                                      ,Model model
                                      ) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

	    UserCriteria userCriteria = new UserCriteria();
	    userCriteria.setSearchUserId(loginCriteria.getSearchUserId());
	    userCriteria.setSearchUserPwd(loginCriteria.getSearchUserPwd());

        String loginIp = request.getHeader("HTTP_X_FORWARDED_FOR");
        if(loginIp == null || loginIp.length() == 0 || loginIp.toLowerCase().equals("unknown")){
            loginIp = request.getHeader("REMOTE_ADDR");
        }

        if(loginIp == null || loginIp.length() == 0 || loginIp.toLowerCase().equals("unknown")){
            loginIp = request.getRemoteAddr();
        }

        String loginResult = userService.processLogin(loginSessionInfoFactory, userCriteria, loginIp);

        //로그인성공
        if(loginResult.equals(Constants.LOGIN_RESULT_SUCCESS)) {

            //팝업목록 조회
            LoginSessionInfo loginSessionInfo = loginSessionInfoFactory.getObject();
            PopupCriteria popupCriteria = new PopupCriteria();
            popupCriteria.setSearchPopupLvlTypeCd(loginSessionInfo.getSessionUserTypeCd());
            popupCriteria.setSearchPopupYn(Constants.YES_NO_Y);
            /*List<PopupVo> popupVoList = popupService.getPopupListFront(popupCriteria);
            result.put("popupVoList", popupVoList);*/

            result.put("result", Constants.RESULT_SUCCESS);

            //로그인 성공 후 메뉴 및 접근 url 셋팅
            menuService.processLoginMenu(loginSessionInfoFactory);

            log.info(loginSessionInfoFactory.getObject().toString());
        }else if(loginResult.equals(Constants.LOGIN_RESULT_DORMANT)) {  //2016.08.08.이인희 휴면계정로직추가
            result.put("result", Constants.LOGIN_RESULT_DORMANT);
        }else{  //로그인실패
            result.put("result", Constants.RESULT_FAIL);
        }

        return result;
    }

    /**
     * 회원 로그아웃(AJAX)
     *
     * @param LoginCriteria
     * @return String
     * @throws Exception
     */
	@RequestMapping(value = "/processWebLogoutAjax.do", method = RequestMethod.POST)
    @ResponseBody
	public Map<String,Object> processWebLogoutAjax(HttpServletRequest request, Model model) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        userService.logout(loginSessionInfoFactory);
        result.put("result", Constants.RESULT_SUCCESS);

        return result;
    }

}
