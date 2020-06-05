package kr.co.smartdatacorp.web.controller.admin;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.service.PayGroupService;
import kr.co.smartdatacorp.core.service.PayService;
import kr.co.smartdatacorp.core.vo.pay.PayCriteria;
import kr.co.smartdatacorp.core.vo.pay.PayGroupCriteria;
import kr.co.smartdatacorp.core.vo.pay.PayGroupVo;
import kr.co.smartdatacorp.core.vo.pay.PayVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/admin/payServiceGroup")
@Controller("admin.PayGroupController")
public class PayGroupController extends BaseController {

    final static Logger log = LoggerFactory.getLogger(PayGroupController.class);

    @Resource(name = "payGroupService")
    private PayGroupService payGroupService;

    /**
     * admin > 간편결제관리 > 결제서비스그룹 관리 > 목록
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceGroupList.do", method = {RequestMethod.POST})
    public String payServiceGroupList(
            @ModelAttribute("search") PayGroupCriteria criteria
            , Model model) throws Exception{

        criteria.setLoginSessionInfoFactory(loginSessionInfoFactory);

        //criteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        criteria.setSortOrder("useYn");

        Map<String, Object> payList = payGroupService.getPayServiceGroupList(criteria);

        model.addAttribute("result", payList);

        return "admin/payGroup/payGroupList"+ Constants.ADMIN_TLF;
    }

    /**
     * admin > 간편결제관리 > 결제서비스그룹 관리 > 목록 검색(AJAX)
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getPayServiceGroupListAjax.do", method = {RequestMethod.POST})
    public String getPayServiceGroupListAjax(
            @ModelAttribute("search") PayGroupCriteria criteria
            , Model model) throws Exception{

        CommFncUtil.printVo("PayGroupCriteria", criteria);

        Map<String, Object> payList = payGroupService.getPayServiceGroupList(criteria);

        model.addAttribute("result", payList);

        return "admin/payGroup/include/payGroupList_INC";
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 수정 저장 (AJAX)
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyPayServiceGroupAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyPayServiceGroupAjax(
            @RequestParam Map<String, Object> paramMap,
            PayGroupVo payGroupVo) throws Exception{

        CommFncUtil.printParameterLogByMap("","",paramMap);

        payGroupVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        log.info("=====> payGroupVo " + payGroupVo.getSessionUserInfoId());

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = payGroupService.modifyPayServiceGroup(payGroupVo, paramMap);

        if(cnt > 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }


    /**
     * admin > 간편결제관리 > 결제서비스그룹 관리 > 상세
     * @param param
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceGroupDetail.do", method = {RequestMethod.POST})
    public String payServiceGroupDetail(
            @RequestParam Map<String, Object> param,
            @ModelAttribute("search") PayGroupCriteria criteria,
            Model model) throws Exception{

        CommFncUtil.printVo("PayGroupCriteria",criteria);

        CommFncUtil.printParameterLogByMap("PayGroupController","payServiceGroupDetail",param);

        EgovMap payInfo = payGroupService.getPayServiceGroupDetail(param);

        model.addAttribute("result",payInfo);


        return "admin/payGroup/payGroupDetail"+Constants.ADMIN_TLF;
    }

    /**
     * admin > 간편결제관리 > 결제서비스그 관리 > 수정
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceGroupModify.do", method = {RequestMethod.POST})
    public String payServiceGroupModify(
            Model model,
            @ModelAttribute("search") PayGroupCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        EgovMap payInfo = payGroupService.getPayServiceGroupDetail(param);

        List<EgovMap> serProvList = payGroupService.getCommonCodeList("SERVICE_PROVIDER");
        List<EgovMap> payMeanList = payGroupService.getCommonCodeList("PAYMENT_MEAN");
        List<EgovMap> payMethodList = payGroupService.getCommonCodeList("PAYMENT_METHOD");

        model.addAttribute("serProvList", serProvList); // 서비스제공자 목록
        model.addAttribute("payMeanList", payMeanList); // 결제수단 목록
        model.addAttribute("payMethodList", payMeanList); // 결제방식 목록
        model.addAttribute("result",payInfo); // 결제서비스 상세정보

        return "admin/payGroup/payGroupModify"+Constants.ADMIN_TLF;
    }

    /**
     * admin > 간편결제관리 > 결제서비스그룹 관리 > 등록
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/payServiceGroupCreate.do", method = {RequestMethod.POST})
    public String payServiceGroupCreate(
            Model model,
            @ModelAttribute("search") PayGroupCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        List<EgovMap> serProvList = payGroupService.getCommonCodeList("SERVICE_PROVIDER");
        List<EgovMap> payMeanList = payGroupService.getCommonCodeList("PAYMENT_MEAN");
        List<EgovMap> payMethodList = payGroupService.getCommonCodeList("PAYMENT_METHOD");

        model.addAttribute("serProvList", serProvList); // 서비스제공자 목록
        model.addAttribute("payMeanList", payMeanList); // 결제수단 목록
        model.addAttribute("payMethodList", payMeanList); // 결제방식 목록

        return "admin/payGroup/payGroupCreate"+Constants.ADMIN_TLF;
    }




    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 등록 저장 (AJAX)
     * @param payGroupVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createPayServiceGroupAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createPayServiceGroupAjax(PayGroupVo payGroupVo) throws Exception{

        CommFncUtil.printVo("payGroupVo", payGroupVo);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = payGroupService.createPayServiceGroup(payGroupVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }



}
