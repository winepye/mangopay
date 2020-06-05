package kr.co.smartdatacorp.web.controller.admin;

import java.util.ArrayList;
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
import kr.co.smartdatacorp.core.bean.util.DateUtil;
import kr.co.smartdatacorp.core.bean.util.FileUtil;
import kr.co.smartdatacorp.core.service.BoardService;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.board.BoardAnswerVo;
import kr.co.smartdatacorp.core.vo.board.BoardCriteria;
import kr.co.smartdatacorp.core.vo.board.BoardVo;
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
@RequestMapping("/admin/board")
@Controller("admin.BoardController")
public class BoardController extends BaseController{

    @Resource(name = "boardService")
    private BoardService boardService;

    @Resource(name = "fileService")
    private FileService fileService;

    protected static final Log logger = LogFactory.getLog(BoardController.class);

    /**************************************************************************************************/
    /***************************************FAQ 시작*********************************************/
    /**************************************************************************************************/
    /**
     * 게시판 > FAQ 목록 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/faq/faqList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getFaqList( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                              ,Model model
                             ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_FAQ);

        if(boardCriteria.getSearchContentType() == null || boardCriteria.getSearchContentType().equals("")){
            boardCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
            boardCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-Constants.SEARCH_DEFAULT_PER_MONTH));
            boardCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));
        }

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "admin/board/faqList"+Constants.ADMIN_TLF;
    }

    /**
     * 게시판 > FAQ 목록 검색(AJAX)
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/faq/getFaqBoardListAjax.do", method = {RequestMethod.POST} )
    public String getFaqBoardListAjax(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                      ,Model model
                                      ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_FAQ);

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "admin/board/include/faqList_INC";
    }

    /**
     * 게시판 > FAQ 작성 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/faq/faqCreate.do", method = {RequestMethod.POST} )
    public String createFaq(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                  ,Model model ) throws Exception{
        return "admin/board/faqCreate"+Constants.ADMIN_TLF;
    }

    /**
     * FAQ 게시판 저장(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/faq/createFaqAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createFaqAjax(BoardVo boardVo
                                            ,@RequestParam(value="uploadList",required=false) String[] uploadList
                                            ) throws Exception{

        //uploadList 가 있다면  파일 그룹 시퀀스를 , uploadList 가 null 이라면 null 을 리턴한다.
        Integer fileGroupSeq = FileUtil.createAtchFileGrpSeq(loginSessionInfoFactory,uploadList,null);
        //리턴 받은 파일그룹 시퀀스를 셋팅
        boardVo.setAtchFileGrpSeq(fileGroupSeq);

        //세션에있는 로그인 정보를 셋팅
        boardVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.createBoard(Constants.BOARD_TYPE_CD_FAQ,boardVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * FAQ 게시판 삭제(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/faq/deleteFaqAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteFaqAjax(@RequestParam("deleteBoardSeq") String[] deleteBoardSeq) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.deleteBoard(deleteBoardSeq);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 게시판 > FAQ 상세화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/faq/faqDetail.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getFaqDetail( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_FAQ);
        BoardVo faqBoardVo = boardService.getBoardDetail(boardCriteria);
        model.addAttribute("faqBoardVo", faqBoardVo);
        return "admin/board/faqDetail"+Constants.ADMIN_TLF;
    }

    /**
     * 게시판 > FAQ 수정화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/faq/faqModify.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getFaqModify( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_FAQ);
        BoardVo faqBoardVo = boardService.getBoardDetail(boardCriteria);
        model.addAttribute("faqBoardVo", faqBoardVo);
        return "admin/board/faqModify"+Constants.ADMIN_TLF;
    }

    /**
     * FAQ 게시판 수정(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/faq/modifyFaqAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyFaqAjax(BoardVo boardVo) throws Exception{

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        boardVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.modifyBoard(Constants.BOARD_TYPE_CD_FAQ,boardVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }


    /**************************************************************************************************/
    /***************************************공지사항 시작*********************************************/
    /**************************************************************************************************/


