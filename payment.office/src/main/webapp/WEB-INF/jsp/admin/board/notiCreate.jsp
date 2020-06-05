<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/daumEditorHeader.jsp"%>
<%@ include file="./js/notiCreate_JS.jsp"%>
<!--
  * @Class Name  : notiCreatePage.jsp
  * @Description : 공지사항 작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">공지사항 등록</h3>
       	<table id="templateProject" class="tb_left_st2" summary="공지사항 등록, 제목, 공지유형, 내용, 노출여부">
           <caption>
               공지사항 등록
           </caption>
           <colgroup>
               <col width="12%" />
               <col width="*" />
               <col width="12%" />
               <col width="20%" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row">
                   		<label for="title"><span class="redstar">*</span>제목</label>
                   </th>
                   <td>
                   		<input id="title" name="title" class="input_s_b w100pro" maxlength="100" placeholder="제목을 입력하세요." />
                   </td>
                   <th scope="row">
                   		<label for="categCd"><span class="redstar">*</span>공지유형</th>
                   <td>
                        <customTagUi:code type="select" cdGrp="NOTI_CATEG_CD" name="categCd" id="categCd" attr='class="sel_basic w200px"' subjectText="선택"/>
                   </td>
               </tr>
               <tr>
                   <th scope="row"><label for="topStartDtS"><span class="redstar">*</span>탑공지기간</label></th>
                   <td>
                   		<input id="topStartDtS" name="topStartDtS" class="input_s_b w_date" maxlength="10" />
                   		<span>~</span>
                   		<input id="topEndDtS" name="topEndDtS" class="input_s_b w_date" maxlength="10" />
                   </td>
                   <th scope="row"><label for="openYn">게시여부</label></th>
                   <td>
                   		<customTagUi:code type="radio" cdGrp="YN_COMMON" name="openYn" id="openYn" cd="Y"/>
                   </td>
               </tr>
               <tr>
                   <th scope="row"><span class="redstar">*</span>내용</th>
                   <td colspan="3">
                   		<jsp:include page="/WEB-INF/jsp/daumeditor/daumeditor.jsp" flush="true"/>
                   		<input type="hidden" id = "content" name = "content">
                   </td>
               </tr>
               <tr class = "addFileList">
                   <th scope="row">첨부파일</th>
                   <td colspan="3">
                   		<customTagUi:fileUpload fileTypeCd="ETC"/>
                   </td>
               </tr>
           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoNotiListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnCreateNoti" class="btn_gray_B01">저장</button>
        </div>
		<!-- 버튼 -->

	</form>
	<form id = "moveFrm" name = "moveFrm" method = "post">
       <!-- 검색조건 유지를 위한 파라미터 :S -->
       <input type="hidden" name = "searchContentType" value='<c:out value="${boardCriteria.searchContentType }" />'>
       <input type="hidden" name = "searchContentText" value='<c:out value="${boardCriteria.searchContentText }" />'>
       <input type="hidden" name = "currentPageNo" value='<c:out value="${boardCriteria.currentPageNo }" />'>
       <input type="hidden" name = "searchBoardTypeCd" value='<c:out value="${boardCriteria.searchBoardTypeCd }" />'>
       <input type="hidden" name = "searchOpenYn" value='<c:out value="${boardCriteria.searchOpenYn }" />'>
       <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
       <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>">
       <!-- 20개씩/40개씩/60개씩 보기 -->
       <input type="hidden" name = "recordCountPerPage" value='<c:out value="${boardCriteria.recordCountPerPage }" />'>
       <!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>
</section>