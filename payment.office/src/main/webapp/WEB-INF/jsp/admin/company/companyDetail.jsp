<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/companyDetail_JS.jsp"%>
<!--
  * @Class Name  : companyDetail.jsp
  * @Description : 고객사상세
  * @Modification Information
  * @
  * @ 수정일             수정자      수정내용
  * @ 2018.11.19	 이인희      최초 생성
-->
<section id="detail_contents">
	<c:set var="isAuthConstNow" value="N" />
    <form id="frm" name="frm" method="post">
        <!-- 탭별 페이징 구분을 위한 히든값 -->
        <input type="hidden" id="currentPageNo" name = "currentPageNo" value="1">

        <h3 class="h2_table_title">고객사정보</h3>
        <table id="templateProject" class="tb_left_st2" summary="고객사정보">
            <caption>고객사정보</caption>
            <colgroup>
                <col width="20%" />
                <col width="30%" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">사업자 구분</th>
                    <td colspan="3">
                        <span class="txt_num">
                            <c:if test="${result.company.businessType == 'corporate'}">
                                법인
                            </c:if>
                            <c:if test="${result.company.businessType == 'personal'}">
                                개인
                            </c:if>
                        </span>
                    </td>
                </tr>

                <tr>
                    <th scope="row">사업자번호</th>
                    <td><span class="txt_num"><c:out value="${result.company.bizRegNum}" /></span></td>
                </tr>

                <tr>
                    <th scope="row">
                        <c:if test="${result.company.businessType == 'corporate'}">
                            법인 등록번호
                        </c:if>
                        <c:if test="${result.company.businessType == 'personal'}">
                            생년월일
                        </c:if>
                    </th>
                    <td><span class="txt_num"><c:out value="${result.company.corpNum}" /></span></td>

                    <th scope="row">
                        <c:if test="${result.company.businessType == 'corporate'}">
                            대표자명
                        </c:if>
                        <c:if test="${result.company.businessType == 'personal'}">
                            성명
                        </c:if>
                    </th>
                    <td><span class="txt_num"><c:out value="${result.company.ceoName}" /></span></td>
                </tr>

                <tr>
                    <th scope="row">
                        <c:if test="${result.company.businessType == 'corporate'}">
                            법인명
                        </c:if>
                        <c:if test="${result.company.businessType == 'personal'}">
                            상호
                        </c:if>
                    </th>
                    <td colspan="3"><span class="txt_num"><c:out value="${result.company.companyName}" /> </span></td>
                </tr>

                <tr>
                    <th scope="row">사업장주소</th>
                    <td colspan="3"><span class="txt_num">
                        (<c:out value="${result.company.companyZip}" />) <c:out value="${result.company.companyAddr1}" />
                        <c:out value="${result.company.companyAddr2}" />
                    </span></td>
                </tr>

                <tr>
                    <th scope="row">업태</th>
                    <td><span class="txt_num"><c:out value="${result.company.bizCond}" /></span></td>

                    <th scope="row">종목</th>
                    <td><span class="txt_num"><c:out value="${result.company.bizType}" /></span></td>
                </tr>

                <tr>
                    <th scope="row">대표번호</th>
                    <td><span class="txt_num"><c:out value="${result.company.telNum}" /> </span></td>
                    <th scope="row">결제타입</th>
                    <td>
                        <span class="txt_num">
                            <c:if test="${result.company.paymentType == 'EASY_PAY'}">
                                간편결제
                            </c:if>
                            <c:if test="${result.company.paymentType == 'MPOS_PAY'}">
                                mPos
                            </c:if>
                            <c:if test="${result.company.paymentType == 'ALL'}">
                                mPos+간편결제
                            </c:if>
                        </span>
                    </td>
                </tr>

                <tr>
                    <th scope="row">홈페이지</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${result.company.homepageUrl eq null or result.company.homepageUrl eq '' }">http://</c:when>
                            <c:otherwise><c:out value="${result.company.homepageUrl }" /></c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th scope="row">제휴사정보</th>
                    <td><span class="txt_eng"><c:out value="${result.company.partnerName }" /></span></td>

                    <th scope="row">사용여부</th>
                    <td><span class="txt_eng">
                        <c:if test="${result.company.useYn == 'Y'}">
                            사용
                        </c:if>
                        <c:if test="${result.company.useYn == 'N'}">
                            미사용
                        </c:if>
                    </span></td>
                </tr>

                <tr>
                    <th scope="row">가맹점 키값</th>
                    <td colspan="3"><span class="txt_eng"><c:out value="${result.company.compApikey }" /></span></td>
                </tr>

            </tbody>
        </table>

        <div style="width:100%; padding-top: 20px; display: none">
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
		</div>

    </form>

    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchCompanyId" value='<c:out value="${companyCriteria.searchCompanyId }" />'>
        <input type="hidden" name="searchCompanyName" value='<c:out value="${companyCriteria.searchCompanyName }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${companyCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${companyCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

        <input type="hidden" name="companyInfoId" id="companyInfoId" value="${result.company.companyInfoId}">
    </form>

    <div class="bs_BtnBox_c">
	    <button type="button" id="btnGoCompanyListPage" class="btn_white_B01">목록</button>
	    <button type="button" id="btnGoCompanyModifyPage" class="btn_gray_B01">수정</button>
	</div>
</section>

