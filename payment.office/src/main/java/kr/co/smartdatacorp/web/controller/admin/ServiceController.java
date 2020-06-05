package kr.co.smartdatacorp.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.service.PayService;
import kr.co.smartdatacorp.core.vo.mposSrv.MposSrvCriteria;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.DateUtil;
import kr.co.smartdatacorp.core.dao.PaymentDao;
import kr.co.smartdatacorp.core.service.PaymentService;
import kr.co.smartdatacorp.core.service.ServiceService;
import kr.co.smartdatacorp.core.vo.code.CodeCriteria;
import kr.co.smartdatacorp.core.vo.service.ServiceCriteria;
import kr.co.smartdatacorp.web.bean.util.AsyncMethodBean;
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
*   수정일                   수정자                   수정내용
*  -------      --------    ---------------------------
*   2018.10.20  이인희                   최초 생성
*
* </pre>
*/
@RequestMapping("/admin/service")
@Controller("admin.ServiceController")
public class ServiceController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(ServiceController.class);

    @Resource(name = "serviceService")
    private ServiceService serviceService;

    @Resource(name = "asyncMethodBean")
    private AsyncMethodBean asyncMethodBean;

    @Resource
    PaymentDao paymentDao;

    @Resource
    PaymentService paymentService;

    @Resource
    PayService payService;

    /**
     * 승인이력 조회
     * @param serviceCriteria
     * @param codeCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payment/getPaymentList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getGeneralReportList( @ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                    ,@ModelAttribute("codeCriteria") CodeCriteria codeCriteria
                                    ,Model model
                             ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        serviceCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);

        //초기 조회값 세팅
        if(serviceCriteria.getSearchFromDt() == null || serviceCriteria.getSearchToDt().equals("")){
            serviceCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);

            serviceCriteria.setSearchDateType(Constants.SEARCH_DATE_TYPE_ANAL_DT);
            serviceCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-Constants.SEARCH_DEFAULT_PER_MONTH));
            serviceCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));

            serviceCriteria.setSortList(Constants.SORT_KIND_REG_DT);
            serviceCriteria.setSortKind(Constants.SORT_DESC);
        }

        List<EgovMap> reportVolist = serviceService.getPaymentList(serviceCriteria); /* List */
        result.put("reportVolist", reportVolist);

        model.addAttribute("result", result);

        return "admin/service/adminPaymentList"+Constants.ADMIN_TLF;
    }

    /**
     * 승인이력 조회(AJAX)
     * @param serviceCriteria
     * @param codeCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payment/getPaymentListAjax.do", method = {RequestMethod.POST} )
    public String getPaymentListAjax(@ModelAttribute("serviceCriteria") ServiceCriteria serviceCriteria
                                          ,@ModelAttribute("codeCriteria") CodeCriteria codeCriteria
                                          ,Model model
                                      ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //세션에있는 로그인 정보를 셋팅
        serviceCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);

        List<EgovMap> reportVolist = serviceService.getPaymentList(serviceCriteria);/* List */
        result.put("reportVolist", reportVolist);

        model.addAttribute("result", result);

        return "admin/service/include/adminPaymentList_INC";
    }

    /**
     * 승인이력 상세팝업
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payment/getPaymentDetailPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String getPaymentDetailPop(@RequestParam Map<String,Object> param
                                        ,Model model ) throws Exception {
        Map<String,Object> result = new HashMap<String,Object>();

        EgovMap payDetail = serviceService.getPaymentDetail(param);
        model.addAttribute("payDetail", payDetail);

        return "admin/service/adminPaymentDetailPop"+Constants.FRONT_EMPTY;
    }



    /*
    ====================================== mpos 승인내역 ========================================= START
     */

    /**
     * admin > 매출관리 > mPOS 승인내역조회 : 목록화면
     * @param model
     * @param mposSrvCriteria
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mpos/mposSrvList.do", method = {RequestMethod.POST})
    public String mposSrvList(
            Model model,
            @ModelAttribute("criteria") MposSrvCriteria mposSrvCriteria) throws Exception{

        // 초기값 셋팅
        mposSrvCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        mposSrvCriteria.setSortOrder("A.PAYMENT_HIST_ID DESC");

        //검색영역(결제방법, 서비스제공자) 목록
        List<EgovMap> paymentMethodList = payService.getCommonCodeList("PAYMENT_METHOD"); //결제방법
        List<EgovMap> serviceProviderList = payService.getCommonCodeList("SERVICE_PROVIDER"); //서비스제공자

        model.addAttribute("paymentMethodList",paymentMethodList);
        model.addAttribute("serviceProviderList",serviceProviderList);


        //승인내역
        List<EgovMap> mposPayList = serviceService.getMposPayList(mposSrvCriteria);
        model.addAttribute("mposPayList",mposPayList);

        return "admin/mposSrv/mposSrvList"+Constants.ADMIN_TLF;
    }

    /**
     * admin > 매출관리 > mPOS 승인내역조회
     * @param model
     * @param mposSrvCriteria
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mpos/getMposSrvListAjax.do", method = {RequestMethod.POST})
    public String getMposSrvListAjax(
            Model model
            , @ModelAttribute("criteria") MposSrvCriteria mposSrvCriteria) throws Exception{

        CommFncUtil.printVo("mpos승인목록 조회",mposSrvCriteria);

        //승인내역
        List<EgovMap> mposPayList = serviceService.getMposPayList(mposSrvCriteria);
        model.addAttribute("mposPayList",mposPayList);

        return "admin/mposSrv/include/mposSrvList_INC";
    }

    @RequestMapping(value = "/mpos/mposSrvDetailPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String mposSrvDetailPop(
            @RequestParam Map<String,Object> param
            ,Model model ) throws Exception {

        CommFncUtil.printParameterLogByMap("ServiceController","mposSrvDetailPop",param);

        //Map<String,Object> result = new HashMap<String,Object>();

        List<EgovMap> payDetailList = serviceService.getMposSrvDetailList(param);
        model.addAttribute("payDetailList", payDetailList);

        return "admin/mposSrv/mposSrvDetailPop"+Constants.ADMIN_EMPTY;
    }

    /*
    ====================================== mpos 승인내역 ========================================= END
     */


}