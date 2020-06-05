<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/userList_JS.jsp"%>
<!--
  * @Class Name  : userList.jsp
  * @Description : admin > 회원 목록 조회
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2016.05.14	이인희      최초 생성
-->
<section id="detail_contents">

	<form id = "frm" name = "frm" method="post">
		<!-- 검색 영역 -->
        <div class="adm_searchBox" id = "searchArea">
			    <table id="reg_input_grid" class="adm_tb_search" summary="사용자검색 (사용자ID, 사용자명)">
			        <caption>회원검색</caption>
                       <colgroup>
                           <col width="150">
                           <col width="*">
                           <col width="150">
                           <col width="*">
                       </colgroup>
			        <tbody>
			            <tr>
			                <th scope="row"><label for="searchUserId">사용자 ID</label></th>
			                <td><input type="text" id="searchUserId" name="searchUserId" value="${userCriteria.searchUserId}" class="input_s_b w100pro" placeholder="사용자ID를 입력하세요" onkeypress="if(event.keyCode==13) fn_doSearch(1);" maxlength="25"/></td>
			                <th scope="row"><label for="searchUserName">사용자명</label></th>
			                <td><input type="text" id="searchUserName" name="searchUserName" value="${userCriteria.searchUserName}" class="input_s_b w100pro" placeholder="사용자명을 입력하세요" onkeypress="if(event.keyCode==13) fn_doSearch(1);" maxlength="25"/></td>
                       </tr>
			            <tr>
			                <th scope="row"><label for="searchStoreName">가맹점명</label></th>
			                <td><input type="text" id="searchStoreName" name="searchStoreName" value="${userCriteria.searchStoreName}" class="input_s_b w100pro" placeholder="가맹점명을 입력하세요" onkeypress="if(event.keyCode==13) fn_doSearch(1);" maxlength="25"/></td>
			                <th scope="row"><label for="searchCompanyName">거래처명</label></th>
			                <td><input type="text" id="searchCompanyName" name="searchCompanyName" value="${userCriteria.searchCompanyName}" class="input_s_b w100pro" placeholder="거래청명을 입력하세요" onkeypress="if(event.keyCode==13) fn_doSearch(1);" maxlength="25"/></td>
                       </tr>
			            <tr>
			                <th scope="row"><label for="searchUserTypeCd">사용자구분</label></th>
			                <td>
			                	<customTagUi:code type="select" cdGrp="USER_TYPE_CD" cd="${userCriteria.searchUserTypeCd}" name="searchUserTypeCd" id="searchUserTypeCd" attr='class="sel_basic w100pro"' subjectText="선택"/>
			                </td>
			                <th scope="row"><label for="searchUseYn">사용여부</label></th>
			                <td>
			                	<customTagUi:code type="select" cdGrp="YN_COMMON" cd = "${userCriteria.searchUseYn}" id="searchUseYn" name="searchUseYn"  attr='class="sel_basic w100pro"' subjectText="선택" />
			                </td>
                       </tr>
			        </tbody>
			    </table>
        </div>
       <div class="bs_BtnBox_r">
           <button type="button" id="btnInit" class="btn_white_B01">초기화</button>
           <button type="button" id="btnSearch" class="btn_gray_B01 mgl5">검색</button>
       </div>
		<!-- 검색 영역 -->

        <!-- 20개씩/40개씩/60개씩 보기 -->
        <div class="board_classic">
            <div class="left_block">
                <div class="pageCount">
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${userCriteria.totalRecordCount }</font> 건</span>
                </div>

                <ul class="sortBtnSet">
                    <li>
                        <a id = "sort_column_prefix0" href="javascript:fn_doSort(1)"
                            <c:choose>
	                            <c:when test="${userCriteria.sortOrder eq null or userCriteria.sortOrder eq '' or userCriteria.sortOrder eq 'USER_INFO_ID DESC' }">class="sort_hightolow"</c:when>
	                            <c:when test="${userCriteria.sortOrder eq 'USER_INFO_ID ASC' }">class="sort_lowtohigh"</c:when>
	                        </c:choose>
                            >최근가입순</a>
                    </li>
                    <!-- <li>
                         <a id = "sort_column_prefix2" href="javascript:fn_doSort(1)" class="sort_normal">적중률 순</a>
                    </li> -->
                </ul>
            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="javascript:fn_listChange(this.value)">
                    <option value="15" <c:if test="${userCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${userCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${userCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 회원 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="./include/userList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${userCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${userCriteria.currentPageNo }">
		<input type="hidden" id = "searchUserInfoId" name = "searchUserInfoId">

        <input type="hidden" id="searchIndustCategId" name="searchIndustCategId">
        <input type="hidden" id="searchCategDepth" name="searchCategDepth">
        <input type="hidden" id="searchIndustCategCd" name="searchIndustCategCd">
        <input type="hidden" id="sortOrder" name="sortOrder">
	</form>
</section>

<div id = "sendSmsToUserPop" style="display: none;">

</div>
