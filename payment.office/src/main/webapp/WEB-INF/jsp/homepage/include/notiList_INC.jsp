<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>


    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="51">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="/homepage/img/board-line0.gif" width="1000" height="1"></td>
        </tr>
        <tr>
          <td height="46" bgcolor="F7F7EC">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="44" align="center"><b>번호</b></td>
                <td width="710" align="center"><b>제목</b></td>
                <td width="85" align="center"><b>작성자</b></td>
                <td width="84" align="center"><b>작성일</b></td>
                <td width="77" align="center"><b>조회수</b></td>
              </tr>
            </table>
          </td>
        </tr>
        <c:forEach var = "data" items="${result.boardVolist }" varStatus="loop">
        <tr>
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td colspan="5"><img src="/homepage/img/board-line.gif" width="1000" height="1"></td>
              </tr>
              <tr>
                <td width="44" height="44" align="center"><c:out value='${data.boardSeq }' /></td>
                <td width="710" style="padding:0 0 0 10"><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
                <td width="85" align="center"><c:out value="${data.userName }" /></td>
                <td width="84" align="center"><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
                <td width="77" align="center"><c:out value="${data.viewCnt }" /></td>
              </tr>
            </table>
          </td>
        </tr>
		</c:forEach>
		<c:if test="${fn:length(result.boardVolist) <= 0 }">
			<tr>
	          <td>
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td colspan="5"><img src="/homepage/img/board-line.gif" width="1000" height="1"></td>
	              </tr>
	              <tr>
	                <td colspan="5" height="44" align="center">검색결과가 없습니다.</td>
	              </tr>
	            </table>
	          </td>
	        </tr>

		</c:if>

        <tr>
          <td><img src="/homepage/img/board-line0.gif" width="1000" height="1"></td>
        </tr>
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
      </table>
