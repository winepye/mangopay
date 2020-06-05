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

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.service.CodeService;
import kr.co.smartdatacorp.core.service.CodeGroupService;
import kr.co.smartdatacorp.core.vo.code.CodeCriteria;
import kr.co.smartdatacorp.core.vo.code.CodeGroupCriteria;
import kr.co.smartdatacorp.core.vo.code.CodeVo;
import kr.co.smartdatacorp.core.vo.code.CodeVoList;
import kr.co.smartdatacorp.web.controller.common.BaseController;
import kr.co.smartdatacorp.core.vo.code.CodeGroupVo;

/**
*
* Code Controller 클래스
* @author 김준석
* @since 2018.10.11
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자                 수정내용
*  -------    --------    ---------------------------
*   2018.10.11  이인희                최초 생성
*
* </pre>
*/
@RequestMapping("/admin/baseMng")
@Controller
public class CodeController extends BaseController {

    protected static final Log logger = LogFactory.getLog(CodeController.class);

    @Resource(name = "codeService")
    CodeService codeService;

    @Resource(name = "codeGroupService")
    CodeGroupService codeGroupService;

    /**
     * 코드 관리화면
     *
     * @param CodeGroupCriteria :검색 조건 수집
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/code/codeMng.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getCodeGroupList(@ModelAttribute("codeGroupCriteria") CodeGroupCriteria codeGroupCriteria
                                         ,Model model) throws Exception{
        logger.info("CodeGroup Search Start...............");

        Map<String, Object> result = new HashMap();

        List<CodeGroupVo> codeGroupVoList = codeGroupService.getCodeGroupList(codeGroupCriteria);

        result.put("codeGroupVoList", codeGroupVoList);

        model.addAttribute("result", result);

        return "admin/code/codeMng"+Constants.ADMIN_TLF;
    }

    /**
     * 코드그룹 목록 조회(AJAX)
     *
     * @param CodeCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/code/getCodeGroupListAjax.do", method = {RequestMethod.POST} )
    public String getCodeGroupListAjax(@ModelAttribute("codeGroupCriteria") CodeGroupCriteria codeGroupCriteria
                                      ,Model model
                                      ) throws Exception{

        Map<String, Object> result = new HashMap();

        List<CodeGroupVo> codeGroupVoList = codeGroupService.getCodeGroupList(codeGroupCriteria);

        result.put("codeGroupVoList", codeGroupVoList);

        model.addAttribute("result", result);

        return "admin/code/include/codeMng_INC";
    }

    /**
     * 코드그룹 상세 조회(AJAX)
     *
     * @param CodeGroupCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/code/getCodeGroupDetailAjax.do", method = {RequestMethod.GET,RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> getCodeGroupDetailAjax( @ModelAttribute("codeGroupCriteria") CodeGroupCriteria codeGroupCriteria
                                ,Model model
                               ) throws Exception{
        logger.info("CodeGroup getCodeGroupDetailAjax Start...............");

        Map<String,Object> result = new HashMap<String,Object>();

        CodeGroupVo codeGroupVo = codeGroupService.getCodeGroupDetail(codeGroupCriteria);

        result.put("codeGroupVo", codeGroupVo);

        return result;
    }

    /**
     * 코드그룹 수정(AJAX)
     *
     * @param CodeGroupVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/code/modifyCodeGroupAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyCodeGroupAjax(CodeGroupVo codeGroupVo) throws Exception{
        logger.info("CodeGroup modifyCodeGroupAjax Start...............");

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        codeGroupVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = codeGroupService.modifyCodeGroup(codeGroupVo);

        if(cnt == 1) result.put("message", "수정되었습니다");
        else result.put("message", "오류가 발생하였습니다.");

        result.put("cdGrp", codeGroupVo.getCdGrp());

        return result;
    }

    /**
     * 코드그룹 생성(AJAX)
     *
     * @param CodeGroupVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/code/createCodeGroupAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createCodeGroupAjax(CodeGroupVo codeGroupVo) throws Exception{
        logger.info("CodeGroup createCodeGroupAjax Start...............");

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        codeGroupVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        String resultMessage = codeGroupService.createCodeGroup(codeGroupVo);

        result.put("message", resultMessage);
        result.put("cdGrp", codeGroupVo.getCdGrp());

        return result;
    }

    /**
     * 코드목록 조회(AJAX)
     *
     * @param CodeCriteria :검색 조건 수집
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/code/getCodeListAjax.do", method = RequestMethod.POST)
    public String getCodeListAjax(@ModelAttribute("codeCriteria") CodeCriteria codeCriteria
                                         ,Model model) throws Exception{
        logger.info("Code getCodeListAjax Start...............");

        Map<String, Object> result = new HashMap();

        List<CodeVo> codeVoList = codeService.getCodeList(codeCriteria);

        result.put("codeVoList", codeVoList);

        model.addAttribute("result", result);

        return "admin/code/include/codeMng_INC1";
    }

    /**
     * 코드 조회(AJAX)
     *
     * @param CodeCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/code/getCodeDetailAjax.do", method = {RequestMethod.GET,RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> getCodeDetailAjax( @ModelAttribute("codeCriteria") CodeCriteria codeCriteria
                                ,Model model
                               ) throws Exception{
        logger.info("Code getCodeDetailAjax Start...............");

        Map<String,Object> result = new HashMap<String,Object>();

        CodeVo codeVo = codeService.getCodeDetail(codeCriteria);

        result.put("codeVo", codeVo);

        return result;
    }

    /**
     * 코드 수정(AJAX)
     *
     * @param CodeVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/code/modifyCodeAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyCodeAjax(CodeVo codeVo) throws Exception{
        logger.info("Code modifyCodeAjax Start...............");

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        codeVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = codeService.modifyCode(codeVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 코드 생성(AJAX)
     *
     * @param CodeVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/code/createCodeAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createCodeAjax(CodeVo codeVo) throws Exception{
        logger.info("Code createCodeAjax Start...............");

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        codeVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = codeService.modifyCode(codeVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 코드목록 Delete, Insert(AJAX)
     *
     * @param CodeVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/code/createCodeListAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createCodeListAjax(CodeVoList codeVoList
                                                ,@RequestParam(value="cdGrp", required = true) String cdGrp) throws Exception{
        logger.info("Code createCodeByArrayAjax Start...............");
        logger.info("Code cdGrp = " + cdGrp);

        System.out.println("codeVoList.size() = " + codeVoList.getCodeVoList().size());
        Map<String,Object> result = new HashMap<String,Object>();

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        codeVoList.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Integer cnt = codeService.createCodeList(codeVoList, cdGrp);

        if(1 == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }
}
