<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : companyList.jsp
  * @Description : admin > 고객사 목록 조회
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.11.16	    이인희      최초 생성
-->

<!-- 템플릿 목록 -->
<table id="companyTable" class="tb_basic_st" summary="고객사List">
	<caption>고객사 목록</caption>
    <colgroup>
        <col width="50"> <!--No-->
        <col width="60"> <!--서비스상태-->
        <col width="70"> <!--브랜드코드-->
        <col width="*"> <!--브랜드명-->
        <col width="80"> <!--고객사명-->
        <col width="100"> <!--업종-->
        <col width="60"> <!--매장수-->
        <col width="100"> <!--등록일-->
        <col width="80"> <!--등록자-->
        <col width="100"> <!--수정일-->
        <col width="80"> <!--수정자-->
    </colgroup>
	<thead>
		<tr>
			<th scope="col">NO</th>
			<th scope="col">서비스상태</th>
			<th scope="col">브랜드코드</th>
			<th scope="col">브랜드명</th>
			<th scope="col">고객사명</th>
			<th scope="col">업종</th>
			<th scope="col">매장수</th>
			<th scope="col">등록일</th>
			<th scope="col">등록자</th>
			<th scope="col">수정일</th>
			<th scope="col">수정자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${result}" varStatus="status">
			<tr>
				<td>
					<c:out value='${data.rnum }' />
				</td>
				<td><c:out value='${data.currentState }' /></td>
				<td><c:out value='${data.brandInfoId }' /></td>
				<td class="txt_userid">
					<a href="javascript:fn_goDetailPage('<c:out value="${data.brandInfoId}" />','<c:out value="${data.companyInfoId}" />')"><c:out value='${data.brandName }' /></a>
				</td>
				<td><c:out value='${data.companyName }' /></td>
				<td><c:out value='${data.bizType }' /></td>
				<td><c:out value='${data.shopCnt }' /></td>
				<td><c:out value='${data.createDate }' /></td>
				<td><c:out value='${data.createBy }' /></td>
				<td><c:out value='${data.updateDate }' /></td>
				<td><c:out value='${data.updateBy }' /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result) <= 0 }">
			<tr>
				<td class="nodata" colspan="9">조회된 데이터가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${brandCriteria.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${brandCriteria}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>

<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="rightzone"><button type="button" onclick="goBrandCreatePage();" class="btn_blue_B02">브랜드 등록</button></span>
</div>