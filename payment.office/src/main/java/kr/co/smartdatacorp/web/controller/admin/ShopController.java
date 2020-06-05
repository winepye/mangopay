package kr.co.smartdatacorp.web.controller.admin;

/*import com.sun.deploy.net.HttpRequest;
import com.sun.deploy.net.HttpResponse;*/
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.*;
import kr.co.smartdatacorp.core.service.BrandService;
import kr.co.smartdatacorp.core.service.CompanyService;
import kr.co.smartdatacorp.core.service.ShopService;
import kr.co.smartdatacorp.core.vo.shop.ShopCriteria;
import kr.co.smartdatacorp.core.vo.shop.ShopTerminalVo;
import kr.co.smartdatacorp.core.vo.shop.ShopVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hsmf.MAPIMessage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/admin/shop")
@Controller("admin.ShopController")
public class ShopController extends BaseController {

    final static Logger log = LoggerFactory.getLogger(ShopController.class);

    @Resource(name = "shopService")
    private ShopService shopService;

    @Resource(name = "companyService")
    private CompanyService companyService;

    @Resource(name = "brandService")
    private BrandService brandService;

    /**
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/shopExcelUpload.do", method = {RequestMethod.POST})
    public String shopExcelUpload() throws Exception{

        return "admin/shop/shopExcelUpload"+Constants.ADMIN_TLF;

    }

    @RequestMapping(value = "/shopExcelUploadAjax.do", method = {RequestMethod.POST})
    public String excelUploadAjax(MultipartHttpServletRequest request, Model model)  throws Exception{

        Map<String, Object> rslt =  new HashMap<String, Object>();

        MultipartFile excelFile =request.getFile("excelFile");

        System.out.println("파라미터명" + excelFile.getName());
        System.out.println("파일크기" + excelFile.getSize());
        System.out.println("파일 존재" + excelFile.isEmpty());
        System.out.println("오리지날 파일 이름" + excelFile.getOriginalFilename());

        System.out.println("엑셀 파일 업로드 컨트롤러");
        if(excelFile==null || excelFile.isEmpty()){
            throw new RuntimeException("엑셀파일을 선택 해 주세요.");
        }

        File destFile = new File(excelFile.getOriginalFilename());

        try{
            excelFile.transferTo(destFile);
        }catch (IOException e){
            throw new RuntimeException(e.getMessage(),e);
        }catch (IllegalStateException e){
            throw new RuntimeException(e.getMessage(),e);
        }

        List<Map<String, Object>> errList =  shopService.excelUpload(destFile); // 작업 완료 후 파일 삭제


        FileUtils.forceDelete(destFile);

        rslt.put("result", errList);

        model.addAttribute("result", rslt);

        return "admin/shop/include/shopExcelUpload_INC";
    }

    /**
     * admin > 고객사관리 > 매장관리 > 목록
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/shopList.do", method = {RequestMethod.POST})
    public String shopList(
            @ModelAttribute("search") ShopCriteria criteria
            , Model model) throws Exception{

        criteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
        criteria.setSortOrder("A.SHOP_INFO_ID DESC");

        Map<String, Object> shopReqList = shopService.getShopReqList(criteria);

        model.addAttribute("result", shopReqList);

        log.debug(""+shopReqList.get("pBizTypeList"));

        return "admin/shop/shopList"+ Constants.ADMIN_TLF;
    }

    /**
     * 고객사 정보 (팝업)
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getCompanyDetailPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String getCompanyDetailPop(
            @RequestParam Map<String,Object> param
            ,Model model ) throws Exception {
        CommFncUtil.printParameterLogByMap("ShopController", "getCompanyDetailPop", param);

        Map<String, Object> result = companyService.getStoreDetail(param);

        model.addAttribute("result", result);

        return "admin/shop/companyDetailPop"+Constants.ADMIN_EMPTY;
    }

    /**
     * 브랜드 정보 (팝업)
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getBrandDetailPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String getBrandDetailPop(
            @RequestParam Map<String,Object> param
            ,Model model ) throws Exception {
        CommFncUtil.printParameterLogByMap("ShopController", "getBrandDetailPop", param);

        EgovMap brandInfo = brandService.getBrandInfo(param);

        model.addAttribute("result", brandInfo);

        return "admin/shop/brandDetailPop"+Constants.ADMIN_EMPTY;
    }

    /**
     * 매장 등록 (팝업)
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createShopPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String createShopPop(
            @RequestParam Map<String,Object> param
            ,Model model ) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();

        // 고객사목록
        List<EgovMap> companyList = shopService.getCompanyList();
        result.put("companyList",companyList);

        // 브랜드목록
        List<EgovMap> brandList = shopService.getBrandList();
        result.put("brandList",brandList);

        model.addAttribute("result", result);

        return "admin/shop/shopCreatePop"+Constants.ADMIN_EMPTY;
    }

    /**
     * 매장단말기 등록 (팝업)
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createShopTerminalPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String createShopTerminalPop(
            @RequestParam Map<String,Object> param
            ,Model model ) throws Exception {

        log.debug("shopInfoId = "+param.get("shopInfoId"));
        String shopInfoId = (String) param.get("shopInfoId");

        Map<String, Object> result = new HashMap<String, Object>();

        EgovMap shopTerminalBasicInfo = shopService.getShopTerminalBasicInfo(shopInfoId);
        result.put("shopTerminalBasicInfo", shopTerminalBasicInfo);

        result.put("shopInfoId",shopInfoId);

        model.addAttribute("result", result);

        return "admin/shop/shopTerminalCreatePop"+Constants.ADMIN_EMPTY;
    }

    /**
     * 매장 수정 (팝업)
     * @param param
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyShopPop.do", method = {RequestMethod.GET,RequestMethod.POST})
    public String modifyShopPop(
            @RequestParam Map<String,Object> param
            ,Model model ) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();

        CommFncUtil.printParameterLogByMap("","매장수정 팝업 인자",param);

        // 매장정보
        EgovMap shopInfo = shopService.getShopInfo((String) param.get("shopInfoId"));
        result.put("shopInfo",shopInfo);

        // 고객사목록
        List<EgovMap> companyList = shopService.getCompanyList();
        result.put("companyList",companyList);

        // 브랜드목록
        List<EgovMap> brandList = shopService.getBrandList();
        result.put("brandList",brandList);

        model.addAttribute("result", result);

        return "admin/shop/shopModifyPop"+Constants.ADMIN_EMPTY;
    }

    /**
     * admin > 고객사관리 > 매장관리 > 목록 검색(AJAX)
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getShopListAjax.do", method = {RequestMethod.POST})
    public String getPayServiceListAjax(
            @ModelAttribute("search") ShopCriteria criteria
            , Model model) throws Exception{

        CommFncUtil.printVo("PayCriteria", criteria);

        Map<String, Object> shopReqList = shopService.getShopReqList(criteria);

        model.addAttribute("result", shopReqList);

        return "admin/shop/include/shopList_INC";
    }

    /**
     * admin > 고객사관리 > 매장관리 > 목록 : 과세 및 봉사료 일괄 저장
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/selectModifyShopAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> selectModifyShopAjax(
            @RequestParam Map<String, Object> paramMap) throws Exception{
        CommFncUtil.printParameterLogByMap("","selectModifyShopAjax",paramMap);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = shopService.checkListSave(paramMap);

        if(cnt >= 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * admin > 고객사관리 > 매장관리 > 상세 : 서비스제공자 저장
     * @param paramMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/mergeShopTerminalSrvProvAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> mergeShopTerminalSrvProvAjax(
            @RequestParam Map<String, Object> paramMap) throws Exception{
        CommFncUtil.printParameterLogByMap("ShopController","서비스제공자 저장",paramMap);

        Map<String, Object> result = new HashMap<String, Object>();

        paramMap.put("sessionUserInfoId",loginSessionInfoFactory.getObject().getSessionUserInfoId());

        Integer cnt = shopService.mergeShopTerminalSrvProvListSave(paramMap);

        if(cnt >= 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * admin > 고객사관리 > 매장관리 > 상세페이지
     * @param param
     * @param criteria
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/shopDetail.do", method = {RequestMethod.POST})
    public String shopDetail(
            @RequestParam Map<String, Object> param,
            @ModelAttribute("search") ShopCriteria criteria,
            Model model) throws Exception{

        CommFncUtil.printVo("ShopCriteria",criteria);

        CommFncUtil.printParameterLogByMap("ShopController","shopDetail",param);


        Map<String, Object> result = shopService.getDetailInfo(criteria);

        model.addAttribute("shopInfo",result.get("shopInfo"));
        model.addAttribute("shopTerminalList",result.get("shopTerminalList"));

        return "admin/shop/shopDetail"+Constants.ADMIN_TLF;
    }

    /**
     * admin > 고객사관리 > 매장관리 > 상세페이지 : 매장 단말기정보 검색(AJAX)
     * @param paramMap
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getShopTerminalInfoAjax.do", method = {RequestMethod.POST})
    public String getShopTerminalInfoAjax(
            @RequestParam Map<String, Object> paramMap
            , Model model) throws Exception{

        CommFncUtil.printParameterLogByMap("ShopController","매장 단말기정보 검색",paramMap);

        Map<String, Object> result = shopService.getShopTerminalInfo(paramMap);

        List<EgovMap> srvProvList = shopService.getCommonCodeList("SERVICE_PROVIDER");

        result.put("srvProvCdList",srvProvList);

        model.addAttribute("result", result);

        return "admin/shop/include/shopTerminalList_INC";
    }

    /**
     * admin > 고객사관리 > 매장관리 > 수정페이지
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/shopModify.do", method = {RequestMethod.POST})
    public String shopModify(
            Model model,
            @ModelAttribute("search") ShopCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        EgovMap payInfo = null;//shopService.getPayServiceDetail(param);

        List<EgovMap> serProvList = shopService.getCommonCodeList("SERVICE_PROVIDER");
        List<EgovMap> payMeanList = shopService.getCommonCodeList("PAYMENT_MEAN");
        List<EgovMap> payMethodList = shopService.getCommonCodeList("PAYMENT_METHOD");

        model.addAttribute("serProvList", serProvList); // 서비스제공자 목록
        model.addAttribute("payMeanList", payMeanList); // 결제수단 목록
        model.addAttribute("payMethodList", payMeanList); // 결제방식 목록
        model.addAttribute("result",payInfo); // 결제서비스 상세정보

        return "admin/shop/shopModify"+Constants.ADMIN_TLF;
    }*/

