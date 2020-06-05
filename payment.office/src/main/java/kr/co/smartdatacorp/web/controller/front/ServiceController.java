package kr.co.smartdatacorp.web.controller.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
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
import kr.co.smartdatacorp.core.bean.util.DateUtil;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.service.ReqMessageService;
import kr.co.smartdatacorp.core.service.ServiceService;
import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.service.ServiceCriteria;
import kr.co.smartdatacorp.web.controller.common.BaseController;

/**
*
* Report List Controller 클래스
* @author 이인희
* @since 2018.10.20
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자                   수정내용
*  -------      --------    ---------------------------
*   2018.10.20  이인희                   최초 생성
*
* </pre>
*/
@RequestMapping("/service")
@Controller("front.ServiceController")
public class ServiceController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(ServiceController.class);

    @Resource(name = "serviceService")
    private ServiceService serviceService;

    @Resource(name = "userService")
    private UserService userService;

    @Resource(name = "fileService")
    private FileService fileService;

    /**
     * 통합 리포트 목록 화면
     *
     * @param ServiceCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/payment/getPaymentList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getPaymentList( @ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                    ,Model model
                             ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        serviceCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);
        //해당가맹점 정보만 조회
        serviceCriteria.setSearchStoreCode(loginSessionInfoFactory.getObject().getSessionStoreCode());
        serviceCriteria.setSearchCompanyInfoId(loginSessionInfoFactory.getObject().getSessionCompanyInfoId());
        serviceCriteria.setSearchUserTypeCd(loginSessionInfoFactory.getObject().getSessionUserTypeCd());

        serviceCriteria.setSearchDateType(Constants.SEARCH_DATE_TYPE_CREATE_DATE);

        //초기 조회값 세팅
        if(serviceCriteria.getSearchFromDt() == null || serviceCriteria.getSearchToDt().equals("")){
            serviceCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_20);

            serviceCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-Constants.SEARCH_DEFAULT_PER_MONTH));
            serviceCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));

            serviceCriteria.setSortList(Constants.SORT_KIND_REG_DT);
            serviceCriteria.setSortKind(Constants.SORT_DESC);
        }

        List<EgovMap> reportVolist = serviceService.getPaymentList(serviceCriteria); /* List */
        result.put("reportVolist", reportVolist);

        model.addAttribute("result", result);

        return "service/frontPaymentList"+Constants.FRONT_TLF;
    }

    /**
     * 통합 리포트 목록 검색(AJAX)
     *
     * @param ServiceCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/payment/getPaymentListAjax.do", method = {RequestMethod.POST} )
    public String getPaymentListAjax(@ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                          ,Model model
                                      ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        serviceCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);
        //해당가맹점 정보만 조회
        serviceCriteria.setSearchStoreCode(loginSessionInfoFactory.getObject().getSessionStoreCode());
        serviceCriteria.setSearchCompanyInfoId(loginSessionInfoFactory.getObject().getSessionCompanyInfoId());
        serviceCriteria.setSearchUserTypeCd(loginSessionInfoFactory.getObject().getSessionUserTypeCd());

        List<EgovMap> reportVolist = serviceService.getPaymentList(serviceCriteria);/* List */
        result.put("reportVolist", reportVolist);

        model.addAttribute("result", result);

        return "front/service/include/frontPaymentList_INC";
    }



    /**
     * 승인이력 상세팝업
     *
     * @param Model
     * @param ServiceCriteria
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payment/getPaymentDetailPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String getPaymentDetailPop(@RequestParam Map<String,Object> param
                                        ,Model model ) throws Exception {
        Map<String,Object> result = new HashMap<String,Object>();

        EgovMap payDetail = serviceService.getPaymentDetail(param);
        model.addAttribute("payDetail", payDetail);

        return "front/service/frontPaymentDetailPop"+Constants.FRONT_EMPTY;
    }

    /**
     * 청구서발송
     *
     * @param
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/payment/sendPayment.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String sendPayment( @ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                    ,Model model
                             ) throws Exception{
        return "service/sendPayment"+Constants.FRONT_TLF;
    }

    /**
     * 청구서발송(AJAX)
     *
     * @param Map<String,Object>
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/payment/sendPaymentAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> sendPaymentAjax(@RequestParam Map<String,Object> param
                                            ) throws Exception{
        //session 정보 setting
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();
        String storeCode = loginSessionInfoFactory.getObject().getSessionStoreCode();
        String userName = loginSessionInfoFactory.getObject().getSessionUserName();

        param.put("userInfoId", userInfoId);
        param.put("storeCode", storeCode);
        param.put("userName", userName);

        // 보낼 대상 jsonStr 을 리스트로 변환
        String sendListStr = (String)param.get("sendList");

        ObjectMapper objectMapper = new ObjectMapper();

        List<Map<String, Object>> sendList = objectMapper.readValue(sendListStr,
                new TypeReference<List<Map<String, Object>>>() {
                });

        param.put("sendList", sendList);
        Map<String,Object> reqResult = serviceService.sendPayment(param);

        return reqResult;
    }
    /**
     * 메세지 충전내역
     */
    /*@Resource(name = "reqMessageService")
    private ReqMessageService reqMessageService;*/
    /**
     * 사용자그룹
     *
     * @param
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/getCustomerGroupList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getCustomerGroupList( @ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                    ,Model model
                             ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        serviceCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();
        serviceCriteria.setSearchUserInfoId(userInfoId);

        //초기 조회값 세팅
        serviceCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_20);

        List<EgovMap> customerGroupList = serviceService.getCustomerGroupList(serviceCriteria); /* List */
        result.put("customerGroupList", customerGroupList);

        model.addAttribute("result", result);


        ///////////////////메세지충전 TEST//////////////////////////
