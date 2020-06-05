<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
	<section id="contents">
		<!-- notice_top -->
		<table class="board_list_st01" summary="공지사항 (번호, 제목, 작성자 등)" >
			<caption>공지사항 목록</caption>
				    <colgroup>
					    <col width="8%" />
                        <col width="*" />
                        <col width="10%" />
                        <col width="10%" />
                    </colgroup>
                    <thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">등록일</th>
						<th scope="col">조회수</th>
					</tr>
				</thead>
				<tbody>
				<!-- 공지로 설정된 경우 -->
				<c:forEach var = "data" items="${result.boardVoToplist }">
					<tr class="setNotice">
						<td><span class="icon_notice"><em>notice</em></span></td>
						<td class="txt_left"><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
						<td><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
						<td><c:out value="${data.viewCnt }" /></td>
					</tr>
				</c:forEach>
				<c:forEach var = "data" items="${result.boardVolist }" varStatus="loop">
					<tr>
						<td scope="col"><c:out value='${data.boardSeq }' /></td>
						<td class="txt_left"><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
						<td><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
						<td><c:out value="${data.viewCnt }" /></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(result.boardVolist) <= 0 }">
					<tr>
						<td colspan="4" class="no_con">검색결과가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<div class="btnPageZoneWrap">
				<div class="btnPageZone">
					<customTagUi:pagiNavigation paginationInfo="${boardCriteria}" type="front" jsFunction="fn_doSearch" />
				</div>
			</div>
			<!--//게시판페이지버튼//-->
			<!-- <div class="bs_BtnBox_r"><a href="#" id="btnGoNotiCreatePage" name="btnGoNotiCreatePage" class="btn_white_B01">글쓰기</a></div> -->
	</section>