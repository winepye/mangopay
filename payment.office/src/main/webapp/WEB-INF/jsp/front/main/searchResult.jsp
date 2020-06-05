﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/searchResult_JS.jsp"%>
<form id = "frm" name = "frm" method="post">
<!-- 더보기 검색을 위한 히든값 -->
<input type="hidden" id = "searchReportKindCd" name = "searchReportKindCd">
<input type="hidden" id="searchReportSeq" name="searchReportSeq">
<input type="hidden" id="searchContentType" name="searchContentType" value="title">
<!--검색-->
<div class="all_srchBox">
	<div class="fl_block">
		<span class="title">기간</span>
		<input type="text" class="input_s_b w_date" id="searchFromDtS" name="searchFromDtS" value="<fmt:formatDate value="${reportCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>"/>
           <span class="dash">~</span>
        <input type="text" class="input_s_b w_date" id="searchToDtS" name="searchToDtS" value="<fmt:formatDate value="${reportCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"/>

		<span class="btn_push_st01">
		      <a href="javascript:fn_setDate(1)" class="left"><em>1개월</em></a>
			  <a href="javascript:fn_setDate(3)" class="middle"><em>3개월</em></a>
			  <a href="javascript:fn_setDate(6)" class="middle"><em>6개월</em></a>
			  <a href="javascript:fn_setDate(12)" class="middle"><em>1년</em></a>
			  <a href="javascript:fn_setDate(24)" class="middle"><em>2년</em></a>
			  <!-- <a href="javascript:fn_setDate(99)" class="right"><em>전체</em></a> -->
		</span>
	</div>
	<div class="fr_block">
		<label class="txt" style="display: none;"><input type="checkbox" id = "isSearchInResult"><span>결과내검색</span></label>
		<input type="text" class="input_s_b wstyle02" id="searchContentText2" placeholder="검색어를 입력해주세요." title="검색어입력" value="${reportCriteria.searchContentText }">
		<button type="button" class="btn_b_search" id = "btnSearch">검색</button>
	</div>
</div>
<div id = "includeArea">
<jsp:include page="./include/searchResult_INC.jsp"></jsp:include>
</div>
<!--검색주의사항-->
<p class="notice_mark">
	<span class="mark"><em>!</em></span><strong>검색결과가 없을때, 아래
		주의사항을 읽어보고 다시 검색해보세요!</strong>
</p>
<ul class="dot_list_st01 mgt5">
	<li>단어의 철자가 정확한지 확인해 보세요.</li>
	<li>한글을 영어로 혹은 영어를 한글로 입력했는지 확인해 보세요.</li>
	<li>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요.</li>
	<li>두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해보세요.</li>
</ul>
<!--//검색주의사항//-->
</form>