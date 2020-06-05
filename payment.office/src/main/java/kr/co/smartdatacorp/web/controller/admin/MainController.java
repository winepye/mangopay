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

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.service.ServiceService;
import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.user.UserCriteria;
import kr.co.smartdatacorp.web.controller.common.BaseController;

/**
*
* Main List Controller 클래스
* @author 이인희
* @since 2016.05.26
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일                   수정자                   수정내용
*  -------      --------    ---------------------------
*   2018.10.26  이인희                   최초 생성
*
* </pre>
*/
@RequestMapping("/admin/main")
@Controller("admin.MainController")
public class MainController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(MainController.class);

    /**
     * 회원 서비스
     */
    @Resource(name = "userService")
    private UserService userService;

    @Resource(name = "serviceService")
    private ServiceService serviceService;


    /**
     * 관리자메인화면
     *
     * @param UserCriteria
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/adminMainList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getAdminMainList( @ModelAttribute("userCriteria") UserCriteria userCriteria
                                      ,Model model) throws Exception{

        Map<String,Object> result = new HashMap<String,Object>();

        //회원정보
        userCriteria.setLoginSessionInfoFactory(loginSessionInfoFactory);
        userCriteria.setSearchUserInfoId(userCriteria.getSessionUserInfoId());
        EgovMap userVo = userService.getUserDetail(userCriteria);
        result.put("userVo", userVo);

        //메인화면 summaryInfo
        Map<String,Object> param = new HashMap();
        //해당가맹점 정보만 조회
        /*param.put("storeCode", loginSessionInfoFactory.getObject().getSessionStoreCode());
        param.put("companyInfoId", loginSessionInfoFactory.getObject().getSessionCompanyInfoId());
        param.put("userTypeCd", loginSessionInfoFactory.getObject().getSessionUserTypeCd());*/

        EgovMap summaryInfo = serviceService.getFrontMainSummaryInfo(param);
        result.put("summaryInfo", summaryInfo);

        List<EgovMap> summaryInfo2 = serviceService.getFrontMainSummaryInfo2(param);
        result.put("summaryInfo2", summaryInfo2);

        List<EgovMap> summaryInfo3 = serviceService.getFrontMainSummaryInfo3(param);
        result.put("summaryInfo3", summaryInfo3);

        List<EgovMap> summaryInfo4 = serviceService.getFrontMainSummaryInfo4(param);
        result.put("summaryInfo4", summaryInfo4);

        model.addAttribute("result", result);

        return "admin/main/mainList"+Constants.ADMIN_TF;
    }

    //개발 인덱스 페이지....
    @RequestMapping("/adminIndex.do")
    public String adminIndex(){
        return "admin/main/adminIndex"+Constants.ADMIN_TF;
    }
}