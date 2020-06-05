<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<tiles:insertAttribute name="header" />
</head>
<body>
	<div id="wrap">
		<header>
			<tiles:insertAttribute name="top" />
		</header>
		<c:if test="${fn:indexOf(pageUrl,'main.do')<0}">
			<div id="container_wrap">
				<!--페이지위치-->
				<customTagUi:menuNavigation location="${reportLocation }"
					currentUrl="${currentUrl }" />
				<div id="container_wrap2">
					<div id="container">
		</c:if>
		<tiles:insertAttribute name="content" />
		<c:if test="${fn:indexOf(pageUrl,'main.do')<0}">
	</div>
	   </c:if>

	<tiles:insertAttribute name="footer" />


	<c:if test="${fn:indexOf(pageUrl,'main.do')<0}">
		</div>
		</div>
	</c:if>

</body>
</html>
