<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/companyDetailPop_JS.jsp"%>

<div id="pop_wrap">
    <!--팝업컨텐츠-->
    <div class="pop_container">

        <h3 class="h2_table_title" style="font-weight: bold">브랜드정보</h3>
        <table id="templateProject" class="tb_left_st2" summary="브랜드정보">
            <caption>브랜드정보</caption>
            <colgroup>
                <col width="20%" />
                <col width="30%" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">브랜드명</th>
                    <td><c:out value="${result.brandName}" /></td>
                    <th scope="row">브랜드코드</th>
                    <td><c:out value="${result.brandInfoId}" /></td>
                </tr>

                <tr>
                    <th scope="row">고객사명</th>
                    <td><c:out value="${result.companyName}" /></td>
                    <th scope="row">사업자번호</th>
                    <td><c:out value="${result.bizRegNum}" /></td>
                </tr>

                <tr>
                    <th scope="row">매장구분</th>
                    <td colspan="3">
                        <c:if test="${result.shopPayType == 'AFTER'}">
                            선불
                        </c:if>
                        <c:if test="${result.shopPayType == 'BEFORE'}">
                            후불
                        </c:if>
                    </td>
                </tr>

                <tr>
                    <th scope="row">업종</th>
                    <td colspan="3"><c:out value="${result.bizType}" /></td>
                </tr>

                <tr>
                    <th scope="row">대표번호</th>
                    <td><span class="txt_num"><c:out value="${result.telNum}" /> </span></td>
                    <th scope="row">담당자</th>
                    <td><c:out value="${result.personCharge}"/> </td>
                </tr>
            </tbody>
        </table>

        <div class="bs_BtnBox_c">
            <button type="button" id="btnGoBrandListPage" class="btn_gray_B01 mgl5" onclick="fn_closeWindow()">닫기</button>
        </div>

    </div>
    <!--팝업컨텐츠-->
</div>
