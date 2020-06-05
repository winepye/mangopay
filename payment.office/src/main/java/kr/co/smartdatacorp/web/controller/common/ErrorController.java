package kr.co.smartdatacorp.web.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
@RequestMapping("/common/error")
public class ErrorController {

    @RequestMapping("/errError.do")
    public String goErrorPage(){
        return "error/errError";
    }
}
