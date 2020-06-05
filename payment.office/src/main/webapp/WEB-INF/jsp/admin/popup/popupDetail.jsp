<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/popupDetail_JS.jsp"%>
<!--
  * @Class Name  : popupDetail.jsp
  * @Description : 팝업작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2016.07.20	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">팝업 상세</h3>
       	<table id="templateProject" class="tb_left_st2" summary="팝업 등록, 제목, 공지유형, 내용, 노출여부">
           <caption>
               팝업 상세
           </caption>
           <colgroup>
               <col width="12%" />
               <col width="25%" />
               <col width="12%" />
               <col width="25%" />
               <col width="12%" />
               <col width="14%" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row"><label for="title">팝업 제목</label></th>
                   <td>
                   		<c:out value="${popupVo.title }" />
                   </td>
                   <th scope="row"><label for="categCd">공지유형</label></th>
                   <td>
                        <customTagUi:code type="text" cdGrp="POPUP_LVL_TYPE_CD" name="" cd="${popupVo.popupLvlTypeCd}" />
                   </td>
               </tr>
               <tr>
                   <th scope="row"><label for="categCd">팝업기간</label></th>
                   <td>
                        <fmt:formatDate value="${popupVo.popupStartDt}" pattern="yyyy/MM/dd"/> ~ <fmt:formatDate value="${popupVo.popupEndDt}" pattern="yyyy/MM/dd"/>
                   </td>
                   <th scope="row"><label for="title">팝업 여부</label></th>
                   <td>
                   		<c:out value="${popupVo.popupYn eq 'Y' ? '예' : '아니오' }" />
                   </td>
               </tr>
               <tr>
                   <th scope="row">내용</th>
                   <td colspan="5">
                   		<div class="editorContent"><c:out value="${popupVo.content }" escapeXml="false"/></div>
                   </td>
               </tr>

           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
           <button type="button" id="btnGoPopupListPage" class="btn_white_B01">목록</button>
           <button type="button" id="btnGoPopupModifyPage" class="btn_gray_B01">수정</button>
       </div>
		<!-- 버튼 -->
	</form>
	<form id = "moveFrm" name = "moveFrm" method = "post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name = "searchContentText" value='<c:out value="${popupCriteria.searchContentText }" />'>
        <input type="hidden" name = "searchPopupYn" value='<c:out value="${popupCriteria.searchPopupYn }" />'>
        <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${popupCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
        <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${popupCriteria.searchToDt}" pattern="yyyy/MM/dd"/>">
        <!-- 상세 -->
        <input type="hidden" name = "searchPopupSeq" value='<c:out value="${popupCriteria.searchPopupSeq }" />'>
        <!-- 페이징 -->
        <input type="hidden" name = "currentPageNo" value='<c:out value="${popupCriteria.currentPageNo }" />'>
        <input type="hidden" name = "recordCountPerPage" value='<c:out value="${popupCriteria.recordCountPerPage }" />'>
       <!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>
</section>