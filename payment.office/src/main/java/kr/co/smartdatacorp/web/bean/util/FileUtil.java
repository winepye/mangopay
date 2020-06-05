package kr.co.smartdatacorp.web.bean.util;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.co.smartdatacorp.core.bean.session.LoginSessionInfo;
import kr.co.smartdatacorp.core.service.FileService;
import kr.co.smartdatacorp.core.vo.file.FileVo;

public class FileUtil {

    public static boolean writeFile(FileVo fileVo, MultipartFile file) throws Exception {
        try {
            File dir = new File(fileVo.getPath());
            if (!dir.isDirectory()) {
                if (!dir.mkdirs()) {
                    System.out.println("directory make error.");
                }
            }

            FileCopyUtils.copy(file.getBytes(), new FileOutputStream(
                    fileVo.getPath() + System.getProperty("file.separator")
                            + fileVo.getFilePhysNm()));

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return true;
    }

    public static boolean makeDirs(String filepath) throws Exception {
        try {
            File dir = new File(filepath);
            if (!dir.isDirectory()) {
                if (!dir.mkdirs()) {
                    System.out.println("directory make error.");
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return true;
    }

    /**
     * 저장시 파일의 그룹 번호를 업데이트한다.
     *
     *
     *
     * @param ObjectFactory
     * @return ArrayList<Integer> uploadList : 그룹 대상 파일의 리스트
     * @return Integer atchFileGrpSeq : null이 아니라면 그룹번호를 새로 만들지 않는다.(수정일때 사용)
     * @throws Exception
     */
    public static Integer createAtchFileGrpSeq(
            ObjectFactory<LoginSessionInfo> loginSessionInfoFactory , String[] uploadList,Integer atchFileGrpSeq)
            throws Exception {

        Integer fileGroupSeq = null;
        if (uploadList != null && uploadList.length > 0) {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
                    .getRequestAttributes()).getRequest();

            // HttpSession 객체 가져오기
            HttpSession session = request.getSession();

            // ServletContext 객체 가져오기
            ServletContext conext = session.getServletContext();

            WebApplicationContext ctx = RequestContextUtils
                    .getWebApplicationContext(request, conext);

            // 스프링 빈 가져오기 & casting
            FileService fileService = (FileService) ctx.getBean("fileService");

            if(atchFileGrpSeq != null){
                fileGroupSeq=atchFileGrpSeq;
            }else{
                fileGroupSeq = fileService
                        .getNextAttachFileGroupSeq(loginSessionInfoFactory);
            }

            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("atchFileGrpSeq", fileGroupSeq);
            paramMap.put("uploadList", uploadList);
            paramMap.put("sysDttm", new Date());
            paramMap.put("sessionUserInfoId", loginSessionInfoFactory.getObject().getSessionUserInfoId());

            Integer cnt = fileService.modifyGroupFileSeq(paramMap);

            if (cnt == null || cnt < 1) {
                throw new Exception("쿼리 오류");
            }
        }else
            fileGroupSeq = atchFileGrpSeq;

        return fileGroupSeq;
    }

    /**
     * 워터 마크를 만듬
     *
     * @param File watermarkImageFile :워터마크 파일
     * @param File sourceImageFile : 원본 이미지 경로
     * @param File destImageFile : 변환 이미지 경로
     * @throws Exception
     */
    public static void addImageWatermark(File watermarkImageFile, File sourceImageFile, File destImageFile) {
        try {
            BufferedImage sourceImage = ImageIO.read(sourceImageFile);
            BufferedImage watermarkImage = ImageIO.read(watermarkImageFile);

            // initializes necessary graphic properties
            Graphics2D g2d = (Graphics2D) sourceImage.getGraphics();
            AlphaComposite alphaChannel = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 0.3f);
            g2d.setComposite(alphaChannel);

            // calculates the coordinate where the image is painted
            int topLeftX = (sourceImage.getWidth() - watermarkImage.getWidth()) / 2;
            int topLeftY = (sourceImage.getHeight() - watermarkImage.getHeight()) / 2;

            // paints the image watermark
            g2d.drawImage(watermarkImage, topLeftX, topLeftY, null);

            ImageIO.write(sourceImage, "png", destImageFile);
            g2d.dispose();

            System.out.println("The image watermark is added to the image.");

        } catch (IOException ex) {
            System.err.println(ex);
        }
    }

    /**
     * FTP Upload
     * @param
     * @return
     */
    public static int FTP_upload(FileVo fileVo,String localePath, String url, String id, String pwd, String port) throws Exception {

        FTPClient ftp = null; // FTP Client 객체
        FileInputStream fis = null; // File Input Stream
        File uploadfile = null; // File 객체
        System.out.println("-------");
        int result = -1;

        try {
            ftp = new FTPClient(); // FTP Client 객체 생성
            ftp.setControlEncoding("UTF-8"); // 문자 코드를 UTF-8로 인코딩
            // ftp.connect(url, Integer.parseInt(port)); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
            ftp.connect(url, Integer.parseInt(port)); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
            ftp.login(id, pwd); // FTP 로그인 ID, PASSWORLD 입력
            // ftp.enterLocalPassiveMode(); // Passive Mode 접속일때

            //로컬 Path는 디렉토리 경로부터 선언되어있기때문에...
            localePath = localePath.replaceAll("\\\\", "\\\\\\\\");
            String remoteFilePath = fileVo.getPath().split(localePath)[1];

            if(ftp.changeWorkingDirectory(remoteFilePath) == false){ // 작업 디렉토리 변경
                String[] pathbuf = remoteFilePath.split("/");
                String mPath="";
                for(String makepath : pathbuf){
                    mPath+=makepath;
                    System.out.println("test : "+mPath);
                    if(makepath.length()>1 && ftp.changeWorkingDirectory(mPath) == false){
                        ftp.makeDirectory(mPath);
                    }
                }
                ftp.makeDirectory(remoteFilePath); // 작업 디렉토리 생성
                ftp.changeWorkingDirectory(remoteFilePath); // 작업 디렉토리 변경
            }
            ftp.setFileType(FTP.BINARY_FILE_TYPE); // 업로드 파일 타입 셋팅

            try {
                uploadfile = new File(fileVo.getPath()+fileVo.getFilePhysNm());
                fis = new FileInputStream(uploadfile); // 업로드할 File 생성
                ftp.enterLocalPassiveMode();
                boolean isSuccess = ftp.storeFile(fileVo.getFilePhysNm(), fis); // File 업로드

                if (isSuccess) {
                    result = 1; // 성공
                }
                else {
                    throw new Exception("파일 업로드를 할 수 없습니다.");
                }
            }
            catch (IOException ex) {
                System.out.println("IO Exception : " + ex.getMessage());
            }
            finally {
                if (fis != null) {
                    try {
                        System.out.println("result"+result);
                        fis.close(); // Stream 닫기
                        return result;

                    }
                    catch (IOException ex) {
                        System.out.println("IO Exception : " + ex.getMessage());
                    }
                }
            }

            ftp.logout(); // FTP Log Out
        }
        catch (IOException e) {
            System.out.println("IO:" + e.getMessage());
        }
        finally {
            if (ftp != null && ftp.isConnected()) {
                try {
                    ftp.disconnect(); // 접속 끊기
                    return result;
                }
                catch (IOException e) {
                    System.out.println("IO Exception : " + e.getMessage());
                }
            }
        }
        return result;
    }

    /**
     * FTP Delete
     * @param
     * @return
     */
    public static int FTP_delete(FileVo fileVo,String localePath, String url, String id, String pwd, String port) throws Exception {

        FTPClient ftp = null; // FTP Client 객체
        FileInputStream fis = null; // File Input Stream

        int result = -1;
        //로컬 Path는 디렉토리 경로부터 선언되어있기때문에...
        localePath = localePath.replaceAll("\\\\", "\\\\\\\\");
        String remoteFilePath = fileVo.getPath().split(localePath)[1];


        try {
            ftp = new FTPClient(); // FTP Client 객체 생성
            ftp.setControlEncoding("UTF-8"); // 문자 코드를 UTF-8로 인코딩
            ftp.connect(url, Integer.parseInt(port)); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
            ftp.login(id, pwd); // FTP 로그인 ID, PASSWORLD 입력
            ftp.enterLocalPassiveMode(); // Passive Mode 접속일때
            ftp.changeWorkingDirectory(remoteFilePath); // 작업 디렉토리 변경
            ftp.setFileType(FTP.BINARY_FILE_TYPE); // 업로드 파일 타입 셋팅
            ftp.enterLocalPassiveMode();

            try {
                boolean isSuccess = ftp.deleteFile(fileVo.getFilePhysNm());// 파일삭제

                if (isSuccess) {
                    result = 1; // 성공
                }
                else {
                    throw new Exception("파일을 삭제 할 수 없습니다.");
                }
            }
            catch (IOException ex) {
                System.out.println("IO Exception : " + ex.getMessage());
            }
            finally {
                if (fis != null) {
                    try {
                        fis.close(); // Stream 닫기
                        return result;
                    }
                    catch (IOException ex) {
                        System.out.println("IO Exception : " + ex.getMessage());
                    }
                }
            }
            ftp.logout(); // FTP Log Out
        }
        catch (IOException e) {
            System.out.println("IO:" + e.getMessage());
        }
        finally {
            if (ftp != null && ftp.isConnected()) {
                try {
                    ftp.disconnect(); // 접속 끊기
                    return result;
                }
                catch (IOException e) {
                    System.out.println("IO Exception : " + e.getMessage());
                }
            }
        }
        return result;
    }
}
