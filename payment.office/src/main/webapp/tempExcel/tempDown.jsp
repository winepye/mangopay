<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.*" %>

<%

    String fileName = "tempExcel.xls";

    // ex) /Users/bloodmun/Documents/smartdata/payment.office/src/main/webapp/
    String path = request.getSession().getServletContext().getRealPath("/");


    File file = new File(path+"tempExcel/sample2.xls");
    FileInputStream fileInputStream = null;
    ServletOutputStream servletOutputStream = null;

    try{

        String downName = null;
        String browser = request.getHeader("User-Agent");

        //파일 인코딩
        if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
            downName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
        } else {
            downName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
        }

        response.setHeader("Content-Type", "application/vnd.ms-xls");
        response.setHeader("Content-Disposition","attachment;filename=\"" + downName+"\"");

        fileInputStream = new FileInputStream(file);
        servletOutputStream = response.getOutputStream();

        byte b [] = new byte[1024];
        int data = 0;

        while((data=(fileInputStream.read(b, 0, b.length))) != -1){
            servletOutputStream.write(b, 0, data);
        }

        servletOutputStream.flush();

    }catch (Exception e){
        e.printStackTrace();
    }finally {
        if(servletOutputStream!=null){

            try {
                servletOutputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }

        if (fileInputStream!=null){

            try {
                fileInputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

%>
