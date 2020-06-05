<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/faqList_JS.jsp"%>

<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<form id = "frm" name = "frm" method="post">

	<!-- 검색 -->
	<div class="searchZone mgt40">
		<div class="fl_block">
			<select class="sel_basic w100pro" title="구분" title="구분" id="searchContentType" name = "searchContentType">
				<option value="titleAndContent">제목/내용</option>
			</select>
		</div>
		<div class="fr_block">
			<input type="text" class="input_s_b wstyle" id="searchContentText" name = "searchContentText" placeholder="검색어를 입력해 주세요." title="검색어입력"
                onkeypress="if(event.keyCode==13) {fn_doSearch(1); return false;}" autocomplete="off"/>
			<button type="button" id = "btnSearch" name="btnSearch" class="btn_b_search"><em>검색</em></button>
		</div>
	</div>
	<p class="notice_mark mgt5"><span class="mark"><em>!</em></span><span><!-- 홈페이지를 이용하면서 자주하는 질문사항들을 모아두었습니다.  -->원하는 정보를 찾을 수 없으면 1:1문의를 이용해주세요.</span><a href="${pageContext.request.contextPath}/board/qna/qnaList.do">1:1문의 바로가기</a></p>
	<!--//검색//-->

	<!-- 탭 -->
	<div class="gtabZone count_n06 mgt30">
	    <ul id = "tabUl">
	        <li id = "tabLi_"<c:if test = "${boardCriteria.searchCategCd eq null}"> class="on"</c:if> onclick="javascript:fn_setCategCd('')">
                <a href="javascript:void(0);">전체</a>
                <c:if test = "${boardCriteria.searchCategCd eq null}"><em class="point"></em></c:if>
            </li>
	        <c:forEach var = "data" items="${result.codeList }">
                <li id = "tabLi_${data.cd}"
                    <c:if test = "${data.cd eq boardCriteria.searchCategCd }"> class="on"</c:if> onclick="javascript:fn_setCategCd('${data.cd}')">
                        <a href="javascript:void(0);">${data.cdNm }</a>
                    <c:if test = "${data.cd eq boardCriteria.searchCategCd }"><em class="point"></em></c:if>
                </li>
            </c:forEach>
	    </ul>
	</div>
	<!--//탭//-->

	<div id = "includeArea">
		<jsp:include page="./include/faqList_INC.jsp"></jsp:include>
	</div>

	<!-- 페이징을 위한 데이터 -->
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${boardCriteria.recordCountPerPage }">
	<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${boardCriteria.currentPageNo }">
	<!-- 검색을 위한 데이터 -->
	<input type="hidden" id = "searchCategCd" name = "searchCategCd" value="${boardCriteria.searchCategCd }">

</form>