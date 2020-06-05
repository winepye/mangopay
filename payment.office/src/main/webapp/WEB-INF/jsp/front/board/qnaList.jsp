<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/qnaList_JS.jsp"%>
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />
<section id="contents">
<form id = "frm" name = "frm" method="post">
	<!--1:1문의진행단계-->
	<div class="inquiryStepBox">
		<div class="box">
			<dl>
				<dt>문의접수</dt>
				<dd class="step01">
					문의유형을 선택한 후<br>궁금하신 내용을 접수해주세요.
				</dd>
			</dl>
		</div>
		<div class="arrow"></div>
		<div class="box">
			<dl>
				<dt>답변등록</dt>
				<dd class="step02">
					관리자가 문의하신 내용에 대해<br>충분한 검토후 신속하게 답변해드립니다.
				</dd>
			</dl>
		</div>
		<div class="arrow"></div>
		<div class="box">
			<dl>
				<dt>답변확인</dt>
				<dd class="step03">
					답변을 확인하시고 부족한 부분은<br>추가문의나 전화상담을 이용해주세요.
				</dd>
			</dl>
		</div>
	</div>
	<ul class="dot_list_st01">
		<li>오프라인 상담시간 : 09:00AM ~ 18:00PM (공휴일,주말 제외)</li>
		<li>온라인 상담시간 : 365일 24시간 상담신청 가능<br>1:1 문의내용은 비공개로 진행되며 24시간 이내의 답변을 원칙으로 하고 있으나, 업무가 많거나 회사사정에 따라 답변이 조금 더 지연될수도 있습니다.
		</li>
	</ul>
	<!--//1:1문의진행단계//-->
	<!--검색-->
	<div class="searchBox mgt30">
		<div class="fl_block">
			<span class="title">기간선택</span>
            <input type="text" class="input_s_b w_date" id="searchFromDtS" name="searchFromDtS" value="<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>"/>
            ~
			<input type="text" class="input_s_b w_date" id="searchToDtS" name="searchToDtS" value="<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"/>

			<span class="btn_push_st01" id = "searchDateBtArea">
				<a href="javascript:fn_setDate(1)" class="left"   id="searchDate_1"><em>1개월</em></a>
				<a href="javascript:fn_setDate(3)" class="middle" id="searchDate_3"><em>3개월</em></a>
				<a href="javascript:fn_setDate(6)" class="right"  id="searchDate_6"><em>6개월</em></a>
			</span>
		</div>
		<div class="fr_block">
			<input type="text" class="input_s_b wstyle" name="searchContentText" id="searchContentText" placeholder="검색어를 입력해주세요." value="${boardCriteria.searchContentText }"
			onkeypress="if(event.keyCode==13) {fn_doSearch(1); return false;}" autocomplete="off"/>
			<button type="button" id = "btnSearch" class="btn_b_search">검색</button>
			<input type="hidden" name = "searchContentType" value="titleAndContent">
		</div>
	</div>
	<!--//검색//-->

	<div id="includeArea">
		<jsp:include page="./include/qnaList_INC.jsp"></jsp:include>
	</div>

	<!-- 페이징을 위한 데이터 -->
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${boardCriteria.recordCountPerPage }">
	<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${boardCriteria.currentPageNo }">
	<input type="hidden" id = "searchBoardSeq" name = "searchBoardSeq">
</form>
</section>

