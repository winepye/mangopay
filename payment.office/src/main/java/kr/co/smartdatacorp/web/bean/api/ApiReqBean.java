package kr.co.smartdatacorp.web.bean.api;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import kr.co.smartdatacorp.core.bean.util.BaseValueMstrUtil;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.web.batch.Batch;

@Component("apiReqBean")
public class ApiReqBean {

    protected static final Log logger = LogFactory.getLog(Batch.class);

    @Resource(name = "messageSource")
    public MessageSource messageSource;

    @Resource(name = "fileService")
    private FileService fileService;


    /**
     * 간편결제 Api요청 공통 유틸
     * @param List
     * @param String[]
     * @return String
     */
    public Map commonIfReq(Map<String,Object> reqMap){
        try{
            //Spring Rest Template.....
            RestTemplate restTemplate = new RestTemplate();
            String url =BaseValueMstrUtil.getInstance().getBaseValue("IF_URL");
            logger.info("IF URL IS .........: "+url);
            //Json 스트링 변환
            ObjectMapper mapper = new ObjectMapper();

            //요청 map을 JsonString으로 변환한다.
            //String reqMapToJsonString = mapper.writeValueAsString(reqMap);

            //application/json ; utf-8;
            /*HttpHeaders headers = new HttpHeaders();
            Charset utf8 = Charset.forName("UTF-8");
            MediaType mediaType = new MediaType("application", "json", utf8);
            headers.setContentType(mediaType);
*/

            //Http Entity에 requstBody 와 헤더 정보를 셋한다.
            //HttpEntity<String> entity = new HttpEntity<String>(reqMapToJsonString,headers);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Map<String,Object>> entity = new HttpEntity<Map<String,Object>>(reqMap,headers);

            //호출 ...리턴 제이슨을 스트링으로 받는다.
            Map returnMap =  restTemplate.postForObject(url, entity, Map.class);

            return returnMap;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }

    }
}
