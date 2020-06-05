<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/mposSrvList_JS.jsp"%>
<!--
  * @Description : admin > 매출관리 > mPOS 승인내역
-->
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

    <section id="detail_contents">
        <form id = "frm" name = "frm" method="post">
            <!-- 검색 영역 -->
            <div class="adm_searchBox" id = "searchArea">
                <table class="adm_tb_search">
                    <caption>mpos승인내역</caption>
                    <colgroup>
                        <col width="10%" />
                        <col width="23%" />
                        <col width="10%" />
                        <col width="23%" />
                        <col width="10%" />
                        <col width="24%" />
                    </colgroup>
                    <tbody>

                        <tr>
                            <th scope="row">고객사명</th>
                            <td>
                                <input type="text" class="input_s_b w100pro"
                                       id="searchCompanyName" name="searchCompanyName" value="${criteria.searchCompanyName}">
                            </td>
                            <th scope="row">브랜드명</th>
                            <td>
                                <input type="text" class="input_s_b w100pro"
                                       id="searchBrandName" name="searchBrandName" value="${criteria.searchBrandName}">
                            </td>
                            <th scope="row">매장명</th>
                            <td>
                                <input type="text" class="input_s_b w100pro"
                                       id="searchShopName" name="searchShopName" value="${criteria.searchShopName}">
                            </td>
                        </tr>

                        <tr>
                            <th scope="row">사업자번호</th>
                            <td>
                                <input type="text" class="input_s_b w100pro"
                                       id="searchBizNum" name="searchBizNum" value="${criteria.searchBizNum}">
                            </td>
                            <th scope="row">CAT-ID</th>
                            <td>
                                <input type="text" class="input_s_b w100pro"
                                       id="searchCatId" name="searchCatId" value="${criteria.searchCatId}">
                            </td>
                            <th scope="row"></th>
                            <td></td>
                        </tr>

                        <tr>
                            <th scope="row">결제수단</th>
                            <td colspan="5">
                                <c:forEach var="data" items="${paymentMethodList}" varStatus="i">
                                    <input type="checkbox" name="searchPaymentMethod" id="${data.cd}" value="${data.cd}">
                                    <label class="custom-control-label" for="${data.cd}">${data.cdNm}</label>
                                    &nbsp;
                                    <c:if test="${i.index ne 0 and (i.index%10) == 0 }"><br></c:if>
                                </c:forEach>
                            </td>
                        </tr>

                        <tr>
                            <th scope="row">서비스제공자</th>
                            <td colspan="5">
                                <c:forEach var="data" items="${serviceProviderList}" varStatus="i">
                                    <input type="checkbox" name="searchSrvProvider" id="${data.cd}" value="${data.cd}">
                                    <label class="custom-control-label" for="${data.cd}">${data.cdNm}</label>
                                    &nbsp;<c:if test="${i.index ne 0 and (i.index%10) == 0 }"><br></c:if>
                                </c:forEach>
                            </td>
                        </tr>

                        <tr>
                            <th scope="row"><label for="searchType">기간</label></th>
                            <td colspan="5">
                                <select name="searchType" id="searchType" class="sel_basic">
                                    <option value="reqDate" <c:if test="${ criteria.searchType eq 'reqDate'}">selected="selected"</c:if>> 요청일자</option>
                                    <option value="apprDate" <c:if test="${ criteria.searchType eq 'apprDate'}">selected="selected"</c:if>> 승인일자</option>
                                </select>

                                <input id="searchSdate" name="searchSdate" class="input_s_b w_date" value=""/> <%--<fmt:formatDate value="${search.searchState}" pattern="yyyy/MM/dd"/>--%>
                                <lable> ~ </lable>
                                <input id="searchEdate" name="searchEdate" value="" onchange="fn_checkFromDate(this)" class="input_s_b w_date"/>
                                <input type="hidden" id="tempSdate" value="${criteria.searchSdate}">
                                <input type="hidden" id="tempEdate" value="${criteria.searchEdate}">
                                &nbsp;
                                &nbsp;

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
                 <button type="button" id="btnSearch" class="btn_gray_B01">검색</button>
                <button type="button" id="btnClose" class="btn_gray_B01 mgl5">검색영역 접기</button>
             </div>
             <!-- 검색 영역 -->

            <!-- 게시판 정렬목록 -->
            <div class="board_classic">
                <div class="left_block">
                    <div class="pageCount">
                        <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${criteria.totalRecordCount }</font> 건</span>
                    </div>

                    <ul class="sortBtnSet">
                        <li>
                            <a id = "sort_column_prefix0" href="javascript:fn_doSort(1)"
                                    <c:choose>
                                        <c:when test="${criteria.sortOrder eq null or criteria.sortOrder eq '' or criteria.sortOrder eq 'A.PAYMENT_HIST_ID DESC' }">class="sort_hightolow"</c:when>
                                        <c:when test="${criteria.sortOrder eq 'A.PAYMENT_HIST_ID ASC' }">class="sort_lowtohigh"</c:when>
                                    </c:choose>
                            >결제이 순</a>
                        </li>
                    </ul>
                </div>
                <div class="rightblock">
                    <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="javascript:fn_listChange($(this).val())">
                        <option value="15" <c:if test="${criteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                        <option value="30" <c:if test="${criteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                        <option value="45" <c:if test="${criteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                    </select>
                </div>
            </div>
            <!--/ 게시판 정렬목록 /-->

            <div id = "listArea">
                <jsp:include page="./include/mposSrvList_INC.jsp"></jsp:include>
            </div>

            <!-- 검색이나 화면이동을 위한 데이터 -->
            <input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${criteria.recordCountPerPage }">
            <input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${criteria.currentPageNo }">

            <input type="hidden" id="sortOrder" name="sortOrder">
        </form>

    </section>
