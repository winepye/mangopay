<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/adminPaymentList_JS.jsp"%>
<!--
  * @Class Name  : generalReportList.jsp
  * @Description : admin > 리포트 일반 조회
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.09	이인희      최초 생성
-->
<form id = "frm" name = "frm" method="post">
<input type="hidden" id="txId" name="txId"/>
<input type="hidden" id="deleteBoardSeq" name="deleteBoardSeq" value="32"/>

<section id="detail_contents">
    <!-- 검색 영역 -->
    <div id="codeGroupDetailArea" class="adm_searchBox">
		<table id="reg_input_grid" class="adm_tb_search" summary="일반리포트검색 (일자, 회원명, 회원ID, 제목)">
			<caption>일반리포트검색</caption>
            <colgroup>
                <col width="100" />
                <col width="20%" />
                <col width="100" />
                <col width="*" />
                <col width="100" />
                <col width="20%" />
            </colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="searchFromDt">일자</label></th>
					<td colspan="5" class="vtwrap">
	                    <select id="searchDateType" name = "searchDateType" class="sel_basic" title="일자">
	                        <option value="createDate" <c:if test="${serviceCriteria.searchDateType eq 'createDate'}">selected="selected"</c:if>>요청일자</option>
	                        <option value="approvalDatetime" <c:if test="${serviceCriteria.searchDateType eq 'approvalDatetime'}">selected="selected"</c:if>>승인일자</option>
	                    </select>
						<input type="text"  class="input_s_b w_date mgl5 " id = "searchFromDt" name = "searchFromDt" value="<fmt:formatDate value="${serviceCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>" readonly="readonly" />
						<span class="mgl3">~</span>
						<input type="text"  class="input_s_b w_date  mgl3" id = "searchToDt" name="searchToDt" value="<fmt:formatDate value="${serviceCriteria.searchToDt}" pattern="yyyy/MM/dd"/>" readonly="readonly" />
						&nbsp;&nbsp;
						<span id="searchDateBtArea" class="btn_monthset mgl10">
                            <button type="button" id="searchDate_1" onclick="javascript:fn_setDate(1)" class="left_r">1개월</button>
                            <button type="button" id="searchDate_3" onclick="javascript:fn_setDate(3)" class="">3개월</button>
                            <button type="button" id="searchDate_6" onclick="javascript:fn_setDate(6)" class="right_r">6개월</button>
                        </span>
					</td>
		        </tr>
		        <tr>
					<th scope="row"><label for=searchStoreName>가맹점명</label></th>
                    <td>
                        <input id="searchStoreName" name = "searchStoreName" type="text" placeholder="가맹점명을 입력하세요" class="input_s_b w100pro" title="회원명" 가맹점명="${serviceCriteria.searchStoreName }" maxlength="25"/>
                    </td>
					<th scope="row"><label for="searchCatId">CAT ID</label></th>
                    <td>
                        <input id="searchCatId" name = "searchCatId" type="text" placeholder="CAT ID를 입력하세요" class="input_s_b w100pro" title="트렌젝션 ID" value="${serviceCriteria.searchCatId }" maxlength="100"/>
                    </td>
					<th scope="row"><label for="searchProcessStatus">진행상태</label></th>
                    <td>
                        <select id="searchProcessStatus" name="searchProcessStatus"  class="sel_basic selshowst" title="진행상태" >  <!-- onchange="javascript:fn_listChange(this.value)" -->
		                    <option value="">전체</option>
		                    <option value="STORE_REQUEST">가맹점요청</option>
		                    <option value="AUTH_REQUEST">인증요청</option>
		                    <option value="AUTH_COMPLETE">인증완료</option>
		                    <option value="APPROVE_REQUEST">승인요청</option>
		                    <option value="APPROVE_FAIL">승인실패</option>
		                    <option value="APPROVE_COMPLETE">승인완료</option>
		                    <option value="CANCEL_REQUEST">취소요청</option>
		                    <option value="CANCEL_COMPLETE">취소완료</option>
		                </select>
                    </td>
				</tr>
			</tbody>
		</table>
    </div>
    <div class="bs_BtnBox_r">
         <button type="button" id="btnInit" class="btn_white_B01">초기화</button>
         <button type="button" id="btnSearch" class="btn_gray_B01">검색</button>
     </div>
     <!-- 검색 영역 -->

		<!-- 탭 -->
		<div class="gtabZone count_n11">
			<ul id = "tabUl">
				<li id = "tabLi_"  class="on">
					<a href="javascript:void(0);">전체</a>
                </li>
			</ul>
		</div>
		<!--//탭//-->

		<!-- 게시판 정렬목록 -->
		<div class="board_classic">
            <div class="left_block">
                <div class="pageCount">
                    <strong>전체</strong><span id="listTotalCnt">${serviceCriteria.totalRecordCount } 건</span>
                </div>
                <ul class="sortBtnSet">

                    <li>
                        <a id = "sort_column_prefix0" href="javascript:fn_doSort(0)"  class="sort_hightolow"
                            <c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_lowtohigh' }"> class="sort_lowtohigh"</c:if>
                            <c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_hightolow' }"> class="sort_hightolow"</c:if>
                            <c:if test = "${serviceCriteria.sortList ne '0' }"> class="sort_normal"</c:if>
                        >요청일시순
                            <c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_lowtohigh' }"><em>오름차순</em></c:if>
                            <c:if test = "${serviceCriteria.sortList eq '0' && serviceCriteria.sortKind eq 'sort_hightolow' }"><em>내림차순</em></c:if>
                            <c:if test = "${serviceCriteria.sortList ne '0' }"><em>정렬</em></c:if>
                        </a>
                    </li>
                </ul>
            </div>
			<div class="rightblock">
                <span class="sortCheckSet">
                    <label><input type="checkbox" id="searchApproveYn" name="searchApproveYn" value="YES" <c:if test="${serviceCriteria.searchApproveYn eq 'YES'}">checked="checked"</c:if> /><span>승인완료</span></label>
                    <label><input type="checkbox" id="searchCancelYn"   name="searchCancelYn"   value="YES" <c:if test="${serviceCriteria.searchCancelYn eq 'YES'}">checked="checked"</c:if> /><span>취소완료</span></label>
                </span>
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="javascript:fn_listChange($(this).val())">
                    <option value="15" <c:if test="${serviceCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${serviceCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${serviceCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
			</div>
		</div>
		<!--/ 게시판 정렬목록 /-->

        <div id = "listArea">
	        <jsp:include page="./include/adminPaymentList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${serviceCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${serviceCriteria.currentPageNo }">
		<input type="hidden" id = "sortList" name = "sortList" value="${serviceCriteria.sortList }">
		<input type="hidden" id = "sortKind" name = "sortKind" value="${serviceCriteria.sortKind }">

</section>
</form>