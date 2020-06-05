package kr.co.smartdatacorp.web.controller.admin;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.service.CateService;
import kr.co.smartdatacorp.core.vo.cate.CateCriteria;
import kr.co.smartdatacorp.core.vo.cate.CateVo;
import kr.co.smartdatacorp.core.vo.cate.CateVoList;
import kr.co.smartdatacorp.web.controller.common.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sun.misc.Request;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/admin/cate")
@Controller
public class CateController extends BaseController {

    @Resource(name = "cateService")
    CateService cateService;

    protected static final Logger log = LoggerFactory.getLogger(CateController.class);

    /**
     * admin > 설정 > 업종카테고리 관리 > 사이드 목록 ( 업종 상위 )
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/cateIndutyList.do", method = {RequestMethod.POST, RequestMethod.GET})
    public String cateIndutyList(Model model) throws Exception{

        Map<String, Object> result = new HashMap<String, Object>();

        // 상위분류 코드 목록
        List<EgovMap> listCateIndutyGroup = cateService.cateIndutyGroupList();

        result.put("listCateIndutyGroup",listCateIndutyGroup);

        model.addAttribute("result", result);

        return "admin/cate/cateMng"+ Constants.ADMIN_TLF;
    }

    /**
     * admin > 설정 > 업종카테고리 관리 > 업종(상) 상세정보
     * @param cateCriteria
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getCateIndutyDetailAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> getCateIndutyDetailAjax(
            @ModelAttribute("criteria") CateCriteria cateCriteria) throws Exception{

        Map<String, Object> result = new HashMap<String, Object>();

        CateVo cateVo = cateService.getInfoCateIndutyGroup(cateCriteria);

        result.put("cateVo",cateVo);

        return result;
    }

    /**
     * admin > 설정 > 업종카테고리관리 > 업종(하) 목록
     * @param cateCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getCateIndutyListAjax.do", method = RequestMethod.POST)
    public String getCateIndutyListAjax(
            @ModelAttribute("criteria") CateCriteria cateCriteria
            ,Model model) throws Exception{


        Map<String, Object> result = new HashMap();

        List<CateVo> cateVoList = cateService.getCateIndutyList(cateCriteria);

        result.put("cateVoList", cateVoList);

        model.addAttribute("result", result);

        return "admin/cate/include/cateMng_INC1";
    }

    /**
     * admin > 설정 > 업종카테고리관리 > 업종(상) 신규저장
     * @param cateVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createCateIndutyGroupAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createCateIndutyGroupAjax(CateVo cateVo) throws Exception{

        Map<String, Object> result = new HashMap<String, Object>();

        cateVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        String rsltMsg = cateService.createCateIndutyGroup(cateVo);

        result.put("message",rsltMsg);
        result.put("cateCdPr", cateVo.getCateCdPr());

        return result;
    }

    /**
     * admin > 설정 > 업종카테고리관리 > 업종(상) 수정저장
     * @param cateVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyCateIndutyGroupAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyCateIndutyGroupAjax(CateVo cateVo) throws Exception{

        Map<String, Object> result = new HashMap<String, Object>();

        cateVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        String rsltMsg = cateService.modifyCateIndutyGroup(cateVo);

        result.put("message",rsltMsg);
        result.put("cateCdPr", cateVo.getCateCdPr());

        return result;
    }

    /**
     * admin > 설정 > 업종카테고리관리 > 업종(하) 목록저장
     * @param cateVoList 업종(하) 목록
     * @param cateCdPr 업종(상) 코드
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createCateIndutyListAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createCateIndutyListAjax(
            CateVoList cateVoList,
            @RequestParam(value = "cateCdPr", required = true) String cateCdPr)throws Exception{
        Map<String, Object> result = new HashMap<String, Object>();

        cateVoList.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Integer cnt = cateService.createCateIndutyList(cateVoList, cateCdPr);

        if(1 == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }


}
