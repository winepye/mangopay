package kr.co.smartdatacorp.web.controller.admin;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.CommFncUtil;
import kr.co.smartdatacorp.core.service.MposAppService;
import kr.co.smartdatacorp.core.vo.mposApp.MposAppCriteria;
import kr.co.smartdatacorp.core.vo.mposApp.MposAppVo;
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

@RequestMapping("/admin/mposapp")
@Controller("admin.MposAppController")
public class MposAppController extends BaseController {

    final static Logger log = LoggerFactory.getLogger(MposAppController.class);

    @Resource(name="mposAppService")
    private MposAppService mposAppService;

    /**
     * admin > APP 버전관리 > MPOS 버전 관리 > 목록 화면
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mposAppList.do", method = {RequestMethod.POST})
    public String mposAppList(@ModelAttribute("search") MposAppCriteria criteria, Model model) throws Exception{

        CommFncUtil.printVo("목록 검색 조건",criteria);

        criteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        criteria.setSortOrder("A.APP_VERSION_ID DESC");

        Map<String, Object> mposAppList = mposAppService.getMposAppList(criteria);
        model.addAttribute("result", mposAppList);

        return "admin/mposApp/mposAppList"+ Constants.ADMIN_TLF;
    }

    /**
     * admin > APP 버전관리 > MPOS 버전 관리 > 목록 검색 (AJAX)
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getMposAppListAjax.do", method = {RequestMethod.POST})
    public String getMposAppListAjax(@ModelAttribute("search") MposAppCriteria criteria, Model model) throws Exception{

        CommFncUtil.printVo("목록 검색 param", criteria);

        Map<String, Object> mposAppList = mposAppService.getMposAppList(criteria);
        model.addAttribute("result", mposAppList);

        return "admin/mposApp/include/mposAppList_INC";
    }

    /**
     * admin > APP 버전관리 > MPOS 버전 관리 > 상세 화면
     * @param param
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mposAppDetail.do", method = {RequestMethod.POST})
    public String mposAppDetail(
            @RequestParam Map<String, Object> param,
            @ModelAttribute("search") MposAppCriteria criteria,
            Model model) throws Exception{

        CommFncUtil.printVo("MposAppCriteria",criteria);

        CommFncUtil.printParameterLogByMap("MposAppController","mposAppDetail",param);

        EgovMap mposAppInfo = mposAppService.getMposAppDetail(param);

        model.addAttribute("result",mposAppInfo);


        return "admin/mposApp/mposAppDetail"+Constants.ADMIN_TLF;
    }

    /**
     * admin > APP 버전관리 > MPOS 버전 관리 > 수정 화면
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mposAppModify.do", method = {RequestMethod.POST})
    public String mposAppModify(
            Model model,
            @ModelAttribute("search") MposAppCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        CommFncUtil.printVo("수정화면 조건",criteria);

        EgovMap mposAppInfo = mposAppService.getMposAppDetail(param);
        model.addAttribute("result",mposAppInfo);

        return "admin/mposApp/mposAppModify"+Constants.ADMIN_TLF;
    }

    /**
     * admin > APP 버전관리 > MPOS 버전 관리 > 등록 화면
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mposAppCreate.do", method = {RequestMethod.POST})
    public String mposAppCreate(
            Model model,
            @ModelAttribute("search") MposAppCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        CommFncUtil.printVo("등록화면 조건",criteria);

        return "admin/mposApp/mposAppCreate"+Constants.ADMIN_TLF;
    }

    /**
     * admin > APP 버전관리 > MPOS 버전 관리 > 수정저장 (AJAX)
     * @param vo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyMposAppAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyMposAppAjax(MposAppVo vo) throws Exception{

        CommFncUtil.printVo("수정 항목",vo);
        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = mposAppService.modifyMposAppService(vo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * admin > APP 버전관리 > MPOS 버전 관리 > 등록저장 (AJAX)
     * @param vo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createMposAppAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createMposAppAjax(MposAppVo vo) throws Exception{

        CommFncUtil.printVo("저장 항목",vo);
        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = mposAppService.createMposAppService(vo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }



}
