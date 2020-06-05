<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/notiList_JS.jsp"%>
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />
<section id="contents">
	<form id = "frm" name = "frm" method="post">
		<div class="Notice_top">
			<div class="Not_top_L">
				<strong>전체</strong><span>${boardCriteria.totalRecordCount } 건</span>
			</div>
		</div>
		<!--//검색//-->
		<div id = "includeArea">
			<jsp:include page="./include/notiList_INC.jsp"></jsp:include>
		</div>
		<!-- 페이징을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${boardCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${boardCriteria.currentPageNo }">
		<!-- 상세 페이지 이동을 위한 테이더-->
		<input type="hidden" id = "searchBoardSeq" name = "searchBoardSeq">
	</form>
</section>