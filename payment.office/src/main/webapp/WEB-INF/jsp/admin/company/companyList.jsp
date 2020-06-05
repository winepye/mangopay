<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/companyList_JS.jsp"%>
<!--
  * @Class Name  : companyList.jsp
  * @Description : admin > 고객사정보
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.11.16	     이인희      최초 생성
-->
<section id="detail_contents">

	<form id = "frm" name = "frm" method="post">
		<!-- 검색 영역 -->
        <div class="adm_searchBox" id = "searchArea">
		    <table id="reg_input_grid" class="adm_tb_search" summary="고객사검색 (고객사코드, 고객사명)">
		        <caption>고객사 검색</caption>
                      <colgroup>
                          <col width="150">
                          <col width="*">
                          <col width="150">
                          <col width="*">
                      </colgroup>
		        <tbody>
		            <tr>
		                <th scope="row"><label for="searchCompanyId">고객사정보ID</label></th>
		                <td><input type="text" id="searchCompanyId" name="searchCompanyId"
                                   value="${companyCriteria.searchCompanyId}" class="input_s_b w100pro"
                                   placeholder="고객사정보ID를 입력하세요" onkeypress="if(event.keyCode==13) fn_doSearch(1);"
                                   maxlength="25"/></td>
		                <th scope="row"><label for="searchCompanyName">고객사명</label></th>
		                <td><input type="text" id="searchCompanyName" name="searchCompanyName"
                                   value="${companyCriteria.searchCompanyName}" class="input_s_b w100pro"
                                   placeholder="고객사명을 입력하세요" onkeypress="if(event.keyCode==13) fn_doSearch(1);"
                                   maxlength="25"/></td>
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
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${companyCriteria.totalRecordCount }</font> 건</span>
                </div>

                <ul class="sortBtnSet">
                    <li>
                        <a id = "sort_column_prefix0" href="javascript:fn_doSort(1)"
                            <c:choose>
	                            <c:when test="${companyCriteria.sortOrder eq null or companyCriteria.sortOrder eq '' or companyCriteria.sortOrder eq 'A.COMPANY_INFO_ID DESC' }">class="sort_hightolow"</c:when>
	                            <c:when test="${companyCriteria.sortOrder eq 'A.COMPANY_INFO_ID ASC' }">class="sort_lowtohigh"</c:when>
	                        </c:choose>
                            >고객사등록순</a>
                    </li>
                </ul>
            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="fn_listChange(this.value)">
                    <option value="15" <c:if test="${companyCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${companyCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${companyCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 가맹점 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="./include/companyList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${companyCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${companyCriteria.currentPageNo }">
		<input type="hidden" id = "selectedCompanyInfoId" name = "selectedCompanyInfoId">
		<input type="hidden" id = "companyInfoId" name = "companyInfoId">

        <input type="hidden" id="sortOrder" name="sortOrder">
	</form>
</section>