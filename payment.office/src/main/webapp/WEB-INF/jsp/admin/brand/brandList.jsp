<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/brandList_JS.jsp"%>

<style>
    .btn_white_BSM {
        min-width:70px;
        /*background:url(../images/common/bg_btn_graytop.gif) repeat-x;*/
        border:#bdc3d1 solid 1px;
        border-radius:2px;
        padding:7px 10px 9px 10px;
        font-weight:normal;
        font-size:12px;
        letter-spacing:-0.05em;
        vertical-align:middle;
        display:inline-block;
        text-align:center;
        line-height:1;
        box-sizing:border-box;
        height:26px;
    }
</style>

<!--
  * @Class Name  : brandList.jsp
  * @Description : 고객사관리 > 브랜드관
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.13        이인희      최초 생성
-->
<section id="detail_contents">

	<form id = "frm" name = "frm" method="post">
		<!-- 검색 영역 -->
        <div class="adm_searchBox" id = "searchArea">
		    <table id="reg_input_grid" class="adm_tb_search">
		        <caption>브랜드 검색</caption>
                      <colgroup>
                          <col width="150">
                          <col width="*">
                          <col width="150">
                          <col width="*">
                      </colgroup>
		        <tbody>
                    <tr>
		                <th scope="row"><label for="searchName">검색</label></th>
		                <td colspan="3">
                            <select name="searchName" id="searchName" class="sel_basic w10pro">
                                <option value="company">고객사명</option>
                                <option value="brand">브랜드명</option>
                            </select>
                            <input type="text" class="input_s_b w70pro" name="searchInputName" id="searchInputName"
                                   placeholder="검색명을 입력하세요.">
                            <%--<input type="text" id="searchCompanyId" name="searchCompanyId"
                            value="${brandCriteria.searchBrandName}" class="input_s_b w100pro"
                            placeholder="고객사정보ID를 입력하세요" onkeypress="if(event.keyCode==13)
                            fn_doSearch(1);" maxlength="25"/>--%>

                            <input type="hidden" id="searchBrandName" name="searchBrandName">
                            <input type="hidden" id="searchCompanyName" name="searchCompanyName">
                        </td>
                    </tr>
		            <tr>
                        <%--FIXME: 2019-01-07 업종 수정 해야함--%>
		                <th scope="row"><label for="depth1">업종</label></th>
		                <td colspan="3">
                            <select name="depth1" id="depth1" class="sel_basic w40pro">
                                <option value="">선택</option>
                            </select>
                            <select name="depth2" id="depth2" class="sel_basic w40pro">
                                <option value="">선택</option>
                            </select>
                            <input type="hidden" id="searchBizType" name="searchBizType">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="currentState">서비스상태</label></th>
                        <td>
                            <span class=radio_list>
                            <label for="currentState"><input type="radio" id="currentState" name="businessType"
                                                       value="corporate" checked> 전체</label>
                            </span>
                            <span class=radio_list>
                                <label for="cs2"><input type="radio" id="cs2" name="businessType"
                                                          value="personal"> 정상</label>
                            </span>
                            <span class=radio_list>
                                <label for="cs3"><input type="radio" id="cs3" name="businessType"
                                                          value="personal"> 해지</label>
                            </span>
                            <input type="hidden" id="searchState" name="searchState">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="period">기간</label></th>
                        <td>
                            <select name="period" id="period" class="sel_basic">
                                <option value="regdate">등록일</option>
                                <option value="udate">수정일</option>
                            </select>
                            <input id="equipDateS" name="equipDateS" class="input_s_b w_date" maxlength="10"/>
                            <lable> ~ </lable>
                            <input id="equipDateE" name="equipDateE" class="input_s_b w_date" maxlength="10"/>
                            <button type="button" class="btn_white_BSM">오늘</button>
                            <button type="button" class="btn_white_BSM">3일간</button>
                            <button type="button" class="btn_white_BSM">일주일</button>
                            <button type="button" class="btn_white_BSM">1개월</button>
                            <button type="button" class="btn_white_BSM">3개월</button>
                            <button type="button" class="btn_white_BSM">전체</button>

                            <input type="hidden" id="searchType" name="searchType">
                            <input type="hidden" id="searchSdate" name="searchSdate">
                            <input type="hidden" id="searchEdate" name="searchEdate">

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
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${brandCriteria.totalRecordCount }</font> 건</span>
                </div>

                <ul class="sortBtnSet">
                    <li>
                        <a id = "sort_column_prefix0" href="javascript:fn_doSort(1)"
                            <c:choose>
	                            <c:when test="${brandCriteria.sortOrder eq null or brandCriteria.sortOrder eq '' or brandCriteria.sortOrder eq 'A.BRAND_INFO_ID DESC' }">class="sort_hightolow"</c:when>
	                            <c:when test="${brandCriteria.sortOrder eq 'A.BRAND_INFO_ID ASC' }">class="sort_lowtohigh"</c:when>
	                        </c:choose>
                            >고객사등록순</a>
                    </li>
                </ul>
            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="fn_listChange(this.value)">
                    <option value="15" <c:if test="${brandCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${brandCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${brandCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 가맹점 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="./include/brandList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${brandCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${brandCriteria.currentPageNo }">
		<input type="hidden" id = "selectedBrandInfoId" name = "selectedBrandInfoId">
		<input type="hidden" id = "brandInfoId" name = "brandInfoId">
		<input type="hidden" id = "companyInfoId" name = "companyInfoId">

        <input type="hidden" id="sortOrder" name="sortOrder">
	</form>
</section>