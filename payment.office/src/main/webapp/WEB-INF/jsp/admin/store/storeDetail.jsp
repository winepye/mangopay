<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/storeDetail_JS.jsp"%>
<!--
  * @Class Name  : storeDetail.jsp
  * @Description : 가맹점상세
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<c:set var="isAuthConstNow" value="N" />
    <form id="frm" name="frm" method="post">
        <!-- 탭별 페이징 구분을 위한 히든값 -->
        <input type="hidden" id="currentPageNo" name = "currentPageNo" value="1">

        <h3 class="h2_table_title">가맹점정보</h3>
        <table id="templateProject" class="tb_left_st2" summary="가맹점정보">
            <caption>가맹점정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">가맹정명</th>
                    <td><span class="txt_eng"><c:out value="${result.storeName }" /></span></td>
                    <th scope="row">가맹점코드</th>
                    <td><span class="txt_num"><c:out value="${result.storeCode}" /></span></td>
                </tr>
                <tr>
                    <th scope="row">CAT ID</th>
                    <td><span class="txt_eng"><c:out value="${result.catId }" /></span></td>
                    <th scope="row">제휴사정보</th>
                    <td><span class="txt_num"><c:out value="${result.partnerName}" /></span></td>
                </tr>
                <tr>
                    <th scope="row">가맹점 키값</th>
                    <td><span class="txt_eng"><c:out value="${result.compApikey }" /></span></td>
                    <th scope="row">사업자번호</th>
                    <td><span class="txt_eng"><c:out value="${result.bizRegNum }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">부가세</th>
                    <td>
                    	<span class="txt_eng">
                    		<c:out value="${result.taxTypeName }" />&nbsp;,&nbsp;<c:out value="${result.taxRate }" />%
                    		</span>
                    </td>
                    <th scope="row">봉사료</th>
                    <td>
                    	<span class="txt_eng">
                    		<c:out value="${result.serviceChargeYnName }" />&nbsp;,&nbsp;<c:out value="${result.serviceChargeRate }" />%
                    	</span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">대표자명</th>
                    <td><span class="txt_eng"><c:out value="${result.ceoName }" /></span></td>
                    <th scope="row">업종</th>
                    <td><span class="txt_eng"><c:out value="${result.bizType }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">연락처</th>
                    <td><span class="txt_eng"><c:out value="${result.telNum }" /></span></td>
                    <th scope="row">핸드폰</th>
                    <td><span class="txt_eng"><c:out value="${result.mobileNum }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">기기번호</th>
                    <td><span class="txt_eng"><c:out value="${result.deviceNum }" /></span></td>
                    <th scope="row">설치일</th>
                    <td><span class="txt_eng"><c:out value="${result.equipDate }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">거래처정보</th>
                    <td>
                    	<span class="txt_eng"><c:out value="${result.companyName }" /></span>
                    </td>
                    <th scope="row">사용여부</th>
                    <td>
                    	<span class="txt_eng"><c:out value="${result.useYnName }" /></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td colspan="3">
                    	<span class="txt_eng"><c:out value="${result.emailAddr }" /></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">주소</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${result.storeAddr1 eq null || result.storeAddr1 eq ''}">-</c:when>
                            <c:otherwise>
                                <span class="txt_num">(<c:out value="${result.storeZip}" />)</span>
                                 <c:out value="${result.storeAddr1}" /> <c:out value="${result.storeAddr2}" />
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>

    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchStoreId" value='<c:out value="${storeCriteria.searchStoreId }" />'>
        <input type="hidden" name="searchStoreName" value='<c:out value="${storeCriteria.searchStoreName }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${storeCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${storeCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

        <input type="hidden" name="storeCode" id="storeCode" value="${result.storeCode}">
    </form>

    <div class="bs_BtnBox_c">
	    <button type="button" id="btnGoStoreListPage" class="btn_white_B01">목록</button>
	    <button type="button" id="btnGoStoreModifyPage" class="btn_gray_B01">수정</button>
	</div>
</section>

