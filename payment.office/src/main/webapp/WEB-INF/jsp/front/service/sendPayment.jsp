<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/sendPayment_JS.jsp"%>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/xlsx.full.min.js"></script>
<!--
  * @Class Name  : sendPayment.jsp
  * @Description : front > 승인이력검색
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2020.5.31	 psj      최초 생성
-->
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />
<a id="downTemplate"></a>
<section id="contents">
<div id = "initFileArea" style="display: none;">
	<input type="file" style="position:absolute;margin:0;width: 80px;padding:0;margin-left: -70px;margin-top: -8px;z-index:1;opacity:0;filter:alpha(opacity:0);cursor:pointer;-ms-filter:;" class="Add_Files" id="excelFileBuf" name="excelFileBuf" onchange="excelExport(event)">
</div>

<form id = "frm" name = "frm" method="post">
 	<div class="detail_BtnBox mgt5 mgb5" style="text-align: right;">
        <!-- <button type="button" class="btn_white_B02" id="btnVisitCancel">건별추가</button> -->
        <button type="button" class="btn_white_B02" id="btnCustomerAdd" onclick="openCustomerGroupPop2();">사용자그룹추가</button>
        <button type="button" class="btn_white_B02" id="btnTemplateExcelDown">엑셀 템플릿</button>
        <div class="btn_white_B02" id="btnExcelUpload" style="cursor: pointer;"><span>엑셀업로드</span>
        	<input type="file" style="position:absolute;margin:0;width: 80px;padding:0;margin-left: -70px;margin-top: -8px;z-index:1;opacity:0;filter:alpha(opacity:0);cursor:pointer;-ms-filter:;" class="Add_Files" id="excelFile" name="excelFile" onchange="excelExport(event)">
        </div>
    </div>
	<table id="paymentTable" class="board_list_st01" summary="" >
	  <caption>청구서발송</caption>
	  <colgroup>
	      <col width="50"    />
	      <col width="140px"    />
	      <col width="130px"    />
	      <col width="140px"    />
	      <col width="100px"    />
	      <col width="*"    />
	  </colgroup>

	  <thead>
	      <tr>
	          <th scope="col"><label><input type="checkbox" id="chkPaymentTable" onclick="fn_allCheck(this);" /><em class="hidden">전체선택</em></label></th>
	          <th scope="col">발송구분</th>
	          <th scope="col">수취인명</th>
	          <th scope="col">전화번호</th>
	          <th scope="col">청구금액</th>
	          <th scope="col">청구사유</th>
	      </tr>
	  </thead>
	  <tbody>
	     <tr>
	        <td class="no_con" colspan="10" id = "noList">
	        	<p class="notice_mark mgt0"><span class="mark"><em>!</em></span><span>건별추가/사용자그룹추가/엑셀업로드 기능을 통해 발송 대상을 입력해주세요.</span></p>
	        </td>
	      </tr>
	  </tbody>
	</table>

	<div class="bs_BtnBox_c">
		<label><input type="radio" checked="checked" name="sendType" value="ALIMTALK" /><span class="mgl6">카카오톡 청구서발송</span></label>
		<label><input type="radio" name="sendType"  value="SMS"/><span class="mgl6">SMS 청구서발송</span></label>
        <button type="button" class="btn_blue_B01 mgl10" id = "btnSendAll">전체발송</button>
        <button type="button" class="btn_white_B01" id = "btnSend">선택발송</button>
        <button type="button" class="btn_white_B01" id = "btnDelete">선택삭제</button>
    </div>

</form>

<!-- 건별추가 -->
<form id = "createPaymentfrm" name = "createPaymentfrm" method="post">
	<h3 class="memberStateTitle mgt50">건별추가</h3>
	<table class="board_regist_st01 mgt20" summary="메세지충전 (수취인명, 모바일번호, 청구금액,청구사유)">
	   <caption>메세지충전</caption>
	   <colgroup>
	       <col width="12%" />
	       <col width="18%" />
	       <col width="12%" />
	       <col width="20%" />
	       <col width="9%" />
	       <col width="*%" />
	   </colgroup>
	   <tr>
	       <th scope="row"><label for="createPaymentName">수취인명</label></th>
	       <td>
	       		<input type="text" id="createPaymentName" name="createPaymentName" class="input_s_b w100pro">
	       </td>
	       <th scope="row"><label for="createPaymentPhone">모바일번호</label></th>
	       <td>
	           <input type="text" id="createPaymentPhone" name="createPaymentPhone" class="input_s_b w100pro"
	           	   placeholder="(-)제외한 모바일번호 입력"/>
	        </td>
	       <th scope="row"><label for="createPaymentAmount">청구금액</label></th>
	       <td>
	       		<input type="text" id="createPaymentAmount" name="createPaymentAmount" class="input_s_b w80pro number"><span class = "mgl6">원</span>
	       </td>
	      </tr>
	      <tr>
	       <th scope="row"><label for="createPaymentDescription">청구사유</label></th>
	       <td colspan="5">
	       		<input type="text" id="createPaymentDescription" name="createPaymentDescription" class="input_s_b w100pro">
	       </td>
	    </tr>
	</table>
	<div class="bs_BtnBox_c">
	    <button type="button" class="btn_white_B02" id = "btnCreatePaymentInit">초기화</button>
	    <button type="button" class="btn_blue_B02 mgl10" id = "btnCreatePayment">추가</button>
	</div>
</form>
<div id = "customerGroupPop" style="display: none;">
    <div id="pop_wrap" >
    </div>
</div>

<form id = "templateFrm" name = "templateFrm">
</form>


<!-- 사용자그룹추가/수정팝업 -->
<form id = "customerPopFrm" name = "customerPopFrm">

</form>
</section>