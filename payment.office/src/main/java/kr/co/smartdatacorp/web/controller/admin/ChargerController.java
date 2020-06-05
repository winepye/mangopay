package kr.co.smartdatacorp.web.controller.admin;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
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
import kr.co.smartdatacorp.core.service.ChargerService;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.charger.ChargerCriteria;
import kr.co.smartdatacorp.web.controller.common.BaseController;
/**
 * 담당자 컨트롤러 클래스
 * @author 이인희
 * @since 2019.01.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2019.01.10  이인희          최초 생성
 *  </pre>
 */
@RequestMapping("/admin/charger")
@Controller("admin.ChargerController")
public class ChargerController extends BaseController{

    @Resource(name = "fileService")
    private FileService fileService;

    @Resource(name = "chargerService")
    private ChargerService chargerService;

    protected static final Log logger = LogFactory.getLog(ChargerController.class);

    /**
     * 고객사관리 > 담당자등록 목록 화면
     *
     * @param ChargerCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/chargerList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getChargerList( @ModelAttribute("chargerCriteria") ChargerCriteria chargerCriteria
                              ,Model model
                             ) throws Exception{


        if(chargerCriteria.getSearchContentType() == null || chargerCriteria.getSearchContentType().equals("")){
            chargerCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
            chargerCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-Constants.SEARCH_DEFAULT_PER_MONTH));
            chargerCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));
        }

        Map<String,Object> result = new HashMap<String,Object>();

        List<EgovMap> chargerVolist = chargerService.getChargerList(chargerCriteria);

        result.put("chargerVolist", chargerVolist);

        model.addAttribute("result", result);

        return "admin/charger/chargerList"+Constants.ADMIN_TLF;
    }

    /**
     * 고객사관리 > 담당자등록 목록 검색(AJAX)
     *
     * @param ChargerCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/getChargerListAjax.do", method = {RequestMethod.POST} )
    public String getChargerListAjax(@ModelAttribute("chargerCriteria") ChargerCriteria chargerCriteria
                                      ,Model model
                                      ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        List<EgovMap> chargerVolist = chargerService.getChargerList(chargerCriteria);

        result.put("chargerVolist", chargerVolist);

        model.addAttribute("result", result);

        return "admin/charger/include/chargerList_INC";
    }


    /**
     * 고객사관리 > 담당자등록 작성 화면
     *
     * @param ChargerCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/chargerCreate.do", method = {RequestMethod.POST} )
    public String createCharger(@RequestParam Map<String,Object> param
            ,@ModelAttribute("chargerCriteria") ChargerCriteria chargerCriteria
            ,Model model ) throws Exception{

        List<EgovMap> companyInfoList = chargerService.getCompanyInfoListForCombo(param);  //고객사정보
        List<EgovMap> brandInfoList = chargerService.getBrandInfoListForCombo(param);  //브랜드
        List<EgovMap> shopInfoList = chargerService.getShopInfoListForCombo(param);  //매장

        model.addAttribute("companyInfoList", companyInfoList);
        model.addAttribute("brandInfoList", brandInfoList);
        model.addAttribute("shopInfoList", shopInfoList);

        return "admin/charger/chargerCreate"+Constants.ADMIN_TLF;
    }

    /**
     * 담당자등록 저장(AJAX)
     *
     * @param
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/createChargerAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createChargerAjax(@RequestParam Map<String, Object> param
            ,@ModelAttribute("chargerCriteria") ChargerCriteria chargerCriteria
                                            ) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        param.put("sessionUserInfoId", loginSessionInfoFactory.getObject().getSessionUserInfoId());
        Integer cnt = chargerService.createCharger(param);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 담당자등록 삭제(AJAX)
     *
     * @param
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/deleteChargerAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteChargerAjax(@RequestParam("deleteChargerSeq") String[] deleteChargerSeq) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = chargerService.deleteCharger(deleteChargerSeq);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 고객사관리 > 담당자등록 상세화면
     *
     * @param ChargerCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/chargerDetail.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getChargerDetail( @RequestParam Map<String,Object> param
            ,@ModelAttribute("chargerCriteria") ChargerCriteria chargerCriteria
                                ,Model model
                               ) throws Exception{
        EgovMap result = chargerService.getChargerDetail(param);
        model.addAttribute("result", result);

        return "admin/charger/chargerDetail"+Constants.ADMIN_TLF;
    }

    /**
     * 고객사관리 > 담당자등록 수정화면
     *
     * @param ChargerCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/chargerModify.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getChargerModify( @RequestParam Map<String,Object> param
            ,@ModelAttribute("chargerCriteria") ChargerCriteria chargerCriteria
                                ,Model model
                               ) throws Exception{

        EgovMap result = chargerService.getChargerDetail(param);
        model.addAttribute("result", result);

        List<EgovMap> companyInfoList = chargerService.getCompanyInfoListForCombo(param);  //고객사정보
        List<EgovMap> brandInfoList = chargerService.getBrandInfoListForCombo(param);  //브랜드
        List<EgovMap> shopInfoList = chargerService.getShopInfoListForCombo(param);  //매장

        model.addAttribute("companyInfoList", companyInfoList);
        model.addAttribute("brandInfoList", brandInfoList);
        model.addAttribute("shopInfoList", shopInfoList);

        return "admin/charger/chargerModify"+Constants.ADMIN_TLF;
    }

    /**
     * 담당자등록 수정(AJAX)
     *
     * @param
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/modifyChargerAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyChargerAjax(@RequestParam Map<String, Object> param
                                            ) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        param.put("sessionUserInfoId", loginSessionInfoFactory.getObject().getSessionUserInfoId());
        Integer cnt = chargerService.modifyCharger(param);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }
}
