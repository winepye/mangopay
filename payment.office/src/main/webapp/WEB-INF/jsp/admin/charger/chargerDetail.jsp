<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/chargerDetail_JS.jsp"%>
<!--
  * @Class Name  : chargerCreatePage.jsp
  * @Description : 담당자작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">담당자 상세</h3>
       	<table id="templateProject" class="tb_left_st2" summary="담당자 등록, 제목, 공지유형, 내용, 노출여부">
           <caption>
               담당자 상세
           </caption>
           <colgroup>
               <col width="15%" />
               <col width="35%" />
               <col width="15%" />
               <col width="35%" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row">
                   		<label for="title">담당자유형</label>
                   </th>
                   <td colspan="3"><span class="txt_eng"><c:out value="${result.chargerTypeName}" /></span></td>
               </tr>
               <tr>
                   <th scope="row">
                   		<label for="title">서비스제공자</label>
                   </th>
                   <td><span class="txt_eng"><c:out value="${result.serviceProviderName}" /></span></td>
                   <th scope="row">
                   		<label for="categCd">고객사</th>
                   <td><span class="txt_eng"><c:out value="${result.companyName}" /></span></td>
               </tr>
               <tr>
                   <th scope="row">
                   		<label for="title">브랜드</label>
                   </th>
                   <td><span class="txt_eng"><c:out value="${result.brandName}" /></span></td>
                   <th scope="row">
                   		<label for="categCd">매장</th>
                   <td><span class="txt_eng"><c:out value="${result.shopName}" /></span></td>
               </tr>
               <tr>
           			<th scope="row"><label for="chargerName">담당자명</label></th>
           			<td><span class="txt_eng"><c:out value="${result.chargerName}" /></span></td>
           			<th scope="row"><label for="mobileNum1">모바일번호</label></th>
           			<td><span class="txt_eng"><c:out value="${result.mobileNum}" /></span></td>
           		</tr>
           		<tr>
           		    <th scope="row"><label for="emailAddr">이메일</label></th>
           			<td><span class="txt_eng"><c:out value="${result.emailAddr}" /></span></td>
           			<th scope="row"><label for="companyTelNum1">회사전화번호</label></th>
           			<td><span class="txt_eng"><c:out value="${result.companyTelNum}" /></span></td>
           		</tr>
           		<tr>
           			<th scope="row"><label for="departmentName">부서</label></th>
           			<td><span class="txt_eng"><c:out value="${result.departmentName}" /></span></td>
           			<th scope="row"><label for="officialPosition">직위</label></th>
           			<td><span class="txt_eng"><c:out value="${result.officialPosition}" /></span></td>
           		</tr>
           		<tr>
           			<th scope="row"><label for="companyZip">주소</label></th>
           			<td colspan="3">
           			    (<c:out value="${result.companyZip}" />) <c:out value="${result.companyAddr1}" /> <c:out value="${result.companyAddr2}" />
           			</td>
           		</tr>
           		<tr>
           			<th scope="row"><label for="useYn">사용여부</label></th>
           			<td colspan="3"><span class="txt_eng"><c:out value="${result.useYn}" /></span></td>
           		</tr>

           </tbody>
       </table>
		<!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <button type="button" id="btnGoChargerListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnGoChargerModifyPage" class="btn_gray_B01">수정</button>
        </div>
        <!-- 버튼 -->
	</form>
	<form id = "moveFrm" name = "moveFrm" method = "post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <%-- <input type="hidden" name = "searchContentType" value='<c:out value="${chargerCriteria.searchContentType }" />'>
        <input type="hidden" name = "searchContentText" value='<c:out value="${chargerCriteria.searchContentText }" />'>
        <input type="hidden" name = "searchOpenYn" value='<c:out value="${chargerCriteria.searchOpenYn }" />'>
        <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${chargerCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
        <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${chargerCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"> --%>
        <!-- 상세 -->
        <input type="hidden" name = "chargerInfoId" value='<c:out value="${result.chargerInfoId }" />'>
        <!-- 페이징 -->
        <input type="hidden" name = "currentPageNo" value='<c:out value="${chargerCriteria.currentPageNo }" />'>
        <input type="hidden" name = "recordCountPerPage" value='<c:out value="${chargerCriteria.recordCountPerPage }" />'>
       <!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>
</section>