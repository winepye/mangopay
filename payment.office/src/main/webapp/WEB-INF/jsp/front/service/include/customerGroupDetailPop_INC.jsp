<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript">
	var isGroupDetailChg = false;

	$("#customerGroupDetailTable input").change(function(){
		isGroupDetailChg = true;
	});
</script>
<c:choose>
	<c:when test="${result.customerGroupDetail.customerGroup == null }">
		<div class="nocon" id="customerGroupNoSelectArea">
		    <p class="nocon_title">선택된 사용자그룹이 없습니다.</p>
		    <p class="nocon_txt">좌측 사용자그룹 목록을 클릭해 주세요.</p>
		</div>
	</c:when>

	<c:otherwise>
		<input type="hidden" id = "searchCustomerGroupId" value="${result.customerGroupDetail.customerGroup.customerGroupId}">
		<div id = "customerGroupSummaryArea" style="">
			<h4>
			    <strong>[사용자그룹명] : </strong> <span class="comcode">${result.customerGroupDetail.customerGroup.groupNm}</span>
			    <br>
			    <strong>[비고] : </strong> <span class="comcode">${result.customerGroupDetail.customerGroup.description}</span>
			    <br>
			    <strong>[청구사유] : </strong> <span class="comcode"><input type="text" class="input_s_b" id="customerUserReason" value=""placeholder="청구사유를 입력해 주세요."></span>
				<br>
			    <strong>[청구금액] : </strong> <span class="comcode"><input type="text" class="input_s_b number" id="customerAmount" value=""placeholder="청구금액을 입력해 주세요."></span>
			    <div class="detail_BtnBox mgt5 mgb5" style="text-align: right;">
			        <button type="button" class="btn_blue_B02" onclick="selectCustomer()">선택</button>
			    </div>

			</h4>
		</div>
		<!--검색-->
		<div class="searchZone">
			<div class="fl_block">

			</div>
			<div class="fr_block">
				<span class="title mgr6 mgt5" style="float:left;">사용자명</span>
				<input type="text" class="input_s_b" style="float:left;width: 60%" name="searchText2" id="searchText2" value="${result.searchText}" placeholder="사용자명을 입력해주세요."
				onkeypress="if(event.keyCode==13) {getCustomerGroupDetail('${result.customerGroupDetail.customerGroup.customerGroupId}'); return false;}" autocomplete="off"/>
				<button type="button" id = "btnSearch2" style="float:left;width: 40px;" class="btn_b_search mgl6" onclick="getCustomerGroupDetail('${result.customerGroupDetail.customerGroup.customerGroupId}');">검색</button>
			</div>
		</div>

		<table id="customerGroupDetailTable" class="tb_basic_st" summary="" >
		  <caption>사용자그룹목록</caption>
		  <colgroup>
		      <col width="10%"    />
		      <col width="20%"    />
		      <col width="23%"    />
		      <col width="*"    />
		  </colgroup>

		  <thead>
		      <tr>
		          <th scope="col"><label><input type="checkbox" id="chkCustomerGroupDetail" onclick="fn_allCheck(this);" /><em class="hidden">전체선택</em></label></th>
		          <th scope="col">사용자명</th>
		          <th scope="col">모바일번호</th>
		          <th scope="col">비고</th>
		      </tr>
		  </thead>
		  <tbody>
		  	<c:forEach var = "data" items="${result.customerGroupDetail.customerGroupDetailList }" varStatus="i">
		  		<tr id="customerGroupDetailTr_${data.customerGroupDetailId }" class = "customerGroupDetailTr">
		  			<td>
		  				<label><input type="checkbox" name="chkCustomerGroupDetail" value="${data.customerGroupDetailId }" onclick="fn_eachCheck(this);" /></label>
		  				<input type="hidden" name = "customerGroupDetailId" value="${data.customerGroupDetailId }">
		  				<input type="hidden" name = "deleteYn" value="${data.deleteYn }">
		  			</td>
		  			<td >
		  				<input type="text" class="w100pro" name="customerNm" value="${data.customerNm }" readonly="readonly">
		  			</td>
		  			<td>
		  				<input type="text" class="w100pro" name="customerPhone" placeholder="(-)제외" value="${data.customerPhone }"readonly="readonly">
		  			</td>
		  			<td>
		  				<input type="text" class="w100pro" name="description" value="${data.description }"readonly="readonly">
		  			</td>
		  		</tr>
		  	</c:forEach>
		    <c:if test="${fn:length(result.customerGroupDetail.customerGroupDetailList) <= 0 }">
		     <tr>
		        <td class="no_con" colspan="4" style="height: 200px;">
		        	조회된 데이터가 없습니다.
		        </td>
		      </tr>
		    </c:if>
		  </tbody>
		</table>
	</c:otherwise>
</c:choose>