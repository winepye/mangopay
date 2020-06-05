<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>

<html>
<head>
<title>망고페이</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta property="og:image" content="http://www.mangopay.co.kr/resources/images/logo/mangopay_logo2.png">
<meta property="og:image:secure_url" content="https://www.mangopay.co.kr/resources/images/logo/mangopay_logo2.png" />

<link rel="stylesheet" href="/homepage/css/css.css?ver=1.1" type="text/css">
<script language='javascript' src='/homepage/js/mEmbed.js'></script>

<script>var contextRoot="${pageContext.request.contextPath}";</script><!-- necessary! to import js files -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/html5.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-1.10.2.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.form.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-ui.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.blockUI.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.validate.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.maskedinput.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/monthPicker.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/spin.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/arrayUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/dateUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/domUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/eventUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/fileUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/otherUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/stringUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/xmlUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/formUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}'/>"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/commonReport.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script><!-- jquery , ajaxRequest, etc -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/ajaxRequestReport.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>

<tiles:insertAttribute name="header" />

<tiles:insertAttribute name="content" />


</body>
</html>
