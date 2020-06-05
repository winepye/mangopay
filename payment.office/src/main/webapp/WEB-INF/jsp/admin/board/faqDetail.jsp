<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/faqDetail_JS.jsp"%>
<!--
  * @Class Name  : faqCreatePage.jsp
  * @Description : FAQ작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">FAQ 상세</h3>
       	<table id="templateProject" class="tb_left_st2" summary="FAQ 등록, 제목, FAQ유형, 내용, 노출여부">
           <caption>
               FAQ 상세
           </caption>
           <colgroup>
               <col width="12%" />
               <col width="*" />
               <col width="12%" />
               <col width="*" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row">
                   		<label for="title">제목</label>
                   </th>
                   <td>
                   		<c:out value="${faqBoardVo.title }" />
                   </td>
                   <th scope="row">FAQ유형</th>
                   <td>
                   		<customTagUi:code type="text" cdGrp="FAQ_CATEG_CD" name="" cd="${faqBoardVo.categCd}" />
                   </td>
               </tr>
               <tr>
               		<th scope="row">
                   		<label for="title">작성자</label>
                   </th>
                   <td>
                   		<c:out value="${faqBoardVo.userName }" />
                   </td>
                   <th scope="row">작성일</th>
                   <td>
                        <fmt:formatDate value="${faqBoardVo.createDate}" pattern="yyyy/MM/dd"/>
                   </td>
               </tr>
               <tr>
                   <th scope="row">내용</th>
                   <td colspan="3">
                   		<div class="editorContent"><c:out value="${faqBoardVo.content }" escapeXml="false"/></div>
                   </td>
               </tr>
               <tr>
                   <th scope="row">노출여부</th>
                   <td colspan="3">
                   		<customTagUi:code type="text" cdGrp="YN_COMMON" name="" cd="${faqBoardVo.openYn}" />
                   </td>
               </tr>

               <tr>
                   <th scope="row">첨부파일</th>
                   <td colspan="3">
                   		<customTagUi:fileView atchFileGrpSeq = "${faqBoardVo.atchFileGrpSeq }" fileTypeCd="ETC"/>
                   </td>
               </tr>
           </tbody>
       </table>

	   <!-- 버튼 -->
       <div class="bs_BtnBox_c">
           <button type="button" id="btnGoFaqListPage" class="btn_white_B01">목록</button>
           <button type="button" id="btnGoFaqModifyPage" class="btn_gray_B01">수정</button>
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
       <input type="hidden" name = "searchCategCd" value='<c:out value="${boardCriteria.searchCategCd }" />'>
       <input type="hidden" name = "searchOpenYn" value='<c:out value="${boardCriteria.searchOpenYn }" />'>
       <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
       <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>">
       <!-- 20개씩/40개씩/60개씩 보기 -->
       <input type="hidden" name = "recordCountPerPage" value='<c:out value="${boardCriteria.recordCountPerPage }" />'>
       <!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>
</section>