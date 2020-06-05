package kr.co.smartdatacorp.web.controller.common;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.smartdatacorp.core.bean.constant.Constants;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.popup.PopupCriteria;
import kr.co.smartdatacorp.web.bean.util.AsyncMethodBean;
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
public class ViewerController extends BaseController{

    @Resource(name = "fileService")
    private FileService fileService;

    @Resource(name = "asyncMethodBean")
    private AsyncMethodBean asyncMethodBean;




    /**
     * 이미지 뷰어
     * @return String
     * @throws Exception
     */
    @RequestMapping("/viewer/imageViewer.do")
    public String imageViewer(
            Model model,
            @RequestParam(value = "atchFileSeq" ,required = true) Integer atchFileSeq
            ,@RequestParam(value = "viewTitle" ,required = true) String viewTitle
            ,HttpServletRequest request
            )throws Exception{
        model.addAttribute("atchFileSeq", atchFileSeq);
        model.addAttribute("viewTitle", viewTitle);

        return "viewer/imageViewer"+Constants.FRONT_EMPTY;
        //return "front/viewer/imageViewer";

    }

    /**
     * 공통 팝업
     * @return String
     * @throws Exception
     */
    @RequestMapping("/viewer/commonPopup.do")
    public String commonPopup(@ModelAttribute("popupCriteria") PopupCriteria popupCriteria, Model model )throws Exception{
        /*model.addAttribute("viewTitle", viewTitle);
        model.addAttribute("viewContent", viewContent);
        model.addAttribute("popupName", popupName);*/

        //PopupVo popupVo = popupService.getPopupDetail(popupCriteria);
        //model.addAttribute("popupVo", popupVo);

        return "viewer/commonPopup"+Constants.FRONT_EMPTY;
        //return "front/viewer/commonPopup" + Constants.FRONT_EMPTY;

    }

}
