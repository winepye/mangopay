package kr.co.smartdatacorp.web.controller.front;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.DateUtil;
import kr.co.smartdatacorp.core.bean.util.FileUtil;
import kr.co.smartdatacorp.core.service.BoardService;
import kr.co.smartdatacorp.core.service.CodeService;
import kr.co.smartdatacorp.core.vo.board.BoardAnswerVo;
import kr.co.smartdatacorp.core.vo.board.BoardCriteria;
import kr.co.smartdatacorp.core.vo.board.BoardVo;
import kr.co.smartdatacorp.core.vo.code.CodeCriteria;
import kr.co.smartdatacorp.core.vo.code.CodeVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;

/**
*
* InformationController 클래스
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
@RequestMapping("/info")
@Controller("front.InformationController")
public class InformationController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(InformationController.class);

    /**
     * 이용약관
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/siteInfo/siterule.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String goSiterulePage() throws Exception{
        return "siteInfo/siterule"+Constants.FRONT_TLF;
    }
    /**
     * 개인정보취급방침
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/siteInfo/privacy.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String goPrivacyPage() throws Exception{
        return "siteInfo/privacy"+Constants.FRONT_TLF;
    }
}
