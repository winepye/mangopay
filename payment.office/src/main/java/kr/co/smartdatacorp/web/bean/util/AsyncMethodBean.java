package kr.co.smartdatacorp.web.bean.util;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import kr.co.smartdatacorp.core.bean.util.FileUtil;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.file.FileVo;
import kr.co.smartdatacorp.web.bean.api.ApiReqBean;
/**
 * async Method Tread 클래스
 * @author 이인희
 * @since 2016.07.27
 * @version 1.0
 * @see
 *
 * 별도 Thread를 이용해 비동기 메서드를 실행하기위한 클래스
 * 세션정보는 사용할수 없으니 세션정보가 필요하다면 호출할때 파라미터로 넘길것.
 * 그 외 Spring bean은 사용할수 있음
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2016.07.27  이인희          최초 생성
 *  </pre>
 */
@Component("asyncMethodBean")
public class AsyncMethodBean {

    protected static final Log logger = LogFactory.getLog(AsyncMethodBean.class);


    @Resource(name="apiReqBean")
    ApiReqBean apiReqBean;


    @Resource(name = "fileService")
    private FileService fileService;

    @Resource(name = "messageSource")
    public MessageSource messageSource;



   /*******************************************************************************************************
    *************************** 레포트 인터페이스(레포트시스템 -> IB시스템) ***************************
    *******************************************************************************************************/

    /**
    * Ib System Ftp File upload
    *
    * @param FileVo
    * @param Integer uploadUserSeq :업로드한 유저의 유저시퀀스
    * @param String markerImgPath : 마커이미지 경로
    * @throws Exception
    */
    @Async
    public void ftp_upload(FileVo fileVo,String localePath , String ibFtpPath , String ibFtpid , String ibFtpPwd,String ibFtpPort){
      try{
          FileUtil.FTP_upload(fileVo,localePath, ibFtpPath, ibFtpid, ibFtpPwd, ibFtpPort);
      }catch(Exception e){
          e.printStackTrace();
          logger.info("FTP UPLOAD FAIL...........FILE SEQ IS ..: "+ fileVo.getAtchFileSeq());
      }
    }

      /**
       * Ib System Ftp File delete
       *
       * @param FileVo
       * @param Integer uploadUserSeq :업로드한 유저의 유저시퀀스
       * @param String markerImgPath : 마커이미지 경로
       * @throws Exception
       */
     @Async
     public void ftp_delete(FileVo fileVo,String localePath , String ibFtpPath , String ibFtpid , String ibFtpPwd,String ibFtpPort){
         try{
             FileUtil.FTP_delete(fileVo,localePath, ibFtpPath, ibFtpid, ibFtpPwd, ibFtpPort);
         }catch(Exception e){
             e.printStackTrace();
             logger.info("FTP UPLOAD FAIL...........FILE SEQ IS ..: "+ fileVo.getAtchFileSeq());
         }
     }
}
