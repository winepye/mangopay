package kr.co.smartdatacorp.web.controller.front;

import java.util.ArrayList;
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

import kr.co.smartdatacorp.core.bean.util.DateUtil;
import kr.co.smartdatacorp.core.bean.util.FileUtil;
import kr.co.smartdatacorp.core.service.BoardService;
import kr.co.smartdatacorp.core.service.CodeService;
import kr.co.smartdatacorp.core.vo.board.BoardAnswerVo;
import kr.co.smartdatacorp.core.vo.board.BoardCriteria;
import kr.co.smartdatacorp.core.vo.board.BoardVo;
import kr.co.smartdatacorp.core.vo.code.CodeCriteria;
import kr.co.smartdatacorp.core.vo.code.CodeVo;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.web.controller.common.BaseController;

/**
*
* Board Controller 클래스
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
@RequestMapping("/board")
@Controller("front.BoardController")
public class BoardController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(BoardController.class);

    @Resource(name = "boardService")
    private BoardService boardService;

    @Resource(name = "codeService")
    CodeService codeService;

    /**
     * 고객센터 > FAQ 목록 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/faq/faqList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getFaqList( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                              ,@ModelAttribute("codeCriteria") CodeCriteria codeCriteria
                              ,Model model
                             ) throws Exception{
        //faq 글목록 조회
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_FAQ);

        Map<String,Object> result = new HashMap<String,Object>();

        boardCriteria.setSearchOpenYn(Constants.YES_NO_Y); /* 게시여부:Y */
        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        //화면 텝 영역을 만들기 위해 faq카테고리를 조회한다
        codeCriteria.setSearchCdGrp("FAQ_CATEG_CD");
        List<CodeVo> codeVoList = codeService.getCodeList(codeCriteria);

        result.put("codeList", codeVoList);

        model.addAttribute("result", result);

        return "board/faqList"+Constants.FRONT_TLF;
    }

    /**
     * FAQ 목록 검색(AJAX)
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/faq/getFaqListAjax.do", method = {RequestMethod.POST} )
    public String getFaqListAjax(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                     ,@ModelAttribute("codeCriteria") CodeCriteria codeCriteria
                                     ,Model model
                                      ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_FAQ);

        Map<String,Object> result = new HashMap<String,Object>();

        boardCriteria.setSearchOpenYn(Constants.YES_NO_Y); /* 게시여부:Y */
        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        //화면 텝 영역을 만들기 위해 faq카테고리를 조회한다
        codeCriteria.setSearchCdGrp("FAQ_CATEG_CD");
        List<CodeVo> codeVoList = codeService.getCodeList(codeCriteria);

        result.put("codeList", codeVoList);

        model.addAttribute("result", result);
        return "front/board/include/faqList_INC";
    }

    /**
     * 고객센터 > 1:1문의 목록 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/qnaList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String qnaList( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                              ,@ModelAttribute("codeCriteria") CodeCriteria codeCriteria
                              ,Model model
                             ) throws Exception{

        //1:1문의 글목록 조회
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_QNA);

        boardCriteria.setSearchUserInfoId(loginSessionInfoFactory.getObject().getSessionUserInfoId()); //본인이 본것만 작업할것....SJ

        if(boardCriteria.getSearchFromDt() == null || boardCriteria.getSearchToDt().equals("")){
            boardCriteria.setSearchFromDt(DateUtil.getAdjustedMonth(-Constants.SEARCH_DEFAULT_PER_MONTH));
            boardCriteria.setSearchToDt(DateUtil.getAdjustedMonth(0));
        }

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "board/qnaList"+Constants.FRONT_TLF;
    }

    /**
     * 1:1문의 목록 검색(AJAX)
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/getQnaListAjax.do", method = {RequestMethod.POST} )
    public String getQnaListAjax(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                     ,Model model
                                      ) throws Exception{
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_QNA);

        boardCriteria.setSearchUserInfoId(loginSessionInfoFactory.getObject().getSessionUserInfoId()); //본인이 본것만 작업할것....SJ

        Map<String,Object> result = new HashMap<String,Object>();

        List<BoardVo> boardVolist = boardService.getBoardList(boardCriteria);

        result.put("boardVolist", boardVolist);

        model.addAttribute("result", result);

        return "front/board/include/qnaList_INC";
    }

    /**
     * 1:1문의 작성 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/createQna.do", method = {RequestMethod.POST} )
    public String createQna(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                     ,Model model
                                      ) throws Exception{
        return "board/qnaCreate"+Constants.FRONT_TLF;
    }

    /**
     * 1:1문의 저장(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/qna/createQnaAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createQnaAjax(BoardVo boardVo
                                            ,@RequestParam(value="uploadList",required=false) String[] uploadList
                                            ) throws Exception{

        //uploadList 가 있다면  파일 그룹 시퀀스를 , uploadList 가 null 이라면 null 을 리턴한다.
        Integer fileGroupSeq = FileUtil.createAtchFileGrpSeq(loginSessionInfoFactory,uploadList,null);
        //리턴 받은 파일그룹 시퀀스를 셋팅
        boardVo.setAtchFileGrpSeq(fileGroupSeq);

        //세션에있는 로그인 정보를 셋팅
        boardVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        Map<String,Object> result = new HashMap<String,Object>();
        boardVo.setOpenYn(Constants.YES_NO_Y);
        boardVo.setStatusCd("RECP");
        Integer cnt = boardService.createBoard(Constants.BOARD_TYPE_CD_QNA,boardVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
     * 1:1문의 상세 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/qnaDetail.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getQnaDetail( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_QNA);
        BoardVo qnaBoardVo = boardService.getBoardDetail(boardCriteria);
        model.addAttribute("qnaBoardVo", qnaBoardVo);
        List<BoardAnswerVo> qnaAnswerVoList = boardService.getBoardAnswerDetail(boardCriteria);
        if(qnaAnswerVoList!=null && qnaAnswerVoList.size()>0){
            model.addAttribute("qnaAnswerVo", qnaAnswerVoList.get(0));
            model.addAttribute("sessionUserName", loginSessionInfoFactory.getObject().getSessionUserName());
        }
        return "board/qnaDetail"+Constants.FRONT_TLF;
    }

    /**
     * 1:1문의 수정 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/qna/qnaModify.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String modifyQna( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{
        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_QNA);
        BoardVo qnaBoardVo = boardService.getBoardDetail(boardCriteria);
        model.addAttribute("qnaBoardVo", qnaBoardVo);

        return "board/qnaModify"+Constants.FRONT_TLF;
    }

    /**
     * 1:1문의 수정(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/qna/modifyQnaAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> modifyQnaAjax(BoardVo boardVo
                                            ,@RequestParam(value="uploadList",required=false) String[] uploadList
                                            ) throws Exception{

        //uploadList 가 있다면  파일 그룹 시퀀스를 , uploadList 가 null 이라면 null 을 리턴한다.
        Integer fileGroupSeq = FileUtil.createAtchFileGrpSeq(loginSessionInfoFactory,uploadList,boardVo.getAtchFileGrpSeq());
        //리턴 받은 파일그룹 시퀀스를 셋팅
        boardVo.setAtchFileGrpSeq(fileGroupSeq);

        //세션에있는 로그인 정보를 셋팅
        boardVo.setLoginSessionInfoFactory(loginSessionInfoFactory);

        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        Map<String,Object> result = new HashMap<String,Object>();
        boardVo.setOpenYn(Constants.YES_NO_Y);
        Integer cnt = boardService.modifyBoard(Constants.BOARD_TYPE_CD_QNA,boardVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**************************************************************************************************/
    /***************************************공지사항 *************************************************/
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
        boardCriteria.setSearchOpenYn(Constants.YES_NO_Y);

        Map<String,Object> result = boardService.getNotiListFront(boardCriteria);

        model.addAttribute("result", result);

        return "board/notiList"+Constants.FRONT_TLF;
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

        Map<String,Object> result = boardService.getNotiListFront(boardCriteria);

        model.addAttribute("result", result);

        return "front/board/include/notiList_INC";
    }

    /**
     * 공지사항 > 공지사항 상세 화면
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
        Map<String,Object> result = boardService.getNotiDetailFront(boardCriteria);

        model.addAttribute("notiBoardVo"    , result.get("notiBoardVo"));
        model.addAttribute("preNotiBoardVo" , result.get("preNotiBoardVo"));
        model.addAttribute("postNotiBoardVo", result.get("postNotiBoardVo"));

        return "board/notiDetail"+Constants.FRONT_TLF;
    }
}
