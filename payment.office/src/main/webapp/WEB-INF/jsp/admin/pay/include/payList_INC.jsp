<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : payList_INC.jsp
  * @Description : 간편결제관리 > 결제서비스관리 > JS
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.18        이인희      최초 생성
-->

<!-- 템플릿 목록 -->
<table id="companyTable" class="tb_basic_st" summary="고객사List">
	<caption>고객사 목록</caption>
    <colgroup>
        <col width="50"> <!--No-->
        <col width="70"> <!--계약상태-->
        <col width="110"> <!--서비스제공자-->
        <col width="*"> <!--결제수단-->
        <col width="80"> <!--결제방식-->
        <col width="80"> <!--담당자-->
        <col width="100"> <!--등록일-->
        <col width="80"> <!--등록자-->
        <col width="100"> <!--수정일-->
        <col width="80"> <!--수정자-->
    </colgroup>
	<thead>
		<tr>
			<th scope="col">NO</th>
			<th scope="col">서비스상태</th> <%-- FIXME : 2018-12-19 계약상태에 대한 컬럼 정보 없음--%>
			<th scope="col">서비스제공자</th>
			<th scope="col">결제수단</th>
			<th scope="col">결제방식</th>
			<th scope="col">담당자</th> <%-- FIXME : 2018-12-19 서비스제공자 담당자 컬럼 없음--%>
			<th scope="col">등록일</th>
			<th scope="col">등록자</th>
			<th scope="col">수정일</th>
			<th scope="col">수정자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${result.payServiceList}" varStatus="status">
			<tr>
				<td>
					<fmt:parseNumber value="${data.rnum }" integerOnly="true" />
				</td>
				<td>
					<c:if test="${data.useYn eq 'Y'}">
						계약
					</c:if>
					<c:if test="${data.useYn eq 'N'}">
						해지
					</c:if>
				</td>
				<td><c:out value='${data.serviceProviderNm }' /></td>
				<td style="font-weight: bold">
					<u><a href="javascript:fn_goDetailPage('<c:out value="${data.paymentServiceId}" />')"><c:out value='${data.paymentMeanNm }' /></a></u>
				</td>
				<td><c:out value='${data.paymentMethod }' /></td>
				<td>없음</td>
				<td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd"/></td>
				<td><c:out value='${data.createBy }' /></td>
				<td><fmt:formatDate value="${data.updateDate}" pattern="yyyy-MM-dd"/></td>
				<td><c:out value='${data.updateBy }' /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result.payServiceList) <= 0 }">
			<tr>
				<td class="nodata" colspan="10">조회된 데이터가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${search.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${search}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>

<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="rightzone"><button type="button" onclick="goPayCreatePage();" class="btn_blue_B02">간편결제 등록</button></span>
</div>