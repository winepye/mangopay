package kr.co.smartdatacorp.web.bean.util;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.PropertyUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.google.gson.Gson;
import kr.co.smartdatacorp.core.service.BaseValueMstrService;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.common.BaseVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class WebUtil {
    public static Object jsonToBean(String jsonData , Class targetVo){
        Gson gson = new Gson();
        return gson.fromJson(jsonData, targetVo);
    }

    public static Object convertMapToObject(Map map, Object objClass){
        String keyAttribute = null;
        String setMethodString = "set";
        String methodString = null;
        Iterator itr = map.keySet().iterator();
        while(itr.hasNext()){
            keyAttribute = (String) itr.next();
            methodString = setMethodString+keyAttribute.substring(0,1).toUpperCase()+keyAttribute.substring(1);
            try {
                Method[] methods = objClass.getClass().getDeclaredMethods();
                for(int i=0;i<=methods.length-1;i++){
                    if(methodString.equals(methods[i].getName())){
                        System.out.println("invoke : "+methodString);
                        methods[i].invoke(objClass, map.get(keyAttribute));
                    }
                }
            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
        return objClass;
    }

    /**
	 * 사용자 지정 디렉토리에 yyyyMM 형식의 디렉토리가 있는지 확인후 생성
	 * @param String
	 * @return String
	 */
	public static String makeUserDir(String userDir) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM", Locale.KOREA);

		Date currentTime = new Date();
		String dTime = formatter.format(currentTime);

		File dir = new File( userDir + System.getProperty("file.separator") + dTime);
		String returnDir = "";

		if (!dir.isDirectory()) {
			if (!dir.mkdirs()) {
				System.out.println("directory make error.");
			}
		}

		returnDir = String.valueOf(dir);

		return returnDir;
	}
	/**
	 * 사용자 지정 디렉토리에 동일한 파일명이 있는지 확인후 생성
	 * @param String
	 * @return String
	 */
	public static String makeUserFile(String userDir,String bufFileNameHead, String bufFileName,String bufExt) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM", Locale.KOREA);
		Date currentTime = new Date();
		String dTime = formatter.format(currentTime);

		File dir = new File(userDir + System.getProperty("file.separator") + dTime);
		String returnDir = "";

		if (!dir.isDirectory()) {
			if (!dir.mkdirs()) {
				System.out.println("directory make error.");
			}
		}

		returnDir = String.valueOf(dir);
		String fileName = bufFileNameHead+ "_" + System.currentTimeMillis()+bufExt;
		File upfile = new File(returnDir + System.getProperty("file.separator") + fileName);
		if (upfile.exists()) {
			String remakeBufFileName =  bufFileNameHead+ "_" + (System.currentTimeMillis() + 1);

			String newFileName = remakeBufFileName  + bufExt;

			return newFileName;
		}else{
			return String.valueOf(fileName);
		}

	}
	/**
     * vo to json
     * @param List
     * @param String[]
     * @return String
     */
	public static String listToJsonString(List<? extends BaseVo> objectList, String[] set){
        JSONObject jsonObject = new JSONObject();

        if(set.length==0) return "";

        JSONArray jsonArray = new JSONArray();
        List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();

        for (Object object : objectList) {
            Map<String, Object> map = new HashMap<String, Object>();

            try {
                for(int i=0; i<set.length; i++) map.put(set[i], PropertyUtils.getProperty(object, set[i]) == null ? "" : PropertyUtils.getProperty(object, set[i]));
            } catch (Exception e) {
                //e.printStackTrace();
                return "";
            }
            listMap.add(map);
        }

        for (Map<String, Object> jsonItem : listMap) {
            jsonArray.put(jsonItem);
        }

        jsonObject.put("items", jsonArray);

        return jsonObject.toString();
    }

}
