package kr.co.smartdatacorp.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import kr.co.smartdatacorp.core.service.MenuService;
import kr.co.smartdatacorp.core.vo.menu.MenuCriteria;
import kr.co.smartdatacorp.core.vo.menu.MenuGrpCriteria;
import kr.co.smartdatacorp.core.vo.menu.MenuGrpMenuListVo;
import kr.co.smartdatacorp.core.vo.menu.MenuGrpStructCriteria;
import kr.co.smartdatacorp.core.vo.menu.MenuGrpStructVo;
import kr.co.smartdatacorp.core.vo.menu.MenuGrpVo;
import kr.co.smartdatacorp.core.vo.menu.MenuVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;
import egovframework.rte.psl.dataaccess.util.EgovMap;
/**
*
* Menu Controller 클래스
* @author 이인희
* @since 2018.10.11
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일      수정자                 수정내용
*  -------    --------    ---------------------------
*   2018.10.11  이인희               최초 생성
*
* </pre>
*/
@RequestMapping("/admin/authMng")
@Controller
public class MenuController extends BaseController {

    protected static final Log logger = LogFactory.getLog(MenuController.class);

    @Resource(name = "menuService")
    MenuService menuService;
    /**
     * 메뉴목록 조회 화면
     *
     * @param
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menu/menuList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getMenuList(Model model
                              , @ModelAttribute("menuCriteria") MenuCriteria menuCriteria
                                ) throws Exception{
        menuCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        Map<String,Object> result = menuService.getMenuList(menuCriteria);
        model.addAttribute("result", result);
        return "admin/menu/menuList"+Constants.ADMIN_TLF;
    }

    /**
     * 메뉴목록 조회(AJAX)
     *
     * @param MenuCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menu/getMenuListAjax.do", method = {RequestMethod.POST} )
    public String getFaqBoardListAjax( @ModelAttribute("menuCriteria") MenuCriteria menuCriteria
                                      ,Model model
                                      ) throws Exception{
        Map<String,Object> result = menuService.getMenuList(menuCriteria);
        model.addAttribute("result", result);
        return "admin/menu/include/menuList_INC";
    }

    /**
     * 메뉴상세조회(AJAX)
     *
     * @param MenuCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menu/menuDetailAjax.do", method = {RequestMethod.POST} )
    public String getMenuDetail( @ModelAttribute("menuCriteria") MenuCriteria menuCriteria
                                      ,Model model
                                      ) throws Exception{
        if(menuCriteria.getSearchMenuSeq()!=null){
            MenuVo menuVo = menuService.getMenuDetail(menuCriteria);
            model.addAttribute("menuVo", menuVo);
        }
        return "admin/menu/include/menuList_MenuProcess_POP";
    }


    /**
     * 메뉴 저장(AJAX)
     *
     * @param  Model
     * @param  MenuVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/menu/createMenuAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> createMenuAjax(Model model
                                            ,MenuVo menuVo
                                            ) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        menuVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Integer menuUrlDupChk = menuService.getMenuUrlDupChkCnt(menuVo);
        if(menuUrlDupChk>0){
            result.put("result", Constants.RESULT_EXIST);
            return result;
        }
        if(menuVo.getRepresentMenuYn().equals(Constants.YES_NO_Y)){
            Integer menuBusinessTypeCnt = menuService.getMenuBusinessTypeRepresentCnt(menuVo);
            if(menuBusinessTypeCnt>0){
                result.put("result", Constants.ERROR_BUSINESS_TYPE_DUP);
                return result;
            }
        }

        Integer cnt = menuService.createMenu(menuVo);
        if(cnt==null || cnt <1){
            throw new Exception(messageSource.getMessage("fail.common.noupdate" ,new String[]{}, Locale.KOREA));
        }
        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 메뉴 수정(AJAX)
     *
     * @param  Model
     * @param  MenuVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/menu/modifyMenuAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> modifyMenuAjax(Model model
                                            ,MenuCriteria menuCriteria
                                            ,MenuVo menuVo
                                            ) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        menuVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Integer menuUrlDupChk = menuService.getMenuUrlDupChkCnt(menuVo);
        if(menuUrlDupChk>0){
            result.put("result", Constants.RESULT_EXIST);
            return result;
        }
        if(menuVo.getRepresentMenuYn().equals(Constants.YES_NO_Y)){
            Integer menuBusinessTypeCnt = menuService.getMenuBusinessTypeRepresentCnt(menuVo);
            if(menuBusinessTypeCnt>0){
                result.put("result", Constants.ERROR_BUSINESS_TYPE_DUP);
                return result;
            }
        }

        Integer cnt = menuService.modifyMenu(menuVo);
        if(cnt==null || cnt <1){
            throw new Exception(messageSource.getMessage("fail.common.noupdate" ,new String[]{}, Locale.KOREA));
        }
        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 메뉴그룹 메뉴관리 화면
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuGrp/menuGrpMenuList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String menuGrpMenuList(Model model
                              , @ModelAttribute("menuGrpCriteria") MenuGrpCriteria menuGrpCriteria
                                ) throws Exception{
        List<MenuGrpVo> menuGrpVoList = menuService.getMenuGrpList(menuGrpCriteria);
        model.addAttribute("menuGrpVoList", menuGrpVoList);
        return "admin/menu/menuGrpMenuList"+Constants.ADMIN_TLF;
    }

    /**
     * 메뉴그룹 상세조회(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuGrp/getMenuGrpDetailAjax.do", method = {RequestMethod.POST} )
    public String getMenuGrpDetailAjax(Model model
                                    , @ModelAttribute("menuGrpCriteria") MenuGrpCriteria menuGrpCriteria
                                    ) throws Exception{

        MenuGrpVo menuGrpVo = menuService.getMenuGrpDetail(menuGrpCriteria);

        model.addAttribute("menuGrpVo", menuGrpVo);
        return "admin/menu/include/menuGrpMenuList_MenuGrpDetail_INC";
    }

    /**
     * 메뉴관리 메뉴그룹 목록(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuGrp/getMenuGrpListAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> getMenuGrpListAjax(Model model
                                    , @ModelAttribute("menuGrpCriteria") MenuGrpCriteria menuGrpCriteria
                                    ) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();
        List<MenuGrpVo> menuGrpVoList = menuService.getMenuGrpList(menuGrpCriteria);

        result.put("menuGrpVoList", menuGrpVoList);
        return result;
    }

    /**
     * 메뉴그룹 메뉴 목록(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuGrp/getMenuGrpMenuListAjax.do", method = {RequestMethod.POST} )
    public String getMenuGrpMenuListAjax(Model model
                                      , @ModelAttribute("menuCriteria") MenuCriteria menuCriteria
                                ) throws Exception{
        //업무구분 검색
        List<EgovMap> searchBusinessTypeCdList = menuService.getBusinessTypeCdListByGrp(menuCriteria);
        model.addAttribute("searchBusinessTypeCdList", searchBusinessTypeCdList);

        List<MenuVo> menuVo = menuService.getMenuGrpMenuList(menuCriteria);
        model.addAttribute("menuVo", menuVo);
        return "admin/menu/include/menuGrpMenuList_INC";
    }

    /**
     * 메뉴그룹의 메뉴의 사용여부 수정(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/menuGrp/modifyMenuGrpMenuAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> modifyMenuGrpMenuAjax(Model model
                                            , MenuGrpMenuListVo menuGrpMenuListVo
                                            , @RequestParam(value ="useMenuSeqList" , required=false) Integer[] useMenuSeqList
                                            ) throws Exception{
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        menuGrpMenuListVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();
        menuService.modifyMenuGrpMenu(menuGrpMenuListVo,useMenuSeqList);

        result.put("result", Constants.RESULT_SUCCESS);

        return result;
    }

    /**
     * 메뉴그룹 작성 수정 모달 팝업(AJAX)
     *
     * @param MenuCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuGrp/menuGrpMenuPopupAjax.do", method = {RequestMethod.POST} )
    public String menuGrpMenuPopupAjax( @ModelAttribute("menuGrpCriteria") MenuGrpCriteria menuGrpCriteria
                                      ,@RequestParam(value = "mode",required = false) String mode
                                      ,Model model
                                      ) throws Exception{
        if(mode!=null&&mode.equals("modify")){
            MenuGrpVo menuGrpVo = menuService.getMenuGrpDetail(menuGrpCriteria);

            model.addAttribute("menuGrpVo", menuGrpVo);
        }
        return "admin/menu/include/menuGrpMenuList_MenuGrpProcess_POP";
    }

    /**
     * 메뉴그룹 등록/수정(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuGrp/processMenuGrpAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> processMenuGrpAjax(Model model
                                    , @ModelAttribute("menuGrpVo") MenuGrpVo menuGrpVo
                                    ,@RequestParam(value = "procMode",required = false) String mode
                                    ) throws Exception{
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        menuGrpVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();
        String resultString="";
        if(mode!=null&&mode.equals("modify")){
            resultString=menuService.modifyMenuGrp(menuGrpVo);

            result.put("result", resultString);
        }else if(mode!=null&&mode.equals("create")){
            resultString=menuService.createMenuGrp(menuGrpVo);

            result.put("result", resultString);
        }

        return result;
    }

    /**
     * 메뉴그룹구조관리 화면
     *
     * @param
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/menuGrpStructList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String menuGrpStructList(
                                 Model model
                                ,@ModelAttribute("menuGrpCriteria") MenuGrpCriteria menuGrpCriteria
                                ) throws Exception{
        List<MenuGrpVo> menuGrpVoList = menuService.getMenuGrpList(menuGrpCriteria);
        model.addAttribute("menuGrpVoList", menuGrpVoList);

        return "admin/menu/menuGrpStructList"+Constants.ADMIN_TLF;
    }

    /**
     * 메뉴그룹구조 목록 조회(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/getMenuGrpStructListAjax.do", method = {RequestMethod.POST} )
    public String getMenuGrpStructListAjax(Model model
                                    , @ModelAttribute("menuGrpStructCriteria") MenuGrpStructCriteria menuGrpStructCriteria
                                    ) throws Exception{
        List<MenuGrpStructVo> menuGrpStructVoList = menuService.getMenuGrpStructList(menuGrpStructCriteria);
        model.addAttribute("menuGrpStructVoList", menuGrpStructVoList);
        //model.addAttribute("menuGrpStructVoList", menuGrpStructVoList);
        return "admin/menu/include/menuGrpMenuList_MenuGrpStructList_INC";
    }

    /**
     * 메뉴그룹구조 상세 조회(AJAX)
     *
     * @param MenuCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/getMenuGrpStructAjax.do", method = {RequestMethod.POST} )
    public String getMenuGrpStructAjax(  @ModelAttribute("menuGrpStructCriteria") MenuGrpStructCriteria menuGrpStructCriteria
                                      ,Model model
                                      ) throws Exception{
        if(menuGrpStructCriteria.getSearchMenuGrpStructSeq()!=null&&menuGrpStructCriteria.getSearchMenuGrpStructSeq()!=0){
            MenuGrpStructVo menuGrpStructVo = menuService.getMenuGrpStructDetail(menuGrpStructCriteria);
            model.addAttribute("menuGrpStructVo", menuGrpStructVo);
        }
        return "admin/menu/include/menuGrpStructList_MenuStructDetail_INC";
    }

    /**
     * 메뉴그룹구조 메뉴 목록 조회(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/getMenuGrpMenuListForStructAjax.do", method = {RequestMethod.POST} )
    public String getMenuGrpMenuListForStructAjax(Model model
                                      , @ModelAttribute("menuCriteria") MenuCriteria menuCriteria
                                ) throws Exception{
        menuCriteria.setSearchRepresentMenuYn(Constants.YES_NO_Y);
        List<MenuVo> menuVo = menuService.getMenuGrpMenuList(menuCriteria);
        List<Integer> childList = menuService.getMenuStructChildList(menuCriteria);
        List<Integer> unableList = menuService.getMenuStructUnableList(menuCriteria);
        model.addAttribute("menuVo", menuVo);
        model.addAttribute("childList", childList);
        model.addAttribute("unableList", unableList);
        return "admin/menu/include/menuGrpStructList_MenuGrpMenuListForStruct_INC";
    }

    /**
     * 메뉴그룹구조 메뉴 저장(AJAX)
     *
     * @param  Model
     * @param  MenuGrpCriteria
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/processMenuStructAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> processMenuStructAjax(Model model
                                            , MenuGrpStructCriteria menuGrpStructCriteria
                                            , MenuGrpStructVo menuGrpStructVo
                                            , @RequestParam(value="useMenuSeqList",required=false) String[] useMenuSeqList
                                            ) throws Exception{
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        menuGrpStructVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();
        //Integer cnt = menuService.createMenuStruct(menuGrpStructVo);
        Integer cnt = menuService.processMenuStruct(menuGrpStructCriteria,menuGrpStructVo,useMenuSeqList);
        //menuService.modifyMenuGrpMenuAjax(menuGrpMenuListVo,useMenuSeqList);

        if(cnt==null || cnt <1){
            throw new Exception(messageSource.getMessage("fail.common.noupdate" ,new String[]{}, Locale.KOREA));
        }
        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * 메뉴그룹구조 화면표시명 수정(AJAX)
     *
     * @param  MenuGrpStructCriteria
     * @param  MenuGrpStructVo
     * @param  MenuGrpStructVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/modifyMenuStructScreenNmAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> modifyMenuStructScreenNmAjax(Model model
                                            , MenuGrpStructVo menuGrpStructVo
                                            ) throws Exception{
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        menuGrpStructVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();
        //Integer cnt = menuService.createMenuStruct(menuGrpStructVo);
        Integer cnt = menuService.modifyMenuStructScreenNm(menuGrpStructVo);
        //menuService.modifyMenuGrpMenuAjax(menuGrpMenuListVo,useMenuSeqList);

        if(cnt==null || cnt <1){
            throw new Exception(messageSource.getMessage("fail.common.noupdate" ,new String[]{}, Locale.KOREA));
        }
        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }
    /**
     * 메뉴그룹구조화면 복사, 붙여넣기(AJAX)
     *
     * @param  MenuGrpStructCriteria
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/createMenuStructByNodeCopyAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> createMenuStructByNodeCopyAjax(Model model
                                            , MenuGrpStructCriteria menuGrpStructCriteria
                                            ) throws Exception{
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        menuGrpStructCriteria.setSearchSessionUserInfoId(loginSessionInfoFactory.getObject().getSessionUserInfoId());
        Map<String,Object> result = new HashMap<String,Object>();
        Integer cnt = menuService.updateMenuStructParentMenu(menuGrpStructCriteria);

        if(cnt==null){
            throw new Exception(messageSource.getMessage("fail.common.noupdate" ,new String[]{}, Locale.KOREA));
        }else if(cnt > 0) result.put("result", Constants.RESULT_SUCCESS);
        else if(cnt == -1) result.put("result", Constants.RESULT_REJECT);
        else if(cnt == -2) result.put("result", Constants.RESULT_NO_EXIST);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * 메뉴그룹구조 삭제(AJAX)
     *
     * @param  MenuGrpStructCriteria
     * @throws Exception
     */
    @RequestMapping(value = "/menuStruct/deleteMenuStructAjax.do", method = {RequestMethod.POST} )
    @ResponseBody
    public Map<String,Object> deleteMenuStructAjax(Model model
                                            , MenuGrpStructCriteria menuGrpStructCriteria
                                            ) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();
        if(menuService.deleteMenuStruct(menuGrpStructCriteria))
            result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 메뉴 삭제(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/menu/deleteMenuAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteFaqAjax(@RequestParam("deleteMenuSeq") Integer[] deleteMenuSeq) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        menuService.deleteMenu(deleteMenuSeq);
        result.put("result", Constants.RESULT_SUCCESS);

        return result;
    }
}