    /**
     * admin > 고객사관리 > 매장관리 > 등록페이지
     * @param model
     * @param criteria
     * @param param
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value = "/shopCreate.do", method = {RequestMethod.POST})
    public String shopCreate(
            Model model,
            @ModelAttribute("search") ShopCriteria criteria,
            @RequestParam Map<String, Object> param) throws Exception{

        List<EgovMap> serProvList = shopService.getCommonCodeList("SERVICE_PROVIDER");
        List<EgovMap> payMeanList = shopService.getCommonCodeList("PAYMENT_MEAN");
        List<EgovMap> payMethodList = shopService.getCommonCodeList("PAYMENT_METHOD");

        model.addAttribute("serProvList", serProvList); // 서비스제공자 목록
        model.addAttribute("payMeanList", payMeanList); // 결제수단 목록
        model.addAttribute("payMethodList", payMeanList); // 결제방식 목록

        return "admin/shop/shopCreate"+Constants.ADMIN_TLF;
    }*/

    /**
     * admin > 고객사관리 > 매장관리 > 수정 저장 (AJAX)
     * @param shopVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyShopAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyShopAjax(ShopVo shopVo) throws Exception{

        CommFncUtil.printVo("ShopVo", shopVo);

        shopVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = shopService.modifyShopAjax(shopVo);

        // 매장정보
        EgovMap shopInfo = shopService.getShopInfo(shopVo.getShopInfoId());
        result.put("shopInfo",shopInfo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 등록 저장 (AJAX)
     * @param shopVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createShopAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createShopAjax(ShopVo shopVo) throws Exception{

        CommFncUtil.printVo("ShopVo", shopVo);

        shopVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = shopService.createShopAjax(shopVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 등록 저장 (AJAX)
     * @param shopTerminalVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/createShopTeminalAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> createShopTeminalAjax(ShopTerminalVo shopTerminalVo) throws Exception{

        CommFncUtil.printVo("단말기 등록", shopTerminalVo);

        shopTerminalVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = shopService.createShopTerminalAjax(shopTerminalVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * admin > 간편결제관리 > 결제서비스 관리 > 등록 저장 (AJAX)
     * @param shopTerminalVo
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/modifyShopTeminalAjax.do", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> modifyShopTeminalAjax(ShopTerminalVo shopTerminalVo) throws Exception{

        CommFncUtil.printVo("단말기 수정", shopTerminalVo);

        shopTerminalVo.setSessionUserInfoId(loginSessionInfoFactory.getObject().getSessionUserInfoId());

        Map<String, Object> result = new HashMap<String, Object>();

        Integer cnt = shopService.modifyShopTerminalAjax(shopTerminalVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);

        return result;
    }

    /**
     * 엑셀업로드 템플릿 파일 다운로드
     * @param response
     * @param request
     */
    @RequestMapping(value = "/templateDown.do", method = {RequestMethod.POST, RequestMethod.GET})
    public void tempDown(HttpServletResponse response, HttpServletRequest request){

        String fileName = "tempExcel.xls";
        String path = request.getSession().getServletContext().getRealPath("/");
        File file = new File(path+"tempExcel/sample2.xls");
        FileInputStream fileInputStream = null;
        ServletOutputStream servletOutputStream = null;

        try{

            String downName = null;
            String browser = request.getHeader("User-Agent");

            //파일 인코딩
            if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
                downName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
            } else {
                downName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
            }

            response.setHeader("Content-Type", "application/vnd.ms-xls");
            response.setHeader("Content-Disposition","attachment;filename=\"" + downName+"\"");

            fileInputStream = new FileInputStream(file);
            servletOutputStream = response.getOutputStream();

            byte b [] = new byte[1024];
            int data = 0;

            while((data=(fileInputStream.read(b, 0, b.length))) != -1){
                servletOutputStream.write(b, 0, data);
            }

            servletOutputStream.flush();

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if(servletOutputStream!=null){

                try {
                    servletOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

            }

            if (fileInputStream!=null){

                try {
                    fileInputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

            }
        }
    }


}
