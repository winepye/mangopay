package kr.co.smartdatacorp.web.controller.admin;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.dao.PayDao;
import kr.co.smartdatacorp.core.service.PayService;
import kr.co.smartdatacorp.core.vo.pay.PayCriteria;
import kr.co.smartdatacorp.core.vo.pay.PayVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/admin/payService")
@Controller("admin.PayController")
public class PayController extends BaseController {

    final static Logger log = LoggerFactory.getLogger(PayController.class);

    @Resource(name = "payService")
    private PayService payService;

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 목록
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceList.do", method = {RequestMethod.POST})
    public String getPayServiceList(
            @ModelAttribute("search") PayCriteria criteria
            , Model model) throws Exception{

        criteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        criteria.setSortOrder("A.PAYMENT_SERVICE_ID DESC");

        Map<String, Object> payList = payService.getPayServiceList(criteria);

        model.addAttribute("result", payList);

        return "admin/pay/payList"+ Constants.ADMIN_TLF;
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 목록 검색(AJAX)
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getPayServiceListAjax.do", method = {RequestMethod.POST})
    public String getPayServiceListAjax(
            @ModelAttribute("search") PayCriteria criteria
            , Model model) throws Exception{

        CommFncUtil.printVo("PayCriteria", criteria);

        Map<String, Object> payList = payService.getPayServiceList(criteria);

        model.addAttribute("result", payList);

        return "admin/pay/include/payList_INC";
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 상세
     * @param param
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceDetail.do", method = {RequestMethod.POST})
    public String payServiceDetail(
            @RequestParam Map<String, Object> param,
            @ModelAttribute("search") PayCriteria criteria,
            Model model) throws Exception{

        CommFncUtil.printVo("PayCriteria",criteria);

        CommFncUtil.printParameterLogByMap("PayController","payServiceDetail",param);

        EgovMap payInfo = payService.getPayServiceDetail(param);

        model.addAttribute("result",payInfo);


        return "admin/pay/payDetail"+Constants.ADMIN_TLF;
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 수정
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceModify.do", method = {RequestMethod.POST})
    public String payServiceModify(
            Model model,
            @ModelAttribute("search") PayCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        EgovMap payInfo = payService.getPayServiceDetail(param);

        List<EgovMap> serProvList = payService.getCommonCodeList("SERVICE_PROVIDER");
        List<EgovMap> payMeanList = payService.getCommonCodeList("PAYMENT_MEAN");
        List<EgovMap> payMethodList = payService.getCommonCodeList("PAYMENT_METHOD");

        model.addAttribute("serProvList", serProvList); // 서비스제공자 목록
        model.addAttribute("payMeanList", payMeanList); // 결제수단 목록
        model.addAttribute("payMethodList", payMeanList); // 결제방식 목록
        model.addAttribute("result",payInfo); // 결제서비스 상세정보

        return "admin/pay/payModify"+Constants.ADMIN_TLF;
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 등록
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceCreate.do", method = {RequestMethod.POST})
    public String payServiceCreate(
            Model model,
            @ModelAttribute("search") PayCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        List<EgovMap> serProvList = payService.getCommonCodeList("SERVICE_PROVIDER");
        List<EgovMap> payMeanList = payService.getCommonCodeList("PAYMENT_MEAN");
        List<EgovMap> payMethodList = payService.getCommonCodeList("PAYMENT_METHOD");

        model.addAttribute("serProvList", serProvList); // 서비스제공자 목록
        model.addAttribute("payMeanList", payMeanList); // 결제수단 목록
        model.addAttribute("payMethodList", payMeanList); // 결제방식 목록

        return "admin/pay/payCreate"+Constants.ADMIN_TLF;
    }


    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 수정 저장
      * @param payVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyPayServiceAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyPayServiceAjax(PayVo payVo) throws Exception{

        CommFncUtil.printVo("PayVo", payVo);

        payVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = payService.modifyPayService(payVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 등록 저장
     * @param payVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createPayServiceAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createPayServiceAjax(PayVo payVo) throws Exception{

        CommFncUtil.printVo("PayVo", payVo);

        payVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = payService.createPayService(payVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }



}
