<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/brandDetail_JS.jsp"%>
<!--
  * @Class Name  : brandDetail.jsp
  * @Description : 브랜드상세
  * @Modification Information
  * @
  * @ 수정일             수정자      수정내용
  * @ 2018.12.17   	   이인희      최초 생성
-->
<section id="detail_contents">

    <form id="frm" name="frm" method="post">
        <!-- 탭별 페이징 구분을 위한 히든값 -->
        <input type="hidden" id="currentPageNo" name = "currentPageNo" value="1">

        <h3 class="h2_table_title">브랜드정보</h3>
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

                <%--<tr>
                    <th scope="row">홈페이</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${result.brand.homepageUrl eq null or result.brand.homepageUrl eq '' }">http://</c:when>
                            <c:otherwise><c:out value="${result.brand.homepageUrl }" /></c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th scope="row">제휴사정보</th>
                    <td><span class="txt_eng"><c:out value="${result.brand.partnerName }" /></span></td>

                    <th scope="row">사용여부</th>
                    <td><span class="txt_eng">
                        <c:if test="${result.brand.useYn == 'Y'}">
                            사용
                        </c:if>
                        <c:if test="${result.brand.useYn == 'N'}">
                            미사용
                        </c:if>
                    </span></td>
                </tr>

                <tr>
                    <th scope="row">가맹점 키값</th>
                    <td colspan="3"><span class="txt_eng"><c:out value="${result.brand.compApikey }" /></span></td>
                </tr>--%>

            </tbody>
        </table>

        <%--<div style="width:100%; padding-top: 20px; display: none">
			<label>※ 가맹점 정보</label>
		</div>
		<div style="width:100%; overflow:auto; display: none">
			<table class="tb_left_st2" summary="가맹점 목록">
				<caption>가맹점 목록</caption>
			    <colgroup>
			        <col width="130"> <!--가맹점코드-->
			        <col width="130"> <!--가맹점명-->
			        <col width="100"> <!--CAT ID-->
			        <col width="120"> <!-- 사업자번호 -->
			        <col width="130"> <!--연락처-->
			        <col width="*"> <!-- 핸드폰 -->
			    </colgroup>
				<thead>
					<tr>
						<th scope="col">가맹점코드</th>
						<th scope="col">가맹점명</th>
						<th scope="col">CAT ID</th>
						<th scope="col">사업자번호</th>
						<th scope="col">연락처</th>
						<th scope="col">핸드폰</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="data" items="${result.storeList}" varStatus="status">
						<tr>
							<td style="text-align: center;"><c:out value='${data.storeCode }' /></td>
							<td style="text-align: center;"><c:out value='${data.storeName }' /></td>
							<td style="text-align: center;"><c:out value='${data.catId }' /></td>
							<td style="text-align: center;"><c:out value='${data.bizRegNum }' /></td>
							<td style="text-align: center;"><c:out value='${data.telNum }' /></td>
							<td style="text-align: center;"><c:out value='${data.mobileNum }' /></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(result.storeList) <= 0 }">
						<tr>
							<td class="nodata" colspan="6">조회된 가맹점정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>--%>

    </form>

    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchCompanyName" value='<c:out value="${brandCriteria.searchCompanyName }" />'>
        <input type="hidden" name="searchBrandName" value='<c:out value="${brandCriteria.searchBrandName }" />'>
        <input type="hidden" name="searchBizType" value='<c:out value="${brandCriteria.searchBizType }" />'>
        <input type="hidden" name="searchState" value='<c:out value="${brandCriteria.searchState }" />'>
        <input type="hidden" name="searchType" value='<c:out value="${brandCriteria.searchType }" />'>
        <input type="hidden" name="searchSdate" value='<c:out value="${brandCriteria.searchSdate }" />'>
        <input type="hidden" name="searchEdate" value='<c:out value="${brandCriteria.searchEdate }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${brandCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${brandCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

        <input type="hidden" name="brandInfoId" id="brandInfoId" value="${result.brandInfoId}">
        <input type="hidden" name="companyInfoId" id="companyInfoId" value="${result.companyInfoId}">
    </form>

    <div class="bs_BtnBox_c">
	    <button type="button" id="btnGoBrandListPage" class="btn_white_B01">목록</button>
	    <button type="button" id="btnGoBrandModifyPage" class="btn_gray_B01">수정</button>
	</div>
</section>

