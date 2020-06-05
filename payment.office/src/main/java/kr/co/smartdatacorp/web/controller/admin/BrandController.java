package kr.co.smartdatacorp.web.controller.admin;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.service.BrandService;
import kr.co.smartdatacorp.core.vo.brand.BrandCriteria;
import kr.co.smartdatacorp.core.vo.brand.BrandVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/admin/brand")
@Controller("admin.BrandController")
public class BrandController extends BaseController {

    final static Logger log = LoggerFactory.getLogger(BrandController.class);

    @Resource(name = "brandService")
    private BrandService brandService;


    /**
     * 브랜드 목록 화면 ( admin > 고객사관리 > 브랜드관리 )
     * @param brandCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/brandList.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String getBrandList(@ModelAttribute BrandCriteria brandCriteria, Model model) throws Exception{

        brandCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        brandCriteria.setSortOrder("");

        List<EgovMap> brandList = brandService.getBrandList(brandCriteria);

        model.addAttribute("result", brandList);

        return "admin/brand/brandList"+ Constants.ADMIN_TLF;
    }

    /**
     * 브랜드 목록 검색(AJAX)
     * @param brandCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getBrandListAjax.do", method = {RequestMethod.POST})
    public String getBrandListAjax(
            @ModelAttribute BrandCriteria brandCriteria,
            Model model ) throws Exception{

        List<EgovMap> brandList = brandService.getBrandList(brandCriteria);
        model.addAttribute("result",brandList);

        return "admin/brand/include/brandList_INC"+ Constants.ADMIN_TLF;
    }

    /**
     * 브랜드 상세화면
     * @param param
     * @param brandCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/brandDetail.do", method = {RequestMethod.POST, RequestMethod.GET})
    public String brandDetail(
            @RequestParam Map<String, Object> param,
            @ModelAttribute BrandCriteria brandCriteria,
            Model model ) throws Exception{

        CommFncUtil.printParameterLogByMap("BrandController","brandDetail",param);

        EgovMap brandInfo = brandService.getBrandInfo(param);

        model.addAttribute("result", brandInfo);

        return "admin/brand/brandDetail"+ Constants.ADMIN_TLF;
    }

    /**
     * 브랜드 수정화면
     * @param param
     * @param brandCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/brandModify.do", method = {RequestMethod.POST, RequestMethod.GET})
    public String brandModify(
            @RequestParam Map<String, Object> param,
            @ModelAttribute BrandCriteria brandCriteria,
            Model model ) throws Exception{

        // 고객사명 리스트
        List<EgovMap> companyList = brandService.getCompanyList();

        // FIXME: 2018-12-18 업종(1depth) 목록
        List<EgovMap> bizTypeList1 = brandService.getBizTypeList("1");

        // FIXME: 2018-12-18 업종(2depth) 목록
        List<EgovMap> bizTypeList2 = brandService.getBizTypeList("2");

        for (EgovMap map : bizTypeList1) {
            System.out.println("업종(상) : "+ map.get("data")+" / " + map.get("label"));
        }

        for (EgovMap map : bizTypeList2) {
            System.out.println("업종(하) : "+ map.get("data")+" / " + map.get("label") + " / " + map.get("parent"));
        }


        EgovMap brandInfo = brandService.getBrandInfo(param);

        model.addAttribute("result", brandInfo);

        model.addAttribute("bizTypeParentList", bizTypeList1);
        model.addAttribute("bizTypeList", bizTypeList2);
        model.addAttribute("companyList", companyList);

        return "admin/brand/brandModify"+ Constants.ADMIN_TLF;
    }

    /**
     * 거래처 정보 수정(AJAX) /admin/company/modifyCompanyAjax.do
     * @param brandVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/modifyBrandAjax.do", method={RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyCompanyAjax(BrandVo brandVo) throws Exception{

        CommFncUtil.printVo("/modifyBrandAjax.do", brandVo);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = brandService.modifyBrand(brandVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 브랜드 등록 화면 ( admin > 고객사관리 > 브랜드관리 > 브랜드등록 )
     * @param param
     * @param brandCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/brandCreate.do", method = {RequestMethod.POST})
    public String brandCreate(
            @RequestParam Map<String, Object> param,
            @ModelAttribute BrandCriteria brandCriteria,
            Model model) throws Exception{

        // 고객사명 리스트
        List<EgovMap> companyList = brandService.getCompanyList();

        // 업종(1depth) 목록
        List<EgovMap> bizTypeList1 = brandService.getBizTypeList("1");

        // 업종(2depth) 목록
        List<EgovMap> bizTypeList2 = brandService.getBizTypeList("2");

        for (EgovMap map : bizTypeList1) {
            System.out.println("업종(상) : "+ map.get("data")+" / " + map.get("label"));
        }

        for (EgovMap map : bizTypeList2) {
            System.out.println("업종(하) : "+ map.get("data")+" / " + map.get("label") + " / " + map.get("parent"));
        }

        model.addAttribute("bizTypeParentList", bizTypeList1);
        model.addAttribute("bizTypeList", bizTypeList2);
        model.addAttribute("companyList", companyList);


        return "admin/brand/brandCreate"+Constants.ADMIN_TLF;

    }

    /**
     * 브랜드 정보 저장(ajax)
     * @param brandVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createBrandAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createBrandAjax(BrandVo brandVo) throws Exception{
        Map<String, Object> result = new HashMap<String, Object>();

        CommFncUtil.printVo("brandVo", brandVo);

        Integer cnt = brandService.createBrand(brandVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;

    }


}
