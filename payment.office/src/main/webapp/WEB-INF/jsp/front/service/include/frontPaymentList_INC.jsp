<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<table id="reportTable" class="board_list_st01" summary="" >
  <caption>리포트조회목록</caption>
  <colgroup>
      <col width="140px"    />
      <col width="140px"    />
      <col width="130px"    />
      <col width="*"    />
      <col width="140px"    />
      <col width="100px"    />
      <col width="100px"    />
      <col width="90px"    />
      <col width="90px"    />
      <col width="90px"    />
      <col width="90px"    />
  </colgroup>

  <thead>
      <tr>
          <th scope="col">가맹점명</th>
          <th scope="col">수취인명</th>
          <th scope="col">전화번호</th>
          <th scope="col">청구금액(원)</th>
          <th scope="col">청구사유</th>

          <th scope="col">거래일시</th>
          <th scope="col">진행상태</th>
          <th scope="col">발급사</th>
          <th scope="col">매입사</th>
          <th scope="col">승인번호</th>
      </tr>
  </thead>
  <tbody>
    <c:forEach var = "data" items="${result.reportVolist }" varStatus="i">
      <tr style="cursor:pointer;" onmouseenter="$(this).addClass('selected')" onmouseleave="$(this).removeClass()" onclick="javascript:fn_openDetailPage('${data.txId }');">
          <td class="type01"><c:out value='${data.storeName }' /></td>
          <td><c:out value='${data.payUserName }' /></td>
          <td><c:out value='${data.mobileNo }' /></td>
          <td class="type03"><b></strong><fmt:formatNumber value="${data.approvalAmount  }" pattern="#,###" /></b></td>
          <td class="type02"><c:out value='${data.requestReason }' /></td>

          <td><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
          <td><b><c:out value='${data.processStatusName }' /></b></td>
          <td><c:out value='${data.issuerName }' /></td>
          <td><c:out value='${data.accepterName }' /></td>
          <td class="type02"><c:out value='${data.approvalNumber }' /></td>
      </tr>
    </c:forEach>
    <c:if test="${fn:length(result.reportVolist) <= 0 }">
     <tr>
        <td class="no_con" colspan="10">조회된 데이터가 없습니다.</td>
      </tr>
    </c:if>
  </tbody>
</table>
<!--//탐방리포트목록//-->

<!--게시판페이지버튼-->
<div class="btnPageZoneWrap">
    <div class="btnPageZone" id="btnPageZone">
        <customTagUi:pagiNavigation paginationInfo="${serviceCriteria}" type="front" jsFunction="fn_doSearch" />
    </div>
</div>

<!--//게시판페이지버튼//-->

<INPUT TYPE="hidden" id="listTotalCntHidden" value="${serviceCriteria.totalRecordCount } 건">