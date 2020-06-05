package kr.co.smartdatacorp.web.controller.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.service.BoardService;
import kr.co.smartdatacorp.core.service.ServiceService;
import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.core.vo.board.BoardCriteria;
import kr.co.smartdatacorp.core.vo.board.BoardVo;
import kr.co.smartdatacorp.web.controller.common.BaseController;

/**
*
* 프론트 메인
* @author
* @since
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
*   수정일                   수정자                   수정내용
*  -------      --------    ---------------------------
*
*
* </pre>
*/
@RequestMapping("/main")
@Controller("front.MainController")
public class MainController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(MainController.class);

    /**
     * 회원 서비스
     */
    @Resource(name = "userService")
    private UserService userService;

    /**
     * 게시판 서비스
     */
    @Resource(name = "boardService")
    private BoardService boardService;

    @Resource(name = "serviceService")
    private ServiceService serviceService;

    //개발 인덱스 페이지....
    @RequestMapping("/frontIndex.do")
    public String adminIndex(){
        return "main/frontIndex"+Constants.FRONT_TF;
    }
    /**
     * 프론트 메인화면
     *
     * @param LoginCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping("/main.do")
    public String mainPage(Model model) throws Exception{

        //최근등록 공지사항 (3개)
        BoardCriteria boardCriteria = new BoardCriteria();
        boardCriteria.setRecordCountPerPage(3);
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_NOTI);
        boardCriteria.setSearchOpenYn(Constants.YES_NO_Y);
        List<BoardVo> notiVoList = boardService.getBoardList(boardCriteria);
        model.addAttribute("notiVoList", notiVoList);

        //메인화면 summaryInfo
        Map<String,Object> param = new HashMap();
        //해당가맹점 정보만 조회
        param.put("storeCode", loginSessionInfoFactory.getObject().getSessionStoreCode());
        param.put("companyInfoId", loginSessionInfoFactory.getObject().getSessionCompanyInfoId());
        param.put("userTypeCd", loginSessionInfoFactory.getObject().getSessionUserTypeCd());

        EgovMap summaryInfoMap = serviceService.getFrontMainSummaryInfo(param);
        model.addAttribute("summaryInfoMap", summaryInfoMap);

        /*
        //팝업목록 조회
        PopupCriteria popupCriteria = new PopupCriteria();
        popupCriteria.setSearchPopupLvlTypeCd(Constants.POPUP_LVL_TYPE_CD_ALL);
        popupCriteria.setSearchPopupYn(Constants.YES_NO_Y);
        List<PopupVo> popupVoList = popupService.getPopupListFront(popupCriteria);

        model.addAttribute("popupVoList", popupVoList);

        */

        return "main/main"+Constants.FRONT_TF_MAIN;
    }



}