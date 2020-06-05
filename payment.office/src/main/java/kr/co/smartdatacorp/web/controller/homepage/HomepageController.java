package kr.co.smartdatacorp.web.controller.homepage;

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

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.bean.util.FileUtil;
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
@RequestMapping("/")
@Controller("homepage.HomepageController")
public class HomepageController extends BaseController{

    final static Logger log = LoggerFactory.getLogger(HomepageController.class);

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
    @RequestMapping("/index.do")
    public String mainPage(Model model) throws Exception{

        //return "homepage/index"+Constants.FRONT_TF_MAIN;
        return "index" + Constants.HOMEPAGE_EMPTY;
    }

    /**
     * 프론트 메인화면
     *
     * @param LoginCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping("/mainPopup.do")
    public String mainPopup(Model model) throws Exception{

        //return "homepage/index"+Constants.FRONT_TF_MAIN;
        return "mainPopup" + Constants.HOMEPAGE_EMPTY;
    }

    /**
     *
     *
     * @param LoginCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping("/subpage01.do")
    public String subpage01(Model model) throws Exception{

        return "subpage01" + Constants.HOMEPAGE_EMPTY;
    }

    /**
    *
    *
    * @param LoginCriteria
    * @return String
    * @throws Exception
    */
   @RequestMapping("/subpage02.do")
   public String subpage02(Model model) throws Exception{

       return "subpage02" + Constants.HOMEPAGE_EMPTY;
   }

   /**
   *
   *
   * @param LoginCriteria
   * @return String
   * @throws Exception
   */
  @RequestMapping("/subpage03.do")
  public String subpage03(Model model) throws Exception{

      return "subpage03" + Constants.HOMEPAGE_EMPTY;
  }

      /**
      *
      *
      * @param LoginCriteria
      * @return String
      * @throws Exception
      */
     @RequestMapping("/subpage04.do")
     public String subpage04(Model model) throws Exception{

         return "subpage04" + Constants.HOMEPAGE_EMPTY;
     }

     /**
     *
     *
     * @param LoginCriteria
     * @return String
     * @throws Exception
     */
    @RequestMapping("/questionList.do")
    public String questionList(Model model) throws Exception{

        return "questionList" + Constants.HOMEPAGE_EMPTY;
    }

    /**
    *
    *
    * @param LoginCriteria
    * @return String
    * @throws Exception
    */
   @RequestMapping("/contact.do")
   public String contact(Model model) throws Exception{

       return "contact" + Constants.HOMEPAGE_EMPTY;
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
    @RequestMapping(value = "/notiList.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getNotiList( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                              ,Model model
                             ) throws Exception{

        boardCriteria.setSearchBoardTypeCd(Constants.BOARD_TYPE_CD_NOTI);
        boardCriteria.setSearchOpenYn(Constants.YES_NO_Y);

        Map<String,Object> result = boardService.getNotiListFront(boardCriteria);

        model.addAttribute("result", result);

        //return "homepage/noticeList"+Constants.FRONT_TLF;
        return "notiList" + Constants.HOMEPAGE_EMPTY;
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

        return "include/notiList_INC";
    }

    /**
     * 공지사항 > 공지사항 상세 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @param Model
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/notiDetail.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String getNotiDetail( @ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                ,Model model
                               ) throws Exception{
        Map<String,Object> result = boardService.getNotiDetailFront(boardCriteria);

        model.addAttribute("notiBoardVo"    , result.get("notiBoardVo"));
        model.addAttribute("preNotiBoardVo" , result.get("preNotiBoardVo"));
        model.addAttribute("postNotiBoardVo", result.get("postNotiBoardVo"));

        return "notiDetail" + Constants.HOMEPAGE_EMPTY;
    }

    /**************************************************************************************************/
    /*************************************** 상담의뢰 *************************************************/
    /**************************************************************************************************/

    /**
     * 1:1문의 작성 화면
     *
     * @param BoardCriteria :검색 조건 수집
     * @return String
     * @throws Exception
     */
    @RequestMapping(value = "/createQna.do", method = {RequestMethod.GET,RequestMethod.POST} )
    public String createQna(@ModelAttribute("boardCriteria") BoardCriteria boardCriteria
                                     ,Model model
                                      ) throws Exception{
        return "qnaCreate" + Constants.HOMEPAGE_EMPTY;
    }

    /**
     * 1:1문의 저장(AJAX)
     *
     * @param BoardVo
     * @return Map<String,Object>
     * @throws Exception
     */
    @RequestMapping(value = "/createQnaAjax.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> createQnaAjax(BoardVo boardVo
                                            ,@RequestParam(value="uploadList",required=false) String[] uploadList
                                            ) throws Exception{


        //세션에 있는 로그인 사용자 정보를 Vo에 셋팅
        Map<String,Object> result = new HashMap<String,Object>();
        boardVo.setOpenYn(Constants.YES_NO_Y);
        boardVo.setStatusCd("RECP");
        boardVo.setSessionUserInfoId(-1);

        Integer cnt = boardService.createBoard(Constants.BOARD_TYPE_CD_QNA,boardVo);

        if(cnt == 1) result.put("result", Constants.RESULT_SUCCESS);
        else result.put("result", Constants.RESULT_FAIL);
        return result;
    }

    /**
    *  개인정보처리방침
    *
    * @param LoginCriteria
    * @return String
    * @throws Exception
    */
   @RequestMapping("/personal.do")
   public String personal(Model model) throws Exception{

       return "personal" + Constants.HOMEPAGE_EMPTY;
   }

}