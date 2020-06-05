<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/daumEditorHeader.jsp"%>
<%@ include file="./js/popupCreate_JS.jsp"%>
<!--
  * @Class Name  : popupCreate.jsp
  * @Description : 팝업 작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2016.07.20	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">팝업 등록</h3>
       	<table id="templateProject" class="tb_left_st2" summary="팝업 등록, 제목, 공지유형, 내용, 노출여부">
           <caption>
               팝업 등록
           </caption>
           <colgroup>
              <col width="12%" /> <!--팝업기간-->
              <col width="25%" /> <!--*-->
              <col width="12%" /> <!--당첨자발표-->
              <col width="25%" /> <!--*-->
              <col width="12%" /> <!--팝업여부-->
              <col width="14%" /> <!--*-->
          </colgroup>
           <tbody>
               <tr>
                   <th scope="row">
                   		<label for="title"><span class="redstar">*</span>팝업 제목</label>
                   </th>
                   <td>
                   		<input id="title" name="title" class="input_s_b w100pro" maxlength="100" placeholder="제목을 입력해주세요" />
                   </td>
                   <th scope="row">
                        <label for="popupLvlTypeCd"><span class="redstar">*</span>팝업등급유형코드</th>
                   <td>
                        <customTagUi:code type="select" cdGrp="POPUP_LVL_TYPE_CD" name="popupLvlTypeCd" id="popupLvlTypeCd" attr='class="sel_basic w200px"' subjectText="선택"/>
                   </td>
               </tr>
               <tr>
                   <th scope="row"><label for="popupStartDtS"><span class="redstar">*</span>팝업기간</label></th>
                   <td>
                   		<input id="popupStartDtS" name="popupStartDtS" class="input_s_b w_date" maxlength="10" /> <span>~</span> <input id="popupEndDtS" name="popupEndDtS" class="input_s_b w_date" maxlength="10" />
                   </td>
                   <th scope="row">
                   		<label for="popupYn"><span class="redstar">*</span>팝업 여부</label>
                   </th>
                   <td>
                   		<customTagUi:code type="select" cdGrp="YN_COMMON" name="popupYn" id="popupYn" attr='class="sel_basic"' subjectText="선택" />
                   </td>
               </tr>
               <tr>
                   <th scope="row"><label for="content"><span class="redstar">*</span>내용</label></th>
                   <td colspan="5">
                   		<jsp:include page="/WEB-INF/jsp/daumeditor/daumeditor.jsp" flush="true"/>
                   		<input type="hidden" id = "content" name = "content">
                   </td>
               </tr>
           </tbody>
       </table>
       <!-- 버튼 -->
       <div class="bs_BtnBox_c">
	         <button type="button" id="btnGoPopupListPage" class="btn_white_B01">목록</button>
	         <button type="button" id="btnCreatePopup" class="btn_gray_B01">저장</button>
	   </div>
	   <!-- 버튼 -->


	</form>
	<form id = "moveFrm" name = "moveFrm" method = "post">
       <!-- 검색조건 유지를 위한 파라미터 :S -->
       <input type="hidden" name = "searchContentText" value='<c:out value="${popupCriteria.searchContentText }" />'>
       <input type="hidden" name = "currentPageNo" value='<c:out value="${popupCriteria.currentPageNo }" />'>
       <input type="hidden" name = "searchPopupYn" value='<c:out value="${popupCriteria.searchPopupYn }" />'>
       <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${popupCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
       <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${popupCriteria.searchToDt}" pattern="yyyy/MM/dd"/>">
       <!-- 20개씩/40개씩/60개씩 보기 -->
       <input type="hidden" name = "recordCountPerPage" value='<c:out value="${popupCriteria.recordCountPerPage }" />'>
       <!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>
</section>