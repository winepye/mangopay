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
import kr.co.smartdatacorp.core.service.CompanyService;
import kr.co.smartdatacorp.core.service.StoreService;
import kr.co.smartdatacorp.core.vo.company.CompanyCriteria;
import kr.co.smartdatacorp.core.vo.company.CompanyVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;

@RequestMapping("/admin/company")
@Controller("admin.CompanyController")
public class CompanyController extends BaseController {

    final static Logger log = LoggerFactory.getLogger(CompanyController.class);

    @Resource(name = "companyService")
    private CompanyService companyService;

    @Resource(name = "storeService")
    private StoreService storeService;

    /**
     * 거래처 목록 화면
     * @param companyCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value= "/companyList.do", method={RequestMethod.GET,RequestMethod.POST})
    public String getCompanyList(@ModelAttribute CompanyCriteria companyCriteria, Model model) throws Exception{

        companyCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        companyCriteria.setSortOrder("A.COMPANY_INFO_ID DESC");

        List<EgovMap> companyList = companyService.getCompanyList(companyCriteria);

        model.addAttribute("result", companyList);

        return "admin/company/companyList"+Constants.ADMIN_TLF;
    }

    /**
     * 거래처 목록 검색(AJAX)
     * @param companyCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/getCompanyListAjax.do", method={RequestMethod.POST})
    public String getCompanylistAjax(@ModelAttribute CompanyCriteria companyCriteria, Model model) throws Exception{

        List<EgovMap> companyList = companyService.getCompanyList(companyCriteria);
        model.addAttribute("result", companyList);
        return "admin/company/include/companyList_INC";
    }

    /**
     * 거래처 정보 상세화면
     * @param param
     * @param model
     * @param companyCriteria
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/companyDetail.do", method={RequestMethod.GET, RequestMethod.POST})
    public String companyDetail(@RequestParam Map<String, Object> param, Model model, @ModelAttribute CompanyCriteria companyCriteria) throws Exception{

        CommFncUtil.printParameterLogByMap("CompanyController.java", "companyDetail.do", param);

        Map<String, Object> result = companyService.getStoreDetail(param);

        model.addAttribute("result", result);

        return "admin/company/companyDetail"+Constants.ADMIN_TLF;
    }

    /**
     * 거래처 정보 등록화면
     * @param param
     * @param companyCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/companyCreate.do", method={RequestMethod.POST})
    public String companyCreate(
            @RequestParam Map<String,Object> param,
            @ModelAttribute CompanyCriteria companyCriteria, Model model) throws Exception{

        List<EgovMap> partnerInfoIdList = storeService.getPartnerInfoList(param);
        model.addAttribute("partnerInfoIdList", partnerInfoIdList); // 제휴사정보

        return "admin/company/companyCreate"+Constants.ADMIN_TLF;
    }

    /**
     * 거래처 정보 저장(AJAX)
     * @param companyVo 고객사등록 화면 저장 데이터 VO
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/createCompanyAjax.do", method={RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createCompanyAjax(CompanyVo companyVo) throws Exception{
    //public Map<String, Object> createCompanyAjax(@RequestParam Map<String, Object> params) throws Exception{

        //CommFncUtil.printParameterLogByMap("CompanyController", "createCompanyAjax", params);
        CommFncUtil.printVo("/createCompanyAjax.do", companyVo);


        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = companyService.createCompany(companyVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 거래처 정보 수정화면
     * @param param
     * @param companyCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/companyModify.do", method={RequestMethod.GET, RequestMethod.POST})
    public String companyModify(
                                                @RequestParam Map<String, Object> param
                                               ,@ModelAttribute CompanyCriteria companyCriteria
                                               ,Model model
            ) throws Exception{

        List<EgovMap> partnerInfoIdList = storeService.getPartnerInfoList(param);
        model.addAttribute("partnerInfoIdList", partnerInfoIdList); // 제휴사정보

        Map<String, Object> result = companyService.getStoreDetail(param);

        model.addAttribute("result", result);

        return "admin/company/companyModify"+Constants.ADMIN_TLF;
    }

    /**
     * 거래처 정보 수정(AJAX) /admin/company/modifyCompanyAjax.do
     * @param companyVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/modifyCompanyAjax.do", method={RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyCompanyAjax(CompanyVo companyVo) throws Exception{

        CommFncUtil.printVo("/modifyCompanyAjax.do", companyVo);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = companyService.modifyCompany(companyVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }




}
