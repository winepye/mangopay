<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/mposSrvDetailPop_JS.jsp"%>
<div id="pop_wrap">
    <%--<div class="pop_titleZone">
        <h1 class="title"><span class="code">MPOS 승인이력상세</span></h1>
        <a href="javascript:fn_closeWindow();" class="btn_popclose"><em>닫힘</em></a>
    </div>--%>
    <!--팝업컨텐츠-->
    <div class="pop_container">
        <h2><strong>기본정보</strong></h2>
        <table class="tb_left_st2" summary="MPOS 승인이력상세">
            <caption>
             MPOS 승인이력상세
            </caption>
            <colgroup>
                <col width="200px" />
                <col width="*" />
                <col width="200px" />
                <col width="*" />
            </colgroup>
            <tr>
                <th scope="row">고객사명</th>
                <td><c:out value='${payDetailList[0].companyName }' /></td>
                <th scope="row">브랜드명</th>
                <td><c:out value='${payDetailList[0].brandName }' /></td>
            </tr>
            <tr>
                <th scope="row">매장명</th>
                <td><c:out value='${payDetailList[0].shopName }' /></td>
                <th scope="row">매장맵핑코드</th>
                <td><c:out value='${payDetailList[0].shopMappCode }' /></td>
            </tr>
            <tr>
                <th scope="row">사업자번호</th>
                <td><c:out value='${payDetailList[0].bizNo }' /></td>
                <th scope="row">매장단말번호</th>
                <td><c:out value='${payDetailList[0].shopTerminalNum }' /></td>
            </tr>
            <tr>
                <th scope="row">전체결제금액</th>
                <td><c:out value='${payDetailList[0].paymentTotalAmt }' /></td>
                <th scope="row">mPOS주문번호</th>
                <td><c:out value='${payDetailList[0].mposOrderNum }' /></td>
            </tr>

        </table>

        <div style="padding-top: 20px"></div>


        <h2><strong>결제내역</strong></h2>
        <c:forEach var = "data" items="${payDetailList}" varStatus="i">
            <table class="tb_left_st2" summary="MPOS 승인이력상세">
                <caption>
                    MPOS 승인이력상세
                </caption>
                <colgroup>
                    <col width="13%" />
                    <col width="20%" />
                    <col width="13%" />
                    <col width="20%" />
                    <col width="13%" />
                    <col width="20%" />
                </colgroup>
                <tr>
                    <th scope="row">서비스제공자</th>
                    <td><c:out value='${data.serviceProviderName }' /></td>
                    <th scope="row">결제수단</th>
                    <td><c:out value='${data.paymentMeanName }' /></td>
                    <th scope="row">결제방식</th>
                    <td><c:out value='${data.paymentMethodName }' /></td>
                </tr>
                <tr>
                    <th scope="row">CAT-ID</th>
                    <td><c:out value='${data.catId }' /></td>
                    <th scope="row">승인번호</th>
                    <td><c:out value='${data.approvalNumber }' /></td>
                    <th scope="row">승인일시</th>
                    <td><fmt:formatDate value='${data.approvalDate }' pattern="yyyy.MM.dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th scope="row">승인금액</th>
                    <td><fmt:formatNumber value="${data.approvalAmount }" pattern="#,###"/>원 </td>
                    <th scope="row">봉사료</th>
                    <td><fmt:formatNumber value='${data.serviceCharge }' pattern="#,###" />원</td>
                    <th scope="row">세금</th>
                    <td><fmt:formatNumber value='${data.taxCharge }' pattern="#,###"/>원</td>
                </tr>
                <tr>
                    <th scope="row">발급사명</th>
                    <td><c:out value='${data.issuerName }' /></td>
                    <th scope="row">매입사명</th>
                    <td colspan="3"><c:out value='${data.accepterName }' /></td>
                </tr>
                <tr>
                    <th scope="row">취소여부</th>
                    <td><c:out value='${data.approvalCancelYn eq "Y" ? "예":"아니오" }' /></td>
                    <th scope="row">취소번호</th>
                    <td><c:out value='${data.approvalCancelNumber }' /></td>
                    <th scope="row">취소일시</th>
                    <td><fmt:formatDate value='${data.approvalCancelDate }' pattern="yyyy.MM.dd HH:mm:ss" /></td>
                </tr>
            </table>
            <div style="padding-top: 10px"></div>
        </c:forEach>




        <div class="bs_BtnBox_c mgt20"><a href="javascript:fn_closeWindow();" class="btn_white_B01">닫기</a></div>
    </div>
    <!--팝업컨텐츠-->
</div>