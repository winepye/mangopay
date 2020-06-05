package kr.co.smartdatacorp.web.bean.error;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
/**
*
* ReportErrorHandler 클래스
* -공통 에러 처리
* @author 이인희
* @since 2018.10.22
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일                 수정자                 수정내용
*  -------    --------    ---------------------------
*   2018.10.22  이인희                최초 생성
*
* </pre>
*/
public class ReportErrorHandler implements HandlerExceptionResolver  {

    final static Logger log = LoggerFactory.getLogger(ReportErrorHandler.class);

    private String view;
    public void setView(String view)
    {
     this.view = view;
    }

    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object obj, Exception exception)
    {
        log.debug("======================Error=========================");
        System.out.println("======================Error=========================");
        exception.printStackTrace();

        if(exception.getCause()!=null&&exception.getCause().getMessage()!=null){
            System.out.println("======================Error=========================");
            System.out.println("Report Error Cause : "+exception.getMessage());
            log.debug("Report Error Cause : "+exception.getMessage());
        }

    request.setAttribute("exception",exception);
    String ajaxCall = request.getHeader("x-requested-with");
    if (ajaxCall!=null&&ajaxCall.indexOf("XMLHttpRequest")>-1) {
        try{
        response.sendError(902);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
     return new ModelAndView(view);
    }
}
