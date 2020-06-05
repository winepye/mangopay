<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 템플릿 목록 -->
<table id="chargerTable" class="tb_basic_st" summary="공지사항 List (공지유형, 제목, 탑공지기간, 게시여부, 조회수, 작성자, 작성일)">
    <caption>공지사항 List</caption>
    <colgroup>
       <col width="50">
       <col width="">
       <col width="200">
       <col width="70">
       <col width="">
       <col width="">
       <col width="">
       <col width="">
       <col width="">
       <col width="">
       <col width="">
    </colgroup>
	<thead>
        <tr>
            <th scope="col"><label for=""><input type="checkbox" id="deleteChargerSeq" name='allChk' onclick="fn_allCheck(this);" /><span class="blind">전체선택</span></label></th>
            <th scope="col">담당자유형</th>
            <th scope="col">유형별명칭</th>
            <th scope="col">담당자명</th>
            <th scope="col">모바일</th>
            <th scope="col">이메일</th>
            <th scope="col">회사전화번호</th>
            <th scope="col">등록일</th>
            <th scope="col">등록자</th>
            <th scope="col">수정일</th>
            <th scope="col">수정자</th>
        </tr>
    </thead>
    <tbody>
		<c:forEach var = "data" items="${result.chargerVolist }">
		<tr>
             <td>
           		<input type="checkbox" name = "deleteChargerSeq" value="<c:out value='${data.chargerInfoId }' />" onclick="javascript:fn_eachCheck(this);">
          		<span class="blind">선택</span>
             </td>
             <td><customTagUi:code type="text" cdGrp="CHARGER_TYPE" name="" cd="${data.chargerType}" /></td>
             <td class="txt_title"><c:out value="${data.chargerTypeName }" /></td>
             <td class="txt_title"><a href="javascript:fn_goDetailPage('<c:out value='${data.chargerInfoId }' />')"><c:out value="${data.chargerName }" /></a></td>
             <td class="count_num"><c:out value="${data.mobileNum }" /></td>
             <td class="txt_eng"><c:out value="${data.emailAddr }" /></td>
             <td class="count_num"><c:out value="${data.companyTelNum }" /></td>
             <td class="txt_date"><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
             <td><c:out value="${data.createByName }" /></td>
             <td class="txt_date"><fmt:formatDate value="${data.updateDate}" pattern="yyyy/MM/dd"/></td>
             <td><c:out value="${data.updateByName }" /></td>
         </tr>
		</c:forEach>
		<c:if test="${fn:length(result.chargerVolist) <= 0 }">
		<tr>
			<td class="nodata" colspan="11">조회된 데이터가 없습니다.</td>
		</tr>
		</c:if>
    </tbody>
</table>
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${chargerCriteria}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>
<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="leftzone"><button type="button" id="btnDeleteCharger" class="btn_white_B02">선택삭제</button></span>
    <span class="rightzone"><button type="button" id="btnGoChargerCreatePage" class="btn_blue_B02">담당자 등록</button></span>
</div>
<!-- 버튼 -->
<input type = "hidden" id = "listTotalCount" value="${chargerCriteria.totalRecordCount }" >