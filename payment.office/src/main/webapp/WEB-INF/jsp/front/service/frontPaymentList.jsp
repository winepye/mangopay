<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/frontPaymentList_JS.jsp"%>
<!--
  * @Class Name  : collectReportList.jsp
  * @Description : front > 승인이력검색
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.05	 이인희      최초 생성
-->
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<section id="contents">
<form id = "frm" name = "frm" method="post">
<input type="hidden" id="searchDateType" name="searchDateType" value="createDate"/>
    <!--검색-->
    <div class="searchBox03 mgt40">
        <div class="fl_block">
            <span class="title">거래일시</span>
            <input type="txt" class="input_s_b w_date" title="시작일선택" id="searchFromDt" name="searchFromDt" value="<fmt:formatDate value="${serviceCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>"/>
            <span>~</span>
            <input type="txt" class="input_s_b w_date mgl6" title="종료일선택" id="searchToDt" name="searchToDt" value="<fmt:formatDate value="${serviceCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"/>

			<span class="btn_push_st01" id = "searchDateBtArea">
				<a href="javascript:fn_setDate(1)" class="left"   id="searchDate_1"><em>1개월</em></a>
				<a href="javascript:fn_setDate(3)" class="middle" id="searchDate_3"><em>3개월</em></a>
				<a href="javascript:fn_setDate(6)" class="right"  id="searchDate_6"><em>6개월</em></a>
			</span>
        </div>

        <div class="fr_block">
            <span class="title">진행상태</span>
            <select id="searchProcessStatusStore" name="searchProcessStatusStore" class="sel_basic selshowst" title="진행상태" >  <!-- onchange="javascript:fn_listChange(this.value)" -->
                <option value="">전체</option>
                <option value="REQUEST">요청중</option>
                <option value="COMPLETE">결제완료</option>
                <option value="CANCEL">결제취소</option>
            </select>
            <%-- <span class="title">CAT ID</span>
            <input type="text"  class="input_s_b"   size="30" placeholder="CAT ID를 입력해주세요." title="검색어입력" name="searchCatId" id="searchCatId"  value="${serviceCriteria.searchCatId}"
                onkeypress="if(event.keyCode==13) {fn_doSearch(1); return false;}" autocomplete="off"/> --%>
            <button type="button" class="btn_b_search" id="btnSearch">검색</button>
        </div>
    </div>
    <!--//검색//-->

    <!--탐방리포트검색-->
    <div class="board_classic mgt30">
        <div class="left_block">
            <div class="pageCount">
                <strong>전체</strong><span id="listTotalCnt">${serviceCriteria.totalRecordCount } 건</span>
            </div>
            <ul class="sortBtnSet">
                <li>
                    <a id = "sort_column_prefix0" href="javascript:fn_doSort(0)"
                        <c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_lowtohigh' }"> class="sort_lowtohigh"</c:if>
						<c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_hightolow' }"> class="sort_hightolow"</c:if>
						<c:if test = "${serviceCriteria.sortList ne '0' }"> class="sort_normal"</c:if>
                    >거래일시순
                        <c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_lowtohigh' }"><em>오름차순</em></c:if>
						<c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_hightolow' }"><em>내림차순</em></c:if>
						<c:if test = "${serviceCriteria.sortList ne '0' }"><em>정렬</em></c:if>
                    </a>
                </li>
            </ul>
        </div>
        <div class="right_block">
            <%-- <span class="sortCheckSet">
                <label><input type="checkbox" id="searchApproveYn" name="searchApproveYn" value="YES" <c:if test="${serviceCriteria.searchApproveYn eq 'YES'}">checked="checked"</c:if> /><span>승인완료</span></label>
                <label><input type="checkbox" id="searchCancelYn"   name="searchCancelYn"   value="YES" <c:if test="${serviceCriteria.searchCancelYn eq 'YES'}">checked="checked"</c:if> /><span>취소완료</span></label>
            </span> --%>
            <select id="listViewCount" class="sel_basic selshowst" onchange="fn_listChange($(this).val())" title="게시판목록 갯수설정">
                <option value="20" <c:if test="${serviceCriteria.recordCountPerPage eq '20'}">selected="selected"</c:if>>20개씩 보기</option>
                <option value="40" <c:if test="${serviceCriteria.recordCountPerPage eq '40'}">selected="selected"</c:if>>40개씩 보기</option>
                <option value="60" <c:if test="${serviceCriteria.recordCountPerPage eq '60'}">selected="selected"</c:if>>60개씩 보기</option>
            </select>
        </div>
    </div>
    <!--탐방리포트검색-->

	<div id="includeArea">
		<jsp:include page="./include/frontPaymentList_INC.jsp"></jsp:include>
	</div>

    <!-- 검색이나 화면이동을 위한 데이터 -->
    <input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${serviceCriteria.recordCountPerPage }">
    <input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${serviceCriteria.currentPageNo }">
    <input type="hidden" id = "sortList" name = "sortList" value="${serviceCriteria.sortList }">
    <input type="hidden" id = "sortKind" name = "sortKind" value="${serviceCriteria.sortKind }">
</form>

<form id = "popFrm" name = "frm" method="post">
    <!-- 팝업 검색을 위한 데이터 -->
    <input type="hidden" id = "searchUserInfoId" name = "searchUserInfoId">
</form>

</section>