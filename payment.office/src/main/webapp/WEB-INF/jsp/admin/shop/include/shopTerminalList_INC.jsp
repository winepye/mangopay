<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Description : 고객사관리 > 매장관리 > 목록 화면
-->

<style>
	.alignR {
		text-align: right;
	}
</style>



<div style="padding-top: 20px"></div>
	<div style="float:left; width:91%;">
		<h3 class="h2_table_titleCs" >* 매장단말기 상세정보<span style="font-size: 11px"><b>&nbsp;&nbsp;(※ 매장단말기 정보</b>의 매장단말번호를 클릭하면 상세정보를 확인할 수 있습니다.)</span></h3>

	</div>
	<div style="float:left; width:9%; text-align:right">
		<button type="button" class="btn_gray_B01" onclick="fn_goShopTerminalModify(${result.shopTerminalInfo.shopInfoId})">정보수정</button>
	</div>

<form id = "shopTerminalDetailFrm" name = "saveFrm" method="post">

	<input type="hidden" id="selectedShopTerminalId" name="selectedShopTerminalId">
	<input type="hidden" id="selectedShopInfolId" name="selectedShopInfolId">

	<table class="tb_left_st">
		<caption>매장단말기 등록</caption>
		<colgroup>
			<col width="10%" /><col width="15%" />
			<col width="10%" /><col width="15%" />
			<col width="10%" /><col width="15%" />
			<col width="10%" /><col width="15%" />

		</colgroup>

		<tbody>
			<tr>
				<th scope="row">가맹점상호</th>
				<td>
					<input type="text" class="input_s_b w100pro" id="serviceStoreName" name="serviceStoreName"
						   onkeyup="javascript:chkword(this, 30)"
						   value="${result.shopTerminalInfo.serviceStoreName}"/>
				</td>
				<th scope="row">매장단말번호</th>
				<td>
					<input type="text" class="input_s_b w100pro" id="shopTerminalNum" name="shopTerminalNum"
						   value="${result.shopTerminalInfo.shopTerminalNum}"
						   onkeyup="javascript:chkword(this, 5)"/>
				</td>
				<th scope="row">가맹점대표자</th>
				<td>
					<input type="text" class="input_s_b w100pro" id="serviceCeoName" name="serviceCeoName"
						   value="${result.shopTerminalInfo.serviceCeoName}"/>
				</td>
				<th scope="row">비밀번호</th>
				<td>
					<input type="password" class="input_s_b w100pro" id="password" name="password" />
				</td>
			</tr>



			<tr>
				<th scope="row">사업자번호</th>

				<c:set var = "bizBuf" value="${fn:split(result.shopTerminalInfo.serviceBizNum,'-') }"></c:set>
				<c:set var = "biz1" value="${bizBuf[0] }"></c:set>
				<c:set var = "biz2" value="${bizBuf[1] }"></c:set>
				<c:set var = "biz3" value="${bizBuf[2] }"></c:set>

				<td style="white-space:nowrap;" colspan="3">
					<input id="serviceBizNum1" name="serviceBizNum1" class="input_s_b w30pro"
						   value="${biz1}" onkeyup="javascript:chkword(this, 3, 'serviceBizNum2')" numberOnly/>
					<label class="w5pro">-</label>
					<input id="serviceBizNum2" name="serviceBizNum2" class="input_s_b w20pro"
						   value="${biz2}" onkeyup="javascript:chkword(this, 2, 'serviceBizNum3')" numberOnly/>
					<label class="w5pro">-</label>
					<input id="serviceBizNum3" name="serviceBizNum3" class="input_s_b w40pro"
						   value="${biz3}" onkeyup="javascript:chkword(this, 5, 'serviceTelNum1')" numberOnly/>
					<input type="hidden" name="serviceBizNum" id="serviceBizNum"
						   value="${result.shopTerminalBasicInfo.serviceBizNum}">
				</td>

				<th scope="row">가맹점연락처</th>

				<c:set var = "telNumBuf" value="${fn:split(result.shopTerminalInfo.serviceTelNum,'-') }"></c:set>
				<c:set var = "telNum1" value="${telNumBuf[0] }"></c:set>
				<c:set var = "telNum2" value="${telNumBuf[1] }"></c:set>
				<c:set var = "telNum3" value="${telNumBuf[2] }"></c:set>
				<td colspan="3">
					<input id="serviceTelNum1" name="serviceTelNum1" class="input_s_b w30pro"
						   value="${telNum1}" onkeyup="chkword(this, 3, 'serviceTelNum2')" numberOnly/>
					<label class="w5pro"> - </label>
					<input id="serviceTelNum2" name="serviceTelNum2" class="input_s_b w30pro"
						   value="${telNum2}" onkeyup="chkword(this, 4, 'serviceTelNum3')" numberOnly/>
					<label class="w5pro"> - </label>
					<input id="serviceTelNum3" name="serviceTelNum3" class="input_s_b w30pro"
						   value="${telNum3}" onkeyup="chkword(this, 4, 'paymentGroup')" numberOnly/>
					<input type="hidden" id="serviceTelNum" name="serviceTelNum"
						   value="${result.shopTerminalBasicInfo.serviceTelNum}">
				</td>
			</tr>

			<tr>
				<th scope="row">서비스그룹코드</th>
				<td>
					<customTagUi:code type="select" cdGrp="PAYMENT_GROUP" name="paymentGroup"
									  id="paymentGroup" cd="${result.shopTerminalInfo.paymentGroup}"
									  attr='class="sel_basic w100pro"' subjectText="선택"/>
				</td>
				<th scope="row">초기구동화면</th>
				<td>
					<customTagUi:code type="select" cdGrp="POS_CAT_DIV" name="initDriveScreen"
									  id="initDriveScreen" cd="${result.shopTerminalInfo.initDriveScreen}"
									  attr='class="sel_basic w100pro"' subjectText="선택"/>
				</td>
				<th scope="row">과세형태</th>
				<td>
					<select name="taxDiv" id="taxDiv"  class="sel_basic w100pro">
						<option value="" selected="selected">선택</option>
						<option value="TAX_ON" <c:if test="${result.shopTerminalInfo.taxDiv eq 'TAX_ON'}">selected="selected"</c:if>>과세</option>
						<option value="TAX_OFF" <c:if test="${result.shopTerminalInfo.taxDiv eq 'TAX_OFF'}">selected="selected"</c:if>>면세</option>
						<option value="TAX_PARALLEL" <c:if test="${result.shopTerminalInfo.taxDiv eq 'TAX_PARALLEL'}">selected="selected"</c:if>>과세 면세 겸업</option>
					</select>
				</td>
				<th scope="row">부가세율(%)</th>
				<td>
					<input type="text" class="input_s_b w100pro alignR" id="taxRate" name="taxRate"
						   value="${result.shopTerminalInfo.taxRate}" numberOnly/>
				</td>

			</tr>

			<tr>
				<th scope="row">가맹점우편번호</th>
				<td colspan="3">
					<input id="serviceZip" name="serviceZip" class="input_s_b w80pro" readonly
						   onclick="fn_searchZipCode()"
						   value="${result.shopTerminalInfo.serviceZip}"/>
					<button type="button" id="serviceZipBtn" class="btn_white_B01">검색</button>
				</td>
				<th scope="row">봉사료여부</th>
				<td>
					<select name="svcAmtYn" id="svcAmtYn"  class="sel_basic w100pro">
						<option value="" selected="selected">선택</option>
						<option value="Y" <c:if test="${result.shopTerminalInfo.svcAmtYn eq 'Y'}">selected="selected"</c:if>>예</option>
						<option value="N" <c:if test="${result.shopTerminalInfo.svcAmtYn eq 'N'}">selected="selected"</c:if>>아니오</option>
					</select>
				</td>
				<th scope="row">봉사료율(%)</th>
				<td>
					<input type="text" class="input_s_b w100pro alignR" id="svcChargeRate" name="svcChargeRate"
						   value="${result.shopTerminalInfo.svcChargeRate}" numberOnly/>
				</td>
			</tr>


			<tr>
				<th scope="row">가맹점주소</th>
				<td colspan="3">
					<input id="serviceAddr1" name="serviceAddr1" class="input_s_b w100pro"
						   onkeyup="javascript:chkword(this, 100)"
						   value="${result.shopTerminalInfo.serviceAddr1}"/>
				</td>
				<th scope="row">가맹점주소(상세)</th>
				<td colspan="3">
					<input id="serviceAddr2" name="serviceAddr2" class="input_s_b w100pro"
						   onkeyup="javascript:chkword(this, 100)"
						   value="${result.shopTerminalInfo.serviceAddr2}"/>
				</td>
			</tr>
			<tr>
				<th scope="row">바코드키인모드</th>
				<td>
					<customTagUi:code type="radio" cdGrp="BARCODE_KEYIN_MODE"
									  name="barcodeKeyinMode" id="barcodeKeyinMode" cd="${result.shopTerminalInfo.barcodeKeyinMode}"
									  prefix="<span class=radio_list>" postfix="</span>"/>
				</td>
				<th scope="row">사용여</th>
				<td colspan="5">
					<customTagUi:code type="radio" cdGrp="YN_COMMON"
									  name="useYn" id="useYn" cd="${result.shopTerminalInfo.useYn}"
									  prefix="<span class=radio_list>" postfix="</span>"/>
				</td>
			</tr>

		</tbody>
	</table>

