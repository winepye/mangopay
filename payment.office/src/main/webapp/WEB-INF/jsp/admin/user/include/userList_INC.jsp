<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : userList_INC.jsp
  * @Description : admin > userList_INC
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.04	이인희      최초 생성
-->
<!-- 템플릿 목록 -->
<table id="userTable" class="tb_basic_st" summary="회원List">
	<caption>회원목록</caption>
    <colgroup>
        <col width="120"> <!--사용자ID-->
        <col width="120"> <!--사용자명-->
        <col width="120"> <!--핸드폰-->
        <col width="150"> <!--이메일-->
        <col width="130"> <!--거래처-->
        <col width="*"> <!--가맹점명-->
        <col width="120"> <!--사용자구분-->
        <col width="80"> <!--사용여부-->
    </colgroup>
	<thead>
		<tr>
			<th scope="col">사용자ID</th>
			<th scope="col">사용자명</th>
			<th scope="col">핸드폰</th>
			<th scope="col">이메일</th>
			<th scope="col">거래처</th>
			<th scope="col">가맹점명</th>
			<th scope="col">사용자구분</th>
			<th scope="col">사용여부</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${result}" varStatus="status">
			<tr>
				<td class="txt_userid">
				    <a href="javascript:fn_goDetailPage('<c:out value="${data.userInfoId}" />')"><c:out value='${data.userId }' /></a>
				</td>
				<td><c:out value='${data.userName }' /></td>
				<td class="txt_phonenum"><c:out value='${data.userMobileNum }' /></td>
				<td><c:out value='${data.userEmailAddr }' /></td>
				<%-- <td class="txt_userid"><c:out value='${data.userTypeCd }' /></td> --%>
				<td><c:out value='${data.companyName }' /></td>
				<td><c:out value='${data.storeName }' /></td>
				<td><customTagUi:code type="text" cdGrp="USER_TYPE_CD" name="" cd="${data.userTypeCd}" /></td>
				<td><customTagUi:code type="text" cdGrp="YN_COMMON" name="" cd="${data.useYn}" /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result) <= 0 }">
			<tr>
				<td class="nodata" colspan="8">조회된 데이터가 없습니다.</td>
			</tr>
		</c:if>
	</tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${userCriteria.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${userCriteria}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>

<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <!-- <span class="rightzone"><button type="button" id="btnOpenSmsPopPage" class="btn_blue_B02">SMS & Email 전송</button></span> -->
    <span class="rightzone"><button type="button" onclick="goUserCreatePage();" class="btn_blue_B02">사용자 등록</button></span>
</div>