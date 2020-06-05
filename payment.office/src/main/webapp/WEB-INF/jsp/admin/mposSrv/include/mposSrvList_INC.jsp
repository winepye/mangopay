<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>


<style>
    .SC{
        overflow-x: scroll;
        overflow-y: hidden;
    }

    ::-webkit-scrollbar {

        width: 18px;

        height: 18px;

        border: 10px solid #fff;

    }

    ::-webkit-scrollbar-thumb {

        height: 50px;

        width: 50px;

        background: rgba(0,0,0,.2);

        -webkit-border-radius: 8px;

        border-radius: 8px;

        -webkit-box-shadow: inset 0 0 4px rgba(0,0,0,.1);

        border: 0;

    }
</style>

<div style="width:100%; padding-bottom: 15px;" class="SC">
    <table id="reportTable" class="tb_basic_st" summary="" style="width: 150%;">
        <caption>MPOS승인 목록</caption>
        <colgroup>
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
            <col width="*" />
        </colgroup>
        <thead>
            <tr>
              <th scope="col">고객사명</th>
              <th scope="col">브랜드명</th>
              <th scope="col">매장명</th>
              <th scope="col">결제개수</th>
              <th scope="col">서비스제공자</th>
              <th scope="col">CAT-ID</th>
              <th scope="col">사업자번호</th>
              <th scope="col">결제수단</th>
              <th scope="col">결제방법</th>
              <th scope="col">결제금액(원)</th>
              <th scope="col">세금(원)</th>
              <th scope="col">요청일시</th>
              <th scope="col">승인일시</th>
              <th scope="col">승인번호</th>
              <th scope="col">승인취소</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var = "data" items="${mposPayList}" varStatus="i">
                <tr>
                    <td>
                        <a href="javascript:fn_openDetailPop('${data.paymentHistId }','${data.mposPaymentHistId }');"><strong><c:out value='${data.companyName }' /></strong></a>
                    </td>
                    <td><c:out value='${data.brandName }' /></td>
                    <td><c:out value='${data.shopName }' /></td>
                    <td><c:out value='${data.mposPaymentHistId }' /></td>
                    <td><c:out value='${data.serviceProvider }' /></td>
                    <td><c:out value='${data.catId }' /></td>
                    <td><c:out value='${data.BizNo }' /></td>
                    <td><c:out value='${data.paymentMean }' /></td>
                    <td><c:out value='${data.paymentMethod }' /></td>
                    <td><fmt:formatNumber value="${data.paymentTotalAmt  }" pattern="#,###" /></td>
                    <td><fmt:formatNumber value="${data.taxCharge  }" pattern="#,###" /></td>
                    <td><fmt:formatDate value="${data.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${data.approvalDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><c:out value='${data.approvalNumber }' /></td>
                    <td><c:out value='${data.approvalCancelYn  eq "Y" ? "예" : "아니오"}' /></td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(mposPayList) <= 0 }">
                <tr>
                    <td class="nodata" colspan="14">조회된 데이터가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<input type = "hidden" id = "listTotalCount" value="${criteria.totalRecordCount }" >
<!--게시판페이지버튼-->
<div class="btnPageZoneWrap">
    <div class="btnPageZone" id="btnPageZone">
        <customTagUi:pagiNavigation paginationInfo="${criteria}" type="admin" jsFunction="fn_doSearch" />
    </div>
</div>
<!--//게시판페이지버튼//-->
