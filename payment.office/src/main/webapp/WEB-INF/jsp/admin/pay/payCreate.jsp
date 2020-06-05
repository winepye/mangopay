<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<!--
* @Class Name  : payCreate.jsp
* @Description : 결제서비스 등록화면
* @Modification Information
* @
* @ 수정일        		수정자      수정내용
* @ 2018.11.21	    이인희      최초 생성
-->
<section id="detail_contents">
    <form id = "frm" name = "frm" method="post">
        <h3 class="h2_table_title">결제서비스 등록</h3>
        <table id="templateProject" class="tb_left_st2" summary="결제서비스 등록">

            <caption>
                결제서비스 등록
            </caption>
            <colgroup>
                <col width="20%" />
                <col width="30" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <tbody>

            <tr>
                <th scope="row"><label for="serviceProvider"><span class="redstar">*</span>서비스제공자</label></th>
                <td>
                    <select name="serviceProvider" id="serviceProvider" class="sel_basic w100pro">
                        <option value="" selected="selected">전체</option>
                        <c:forEach var="item" items="${serProvList}">
                            <option value="${item.cd}">${item.cdNm}</option>
                        </c:forEach>
                    </select>
                </td>
                <th scope="row"><label for="paymentMean"><span class="redstar">*</span>결제수단</label></th>
                <td>
                    <select name="paymentMean" id="paymentMean" class="sel_basic w100pro">
                        <option value="" selected="selected">전체</option>
                        <c:forEach var="item" items="${payMeanList}">
                            <option value="${item.cd}">${item.cdNm}</option>
                        </c:forEach>
                    </select>
                </td>

            </tr>

            <tr>
                <th scope="row"><label for="paymentMethod"><span class="redstar">*</span>결제방식</label></th>
                <td>
                    <select name="paymentMethod" id="paymentMethod" class="sel_basic w100pro">
                        <option value="" selected="selected">전체</option>
                        <c:forEach var="item" items="${payMethodList}">
                            <option value="${item.cd}">${item.cdNm}</option>
                        </c:forEach>
                    </select>
                </td>
                <th scope="row">담당자</th>
                <td>
                    <%--// FIXME: 2018-12-20 담당자 컬럼 없음--%>
                    <input type="text" class="input_s_b w100pro" id="manager" name="manager" value="" onkeyup="chkword(this, 10)">
                </td>
            </tr>

            <tr>
                <th scope="row">서비스설명</th>
                <td colspan="3">
                    <input type="text" class="input_s_b w100pro" id="serviceDesc" name="serviceDesc" value="${result.serviceDesc}" >
                </td>
            </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <button type="button" id="btnGoPayListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnCreatePay" class="btn_gray_B01">저장</button>
        </div>
        <!-- 버튼 -->



        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchServiceProviderNm" value='<c:out value="${search.searchServiceProviderNm }" />'>
        <input type="hidden" name="searchPaymentMeanNm" value='<c:out value="${search.searchPaymentMeanNm }" />'>
        <input type="hidden" name="searchState" value='<c:out value="${search.searchState }" />'>
        <input type="hidden" name="searchType" value='<c:out value="${search.searchType }" />'>
        <input type="hidden" name="searchSdate" value='<c:out value="${search.searchSdate }" />'>
        <input type="hidden" name="searchEdate" value='<c:out value="${search.searchEdate }" />'>
        <input type="hidden" name="searchServiceProvider" value='<c:out value="${search.searchServiceProvider }" />'>
        <input type="hidden" name="searchPaymentMean" value='<c:out value="${search.searchPaymentMean }" />'>
        <input type="hidden" name="paymentServiceId" value='<c:out value="${search.paymentServiceId }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${search.currentPageNo }" />'>
        <input type="hidden" name="sortOrder" value='<c:out value="${search.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

    </form>

    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchServiceProviderNm" value='<c:out value="${search.searchServiceProviderNm }" />'>
        <input type="hidden" name="searchPaymentMeanNm" value='<c:out value="${search.searchPaymentMeanNm }" />'>
        <input type="hidden" name="searchState" value='<c:out value="${search.searchState }" />'>
        <input type="hidden" name="searchType" value='<c:out value="${search.searchType }" />'>
        <input type="hidden" name="searchSdate" value='<c:out value="${search.searchSdate }" />'>
        <input type="hidden" name="searchEdate" value='<c:out value="${search.searchEdate }" />'>
        <input type="hidden" name="searchServiceProvider" value='<c:out value="${search.searchServiceProvider }" />'>
        <input type="hidden" name="searchPaymentMean" value='<c:out value="${search.searchPaymentMean }" />'>
        <input type="hidden" name="paymentServiceId" value='<c:out value="${search.paymentServiceId }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${search.currentPageNo }" />'>
        <input type="hidden" name="sortOrder" value='<c:out value="${search.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
    </form>

</section>

<%@ include file="js/payCreate_JS.jsp"%>