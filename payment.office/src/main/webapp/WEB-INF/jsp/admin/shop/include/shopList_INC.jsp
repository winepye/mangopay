<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Description : 고객사관리 > 매장관리 > 목록 화면
-->

<style>
	#companyTable {
		/*display: block;*/
		/*overflow-x: auto;*/
        overflow-x: scroll;
        overflow-y: hidden;
		/*white-space: nowrap;*/
	}

	 .SC{
		 overflow-x: scroll;
		 overflow-y: hidden;
	 }

	::-webkit-scrollbar {

		width: 18px;

		height: 18px;

		border: 10px solid #fff;

	}

	::-webkit-scrollbar-thumb {

		height: 50px;

		width: 50px;

		background: rgba(0,0,0,.2);

		-webkit-border-radius: 8px;

		border-radius: 8px;

		-webkit-box-shadow: inset 0 0 4px rgba(0,0,0,.1);

		border: 0;

	}
</style>
<div style="width:100%; overflow:auto; padding-bottom: 15px;">

	<table id="companyTable" class="tb_basic_st" summary="고객사List" style="width: 220%;">
		<caption>고객사 목록</caption>
		<colgroup>
			<col width="50"> <!--No-->
			<col width="120"> <!--고객사-->
			<col width="120"> <!--브랜드-->
			<col width="120"> <!--업종-->
			<col width="120"> <!--매장-->
			<col width="100"> <!--매장관리코드-->
			<col width="110"> <!--사업자번호-->
			<col width="100"> <!--매장단말번호-->

			<col width="100"> <!--과세형태-->
			<col width="100"> <!--부가세율-->
			<col width="100"> <!--봉사료-->
			<col width="100"> <!--봉사료율-->

			<col width="100"> <!--서비스그룹-->
			<col width="100"> <!--전화번호-->
			<col width="80"> <!--단말개수-->
			<col width="100"> <!--담당자명-->
			<col width="210"> <!--주소-->
			<%--<col width="*">--%> <!--결제서비스--> <%--화면에 보여주기 위한 정보로 부적절--%>
			<col width="100"> <!--등록일-->
			<col width="80"> <!--등록자-->
			<col width="100"> <!--수정일-->
			<col width="80"> <!--수정자-->
		</colgroup>
		<thead>
			<tr>
				<th scope="col">
					<input type="checkbox" id="allChkYn" name="allChkYn"  onclick="fn_listAllCheck(this)" />
				</th>
				<th scope="col">고객사</th>
				<th scope="col">브랜드</th>
				<th scope="col">업종</th>
				<th scope="col">매장</th>
				<th scope="col">매장관리코드</th>
				<th scope="col">사업자번호</th>
				<th scope="col">매장단말번호</th>

				<th scope="col">과세형태</th>
				<th scope="col">부가세율</th>
				<th scope="col">봉사료</th>
				<th scope="col">봉사료율</th>

				<th scope="col">서비스그룹</th>
				<th scope="col">전화번호</th>
				<th scope="col">단말개수</th>
				<th scope="col">담당자명</th>
				<th scope="col">주소</th>
				<%--<th scope="col">결제서비스</th>--%> <%--화면에 보여주기 위한 정보로 부적절--%>
				<th scope="col">등록일</th>
				<th scope="col">등록자</th>
				<th scope="col">수정일</th>
				<th scope="col">수정자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${result.shopList}" varStatus="status">
				<tr>
					<td>
						<input type="checkbox" id="chkYn_${data.shopTerminalId}" name="chkYn" value="${data.shopTerminalId}"/>
					</td>
					<td style="font-weight: bold">
						<u><a href="javascript:fn_goCompanyDetailPage('<c:out value="${data.companyInfoId}" />')">
							<c:out value='${data.companyName }' /></a></u>
					</td>
					<td style="font-weight: bold">
						<u><a href="javascript:fn_goBrandDetailPage('<c:out value="${data.brandInfoId}" />')">
							<c:out value='${data.brandName }' /></a></u>
					</td>
					<td><c:out value='${data.fullCateNm }' /></td>
					<td style="font-weight: bold">
						<u><a href="javascript:fn_goDetailPage('<c:out value="${data.shopInfoId}" />')">
								<c:out value='${data.shopName }' /></a></u>
					</td>
					<td><c:out value='${data.shopMngCode }' /></td>
					<td><c:out value='${data.serviceBizNum }' /></td>
					<td><c:out value='${data.shopTerminalNum }' /></td>

					<td><c:out value='${data.taxDivNm }' /></td>
					<td><c:out value='${data.taxRate }' />%</td>
					<td><c:out value="${data.svcAmtYn eq 'Y' ? '예' : '아니오' }" /></td>
					<td><c:out value='${data.svcChargeRate }' />%</td>

					<td><c:out value='${data.paymentGroupNm }' /></td>
					<td><c:out value='${data.serviceTelNum }' /></td>
					<td><c:out value='${data.terminalCnt }' /></td>
					<td><c:out value='${data.chargerName }' /></td>
					<td><c:out value='${data.serviceAddr }' /></td>
					<td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd"/></td>
					<td><c:out value='${data.createBy }' /></td>
					<td><fmt:formatDate value="${data.updateDate}" pattern="yyyy-MM-dd"/></td>
					<td><c:out value='${data.updateBy }' /></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(result.shopList) <= 0 }">
				<tr>
					<td class="nodata" colspan="8">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</div>

<!-- 템플릿 목록 -->
<input type = "hidden" id = "listTotalCount" value="${search.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${search}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>

<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="rightzone"><button type="button" onclick="fn_goCreatePopPage();" class="btn_blue_B02">매장 등록</button></span>
</div>