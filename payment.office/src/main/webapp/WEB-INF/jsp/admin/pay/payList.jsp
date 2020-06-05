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
  * @Class Name  : payList.jsp
  * @Description : 간편결제관리 > 결제서비스관리
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.18        이인희      최초 생성
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
		                <th scope="row"><label for="searchServiceProvider">서비스제공자명</label></th>
		                <td>
                            <select name="searchServiceProvider" id="searchServiceProvider" class="sel_basic w100pro">
                                <option value="" selected="selected">전체</option>
                                <c:forEach var="item" items="${result.serProvList}">
                                    <option value="${item.cd}" <c:if test="${item.cd eq search.searchServiceProvider}">selected="selected"</c:if> >${item.cdNm}</option>
                                </c:forEach>    
                            </select>
                        </td>
                        <th scope="row"><label for="searchPaymentMean">결제수단</label></th>
		                <td>
                            <select name="searchPaymentMean" id="searchPaymentMean" class="sel_basic w100pro">
                                <option value="" selected="selected">전체</option>
                                <c:forEach var="item" items="${result.payMeanList}">
                                    <option value="${item.cd}" <c:if test="${item.cd eq search.searchPaymentMean}">selected="selected"</c:if>>${item.cdNm}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
		            <tr>
                        <th scope="row">결제방식</th>
                        <td>
                            <input type="text" class="input_s_b w100pro" name="searchPaymentMethod" id="searchPaymentMethod" value="${search.searchPaymentMethod}">
                        </td>
                        <th scope="row"><label for="cS1">계약상태</label></th>
                        <td>
                            <span class=radio_list>
                                <label for="cS1">
                                    <input type="radio" id="cS1" name="contract" value="" <c:if test="${search.searchState eq null or search.searchState eq ''}">checked</c:if> > 전체
                                </label>
                            </span>
                            <span class=radio_list>
                                <label for="cs2">
                                    <input type="radio" id="cs2" name="contract" value="Y" <c:if test="${search.searchState eq 'Y'}">checked</c:if> > 계약
                                </label>
                            </span>
                            <span class=radio_list>
                                <label for="cs3">
                                    <input type="radio" id="cs3" name="contract" value="N" <c:if test="${search.searchState eq 'N'}">checked</c:if> > 해지
                                </label>
                            </span>

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
	                            <c:when test="${search.sortOrder eq null or search.sortOrder eq '' or search.sortOrder eq 'A.PAYMENT_SERVICE_ID DESC' }">class="sort_hightolow"</c:when>
	                            <c:when test="${search.sortOrder eq 'A.PAYMENT_SERVICE_ID ASC' }">class="sort_lowtohigh"</c:when>
	                        </c:choose>
                            >결제서비스등록순</a>
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
	        <jsp:include page="include/payList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${search.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${search.currentPageNo }">

        <input type="hidden" id="searchServiceProviderNm" name="searchServiceProviderNm" value="${search.searchServiceProviderNm }">
        <input type="hidden" id="searchPaymentMeanNm" name="searchPaymentMeanNm" value="${search.searchPaymentMeanNm }">
        <input type="hidden" id="searchState" name="searchState" value="${search.searchState }">

        <input type="hidden" id="paymentServiceId" name="paymentServiceId">


        <input type="hidden" id="sortOrder" name="sortOrder">
	</form>
</section>

<%@ include file="js/payList_JS.jsp"%>