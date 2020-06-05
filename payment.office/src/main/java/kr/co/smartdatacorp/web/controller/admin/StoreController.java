package kr.co.smartdatacorp.web.controller.admin;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.service.StoreService;
import kr.co.smartdatacorp.core.vo.store.StoreCriteria;
import kr.co.smartdatacorp.core.vo.store.StoreVo;
import kr.co.smartdatacorp.core.vo.user.UserCriteria;
import kr.co.smartdatacorp.web.controller.common.BaseController;

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

/**
*
* User List Controller 클래스
* @author 이인희
* @since 2016.05.04
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일                   수정자                   수정내용
*  -------      --------    ---------------------------
*   2016.05.04  이인희                   최초 생성
*
* </pre>
*/
@RequestMapping("/admin/store")
@Controller("admin.StoreController")
public class StoreController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(StoreController.class);

    @Resource(name = "storeService")
    private StoreService storeService;

    /**
     * 가맹점 목록 화면
     * @param storeCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/storeList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getStoreList( @ModelAttribute("storeCriteria") StoreCriteria storeCriteria
                              ,Model model
                             ) throws Exception{

        log.debug("=====> storeCriteria : " + storeCriteria.getCurrentPageNo());

        storeCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);

        List<EgovMap> storeList = storeService.getStoreList(storeCriteria); /* 회원 목록 화면 조회 */

        model.addAttribute("result", storeList);
        return "admin/store/storeList"+Constants.ADMIN_TLF;
    }

    /**
     * 가맹점 목록 검색(AJAX)
     * @param storeCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getStoreListAjax.do", method = {RequestMethod.POST} )
    public String getStoreListAjax(@ModelAttribute("storeCriteria") StoreCriteria storeCriteria
                                      ,Model model
                                      ) throws Exception{
        List<EgovMap> storeList = storeService.getStoreList(storeCriteria); /* 회원 List 조회 */
        model.addAttribute("result", storeList);
        return "admin/store/include/storeList_INC";
    }

    /**
     * 가맹점관리 > 가맹점정보 상세화면
     * @param param
     * @param model
     * @param storeCriteria
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/storeDetail.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String storeDetail( @RequestParam Map<String,Object> param
                                ,Model model
                                ,@ModelAttribute("storeCriteria") StoreCriteria storeCriteria
                               ) throws Exception{
        CommFncUtil.printParameterLogByMap("StoreController.java", "storeDetail.do", param);
        EgovMap result = storeService.getStoreDetail(param);

        model.addAttribute("result", result);

        return "admin/store/storeDetail"+Constants.ADMIN_TLF;
    }


    /**
     * 게시판 > 공지사항 수정화면
     * @param param
     * @param storeCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/storeModify.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getStoreModify(@RequestParam Map<String,Object> param
                                         ,@ModelAttribute("storeCriteria") StoreCriteria storeCriteria
                                         ,Model model
                               ) throws Exception{

        List<EgovMap> partnerInfoIdList = storeService.getPartnerInfoList(param);
        List<EgovMap> companyInfoIdList = storeService.getCompanyInfoList(param);

        model.addAttribute("partnerInfoIdList", partnerInfoIdList); // 제휴사정보
        model.addAttribute("companyInfoIdList", companyInfoIdList); // 거래처정보

        EgovMap result = storeService.getStoreDetail(param);

        model.addAttribute("result", result);

        return "admin/store/storeModify"+Constants.ADMIN_TLF;
    }

    /**
     * 가맹점관리 > 가맹점 등록 화면
     * @param param
     * @param storeCriteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/storeCreate.do", method = {RequestMethod.POST} )
    public String storeCreate(@RequestParam Map<String,Object> param
                                      ,@ModelAttribute("storeCriteria") StoreCriteria storeCriteria
                                      ,Model model ) throws Exception{

        List<EgovMap> partnerInfoIdList = storeService.getPartnerInfoList(param);

        List<EgovMap> companyInfoIdList = storeService.getCompanyInfoList(param);

        model.addAttribute("partnerInfoIdList", partnerInfoIdList); // 제휴사정보
        model.addAttribute("companyInfoIdList", companyInfoIdList); // 거래처정보

        return "admin/store/storeCreate"+Constants.ADMIN_TLF;
    }


    /**
     * 가맹점 게시판 저장(AJAX)
     * @param storeVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createStoreAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createStoreAjax(StoreVo storeVo ) throws Exception{

        CommFncUtil.printVo("/createStoreAjax.do", storeVo);

        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = storeService.createStore(storeVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 가맹점 게시판 수정(AJAX)
     * @param storeVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyStoreAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyStoreAjax(StoreVo storeVo ) throws Exception{

        CommFncUtil.printVo("/modifyStoreAjax.do", storeVo);

        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = storeService.modifyStore(storeVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

}