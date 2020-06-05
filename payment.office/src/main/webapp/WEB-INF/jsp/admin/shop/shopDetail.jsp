<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/shopDetail_JS.jsp"%>
<%@ include file="/WEB-INF/jsp/common/commJS.jsp"%>

<section id="detail_contents">

    <style>
        .h2_table_titleCs {
            /*background:#e7e7e8;
            border-top:#c8c8c8 solid 1px;
            border-left:#c8c8c8 solid 1px;
            border-right:#c8c8c8 solid 1px;*/
            font-size:14px;
            line-height:18px;
            padding:5px 0 6px 10px;
            text-align:left;
            color:#383838;
            font-weight: bold }
    </style>

    <div style="float:left; width:91%;">
        <h3 class="h2_table_titleCs" >* 매장 정보</h3>
    </div>
    <div style="float:left; width:9%; text-align:right">
        <button type="button" class="btn_gray_B01" onclick="fn_goShopModifyPop(${shopInfo.shopInfoId})">정보수정</button>
    </div>

    <table class="tb_left_st2">
        <caption>매장정보</caption>
        <colgroup>
            <col width="20%" /><col width="30%" /><col width="20%" /><col width="30%" />
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">고객사명</th>
                <td id="companyName"><c:out value="${shopInfo.companyName}" /></td>
                <th scope="row">브랜드명</th>
                <td id="brandName"><c:out value="${shopInfo.brandName}" /></td>
            </tr>
            <tr>
                <th scope="row">매장명</th>
                <td id="shopName"><c:out value="${shopInfo.shopName}" /></td>
                <th scope="row">매장관리코드</th>
                <td id="shopMngCode"><c:out value="${shopInfo.shopMngCode}" /></td>
            </tr>
            <tr>
                <th scope="row">매장전화번호</th>
                <td id="shopTelNum"><c:out value="${shopInfo.shopTelNum}" /></td>
                <th scope="row">사용여부</th>
                <td id="useYn"><c:out value="${shopInfo.useYn eq 'Y' ? '예':'아니오'}" /></td>
            </tr>
        </tbody>
    </table>

    <div style="padding-top: 20px"></div>

    <div>
        <div style="float: left; width: 82%;">
            <h3 class="h2_table_titleCs">* 매장단말기 정보</h3>
        </div>
        <div style="float: left; width: 9%; text-align: right">
            <button type="button" class="btn_gray_B01" id="saveBt">일괄적용</button>
        </div>
        <div style="float: left; width: 9%; text-align: right">
            <button type="button" class="btn_gray_B01" onclick="fn_goShopTerminalCreatePop(${shopInfo.shopInfoId})">단말기 추가</button>
        </div>
    </div>


    <table class="tb_basic_st">
        <caption>일괄적용</caption>
        <colgroup>
            <col width="10%" /><col width="15%" />
            <col width="10%" /><col width="15%" />
            <col width="10%" /><col width="15%" />
            <col width="10%" /><col width="15%" />
            <%--<col width="4%" />--%>
        </colgroup>
        <tbody>

        <tr>
            <th scope="row">과세형태</th>
            <td>
                <select name="taxDivM" id="taxDivM"  class="sel_basic w100pro">
                    <option value="" selected="selected">선택</option>
                    <option value="TAX_ON">과세</option>
                    <option value="TAX_OFF">면세</option>
                    <option value="TAX_PARALLEL">과세 면세 겸업</option>
                </select>
            </td>
            <th scope="row">부가세율(%)</th>
            <td>
                <input type="text" class="input_s_b w100pro alignR" value="0" id="taxRateM" name="taxRateM" onkeyup="chkword(this, 3)" numberOnly />
            </td>
            <th scope="row">봉사료여부</th>
            <td>
                <select name="svcAmtYnM" id="svcAmtYnM"  class="sel_basic w100pro">
                    <option value="" selected="selected">선택</option>
                    <option value="Y">예</option>
                    <option value="N">아니오</option>
                </select>
            </td>
            <th scope="row">봉사료율(%)</th>
            <td>
                <input type="text" class="input_s_b w100pro alignR" value="0" id="svcChargeRateM" name="svcChargeRateM" onkeyup="chkword(this, 3)" numberOnly />
            </td>

            <%--<td>
                <button type="button" id="saveBt" class="btn_gray_B01 mgl5">일괄적용</button>
            </td>--%>
        </tr>

        <style>
            .alignR {
                text-align: right;
            }
        </style>


        </tbody>
    </table>

    <form id = "saveFrm" name = "saveFrm" method="post">
        <%--일괄적용을 위한 폼--%>
        <input type="hidden" id="jsonStr" name="jsonStr" />

    </form>




    <table id="companyTable" class="tb_basic_st" summary="고객사List" style="width: 100%;">
        <caption>매장단말기 정보</caption>
        <colgroup>
            <col width="50"> <!--checkbox-->
            <col width="120"> <!--매장-->
            <col width="110"> <!--사업자번호-->
            <col width="100"> <!--매장단말번호-->
            <col width="100"> <!--서비스그룹-->
            <col width="100"> <!--전화번호-->
            <col width="80"> <!--단말개수-->

            <col width="100"> <!--과세형태-->
            <col width="60"> <!--부가세율-->
            <col width="70"> <!--봉사료여부-->
            <col width="60"> <!--봉사료율-->

            <col width="60"> <!--사용여부-->
        </colgroup>
        <thead>
        <tr>
            <th scope="col">
                <input type="checkbox" id="allChkYn" name="allChkYn"  onclick="fn_listAllCheck(this)" />
            </th>
            <th scope="col">매장</th>
            <th scope="col">사업자번호</th>
            <th scope="col">매장단말번호</th>
            <th scope="col">서비스그룹</th>
            <th scope="col">전화번호</th>
            <th scope="col">단말개수</th>

            <th scope="col">과세형태</th>
            <th scope="col">부가세율</th>
            <th scope="col">봉사료여부</th>
            <th scope="col">봉사료율</th>

            <th scope="col">사용여부</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="data" items="${shopTerminalList}" varStatus="status">
            <tr>
                <td>
                    <input type="checkbox" id="chkYn_${data.shopTerminalId}" name="chkYn" value="${data.shopTerminalId}"/>
                </td>
                <td><c:out value='${data.shopName }' /></td>
                <td><c:out value='${data.serviceBizNum }' /></td>
                <td style="font-weight: bold">
                    <u><a href="javascript:fn_getShopTerminalInfo('<c:out value="${data.shopTerminalId}" />','<c:out value="${data.shopInfoId}" />')">
                        <c:out value='${data.shopTerminalNum }' /></a></u>
                </td>
                <td><c:out value='${data.paymentGroupNm }' /></td>
                <td><c:out value='${data.serviceTelNum }' /></td>
                <td><c:out value='${data.terminalCnt }' /></td>

                <td><c:out value='${data.taxDivNm }' /></td>
                <td><c:out value='${data.taxRate }' />%</td>
                <td><c:out value="${data.svcAmtYn eq 'Y' ? '예' : '아니오' }" /></td>
                <td><c:out value='${data.svcChargeRate }' />%</td>

                <td><c:out value="${data.useYn eq 'Y' ? '예' : '아니오'  }" /></td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(shopTerminalList) <= 0 }">
            <tr>
                <td class="nodata" colspan="11">조회된 데이터가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <!--/ 가맹점 정렬목록 /-->
    <div id = "shopTerminalInfoArea">
        <jsp:include page="include/shopTerminalList_INC.jsp"></jsp:include>
    </div>

    <form id="shopTermianlFrm" name="shopTermianlFrm" method="post">
        <input type="hidden" id="shopTerminalId" name="shopTerminalId">
        <input type="hidden" id="shopInfoId" name="shopInfoId">
    </form>


    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <%--고객사(company) or 브랜드명(brand) or 매장명(shop) 검색 구분--%>
        <input type="hidden" name="searchNmType" value='<c:out value="${search.searchNmType }" />'>
        <%--고객사명 or 브랜드명 or 매장명--%>
        <input type="hidden" name="searchNm" value='<c:out value="${search.searchNm }" />'>
        <%--사업자번호--%>
        <input type="hidden" name="searchServiceBizNum" value='<c:out value="${search.searchServiceBizNum }" />'>
        <%--매장관리번호--%>
        <input type="hidden" name="searchShopMngCode" value='<c:out value="${search.searchShopMngCode }" />'>
        <%--담당자명--%>
        <input type="hidden" name="searchChargerName" value='<c:out value="${search.searchChargerName }" />'>
        <%--가맹점 전화번호--%>
        <input type="hidden" name="searchServiceTelNum" value='<c:out value="${search.searchServiceTelNum }" />'>
        <%--주소--%>
        <input type="hidden" name="searchAddr" value='<c:out value="${search.searchAddr }" />'>
        <%--업종(하)--%>
        <input type="hidden" name="searchBizType" value='<c:out value="${search.searchBizType }" />'>
        <%--업종(상)--%>
        <input type="hidden" name="searchPbizType" value='<c:out value="${search.searchPbizType }" />'>
        <%--기간 검색 타입(등록일, 수정일)--%>
        <input type="hidden" name="searchType" value='<c:out value="${search.searchType }" />'>
        <%--검색 시작일--%>
        <input type="hidden" name="searchSdate" value='<c:out value="${search.searchSdate }" />'>
        <%--검색 종료일--%>
        <input type="hidden" name="searchEdate" value='<c:out value="${search.searchEdate }" />'>
        <%--매장정보ID(PK)--%>
        <input type="hidden" name="shopInfoId" value='<c:out value="${search.shopInfoId }" />'>
        <%--매장단말기ID(PK)--%>
        <input type="hidden" name="shopTerminalId" value='<c:out value="${search.shopTerminalId }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${search.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${search.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

    </form>

    <div class="bs_BtnBox_c">
	    <button type="button" id="btnGoListPage" class="btn_white_B01">목록</button>
	    <%--<button type="button" id="btnGoModifyPage" class="btn_gray_B01">수정</button>--%>
	</div>
</section>

