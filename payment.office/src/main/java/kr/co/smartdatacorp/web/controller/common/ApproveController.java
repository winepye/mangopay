package kr.co.smartdatacorp.web.controller.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.DateUtil;
import kr.co.smartdatacorp.core.bean.util.FileUtil;
import kr.co.smartdatacorp.core.dao.PaymentDao;
import kr.co.smartdatacorp.core.service.BoardService;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.service.PaymentService;
import kr.co.smartdatacorp.core.vo.board.BoardAnswerVo;
import kr.co.smartdatacorp.core.vo.board.BoardCriteria;
import kr.co.smartdatacorp.core.vo.board.BoardVo;
import kr.co.smartdatacorp.web.bean.api.AjaxResponse;
import kr.co.smartdatacorp.web.controller.common.BaseController;
/**
 * 게시판 컨트롤러 클래스
 * @author 이인희
 * @since 2018.10.18
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2018.10.18  이인희          최초 생성
 *  </pre>
 */
@RequestMapping("/common/approve")
@Controller("common.ApproveController")
public class ApproveController extends BaseController{

    @Resource(name = "boardService")
    private BoardService boardService;

    @Resource(name = "fileService")
    private FileService fileService;

    @Resource
    PaymentDao paymentDao;

    @Resource
    PaymentService paymentService;

    protected static final Log log = LogFactory.getLog(ApproveController.class);

    /**
     * 가맹점에서 스타트데이터로 결제요청
     * @param :
     * @return :
     * @exception :
     * @author : 이인희
     * @date : 2018. 08. 24.
     */
    @RequestMapping(value = "/cancel/cancelApproveAjax.do", method = {RequestMethod.POST} )
    //@RequestMapping(value = "/cancel/cancelApproveAjax.do", method = RequestMethod.POST)
    //@ResponseBody
    public void cancelApproveAjax(@RequestParam Map<String,Object> param
            ,Model model, HttpServletResponse response ) throws Exception{

        JSONObject json = new JSONObject();
        Map resultMap = new HashMap();
        String resultData = null;
        EgovMap storeInfo = paymentDao.getMasterStoreInfo(param);
        param.put("otcNum", storeInfo.get("otcNum"));
        param.put("memberId", storeInfo.get("memberId"));
        param.put("cardCompCode", storeInfo.get("cardCompCode"));
        param.put("formMgrNumber", storeInfo.get("mgrNum"));
        Map cancelMap = paymentService.reqCancelNice(param, storeInfo);
        if("0000".equals(cancelMap.get("approvalCancelResultCode")))
        {
            resultMap.put("resultCode", "0000");
            resultMap.put("resultMessage", "정상");
        } else
        {
            resultMap.put("resultCode", cancelMap.get("approvalCancelResultCode"));
            resultMap.put("resultMessage", cancelMap.get("approvalCancelResultMsg"));
        }
        AjaxResponse.responseAjaxObject(response, resultMap);
    }
}
