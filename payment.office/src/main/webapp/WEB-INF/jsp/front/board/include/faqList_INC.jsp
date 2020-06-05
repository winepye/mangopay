<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<section id="contents">
	<h3 class="h3_title_st mgt30"><span>자주하는 질문</span><span class="countNum">전체(${boardCriteria.totalRecordCount })</span></h3>

	<table class="board_list_st01" summary="FAQ 자주하는질문(질문내용,조회수)" >
		<caption>자주하는 질문</caption>
			<colgroup>
				<col width="16%" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="algn_left">분류</th>
					<th scope="col">제목</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var = "data" items="${result.boardVolist }" varStatus="i">
					<tr>
						<td class="txt_left"><customTagUi:code type="text" cdGrp="FAQ_CATEG_CD" name="" cd="${data.categCd}" /></td>
						<td class="faq_title">
							<a href="#this" class="question"><em class="hidden">질문</em>${data.title }</a>
						</td>
					</tr>
					<tr class="qnaZone" style="display: none;">
						<td class="qnaAnswer">&nbsp;</td>
						<td class="qnaAnswer">
							<div class="answerBox editorContent"><a><em class="hidden">답변</em><c:out value="${data.content }" escapeXml="false"/></a></div>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(result.boardVolist) <= 0 }">
					<tr>
                		<td colspan="2" class="no_con">검색결과가 없습니다.</td>
            		</tr>
	  			</c:if>
			</tbody>
	</table>

	<!--게시판페이지버튼-->
	<div class="btnPageZoneWrap">
		<div class="btnPageZone">
                <customTagUi:pagiNavigation paginationInfo="${boardCriteria}" type="front" jsFunction="fn_doSearch" />
        </div>
	</div>
	<!--//게시판페이지버튼//-->

</section>