<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Description : 고객사관리 > 매장관리 > 목록 화면
-->

	<table id="companyTable" class="tb_basic_st">
		<caption>목록</caption>
		<colgroup>
			<col width="*">
			<col width="*">
			<col width="*">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">시트명</th>
				<th scope="col">관련테이블</th>
				<th scope="col">마스터번호</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${result.result}" varStatus="status">
				<tr>

					<td><c:out value='${data.sheetName}' /></td>
					<td><c:out value='${data.table}' /></td>
					<td><c:out value="${data.masterNum}" /></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(result.result) <= 0 }">
				<tr>
					<td class="nodata" colspan="8">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
