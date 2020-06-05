<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/shopList_JS.jsp"%>


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
    Description : 고객사관리 > 매장관 > 목록
-->
<section id="detail_contents">

	<form id = "frm" name = "frm" method="post">
		<!-- 검색 영역 -->
        <div class="adm_searchBox" id = "searchArea">
		    <table id="reg_input_grid" class="adm_tb_search">
		        <caption>매장 검색</caption>
                      <colgroup>
                          <col width="10%" />
                          <col width="23" />
                          <col width="10%" />
                          <col width="23%" />
                          <col width="10%" />
                          <col width="24%" />
                      </colgroup>
		        <tbody>
                    <tr>
                        <th scope="row">검색</th>
                        <td colspan="3">
                            <div style="float: left; width: 30%;">
                                <select name="searchNmType" id="searchNmType" class="sel_basic w100pro">
                                    <option value="" selected="selected">선택하세요.</option>
                                    <option value="company" <c:if test="${'company' eq search.searchNmType}">selected="selected"</c:if> >고객사명</option>
                                    <option value="brand" <c:if test="${'brand' eq search.searchNmType}">selected="selected"</c:if> >브랜드명</option>
                                    <option value="shop" <c:if test="${'shop' eq search.searchNmType}">selected="selected"</c:if> >매장명</option>
                                </select>
                            </div>
                            <div style="float: left; width: 50%; padding-left: 5px">
                                <input type="text" class="input_s_b w100pro" id="searchNm" name="searchNm" value="${search.searchNm}">
                            </div>
                        </td>
                        <th scope="row">사업자번호</th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="searchServiceBizNum" name="searchServiceBizNum" value="${search.searchServiceBizNum}">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">매장관리코드</th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="searchShopMngCode" name="searchShopMngCode" value="${search.searchShopMngCode}">
                        </td>
                        <th scope="row">담당자명</th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="searchChargerName" name="searchChargerName" value="${search.searchChargerName}">
                        </td>
                        <th scope="row">전화번호</th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="searchServiceTelNum" name="searchServiceTelNum" value="${search.searchServiceTelNum}">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">주소</th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="searchAddr" name="searchAddr" value="${search.searchAddr}">
                        </td>
                        <th scope="row">업종</th>
                        <td colspan="3">
                            <div style="float: left; width: 45%;">
                                <select name="searchPbizType" id="searchPbizType" class="sel_basic w100pro" title="업종(상위) 선택"
                                        onchange="fn_changeBizTypeId()">
                                    <option value="" selected="selected">선택하세요.</option>
                                    <c:forEach var="item" items="${result.pBizTypeList}">
                                        <option value="${item.cateCd}" <c:if test="${item.cateCd eq search.searchPbizType}">selected="selected"</c:if> >${item.cateNm}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div style="float: left; width: 45%; padding-left: 10px">
                                <select name="searchBizType" id="searchBizType" class="sel_basic w100pro" title="업종(하위)">
                                    <option value="" selected="selected">선택하세요.</option>
                                    <c:forEach var="item" items="${result.bizTypeList}">
                                        <option value="${item.cateCd}" <c:if test="${item.cateCd eq search.searchBizType}">selected="selected"</c:if> >${item.cateNm}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="searchType">기간</label></th>
                        <td colspan="5">
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
           <button type="button" id="btnClose" class="btn_gray_B01 mgl5">검색영역 접기</button>
       </div>
		<!-- 검색 영역 -->

        <div class="adm_searchBox" id = "modifyArea">
            <table class="adm_tb_search">
                <caption>일괄적용</caption>
                <colgroup>
                    <col width="8%" /><col width="15" />
                    <col width="8%" /><col width="15%" />
                    <col width="8%" /><col width="15%" />
                    <col width="8%" /><col width="15%" />
                    <col width="8%" />
                </colgroup>
                <tbody>

                <tr>
                    <th scope="row">과세형태</th>
                    <td>
                        <select name="taxDiv" id="taxDiv"  class="sel_basic w100pro">
                            <option value="" selected="selected">선택</option>
                            <option value="TAX_ON">과세</option>
                            <option value="TAX_OFF">면세</option>
                            <option value="TAX_PARALLEL">과세 면세 겸업</option>
                        </select>
                    </td>
                    <th scope="row">부가세율(%)</th>
                    <td>
                        <input type="text" class="input_s_b w100pro alignR" value="0" id="taxRate" name="taxRate" onkeyup="chkword(this, 3)" numberOnly />
                    </td>
                    <th scope="row">봉사료여부</th>
                    <td>
                        <select name="svcAmtYn" id="svcAmtYn"  class="sel_basic w100pro">
                            <option value="" selected="selected">선택</option>
                            <option value="Y">예</option>
                            <option value="N">아니오</option>
                        </select>
                    </td>
                    <th scope="row">봉사료율(%)</th>
                    <td>
                        <input type="text" class="input_s_b w100pro alignR" value="0" id="svcChargeRate" name="svcChargeRate" onkeyup="chkword(this, 3)" numberOnly />
                    </td>

                    <td>
                        <button type="button" id="saveBt" class="btn_gray_B01 mgl5">일괄적용</button>
                   </td>
                </tr>

                <style>
                    .alignR {
                        text-align: right;
                    }
                </style>


                </tbody>
            </table>
        </div>

        <!-- 20개씩/40개씩/60개씩 보기 -->
        <div class="board_classic" style="padding-top: 15px">
            <div class="left_block">
                <div class="pageCount">
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${search.totalRecordCount }</font> 건</span>
                </div>

                <ul class="sortBtnSet">
                    <li>
                        <a id = "sort_column_prefix0" href="javascript:fn_doSort(1)"
                            <c:choose>
	                            <c:when test="${search.sortOrder eq null or search.sortOrder eq '' or search.sortOrder eq 'A.SHOP_INFO_ID DESC' }">class="sort_hightolow"</c:when>
	                            <c:when test="${search.sortOrder eq 'A.SHOP_INFO_ID ASC' }">class="sort_lowtohigh"</c:when>
	                        </c:choose>
                            >매장등록순</a>
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
	        <jsp:include page="include/shopList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${search.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${search.currentPageNo }">


        <input type="hidden" id="sortOrder" name="sortOrder">
        <input type="hidden" id="shopInfoId" name="shopInfoId">

	</form>

    <form id = "saveFrm" name = "saveFrm" method="post">
        <%--일괄적용을 위한 폼--%>
        <input type="hidden" id="jsonStr" name="jsonStr" />

    </form>


</section>

