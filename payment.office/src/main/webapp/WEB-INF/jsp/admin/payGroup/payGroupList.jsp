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
  * @Class Name  : payGroupList.jsp
  * @Description : 간편결제관리 > 결제서비스그룹 관리
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.31        이인희      최초 생성
-->
<section id="detail_contents">

	<form id = "frm" name = "frm" method="post">
		<!-- 검색 영역 -->
        <div class="adm_searchBox" id = "searchArea">
		    <table id="reg_input_grid" class="adm_tb_search">
		        <caption>브랜드 검색</caption>
                      <colgroup>
                          <col width="20%" />
                          <col width="30" />
                          <col width="20%" />
                          <col width="30%" />
                      </colgroup>
		        <tbody>
                    <tr>
		                <th scope="row"><label for="searchPaymentGroup">결제수단 그룹</label></th>
		                <td colspan="3">
                            <select name="searchPaymentGroup" id="searchPaymentGroup" class="sel_basic w100pro">
                                <option value="" selected="selected">선택</option>
                                <c:forEach var="item" items="${result.payGroupList}">
                                    <option value="${item.cd}" <c:if test="${item.cd eq search.searchPaymentGroup}">selected="selected"</c:if> >${item.cdNm}</option>
                                </c:forEach>    
                            </select>
                        </td>
                        <%-- 화면 저장 로직 관련 서비스제공자 필터링 될 경우 삭제 후 저장 구조가 안됨
                        <th scope="row"><label for="searchServiceProvider">서비스제공자</label></th>
		                <td>
                            <select name="searchServiceProvider" id="searchServiceProvider" class="sel_basic w100pro">
                                <option value="" selected="selected">전체</option>
                                <c:forEach var="item" items="${result.srvProvList}">
                                    <option value="${item.cd}" <c:if test="${item.cd eq search.searchServiceProvider}">selected="selected"</c:if>>${item.cdNm}</option>
                                </c:forEach>
                            </select>
                        </td>--%>
                    </tr>
                </tbody>
		    </table>
        </div>

       <div class="bs_BtnBox_r">
           <%--<button type="button" id="btnInit" class="btn_white_B01">초기화</button>--%>
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
	                            <c:when test="${search.sortOrder eq null or search.sortOrder eq '' or search.sortOrder eq 'useYn' }">class="sort_hightolow"</c:when>
	                            <c:when test="${search.sortOrder eq 'paymentMean' }">class="sort_lowtohigh"</c:when>
	                        </c:choose>
                            > 결제수단 순</a>
                    </li>
                </ul>

            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="fn_listChange(this.value)" style="display: none">
                    <option value="15" <c:if test="${search.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${search.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${search.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 가맹점 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="include/payGroupList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${search.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${search.currentPageNo }">

        <input type="hidden" id="sortOrder" name="sortOrder" value="${search.sortOrder }">
        <input type="hidden" id="jsonStr" name="jsonStr">
        <input type="hidden" id="paymentGroup" name="paymentGroup">
	</form>
</section>

<%@ include file="js/payGroupList_JS.jsp"%>