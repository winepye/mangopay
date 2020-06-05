<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>

<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html>
<tiles:insertAttribute name="header"/>

<body>
<div id="skipNavigation">
	<p><a href="#detail_contents">메뉴 건너뛰기</a></p>
</div>
<hr />

<div id="wrap">

	<tiles:insertAttribute name="top"/>

	<div id="container">

		<tiles:insertAttribute name="left"/>

		<div id="contentsWrap">
            <div class="contents">

				<customTagUi:menuNavigation location="${reportLocation }" currentUrl="${currentUrl }" />

				<tiles:insertAttribute name="content"/>

			</div>

			<tiles:insertAttribute name="footer"/>

		</div>
	</div>
</div>
</body>
</html>
