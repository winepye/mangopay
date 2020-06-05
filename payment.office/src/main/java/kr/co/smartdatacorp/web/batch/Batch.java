package kr.co.smartdatacorp.web.batch;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.co.smartdatacorp.core.service.UserService;
import kr.co.smartdatacorp.web.bean.api.ApiReqBean;

@Component
public class Batch {

    protected static final Log logger = LogFactory.getLog(Batch.class);


    @Resource(name = "messageSource")
    public MessageSource messageSource;

    @Resource(name = "userService")
    public UserService userService;

    @Resource(name="apiReqBean")
    ApiReqBean apiReqBean;


    /**
     * 1. 오후 05:50:00에 호출이 되는 스케쥴러
     */
    //@Scheduled(cron = "0 50 17 * * *")
    public void cronTest1(){
        System.out.println("........................오후 05:50:00입니다. Batch Test................ ");
    }

    /**
     * 탐방예약 후 2개월 동안 탐방예정일 미등록시 회원의 일정에서 탐방예약취소
     * 00시 10분에 실행
     */
    @Scheduled(cron = "0 10 0 * * *")
    public void modifyVisitReservCancelNoVisitSchedule(){

        logger.info(new Date().toString());
        try{
           // batchService.modifyVisitReservCancelNoVisitSchedule();
        }catch(Exception e){
            e.printStackTrace();
        }
        logger.info(new Date().toString());
    }


}
