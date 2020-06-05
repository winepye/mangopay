<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/styleFront.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"/>             <!-- design css -->
<!--에러페이지-->
<div class="errorpg_Box">
    <p class="error_title"><spring:message code='noti.common.noFindPage' /></p>
    <p class="error_txt"><spring:message code='noti.common.retryPage' /><br><spring:message code='noti.common.sorryUse' /></p>
</div>
<div class="bs_BtnBox_c"><button type="button" class="btn_white_B01" onclick="history.back();">이전 페이지</button>
<button type="button" class="btn_blue_B01 mgl10" onclick="window.location.href = '${pageContext.request.contextPath}/main/main.do'">메인으로</button></div>
<!--//에러페이지//-->