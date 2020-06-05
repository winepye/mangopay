<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/daumEditorHeader.jsp"%>
<%@ include file="./js/qnaAnswerCreate_JS.jsp"%>
<!--
  * @Class Name  : qnaAnswerCreate.jsp
  * @Description : 1:1문의 작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<input type="hidden" id = "boardSeq" name = "boardSeq" value="<c:out value="${boardCriteria.searchBoardSeq }" />">
		<h3 class="h2_table_title">1:1문의 답변등록</h3>
       	<table id="templateProject" class="tb_left_st2" summary="내용, 노출여부">
           <caption>
               1:1문의 답변등록
           </caption>
           <colgroup>
               <col width="12%" />
               <col width="*" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row"><span class="redstar">*</span>답변</th>
                   <td>
                   		<jsp:include page="/WEB-INF/jsp/daumeditor/daumeditor.jsp" />
                   		<input type="hidden" id = "content" name = "content">
                   </td>
               </tr>
               <tr>
                   <th scope="row">노출여부</th>
                   <td>
                   		<customTagUi:code type="radio" cdGrp="YN_COMMON" name="openYn" id="openYn" cd="Y" prefix="<span class=radio_list>" postfix="</span>"/>
                   </td>
               </tr>
               <tr class = "addFileList">
                   <th scope="row">첨부파일</th>
                   <td>
                   		<customTagUi:fileUpload fileTypeCd="ETC"/>
                   </td>
               </tr>
           </tbody>
       </table>
		<!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <button type="button" id="btnGoQnaListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnCreateQna" class="btn_gray_B01">저장</button>
        </div>
        <!-- 버튼 -->

	</form>
	<form id = "moveFrm" name = "moveFrm" method = "post">
       <!-- 검색조건 유지를 위한 파라미터 :S -->
       <input type="hidden" name = "searchContentType" value='<c:out value="${boardCriteria.searchContentType }" />'>
       <input type="hidden" name = "searchContentText" value='<c:out value="${boardCriteria.searchContentText }" />'>
       <input type="hidden" name = "currentPageNo" value='<c:out value="${boardCriteria.currentPageNo }" />'>
       <input type="hidden" name = "searchBoardTypeCd" value='<c:out value="${boardCriteria.searchBoardTypeCd }" />'>
       <input type="hidden" name = "searchBoardSeq" value='<c:out value="${boardCriteria.searchBoardSeq }" />'>
       <input type="hidden" name = "searchQnaStatusCd" value='<c:out value="${boardCriteria.searchQnaStatusCd }" />'>
       <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
       <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>">
       <!-- 20개씩/40개씩/60개씩 보기 -->
       <input type="hidden" name = "recordCountPerPage" value='<c:out value="${boardCriteria.recordCountPerPage }" />'>
       <!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>
</section>