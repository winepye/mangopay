<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/payDetail_JS.jsp"%>
<!--
  * @Class Name  : payDetail.jsp
  * @Description : 결제서비스 상세
  * @Modification Information
  * @
  * @ 수정일             수정자      수정내용
  * @ 2018.12.17   	   이인희      최초 생성
-->
<section id="detail_contents">

    <form id="frm" name="frm" method="post">
        <!-- 탭별 페이징 구분을 위한 히든값 -->
        <input type="hidden" id="currentPageNo" name = "currentPageNo" value="1">

        <h3 class="h2_table_title">결제서비스 정보</h3>
        <table id="templateProject" class="tb_left_st2" summary="결제서비스정보">
            <caption>결제서비스정보</caption>
            <colgroup>
                <col width="20%" />
                <col width="30%" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">서비스제공자</th>
                    <td><c:out value="${result.serviceProviderNm}" /></td>
                    <th scope="row">결제수단</th>
                    <td><c:out value="${result.paymentMeanNm}" /></td>
                </tr>

                <tr>
                    <th scope="row">결제방식</th>
                    <td><c:out value="${result.paymentMethod}" /></td>
                    <th scope="row">담당자</th>
                    <td></td>

                </tr>

                <tr>
                    <th scope="row">서비스설명</th>
                    <td colspan="3">
                        <c:out value="${result.serviceDesc}" />
                    </td>
                </tr>

                <tr>
                    <th scope="row">계약상태</th>
                    <td colspan="3">
                        <c:if test="${ result.useYn eq 'Y'}" > 계약 </c:if>
                        <c:if test="${ result.useYn eq 'N'}" > 해지 </c:if>

                    </td>
                </tr>


            </tbody>
        </table>
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
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${search.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

    </form>

    <div class="bs_BtnBox_c">
	    <button type="button" id="btnGoPayListPage" class="btn_white_B01">목록</button>
	    <button type="button" id="btnGoPayModifyPage" class="btn_gray_B01">수정</button>
	</div>
</section>

