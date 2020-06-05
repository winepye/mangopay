package kr.co.smartdatacorp.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
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
import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.bean.util.DateUtil;
import kr.co.smartdatacorp.core.service.StoreService;
import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.user.UserCriteria;
import kr.co.smartdatacorp.web.bean.api.ApiReqBean;
import kr.co.smartdatacorp.web.controller.common.BaseController;

/**
*
* User List Controller 클래스
* @author 이인희
* @since 2018.10.23
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일                   수정자                   수정내용
*  -------      --------    ---------------------------
*   2018.10.23  이인희                   최초 생성
*
* </pre>
*/
@RequestMapping("/admin/user")
@Controller("admin.UserController")
public class UserController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(UserController.class);

    @Resource(name = "userService")
    private UserService userService;

    @Resource(name = "storeService")
    private StoreService storeService;

    @Resource(name="apiReqBean")
    ApiReqBean apiReqBean;
    /**
     * 회원 목록 화면
     *
     * @param UserCriteria
     * @return List<EgovMap>
     * @throws Exception
     */
    @RequestMapping(value = "/userList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getUserList( @ModelAttribute("userCriteria") UserCriteria userCriteria
                              ,Model model
                             ) throws Exception{
        userCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        if(userCriteria.getSearchFromDt() == null || userCriteria.getSearchFromDt().equals("")){

            userCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-12));
            userCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));
        }

        List<EgovMap> userList = userService.getUserListEgovMap(userCriteria); /* 회원 목록 화면 조회 */

        model.addAttribute("result", userList);
        return "admin/user/userList"+Constants.ADMIN_TLF;
    }

    /**
     * 회원 목록 검색(AJAX)
     *
     * @param UserCriteria
     * @return List<EgovMap>
     * @throws Exception
     */
    @RequestMapping(value = "/user/getUserListAjax.do", method = {RequestMethod.POST} )
    public String getUserListAjax(@ModelAttribute("userCriteria") UserCriteria userCriteria
                                      ,Model model
                                      ) throws Exception{

        CommFncUtil.printVo("getUserListAjax.do", userCriteria);

        List<EgovMap> userList = userService.getUserListEgovMap(userCriteria); /* 회원 List 조회 */
        model.addAttribute("result", userList);
        return "admin/user/include/userList_INC";
    }

    /**
     * 회원관리 > 회원 상세화면
     *
     * @param UserCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/userDetailAdmin.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getUserDetailAdmin( @ModelAttribute("userCriteria") UserCriteria userCriteria
                                ,Model model
                               ) throws Exception{
        Map<String, Object> result = userService.getUserDetailAdmin(userCriteria);
        model.addAttribute("result"                     , result);
        return "admin/user/userDetail"+Constants.ADMIN_TLF;
    }

    /**
     * 회원정보 수정화면
     * @param param
     * @param userCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/userModify.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getUserModify(
                                            @RequestParam Map<String,Object> param
                                            ,@ModelAttribute("userCriteria") UserCriteria userCriteria
                                            ,Model model ) throws Exception{

        List<EgovMap> partnerInfoIdList = storeService.getPartnerInfoList(param);
        List<EgovMap> companyInfoIdList = storeService.getCompanyInfoList(param);
        List<EgovMap> storeInfoIdList = storeService.getStoreInfoList(param);

        model.addAttribute("partnerInfoIdList", partnerInfoIdList); // 제휴사정보
        model.addAttribute("companyInfoIdList", companyInfoIdList); // 거래처정보
        model.addAttribute("storeInfoIdList", storeInfoIdList); // 가맹점정보

        Map<String, Object> result = userService.getUserDetail(userCriteria);
        model.addAttribute("result", result);

        return "admin/user/userModify"+Constants.ADMIN_TLF;

    }

    /**
     * 회원 정보 수정(AJAX)
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyUserAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> modifyUserAjax(@RequestParam Map<String,Object> param) throws Exception{

        CommFncUtil.printParameterLogByMap("UserController", "modifyUserAjax", param);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = userService.modifyUser(param);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;

    }

    /**
     * 사용자 등록 화면
     * @param param
     * @param userCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/userCreate.do", method = {RequestMethod.POST} )
    public String userCreate(@RequestParam Map<String,Object> param
                                     ,@ModelAttribute("userCriteria") UserCriteria userCriteria
                                     ,Model model ) throws Exception{

        List<EgovMap> partnerInfoIdList = storeService.getPartnerInfoList(param);
        List<EgovMap> companyInfoIdList = storeService.getCompanyInfoList(param);
        List<EgovMap> storeInfoIdList = storeService.getStoreInfoList(param);

        model.addAttribute("partnerInfoIdList", partnerInfoIdList); // 제휴사정보
        model.addAttribute("companyInfoIdList", companyInfoIdList); // 거래처정보
        model.addAttribute("storeInfoIdList", storeInfoIdList); // 가맹점정보


        return "admin/user/userCreate"+Constants.ADMIN_TLF;

    }

    /**
     * 사용자 등록 저장(AJAX)
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/createUserAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> createUserAjax(@RequestParam Map<String, Object> param) throws Exception{

        CommFncUtil.printParameterLogByMap("UserController", "createUserAjax", param);

        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = userService.createUser(param);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

}