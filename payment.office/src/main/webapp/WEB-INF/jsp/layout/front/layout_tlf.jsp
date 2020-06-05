<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!doctype html>
<html lang="ko">
<tiles:insertAttribute name="header" />

<body>
	<div id="wrap">
	    <header>
		  <tiles:insertAttribute name="top" />
		</header>
		<div id="container_wrap">
			<!--페이지위치-->
			<customTagUi:menuNavigation location="${reportLocation }" currentUrl="${currentUrl }" />
			<!--//페이지위치//-->
			<div id="container_wrap2">
				<tiles:insertAttribute name="left" />
				<div id="container">
					<div class="contents"></div>

					<tiles:insertAttribute name="content" />

				</div>

				<tiles:insertAttribute name="footer" />

			</div>
		</div>
	</div>
</body>
</html>
