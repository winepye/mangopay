<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/notiList_JS.jsp"%>

<form id = "frm" name = "frm" method="post">
<section class="sub5" id="notice">
	<img src="/homepagem/img/sub.jpg">
	<img src="/homepagem/img/sub05-1.jpg">
    <ul>
    	<li><a href="/m/notiList.do" class="select">공지사항</a></li>
        <li><a href="/m/createQna.do">상담의뢰</a></li>
        <li><a href="/m/questionList.do">자주묻는질문</a></li>
        <li><a href="/m/contact.do">Contact us</a></li>
    </ul>

    <!-- 공지사항 목록 -->
     <div id = "includeArea">
		<jsp:include page="./include/notiList_INC.jsp"></jsp:include>
	</div>
	<!-- 페이징을 위한 데이터 -->
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${boardCriteria.recordCountPerPage }">
	<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${boardCriteria.currentPageNo }">
	<!-- 상세 페이지 이동을 위한 테이더-->
	<input type="hidden" id = "searchBoardSeq" name = "searchBoardSeq">




</section>
</form>