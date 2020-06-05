<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 템플릿 목록 -->
<table id="menuTable" class="tb_basic_st" summary="메뉴관리">
    <caption>메뉴목록</caption>
    <colgroup>
        <col width="40"> <!--체크박스-->
        <col width="80"> <!--업무유형-->
        <col width="50"> <!--메뉴유형-->
        <col width="*"> <!--메뉴명-->
        <col width="*"> <!--메뉴설명-->
        <col width="55"> <!--메뉴위치-->
        <col width="*"> <!--메뉴URL-->
        <col width="45"> <!--대표메뉴-->
        <col width="45"> <!--사용-->
        <col width="60"> <!--로그인필요-->
        <col width="80"> <!--수정일-->
        <col width="60"> <!--수정자-->
    </colgroup>
	<thead>
        <tr>
            <th scope="col"><label for=""><input type="checkbox" id="deleteMenuSeq" name='allChk' onclick="fn_allCheck(this);" /><span class="blind">전체선택</span></label></th>
            <th scope="col">업무유형</th>
            <th scope="col">메뉴<br>유형</th>
            <th scope="col">메뉴명</th>
            <th scope="col">메뉴설명</th>
            <th scope="col">메뉴<br>위치</th>
            <th scope="col">메뉴URL</th>
            <th scope="col">대표메뉴여부</th>
            <!-- <th scope="col">정렬순서</th> -->
            <th scope="col">사용<br>여부</th>
            <!-- <th scope="col">작성일</th>
            <th scope="col">작성자</th> -->
            <th scope="col">로그인<br>필요여부</th>
            <th scope="col">수정일</th>
            <th scope="col">수정자</th>

        </tr>
    </thead>
    <tbody>
		<c:forEach var = "data" items="${result.menuVolist }">
			<tr>
				<td>
	           		<input type="checkbox" name = "deleteMenuSeq" value="<c:out value='${data.menuSeq }' />" onclick="javascript:fn_eachCheck(this);">
	           		<input type="hidden" name = "grpMenuListUseYn" value="<c:out value='${data.grpMenuListUseYn }' />">
	          		<span class="blind">선택</span>
             	</td>
             	<td class="txt_left">
             	    <customTagUi:code type="text" cdGrp="BUSINESS_TYPE_CD" name="" cd="${data.businessTypeCd }" />
            	</td>
             	<td >
             	     <customTagUi:code type="text" cdGrp="MENU_TYPE_CD" name="" cd="${data.menuTypeCd }" />
             	</td>
             	<td class="txt_title"><a href="javascript:fn_openDetailPop('${data.menuSeq }');"><c:out value="${data.menuNm }" /></a></td>
             	<td class="txt_left"><c:out value="${data.menuDesc }" /></td>
             	<td class="txt_eng">
             	      <customTagUi:code type="text" cdGrp="MENU_LOCATION_CD" name="" cd="${data.menuLocationCd }" />
             	</td>
             	<td class="re_title"><c:out value="${data.menuUrl }" /></td>
             	<td class="txt_eng">
             	      <c:out value="${data.representMenuYn eq 'Y' ? '예' : '아니오' }" />
             	</td>
             	<%-- <td onclick="fn_openDetailPop('${data.menuSeq }')"><c:out value="${data.sortOrd }" /></td> --%>
             	<td class="txt_eng">
             	      <c:out value="${data.useYn eq 'Y' ? '예' : '아니오' }" />
             	</td>
             	<%-- <td ><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
             	<td ><c:out value="${data.createBy }" /></td> --%>
             	<td class="txt_eng"> <c:out value="${data.loginYn eq 'Y' ? '예' : '아니오' }" /></td>
             	<td class="txt_date"><fmt:formatDate value="${data.updateDate}" pattern="yyyy/MM/dd"/></td>
             	<td ><c:out value="${data.editUserName }" /></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(result.menuVolist) <= 0 }">
		<tr>
			<td class="nodata" colspan="14">조회된 데이터가 없습니다.</td>
		</tr>
		</c:if>
    </tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${menuCriteria.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${menuCriteria}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>

<!-- 메뉴관리화면 버튼 : S -->
<div class="bs_BtnBox_both">
    <span class="leftzone"><button type="button" id="btnDelete" class="btn_white_B02">선택삭제</button></span>
    <span class="rightzone"><button type="button" id="btnCreate" class="btn_blue_B02">신규 메뉴등록</button></span>
</div>
<!--/ 메뉴관리화면 버튼 : E /-->