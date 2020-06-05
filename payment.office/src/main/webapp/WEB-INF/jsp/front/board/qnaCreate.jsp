<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/daumEditorHeader.jsp"%>
<%@ include file="js/qnaCreate_JS.jsp"%>
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />
<section id="contents">
<form id = "frm" name = "frm" method="post">
	<table class ="board_regist_st01 mgt40" summary="공지사항 입력(문의유형, 제목, 내용, 첨부파일, 공개설정)">
		<caption>공지사항입력</caption>
		<colgroup>
			<col width="12%" />
            <col width="*" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">문의유형</th>
				<td class="itemList">
                    <customTagUi:code type="radio" cdGrp="QNA_CATEG_CD" name="categCd" prefix="<label>" postfix="</label>"/>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="title">제목</label></th>
				<td class="inquiry_title"><label><input type="text" id="title" class="input_s_b w100pro" name = "title" placeholder="제목을 입력해주세요." /></label></td>
			</tr>
			<tr>
				<th scope="col"><label for="#">내용</label></th>
				<td>
					<jsp:include page="/WEB-INF/jsp/daumeditor/daumeditor.jsp" />
					<input type="hidden" id = "content" name = "content">
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="Add_Files">파일첨부</label></th>
				<td class="addFileList">
					<customTagUi:fileUpload fileTypeCd="ETC" maxCount="3" maxVolume="8"/>
					<p class="file_notice">* 전체 최대용량 8MB, 이미지파일은 최대 3개까지 첨부 가능합니다.</p>
				</td>
			</tr>
		</tbody>
	</table>
	<!--게시판페이지버튼-->
	<div class="bs_BtnBox_c">
		<button type="button" class="btn_white_B01" id = "btnCancel">취소</button>
		<button type="button" class="btn_blue_B01 mgl10" id = "btnSave">문의하기</button>
	</div>
</form>
<form id = "moveFrm" name = "moveFrm" method = "post">
      <!-- 검색조건 유지를 위한 파라미터 :S -->
      <input type="hidden" name = "searchContentType" value='<c:out value="${boardCriteria.searchContentType }" />'>
      <input type="hidden" name = "searchContentText" value='<c:out value="${boardCriteria.searchContentText }" />'>
      <input type="hidden" name = "currentPageNo" value='<c:out value="${boardCriteria.currentPageNo }" />'>
      <input type="hidden" name = "searchBoardTypeCd" value='<c:out value="${boardCriteria.searchBoardTypeCd }" />'>
      <input type="hidden" name = "searchFromDtS" value='<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>'>
      <input type="hidden" name = "searchToDtS" value='<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>'>
      <!-- 검색조건 유지를 위한 파라미터 :E -->
</form>
</section>