<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

	<table>
    	<tr>
        	<th>번호</th>
            <th>제목</th>
            <th>작성일</th>
        </tr>
        <c:forEach var = "data" items="${result.boardVolist }" varStatus="loop">
	        <tr>
	        	<td><c:out value='${data.boardSeq }' /></td>
	            <td><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
	            <td><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
	        </tr>
        </c:forEach>

        <c:if test="${fn:length(result.boardVolist) <= 0 }">
        	<tr>
	        	<td colspan="3" height="44" align="center">검색결과가 없습니다.</td>
	        </tr>
		</c:if>
    </table>

    <!-- <p class="page">&lt; 1 2 3 4 5 &gt;</p> -->

        <%-- <div class="btnPageZoneWrap">
			<div class="btnPageZone">
				<customTagUi:pagiNavigation paginationInfo="${boardCriteria}" type="front" jsFunction="fn_doSearch" />
			</div>
		</div> --%>
        <!-- <tr>
          <td height="80" align="center">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="/homepage/img/left0.gif" width="21" height="8"></td>
                <td><img src="/homepage/img/left01.gif" width="21" height="8"></td>
                <td align="center" width="20">10</td>
                <td align="center" width="20">9</td>
                <td align="center" width="20">8</td>
                <td align="center" width="20">7</td>
                <td align="center" width="20">6</td>
                <td align="center" width="20">5</td>
                <td align="center" width="20">4</td>
                <td align="center" width="20">3</td>
                <td align="center" width="20">2</td>
                <td align="center" width="20">1</td>
                <td><img src="/homepage/img/right01.gif" width="21" height="8"></td>
                <td><img src="/homepage/img/right02.gif" width="21" height="8"></td>
              </tr>
            </table>
          </td>
        </tr> -->
