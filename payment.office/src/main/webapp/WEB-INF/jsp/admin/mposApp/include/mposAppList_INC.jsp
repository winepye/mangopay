<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : mposAppList_INC.jsp
  * @Description : APP 버전관리 > MPOS 버전관리 > JS
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.27        이인희      최초 생성
-->

<!-- 템플릿 목록 -->
<table id="companyTable" class="tb_basic_st" summary="고객사List">
	<caption>고객사 목록</caption>
    <colgroup>
        <col width="50"> <!--No-->
        <col width="100"> <!--모바일타입-->
        <col width="150"> <!--APP명-->
        <col width="100"> <!--업데이트 방식-->
        <col width="*"> <!--패키지명-->
        <col width="80"> <!--버전-->
        <col width="100"> <!--등록일-->
        <col width="80"> <!--등록자-->
        <col width="100"> <!--수정일-->
        <col width="80"> <!--수정자-->
    </colgroup>
	<thead>
		<tr>
			<th scope="col">NO</th>
			<th scope="col">모바일타입</th>
			<th scope="col">APP명</th>
			<th scope="col">업데이트 방식</th>
			<th scope="col">패키지명</th>
			<th scope="col">버전</th>
			<th scope="col">등록일</th>
			<th scope="col">등록자</th>
			<th scope="col">수정일</th>
			<th scope="col">수정자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${result.mposAppList}" varStatus="status">
			<tr>
				<td><fmt:parseNumber value="${data.rnum}" integerOnly="true" /></td> <%--NO--%>
				<td><c:out value="${data.mobileTypeNm}" /></td> <%--모바일타입--%>
				<td style="font-weight: bold">
					<u><a href="javascript:fn_goDetailPage('<c:out value="${data.appVersionId}" />')">
						<c:out value='${data.appName }' /></a></u>
				</td>
				<td><c:out value='${data.appUpdateMethodNm }' /></td>
				<td><c:out value='${data.packageName }' /></td>
				<td><c:out value="${data.appVersion}" /> </td>
				<td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd"/></td>
				<td><c:out value='${data.createBy }' /></td>
				<td><fmt:formatDate value="${data.updateDate}" pattern="yyyy-MM-dd"/></td>
				<td><c:out value='${data.updateBy }' /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result.mposAppList) <= 0 }">
			<tr>
				<td class="nodata" colspan="10">조회된 데이터가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="3" >
<input type = "hidden" id = "listTotalCount" value="${search.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${search}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>

<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="rightzone"><button type="button" onclick="goCreatePage();" class="btn_blue_B02">MPOS 버전 추가</button></span>
</div>