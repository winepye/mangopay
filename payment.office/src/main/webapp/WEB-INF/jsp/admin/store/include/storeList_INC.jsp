<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : storeList.jsp
  * @Description : admin > 회원 목록 조회
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.04	 이인희      최초 생성
-->

<!-- 템플릿 목록 -->
<table id="userTable" class="tb_basic_st" summary="회원List">
	<caption>회원목록</caption>
    <colgroup>
        <col width="*"> <!--가맹점코드-->
        <col width="*"> <!--가맹점명-->
        <col width="*"> <!--가맹점명-->
        <col width="120"> <!--CAT ID-->
        <col width="120"> <!--사업자번호-->
        <col width="100"> <!--업종-->
        <col width="*"> <!--대표자명-->
        <col width="120"> <!--전화번호-->
        <col width="100"> <!--가입일-->
    </colgroup>
	<thead>
		<tr>
			<th scope="col">가맹점코드</th>
			<th scope="col">가맹점명</th>
			<th scope="col">거래처</th>
			<th scope="col">CAT ID</th>
			<th scope="col">사업자번호</th>
			<th scope="col">업종</th>
			<th scope="col">대표자명</th>
			<th scope="col">전화번호</th>
			<th scope="col">가입일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${result}" varStatus="status">
			<tr>
				<td class="txt_userid">
				    <a href="javascript:fn_goDetailPage('<c:out value="${data.storeCode}" />')"><c:out value='${data.storeCode }' /></a>
				</td>
				<td><c:out value='${data.storeName }' /></td>
				<td><c:out value='${data.companyName }' /></td>
				<td class="txt_phonenum"><c:out value='${data.catId }' /></td>
				<td><c:out value='${data.bizRegNum }' /></td>
				<td><c:out value='${data.bizType }' /></td>

				<td><c:out value='${data.ceoName }' /></td>
				<td><c:out value='${data.telNum }' /></td>
				<td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd"/></td>

			</tr>
		</c:forEach>
		<c:if test="${fn:length(result) <= 0 }">
			<tr>
				<td class="nodata" colspan="9">조회된 데이터가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${storeCriteria.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${storeCriteria}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>

<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="rightzone"><button type="button" onclick="goStoreCreatePage();" class="btn_blue_B02">가맹점 등록</button></span>
</div>