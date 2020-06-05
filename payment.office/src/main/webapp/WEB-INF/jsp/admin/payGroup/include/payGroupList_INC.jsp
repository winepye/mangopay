<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%--<%@ include file="/WEB-INF/jsp/admin/payGroup/js/payGroupList_JS.jsp"%>--%>
<!--
  NAVI : 간편결제관리 > 결제서비스그룹 관리 > 목록
-->

<style>
	.dab{
		disabled :"disabled"
	}
</style>

<!-- 템플릿 목록 -->
<table id="payGroupTb" class="tb_basic_st" summary="고객사List">
	<caption>목록</caption>
    <colgroup>
        <col width="50"> <!--No-->
        <col width="100"> <!--서비스제공자-->
        <col width="100"> <!--결제수단-->
        <col width="80"> <!--사용여부-->
        <col width="80"> <!--노출여부-->
        <col width="100"> <!--노출방법-->
        <col width="80"> <!--노출순번-->
        <col width="120"> <!--노출명-->
        <col width="*"> <!--노출이미지-->
    </colgroup>
	<thead>
		<tr>
			<th scope="col">NO</th>
			<th scope="col">서비스제공자</th>
			<th scope="col" style="cursor: pointer" onclick="fn_sort('paymentMean')" >결제수단</th>
			<th scope="col" style="cursor: pointer" onclick="fn_sort('useYn')">사용여부</th>
			<th scope="col">노출여부</th>
			<th scope="col">노출방법</th>
			<th scope="col" style="cursor: pointer" onclick="fn_sort('displayOrder')">노출순번</th>
			<th scope="col">노출명</th>
			<th scope="col">노출이미지</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${result.paySrvGroupList}" varStatus="status">
			<tr class="testTr">
				<td>
					<fmt:parseNumber value="${data.rnum }" integerOnly="true" />
				</td>

				<td>
					<c:out value='${data.serviceProviderNm }' />
				</td>

				<td id="paymentMeanNm_${data.paymentServiceId}">
					<c:out value='${data.paymentMeanNm }' />
				</td>

				<td <%--class="chktd"--%>>
					<input type="checkbox" id="useYn_${data.paymentServiceId}"
						   name="useYn" value="${data.paymentServiceId}"
						   onchange="fn_onclickEvent('<c:out value="${data.paymentServiceId}" />')"
						   <c:if test="${data.paymentServiceGroupListId ne null}">checked</c:if> />
				</td>

				<td <%--id="td_${data.paymentServiceId}" <c:if test="${data.paymentServiceGroupListId ne null}">class="chktd2"</c:if>--%>>
					<input type="checkbox" name="displayYn" id="displayYn_${data.paymentServiceId}" value="Y"
						   <c:if test="${data.paymentServiceGroupListId eq null}">disabled</c:if>
						   <c:if test="${data.displayYn eq 'Y'}">checked</c:if> />
				</td>

				<td>
					<select name="displayMethod" id="displayMethod_${data.paymentServiceId}"
							class="sel_basic w100pro"
							<c:if test="${data.paymentServiceGroupListId eq null}">disabled</c:if>>
						<option value="" selected="selected">선택</option>
						<c:forEach var="item" items="${result.dispMethodList}">
							<option value="${item.cd}" <c:if test="${item.cd eq data.displayMethod}">selected="selected"</c:if> >${item.cdNm}</option>
						</c:forEach>
					</select>
				</td>

				<td>
					<input type="text" class="input_s_b w100pro" id="displayOrder_${data.paymentServiceId}"
						   name="displayOrder" value="${data.displayOrder}" onkeyup="chkword(this, 11)" numberOnly
						   <c:if test="${data.paymentServiceGroupListId eq null}">disabled</c:if>>
				</td>
				<td>
					<input type="text" class="input_s_b w100pro" id="displayName_${data.paymentServiceId}"
						   name="displayName" value="${data.displayName}"
						   <c:if test="${data.paymentServiceGroupListId eq null}">disabled</c:if>>
				</td>
				<td>
					<input type="text" class="input_s_b w100pro" id="displayImageUrl_${data.paymentServiceId}"
						   name="displayImageUrl" value="${data.displayImageUrl}" onkeyup="chkword(this, 150)"
						   <c:if test="${data.paymentServiceGroupListId eq null}">disabled</c:if>>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result.paySrvGroupList) <= 0 }">
			<tr>
				<td class="nodata" colspan="10">조회된 데이터가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${search.totalRecordCount }" >


<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="rightzone"><button type="button" onclick="fn_listSave();" class="btn_blue_B02">목록저장</button></span>
    <%--<span class="rightzone"><button type="button" onclick="fn_initList();" class="btn_blue_B02">초기화</button></span>--%>
</div>


