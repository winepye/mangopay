<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
 <!--문의게시판-->
<table class="board_list_st01 mgt30" summary="1:1문의 (번호, 문의유형, 제목, 문의날짜, 답변상태)">
	<caption>1:1 문의목록</caption>
    <colgroup>
    	<col width="8%" /><!--번호-->
        <col width="13%" /><!--문의유형-->
        <col width="*" /><!--제목-->
        <col width="10%" /><!--문의날짜-->
        <col width="10%" /><!--답변상태-->
    </colgroup>
    <thead>
        <tr>
            <th scope="col">번호</th>
            <th scope="col">문의유형</th>
            <th scope="col">제목</th>
            <th scope="col">문의날짜</th>
            <th scope="col">답변상태</th>
        </tr>
    </thead>
    <tbody>
    	<c:forEach var = "data" items="${result.boardVolist }" varStatus="i">
    		<tr>
	            <td>${data.boardSeq }</td>
	            <td class="type01"><customTagUi:code type="text" cdGrp="QNA_CATEG_CD" name="boardType2" cd="${data.categCd }" /></td>
	            <td class="qtitle"><span class="question"><em>질문</em></span><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
	            <td class="date"><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
	            <td class="state">
                    <c:choose>
                        <c:when test="${data.statusCd eq 'RECP' }">
                            <span class="start"></span>
                        </c:when>
                        <c:when test="${data.statusCd eq 'READ' }">
                            <span class="ing"></span>
                        </c:when>
                        <c:when test="${data.statusCd eq 'ANSW' }">
                            <span class="finish"></span>
                        </c:when>
                        <c:otherwise>
                            <span class="start"></span>
                        </c:otherwise>
                    </c:choose>
                </td>
        	</tr>
    	</c:forEach>
    	<c:if test="${fn:length(result.boardVolist) <= 0 }">
			<tr>
                <td colspan="5" class="no_con">검색결과가 없습니다.</td>
            </tr>
	  </c:if>
    </tbody>
</table>
<!--//문의게시판//-->
<!--게시판 페이지버튼-->
<div class="btnPageZoneWrap">
    <div class="btnPageZone">
        <customTagUi:pagiNavigation paginationInfo="${boardCriteria}" type="front" jsFunction="fn_doSearch" />
    </div>
</div>
<!--//게시판페이지버튼//-->
<div class="bs_BtnBox_r mgtm30">
    <!-- <a href="#this" class="btn_white_B01" id = "btnCreate">문의등록</a> -->
    <button type="button" class="btn_white_B01" id = "btnCreate">문의하기</button>
</div>
<!--//게시판 페이지버튼//-->