<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<table id="customerGroupTable" class="tb_basic_st" summary="" >
  <caption>사용자그룹목록</caption>
  <colgroup>
      <col width="*"    />
      <col width="*"    />
      <col width="30%"    />
  </colgroup>

  <thead>
      <tr>
          <th scope="col">사용자그룹명</th>
          <th scope="col">비고</th>
          <th scope="col">사용자<br>건수</th>
      </tr>
  </thead>
  <tbody>
  	<c:forEach var = "data" items="${result.customerGroupList }" varStatus="i">
  		<tr id="customerGroupTr_${data.customerGroupId }" class = "customerGroupTr" style="cursor: pointer;">
  			<td onclick="getCustomerGroupDetail('${data.customerGroupId }')">
  				${data.groupNm }
  			</td>
  			<td onclick="getCustomerGroupDetail('${data.customerGroupId }')" >
  				<span style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; /* 라인수 */ -webkit-box-orient: vertical; word-wrap:break-word;">
  				${data.description }
  				</span>
  			</td>
  			<td onclick="getCustomerGroupDetail('${data.customerGroupId }')">
  				${data.customerCnt }
  			</td>

  		</tr>
  	</c:forEach>
    <c:if test="${fn:length(result.customerGroupList) <= 0 }">
     <tr>
        <td class="no_con" colspan="5">조회된 데이터가 없습니다.</td>
      </tr>
    </c:if>
  </tbody>
</table>
<!--게시판페이지버튼-->
<div class="btnPageZoneWrap">
    <div class="btnPageZone" id="btnPageZone">
        <customTagUi:pagiNavigation paginationInfo="${serviceCriteria}" type="front" jsFunction="searchCustomerGroup" />
    </div>
</div>
<!--//게시판페이지버튼//-->

<!-- 검색이나 화면이동을 위한 데이터 -->
<input type="hidden"  name = "recordCountPerPage" value="${serviceCriteria.recordCountPerPage }">
<input type="hidden"  name = "currentPageNo" value="${serviceCriteria.currentPageNo }">