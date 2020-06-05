<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!doctype html>
<html lang="ko">
<head>
<tiles:insertAttribute name="header" />
</head>
<body id="mb_warp">
	<div id="memberWrap">
		<tiles:insertAttribute name="top" />

			<tiles:insertAttribute name="content" />


			<tiles:insertAttribute name="footer" />


	</div>
</body>
</html>