//        Map<String,Object> testMap = new HashMap<String,Object>();
//        testMap.put("txId", "SDAUC364955500100041_REQ120200531153712");
//        reqMessageService.procReqMessagePrice(testMap);

        //해당가맹점 정보만 조회
        return "service/customerGroupList"+Constants.FRONT_TLF;
    }
    /**
     * 사용자그룹팝업
     *
     * @param
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/getCustomerGroupList/pop.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getCustomerGroupListPop( @ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                    ,Model model
                             ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        serviceCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();
        serviceCriteria.setSearchUserInfoId(userInfoId);

        //초기 조회값 세팅
        serviceCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_20);

        List<EgovMap> customerGroupList = serviceService.getCustomerGroupList(serviceCriteria); /* List */
        result.put("customerGroupList", customerGroupList);

        model.addAttribute("result", result);

        //해당가맹점 정보만 조회
        return "front/service/pop/customerGroupListPop";
    }
    /**
     * 사용자그룹검색(AJAX)
     *
     * @param ServiceCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/getCustomerGroupListAjax.do", method = {RequestMethod.POST} )
    public String getCustomerGroupListAjax(@ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                          ,Model model
                                      ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        serviceCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();
        serviceCriteria.setSearchUserInfoId(userInfoId);

        List<EgovMap> customerGroupList = serviceService.getCustomerGroupList(serviceCriteria); /* List */
        result.put("customerGroupList", customerGroupList);

        model.addAttribute("result", result);

        return "front/service/include/customerGroupList_INC";
    }


    /**
     * 사용자그룹추가(AJAX)
     *
     * @param Map<String,Object>
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/createCustomerGroup.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createCustomerGroup(@RequestParam Map<String,Object> param
                                            ) throws Exception{
        //session 정보 setting
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();

        param.put("userInfoId", userInfoId);
        param.put("groupOrd", 1); //

        Map<String,Object> reqResult = serviceService.createCustomerGroup(param);

        return reqResult;
    }
    /**
     * 사용자그룹수정(AJAX)
     *
     * @param Map<String,Object>
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/modifyCustomerGroup.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyCustomerGroup(@RequestParam Map<String,Object> param
                                            ) throws Exception{
        //session 정보 setting
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();

        param.put("userInfoId", userInfoId);

        Map<String,Object> reqResult = serviceService.modifyCustomerGroup(param);

        return reqResult;
    }
    /**
     * 사용자그룹삭제(AJAX)
     *
     * @param Map<String,Object>
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/deleteCustomerGroup.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteCustomerGroup(@RequestParam Map<String,Object> param
                                            ) throws Exception{
        //session 정보 setting
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();

        param.put("userInfoId", userInfoId);

        Map<String,Object> reqResult = serviceService.deleteCustomerGroup(param);

        return reqResult;
    }

    /**
     * 사용자그룹상세검색(AJAX)
     *
     * @param ServiceCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/getCustomerGroupDetailAjax.do", method = {RequestMethod.POST} )
    public String getCustomerGroupDetail(@RequestParam Map<String,Object> param
                                          ,Model model
                                      ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        EgovMap customerGroupDetail = serviceService.getCustomerGroupDetail(param);
        result.put("customerGroupDetail", customerGroupDetail);
        result.put("searchText", param.get("searchText"));

        model.addAttribute("result", result);

        return "front/service/include/customerGroupDetail_INC";
    }
    /**
     * 사용자그룹상세검색팝업(AJAX)
     *
     * @param ServiceCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/getCustomerGroupDetailPopAjax.do", method = {RequestMethod.POST} )
    public String getCustomerGroupDetailPopAjax(@RequestParam Map<String,Object> param
                                          ,Model model
                                      ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        EgovMap customerGroupDetail = serviceService.getCustomerGroupDetail(param);
        result.put("customerGroupDetail", customerGroupDetail);
        result.put("searchText", param.get("searchText"));

        model.addAttribute("result", result);

        return "front/service/include/customerGroupDetailPop_INC";
    }

    /**
     * 사용자그룹상세 추가/수정(AJAX)
     *
     * @param Map<String,Object>
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/userGroup/procCustomerGroupDetail.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> procCustomerGroupDetail(@RequestParam Map<String,Object> param
                                            ) throws Exception{
        //session 정보 setting
        Integer userInfoId = loginSessionInfoFactory.getObject().getSessionUserInfoId();

        param.put("userInfoId", userInfoId);

        // 처리 대상 jsonStr 을 리스트로 변환
        String sendListStr = (String)param.get("sendList");

        ObjectMapper objectMapper = new ObjectMapper();

        List<Map<String, Object>> sendList = objectMapper.readValue(sendListStr,
                new TypeReference<List<Map<String, Object>>>() {
                });

        param.put("sendList", sendList);

        Map<String,Object> reqResult = serviceService.procCustomerGroupDetail(param);

        return reqResult;
    }
}