    /**
     * 게시판 > 공지사항 목록 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/noti/notiList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getNotiList( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                              ,Model model
                             ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_NOTI);

        if(boardCriteria.getSearchContentType() == null || boardCriteria.getSearchContentType().equals("")){
            boardCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
            boardCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-Constants.SEARCH_DEFAULT_PER_MONTH));
            boardCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));
        }

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "admin/board/notiList"+Constants.ADMIN_TLF;
    }

    /**
     * 게시판 > 공지사항 목록 검색(AJAX)
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/noti/getNotiListAjax.do", method = {RequestMethod.POST} )
    public String getNotiListAjax(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                      ,Model model
                                      ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_NOTI);

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "admin/board/include/notiList_INC";
    }

    /**
     * 게시판 > 공지사항 작성 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/noti/notiCreate.do", method = {RequestMethod.POST} )
    public String createNoti(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria

                                  ,Model model ) throws Exception{
        return "admin/board/notiCreate"+Constants.ADMIN_TLF;
    }

    /**
     * 공지사항 게시판 저장(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/noti/createNotiAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createNotiAjax(BoardVo boardVo
                                            ,@RequestParam(value="uploadList",required=false) String[] uploadList
                                            ) throws Exception{
        //uploadList 가 있다면  파일 그룹 시퀀스를 , uploadList 가 null 이라면 null 을 리턴한다.
        Integer fileGroupSeq = FileUtil.createAtchFileGrpSeq(loginSessionInfoFactory,uploadList,null);
        //리턴 받은 파일그룹 시퀀스를 셋팅
        boardVo.setAtchFileGrpSeq(fileGroupSeq);
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        boardVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.createBoard(Constants.BOARD_TYPE_CD_NOTI,boardVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 공지사항 게시판 삭제(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/noti/deleteNotiAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteNotiAjax(@RequestParam("deleteBoardSeq") String[] deleteBoardSeq) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.deleteBoard(deleteBoardSeq);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 공지사항 > 공지사항 상세화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/noti/notiDetail.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getNotiDetail( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_NOTI);
        BoardVo notiBoardVo = boardService.getBoardDetail(boardCriteria);
        model.addAttribute("notiBoardVo", notiBoardVo);
        return "admin/board/notiDetail"+Constants.ADMIN_TLF;
    }

    /**
     * 게시판 > 공지사항 수정화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/noti/notiModify.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getNotiModify( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_NOTI);
        BoardVo notiBoardVo = boardService.getBoardDetail(boardCriteria);
        model.addAttribute("notiBoardVo", notiBoardVo);
        return "admin/board/notiModify"+Constants.ADMIN_TLF;
    }

    /**
     * 공지사항 게시판 수정(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/noti/modifyNotiAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyNotiAjax(BoardVo boardVo
                                            ,@RequestParam(value="uploadList",required=false) String[] uploadList
                                            ) throws Exception{
        //uploadList 가 있다면  파일 그룹 시퀀스를 , uploadList 가 null 이라면 null 을 리턴한다.
        Integer fileGroupSeq = FileUtil.createAtchFileGrpSeq(loginSessionInfoFactory,uploadList,boardVo.getAtchFileGrpSeq());
        //리턴 받은 파일그룹 시퀀스를 셋팅
        boardVo.setAtchFileGrpSeq(fileGroupSeq);
        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        boardVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.modifyBoard(Constants.BOARD_TYPE_CD_NOTI,boardVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**************************************************************************************************/
    /***************************************QNA 시작*********************************************/
    /**************************************************************************************************/
    /**
     * 게시판 > 1:1문의 목록 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/qnaList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getEtcList( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                              ,Model model
                             ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_QNA);

        if(boardCriteria.getSearchContentType() == null || boardCriteria.getSearchContentType().equals("")){
            boardCriteria.setRecordCountPerPage(Constants.RECORD_COUNT_PER_PAGE_15);
            boardCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-Constants.SEARCH_DEFAULT_PER_MONTH));
            boardCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));
        }

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "admin/board/qnaList"+Constants.ADMIN_TLF;
    }

    /**
     * 게시판 > 1:1문의 목록 검색(AJAX)
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/getQnaBoardListAjax.do", method = {RequestMethod.POST} )
    public String getQnaBoardListAjax(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                      ,Model model
                                      ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_QNA);

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "admin/board/include/qnaList_INC";
    }
    /**
     * 1:1문의 삭제(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/qna/deleteQnaAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> deleteQnaAjax(@RequestParam("deleteBoardSeq") String[] deleteBoardSeq) throws Exception{
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.deleteBoard(deleteBoardSeq);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }
    /**
     * 게시판 > 1:1문의 상세화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/qnaDetail.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String qnaDetail( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{

        Map<String,Object> result = boardService.getQnaDetailAdmin(boardCriteria, loginSessionInfoFactory);

        model.addAttribute("qnaBoardVo", result.get("qnaBoardVo"));
        model.addAttribute("boardAnswerVo", result.get("boardAnswerVo"));
        model.addAttribute("isAnswer", result.get("isAnswer"));

        return "admin/board/qnaDetail"+Constants.ADMIN_TLF;
    }

    /**
     * 게시판 > 1:1문의 답변 등록 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/qnaAnswerCreate.do", method = {RequestMethod.POST} )
    public String createqnaQnaAnswer(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                  ,Model model ) throws Exception{
        return "admin/board/qnaAnswerCreate"+Constants.ADMIN_TLF;
    }

    /**
     * 1:1문의 답변 저장(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/qna/createQnaAnswerAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createQnaAnswerAjax(BoardAnswerVo boardAnswerVo
            ,@RequestParam(value="uploadList",required=false) String[] uploadList
            ) throws Exception{
        //uploadList 가 있다면  파일 그룹 시퀀스를 , uploadList 가 null 이라면 null 을 리턴한다.
        Integer fileGroupSeq = FileUtil.createAtchFileGrpSeq(loginSessionInfoFactory,uploadList,null);
        //리턴 받은 파일그룹 시퀀스를 셋팅
        boardAnswerVo.setAtchFileGrpSeq(fileGroupSeq);

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        boardAnswerVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.createQnaAnswer(boardAnswerVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 게시판 > 1:1문의 답변 수정 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/qnaAnswerModify.do", method = {RequestMethod.POST} )
    public String qnaAnswerModify(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                  ,Model model ) throws Exception{
        List<BoardAnswerVo> qnaAnswerVoList = boardService.getBoardAnswerDetail(boardCriteria);
        model.addAttribute("qnaAnswerVo", qnaAnswerVoList.get(0));
        return "admin/board/qnaAnswerModify"+Constants.ADMIN_TLF;
    }

    /**
     * 1:1문의 답변 수정(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/qna/modifyQnaAnswerAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyQnaAnswerAjax(
            BoardAnswerVo boardAnswerVo
            ,@RequestParam(value="uploadList",required=false) String[] uploadList
            ) throws Exception{

        //uploadList 가 있다면  파일 그룹 시퀀스를 , uploadList 가 null 이라면 null 을 리턴한다.
        Integer fileGroupSeq = FileUtil.createAtchFileGrpSeq(loginSessionInfoFactory,uploadList,boardAnswerVo.getAtchFileGrpSeq());
        //리턴 받은 파일그룹 시퀀스를 셋팅
        boardAnswerVo.setAtchFileGrpSeq(fileGroupSeq);

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        boardAnswerVo.setLoginSessionInfoFactory(loginSessionInfoFactory);
        Map<String,Object> result = new HashMap<String,Object>();

        Integer cnt = boardService.modifyQnaAnswer(boardAnswerVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }
}
