<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>


<!doctype html>
<html lang="ko">
<head>
<tiles:insertAttribute name="header" />
</head>
<body>
	<tiles:insertAttribute name="top" />
	<tiles:insertAttribute name="content" />
	<tiles:insertAttribute name="footer" />
</body>
</html>