</form>





	<div style="padding-top: 20px"></div>

	<div style="float:left; width:82%;">
		<h3 class="h2_table_titleCs" >* 매장단말기 서비스제공자</h3>
	</div>
	<div style="float:left; width:9%; text-align:right">
		<button type="button" class="btn_gray_B01" onclick="fn_srvProvAddHtml()">추가</button>
	</div>
	<div style="float:left; width:9%; text-align:right">
		<button type="button" class="btn_gray_B01" onclick="fn_srvProvSave()">저장</button>
	</div>

<form id = "srvProvFrm" name = "srvProvFrm" method="post">
	<input type="hidden" id="srvProvJson" name="srvProvJson">
</form>
	<input type="hidden" id="addIndex" value="0">

	<table class="tb_basic_st" id="srvProvTable">

		<caption>매장단말기 서비스제공자</caption>
		<colgroup>
			<col width="140"> <!--서비스제공자-->
			<col width="100"> <!--CAT_ID-->
			<col width="140"> <!--가맹점ID-->
			<col width="120"> <!--가맹점번호-->
			<col width="100"> <!--서비스체크여부-->
			<col width="90"> <!--사용여부-->
			<col width="80">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">서비스제공자</th>
				<th scope="col">CAT_ID</th>
				<th scope="col">가맹점ID</th> <%--FIXME: 2019-01-14 가맹점ID 및 가맹점번호 변경 여부 확인--%>
				<th scope="col">가맹점번호</th>
				<th scope="col">서비스체크여부</th>
				<th scope="col">사용여부</th>
				<th scope="col"></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${result.srvProvList}" varStatus="status">
				<tr>
					<td>
						<input type="hidden" name="shopTerminalProviderId" value="${data.shopTerminalProviderId}">
						<customTagUi:code type="select" cdGrp="SERVICE_PROVIDER" name="serviceProvider"
										  id="serviceProvider_${data.shopTerminalProviderId}"
										  cd="${data.serviceProvider}" attr='class="sel_basic w100pro"'
										  subjectText="선택"/>
					</td>
					<td>
						<input type="text" id="catId_${data.shopTerminalProviderId}" name="catId" value="${data.catId}" class="input_s_b w100pro" />
					</td>
					<td>
						<input type="text" id="serviceStoreId_${data.shopTerminalProviderId}" name="serviceStoreId" value="${data.serviceStoreId}" class="input_s_b w100pro" />
					</td>
					<td>
						<input type="text" id="serviceStoreNum_${data.shopTerminalProviderId}" name="serviceStoreNum" value="${data.serviceStoreNum}" class="input_s_b w100pro" />
					</td>
					<td>
						<customTagUi:code type="select" cdGrp="YN_COMMON"
										  name="serviceCheckYn" id="serviceCheckYn_${data.shopTerminalProviderId}" cd="${data.serviceCheckYn}"
										  attr='class="sel_basic w100pro"'/>
					</td>
					<td>
						<customTagUi:code type="select" cdGrp="YN_COMMON"
										  name="useYn" id="useYn_${data.shopTerminalProviderId}" cd="${data.useYn}"
										  attr='class="sel_basic w100pro"'/>
					</td>
					<td>

					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(result.srvProvList) <= 0 }">
				<input type="hidden" id="nodata" value="0">
				<tr>
					<td class="nodata" colspan="9">조회된 데이터가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

