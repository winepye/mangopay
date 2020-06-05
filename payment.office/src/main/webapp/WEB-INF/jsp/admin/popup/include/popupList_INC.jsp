<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 템플릿 목록 -->
<table id="notiTable" class="tb_basic_st" summary="팝업목록 (팝업제목, 팝업기간, 팝업여부, 조회수, 작성자, 작성일)">
    <caption>팝업 목록</caption>
    <colgroup>
        <col width="50"> <!--체크박스-->
        <col width="*"> <!--팝업제목-->
        <col width="*"> <!--팝업기간-->
        <col width="80"> <!--팝업여부-->
        <col width="100"> <!--조회수-->
        <col width="*"> <!--작성자-->
        <col width="100"> <!--작성일-->
    </colgroup>
	<thead>
        <tr>
            <th scope="col"><label for=""><input type="checkbox" id="deletePopupSeq" name='allChk' onclick="fn_allCheck(this);" /><span class="blind">전체선택</span></label></th>
            <th scope="col">팝업 제목</th>
            <th scope="col">팝업기간</th>
            <th scope="col">팝업여부</th>
            <th scope="col">작성자</th>
            <th scope="col">작성일</th>

        </tr>
    </thead>
    <tbody>
		<c:forEach var = "data" items="${result.popupVolist }">
		<tr>
             <td>
                <label>
	           		<input type="checkbox" name = "deletePopupSeq" value="<c:out value='${data.popupSeq }' />" onclick="javascript:fn_eachCheck(this);">
	          		<span class="blind">선택</span>
          		</label>
             </td>
             <td class="txt_title"><a href="javascript:fn_goDetailPage('<c:out value='${data.popupSeq }' />')"><c:out value="${data.title }" /></a></td>
             <td class="txt_date"><fmt:formatDate value="${data.popupStartDt}" pattern="yyyy/MM/dd"/> ~ <fmt:formatDate value="${data.popupEndDt}" pattern="yyyy/MM/dd"/></td>
             <td class="txt_eng"><c:out value="${data.popupYn eq 'Y' ? '예' : '아니오' }" /></td>
             <td><c:out value="${data.regUserName }" /></td>
             <td class="txt_date"><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
         </tr>
		</c:forEach>
		<c:if test="${fn:length(result.popupVolist) <= 0 }">
		<tr>
			<td class="nodata" colspan="6">조회된 데이터가 없습니다.</td>
		</tr>
		</c:if>
    </tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${popupCriteria.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${popupCriteria}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>
<!-- 버튼 -->
<div class="bs_BtnBox_both">
    <span class="leftzone"><button type="button" id="btnDeletePopup" class="btn_white_B02">선택삭제</button></span>
    <span class="rightzone"><button type="button" id="btnGoPopupCreatePage" class="btn_blue_B02">신규 팝업 등록</button></span>
</div>
<!-- 버튼 -->