<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<tiles:insertAttribute name="header" />
</head>
<body>
	<div id="detail_contents">
		<tiles:insertAttribute name="content" />
	</div>
</body>
</html>
