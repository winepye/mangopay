<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/adminPaymentDetailPop_JS.jsp"%>
<div id="pop_wrap">
    <div class="pop_titleZone">
        <h1 class="title"><span class="code">승인이력상세</span></h1>
        <a href="javascript:fn_closeWindow();" class="btn_popclose"><em>닫힘</em></a>
    </div>
    <!--팝업컨텐츠-->
    <div class="pop_container">

        <table class="board_popview_st01" summary="승인이력상세">
            <caption>
             승인이력상세
            </caption>
            <colgroup>
                <col width="200px" />
                <col width="*" />
                <col width="200px" />
                <col width="*" />
            </colgroup>
            <tr>
                <th scope="row">가맹점코드</th>
                <td>${payDetail.storeCode }</td>
                <th scope="row">거래고유번호</th>
                <td>${payDetail.transSeqno }</td>
            </tr>
            <tr>
                <th scope="row">가맹점명</th>
                <td>${payDetail.storeName }</td>
                <th scope="row">CAT ID</th>
                <td>${payDetail.catId }</td>
            </tr>
            <tr>
                <th scope="row">거래일시</th>
                <td><fmt:formatDate value="${payDetail.createDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                <th scope="row">진행상태</th>
                <td>${payDetail.processStatusNameAdmin }</td>
            </tr>
            <tr>
                <th scope="row">발급사</th>
                <td>${payDetail.issuerName }</td>
                <th scope="row">매입사</th>
                <td>${payDetail.accepterName }</td>
            </tr>
            <tr>
                <th scope="row">승인번호</th>
                <td>${payDetail.approvalNumber }</td>
                <th scope="row">금액</th>
                <td class="moneyst"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${payDetail.approvalAmount }" /> 원</strong></td>
            </tr>
            <tr>
                <th scope="row">응답코드</th>
                <td>${payDetail.resultCode }</td>
                <th scope="row">응답메시지</th>
                <td>${payDetail.resultMessage }</td>
            </tr>
        </table>

        <div class="pop_tb_notice">
            <ul class="dot_list_st02">
                <li>승인이력에 대한 상세정보 입니다..</li>
            </ul>
        </div>
        <div class="bs_BtnBox_c mgt20"><a href="javascript:fn_closeWindow();" class="btn_white_B01">닫기</a></div>
    </div>
    <!--팝업컨텐츠-->
</div>