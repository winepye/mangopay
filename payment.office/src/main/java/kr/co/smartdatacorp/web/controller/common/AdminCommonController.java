package kr.co.smartdatacorp.web.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.smartdatacorp.core.bean.constant.Constants;
/**
*
* Error Controller 클래스
* @author 이인희
* @since 2016.07.05
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일                 수정자                 수정내용
*  -------    --------    ---------------------------
*   2016.07.05  이인희                최초 생성
*
* </pre>
*/
@Controller
public class AdminCommonController extends BaseController{
    /**
     * 어드민 시작페이지를 리다이렉트한다 (로그인유무)
     *
     * @return String
     * @throws Exception
     */
    @RequestMapping("/admin")
    public String redirectAdminWelcomePage(){
        if(loginSessionInfoFactory.getObject().getSessionUserLvlCd()!=null && loginSessionInfoFactory.getObject().getSessionUserLvlCd().startsWith(Constants.USER_LVL_CD_M)){
            return "redirect:/admin/main/adminMainList.do";
        }else{
            return "redirect:/admin/login/login.do";
        }
    }
}
