package kr.co.smartdatacorp.web.controller.front;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.service.BoardService;
import kr.co.smartdatacorp.core.service.ReqMessageService;
import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.user.UserCriteria;
import kr.co.smartdatacorp.core.vo.user.UserVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;

/**
*
* Report List Controller 클래스
* @author 이인희
* @since 2016.05.04
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자                   수정내용
*  -------      --------    ---------------------------
*   2016.05.09  이인희                   최초 생성
*
* </pre>
*/
@RequestMapping("/myPage")
@Controller("front.MyPageController")
public class MyPageController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(MyPageController.class);

    /**
     * 회원 서비스
     */
    @Resource(name = "userService")
    private UserService userService;

    /**
     * 게시판 서비스
     */
    @Resource(name = "boardService")
    private BoardService boardService;
    /**
     * 메세지 충전내역
     */
    @Resource(name = "reqMessageService")
    private ReqMessageService reqMessageService;

    /**
     * MyPage 메인 화면
     *
     * @param
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/main/myPage.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getMyPage(Model model) throws Exception{

        //리턴 페이지(파트너회원과 일반회원의 jsp)
        String returnPage = "";
        Map<String,Object> result = new HashMap<String,Object>();

        //회원정보
        UserCriteria userCriteria = new UserCriteria();
        userCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);
        userCriteria.setSearchUserInfoId(userCriteria.getSessionUserInfoId());
        EgovMap userVo = userService.getUserDetail(userCriteria);
        result.put("userVo", userVo);

        //리턴할 페이지를 나눈다.파트너 회원인 경우 탐방일정 ,예약목록 , 풀등록요청 데이터를 넘긴다.
        if(loginSessionInfoFactory.getObject().getSessionUserTypeCd().equals(Constants.USER_TYPE_CD_PARTNER)){
          //탐방일정
            Map<String,Object> calendarMap = new HashMap<String, Object>();
            Calendar calendar = Calendar.getInstance();

            //화면에서 컨트롤할 달력 을 표현할 요일 숫자를 만든다.
            int nowWeek = 0;
            int calendarWeek = calendar.get(Calendar.DAY_OF_WEEK);
            if(calendarWeek == 1) nowWeek = 7;
            else nowWeek = calendarWeek-1;

            calendar.set(Calendar.DATE, 1);
            calendarMap.put("nowWeek", nowWeek);
            calendarMap.put("maximumDate", calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            calendarMap.put("year", calendar.get(Calendar.YEAR));
            calendarMap.put("month", calendar.get(Calendar.MONTH)+1);


            //화면에서 컨트롤할 달력 을 표현할 요일 숫자를 만든다.
            int startWeek = 0;
            calendarWeek = calendar.get(Calendar.DAY_OF_WEEK);
            if(calendarWeek == 1) startWeek = 7;
            else startWeek = calendarWeek-1;

            calendarMap.put("startWeek", startWeek);

            //지난달 마지막날을 구한다.
            calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH)+1);
            calendarMap.put("laxtMaximumDate", calendar.getActualMaximum(Calendar.DAY_OF_MONTH));

            result.put("calendarMap", calendarMap);
            returnPage = "myPage/partnerMyPage"+Constants.FRONT_TF;
            //returnPage = "myPage/generalMyPage"+Constants.FRONT_TF;
        }else if(loginSessionInfoFactory.getObject().getSessionUserTypeCd().equals(Constants.USER_TYPE_CD_COMPANY)){
            returnPage = "myPage/companyMyPage"+Constants.FRONT_TF;
        }else{
            returnPage = "myPage/generalMyPage"+Constants.FRONT_TF;
        }
        model.addAttribute("result", result);
        return returnPage;
    }

    /**
     * 회원정보 변경 화면
     *
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/userInfo/userInfoModify.do", method = {RequestMethod.POST} )
    public String modifyuserInfo(Model model,HttpSession session , HttpServletRequest request
                             ) throws Exception{
        if(session.getAttribute("isPasswordConfirm")==null||!String.valueOf(session.getAttribute("isPasswordConfirm")).equals(Constants.YES_NO_Y)){
            return "redirect:"+request.getServletPath();
        }
        session.setAttribute("isPasswordConfirm", Constants.YES_NO_N);

        //회원정보 조회
        UserCriteria userCriteria = new UserCriteria();
        userCriteria.setSearchUserId(loginSessionInfoFactory.getObject().getSessionUserId());
        userCriteria.setSearchUserInfoId(loginSessionInfoFactory.getObject().getSessionUserInfoId());
        EgovMap userVo = userService.getUserDetail(userCriteria);

        model.addAttribute("userVo", userVo);
        return "myPage/userInfoModify"+Constants.FRONT_TLF;
    }

    /**
     * 비밀번호 변경 비밀번호 확인 화면
     *
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = {"/password/passwordModify.do","/accountInfo/accountInfoModify.do","/userInfo/userInfoModify.do"}, method = {RequestMethod.GET} )
    public String confirmPassword(Model model
                                 ,HttpServletRequest request
                             ) throws Exception{
        model.addAttribute("url", request.getServletPath());
        return "myPage/passwordConfirm"+Constants.FRONT_TLF;
    }

    ////////////////////////////////////////
    ///////////////////////////////////////
    /**
     * 비밀번호 확인(AJAX)
     *
     * @param Model
     * @param UserCriteria
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/password/confirmPasswordAjax.do", method = { RequestMethod.POST })
    @ResponseBody
    public Map<String,Object> confirmPasswordAjax(UserCriteria userCriteria , HttpSession session) throws Exception {

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        userCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);

        userCriteria.setSearchUserInfoId(userCriteria.getSessionUserInfoId());
        boolean isConfirmPassword = userService.confirmPassword(userCriteria);

        if(isConfirmPassword){
            result.put("result", Constants.RESULT_SUCCESS);
            session.setAttribute("isPasswordConfirm", Constants.YES_NO_Y);
        }
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * 비밀번호 변경 화면
     *
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/password/passwordModify.do", method = {RequestMethod.POST} )
    public String modifyPassword(Model model , HttpSession session , HttpServletRequest request
                             ) throws Exception{
        if(session.getAttribute("isPasswordConfirm")==null||!String.valueOf(session.getAttribute("isPasswordConfirm")).equals(Constants.YES_NO_Y)){
            return "redirect:"+request.getServletPath();
        }
        session.setAttribute("isPasswordConfirm", Constants.YES_NO_N);
        return "myPage/passwordModify"+Constants.FRONT_TLF;
    }

    /**
     * 비밀번호 변경(AJAX)
     *
     * @param HttpServletRequest
     * @param UserVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/password/modifyPasswordAjax.do", method = { RequestMethod.POST })
    @ResponseBody
    public Map<String,Object> modifyPasswordAjax(HttpServletRequest request, UserVo userVo) throws Exception {

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        userVo.setLoginSessionInfoFactory(loginSessionInfoFactory);


        String endPassword = CommFncUtil.ENC_SHA256(userVo.getUserPwd());
        userVo.setEncodeUserPwd(endPassword);
        userVo.setUserInfoId(userVo.getSessionUserInfoId());

        Integer cnt = userService.modifyUserPassword(userVo);
        //Integer cnt= 1;
        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        //로그아웃 처리
        userService.logout(loginSessionInfoFactory);

        return result;
    }

    /**
     * 회원정보수정(AJAX)
     *
     * @param Map<String,Object>
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/userInfo/processUserInfoModifyAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> processUserInfoModifyAjax(@RequestParam Map<String,Object> param
                                            ) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = userService.processUserInfoModify(param);

        if(cnt == 1){
          //세션정보 업데이트
            loginSessionInfoFactory.getObject().setSessionUserEmail(param.get("userEmailAddr").toString());
            loginSessionInfoFactory.getObject().setSessionUserMobileNo(param.get("userMobileNum").toString());
            loginSessionInfoFactory.getObject().setSessionUserName(param.get("userName").toString());
            result.put("result", Constants.RESULT_SUCCESS);
        }else{
            result.put("result", Constants.RESULT_FAIL);
        }

        return result;
    }

    /**
     * 메세지 충전 화면
     *
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/message/reqMessage.do")
    public String selectReqMessage(Model model , HttpSession session , HttpServletRequest request
                             ) throws Exception{
        return "myPage/reqMessage"+Constants.FRONT_TLF;
    }

    /**
     * 메세지 충전요청(AJAX)
     *
     * @param Map<String,Object>
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/message/reqMessageAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> reqMessageAjax(@RequestParam Map<String,Object> param
                                            ) throws Exception{
        //session 정보 setting
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();
        String storeCode = loginSessionInfoFactory.getObject().getSessionStoreCode();
        String userName = loginSessionInfoFactory.getObject().getSessionUserName();

        param.put("userInfoId", userInfoId);
        param.put("storeCode", storeCode);
        param.put("userName", userName);

        Map<String,Object> reqResult = reqMessageService.reqMessage(param);

        return reqResult;
    }


}