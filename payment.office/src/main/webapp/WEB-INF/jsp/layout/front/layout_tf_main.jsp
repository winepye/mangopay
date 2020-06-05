<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<tiles:insertAttribute name="header" />
</head>
<body><div id="wrap"><header><tiles:insertAttribute name="top" /></header><tiles:insertAttribute name="content"/></div><tiles:insertAttribute name="footer" /></body>
</html>