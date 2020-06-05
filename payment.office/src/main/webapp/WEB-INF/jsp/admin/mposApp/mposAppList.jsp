<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>


<style>
    .btn_white_BSM {
        min-width:65px;
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
  * @Class Name  : mposAppList.jsp
  * @Description : APP 버전관리 > MPOS 버전관리
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.28        이인희      최초 생성
-->
<section id="detail_contents">

	<form id = "frm" name = "frm" method="post">
		<!-- 검색 영역 -->
        <div class="adm_searchBox" id = "searchArea">
		    <table id="reg_input_grid" class="adm_tb_search">
		        <caption>MPOS 버전 검색</caption>
                      <colgroup>
                          <col width="20%" />
                          <col width="30" />
                          <col width="20%" />
                          <col width="30%" />
                      </colgroup>
		        <tbody>
                    <tr>
		                <th scope="row"><label for="searchAppName">APP명</label></th>
		                <td colspan="3">
                            <input type="text" class="input_s_b w100pro" name="searchAppName" id="searchAppName"
                                   value="${search.searchAppName}" placeholder="APP명을 입력하세요."
                                   onkeypress="if(event.keyCode==13) fn_doSearch(1);">
                        </td>
                    </tr>
		            <tr>
                        <th scope="row"><label for="searchType">기간</label></th>
                        <td colspan="3">
                            <select name="searchType" id="searchType" class="sel_basic">
                                <option value="create" <c:if test="${ search.searchType eq 'create'}">selected="selected"</c:if>> 등록일</option>
                                <option value="udate" <c:if test="${ search.searchType eq 'udate'}">selected="selected"</c:if>>수정일</option>
                            </select>

                            <input id="searchSdate" name="searchSdate" class="input_s_b w_date" value=""/> <%--<fmt:formatDate value="${search.searchState}" pattern="yyyy/MM/dd"/>--%>
                            <lable> ~ </lable>
                            <input id="searchEdate" name="searchEdate" value="" onchange="fn_checkFromDate(this)" class="input_s_b w_date"/>
                            <input type="hidden" id="tempSdate" value="${search.searchSdate}">
                            <input type="hidden" id="tempEdate" value="${search.searchEdate}">

                            <button type="button" class="btn_white_BSM" onclick="fn_setDate(0,'day')">오늘</button>
                            <button type="button" class="btn_white_BSM" onclick="fn_setDate(2,'day')">3일간</button>
                            <button type="button" class="btn_white_BSM" onclick="fn_setDate(6,'day')">일주일</button>
                            <button type="button" class="btn_white_BSM" onclick="fn_setDate(1,'month')">1개월</button>
                            <button type="button" class="btn_white_BSM" onclick="fn_setDate(3,'month')">3개월</button>
                            <button type="button" class="btn_white_BSM" onclick="fn_setDate(6,'month')">6개월</button>

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
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${search.totalRecordCount }</font> 건</span>
                </div>

                <ul class="sortBtnSet">
                    <li>
                        <a id = "sort_column_prefix0" href="javascript:fn_doSort(1)"
                            <c:choose>
	                            <c:when test="${search.sortOrder eq null or search.sortOrder eq '' or search.sortOrder eq 'A.APP_VERSION_ID DESC' }">class="sort_hightolow"</c:when>
	                            <c:when test="${search.sortOrder eq 'A.APP_VERSION_ID ASC' }">class="sort_lowtohigh"</c:when>
	                        </c:choose>
                            >app등록순</a>
                    </li>
                </ul>
            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="fn_listChange(this.value)">
                    <option value="15" <c:if test="${search.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${search.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${search.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 가맹점 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="include/mposAppList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${search.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${search.currentPageNo }">


        <input type="hidden" id="appVersionId" name="appVersionId">


        <input type="hidden" id="sortOrder" name="sortOrder">
	</form>
</section>

<%@ include file="js/mposAppList_JS.jsp"%>