<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/customerGroupList_JS.jsp"%>
<!--
  * @Class Name  : sendPayment.jsp
  * @Description : front > 승인이력검색
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2020.5.31	 psj      최초 생성
-->
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/xlsx.full.min.js"></script>
<section id="contents">
<!--탐방일정확인-->
<div class="interCalendarWrap">
	<div class="step_detailview">
	    <h3>
	    	<span>사용자그룹관리
	    		<button type="button" id = "btnAddCustomerGroup" style="width: 40px;" class="btn_gray_s01 mgl10">추가</button>
	    		<button type="button" id = "btnDeleteCustomerGroup" style="width: 40px;" class="btn_white_s01 mgl10">선택삭제</button>
	    	</span>
	    </h3>
	    <div class="detailviewBox">
	        <article>
	        	<form id="groupFrm" name = "groupFrm">
	                <!--검색-->
					<div class="searchZone">
						<div class="fl_block">

						</div>
						<div class="fr_block">
							<span class="title mgr6 mgt5" style="float:left;">사용자그룹명</span>
							<input type="text" class="input_s_b" style="float:left;width: 60%" name="searchText" id="searchText" placeholder="그룹명을 입력해주세요."
							onkeypress="if(event.keyCode==13) {searchCustomerGroup(1); return false;}" autocomplete="off"/>
							<button type="button" id = "btnSearch" style="float:left;width: 40px;" class="btn_b_search mgl6">검색</button>
						</div>
					</div>
					<div id = "customerGroupListArea">
						<div id="includeArea">
							<jsp:include page="./include/customerGroupList_INC.jsp"></jsp:include>
						</div>
					</div>
				  </form>
             </article>
	    </div>
	</div>
	<div class="step_detailview">
	    <h3>사용자관리</h3>
	    <div class="detailviewBox">
	        <article id = "customerGroupDetailArea">
	        	<jsp:include page="./include/customerGroupDetail_INC.jsp"></jsp:include>
             </article>
	    </div>
	</div>

<!-- 사용자그룹추가/수정팝업 -->
<div id = "customerGroupPop" style="display: none;">
    <div id="pop_wrap">
        <div class="pop_titleZone">
            <h1 class="title">사용자그룹 <span class="customerGroupCreate">추가</span><span class="customerGroupModify">수정</span></h1>
            <button type="button" class="btn_popclose closePop"><em>닫힘</em></button>
        </div>
        <!--팝업컨텐츠-->
        <div class="pop_container">
			<input type="hidden" id = "customerGroupIdPop"><!-- 수정용  -->
		    <table class="board_regist_st01 " summary="메세지충전 (충전금액, 충전방법, 결재요청 모바일번호)">
		        <caption>사용자그룹추가/수정</caption>
		        <colgroup>
		            <col width="18%" />
		            <col width="20%%" />
		            <col width="12%" />
		            <col width="*%" />
		        </colgroup>
		        <tr>
		            <th scope="row"><label for="groupNm">사용자그룹명</label></th>
		            <td>
		            	 <input type="text" id="groupNm" name="groupNm" class="input_s_b w100pro">
		            </td>
		            <th scope="row"><label for="description">비고</label></th>
		            <td>
		                <input type="text" id="description" name="description" class="input_s_b w100pro">
		            </td>
		        </tr>
		    </table>
            <div class="bs_BtnBox_c mgt20">
                <button type="button" class="btn_white_B01 closePop" >닫기</button>
                <button type="button" class="btn_blue_B01 mgl10 customerGroupCreate" id = "btnSaveCustomerGroup">저장</button>
                <button type="button" class="btn_blue_B01 mgl10 customerGroupModify" id = "btnModifyCustomerGroup">수정</button>
            </div>
        </div>
        <!--//팝업컨텐츠//-->
    </div>
</div>
<form id = "templateFrm" name = "templateFrm"></form>

</section>