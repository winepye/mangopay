<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<!--
  * @Class Name  : mposAppModify.jsp
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.27	    이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">MPOS 버전 수정</h3>
       	<table id="templateProject" class="tb_left_st2" summary="MPOS 버전 수정">

           <caption>
               MPOS 버전 수정
           </caption>
           <colgroup>
               <col width="20%" />
               <col width="30" />
               <col width="20%" />
               <col width="30%" />
           </colgroup>
           <tbody>

               <tr>
                   <th scope="row"><label for="mobileType"><span class="redstar">*</span>모바일타입</label></th>
                   <td>
                       <customTagUi:code type="radio" cdGrp="MOBILE_TYPE" name="mobileType" id="mobileType"
                                         cd="${result.mobileType}"
                                         prefix="<span class=radio_list>" postfix="</span>"/>
                   </td>
                   <th scope="row"><label for="appName"><span class="redstar">*</span>APP명</label></th>
                   <td>
                       <input type="text" class="input_s_b w100pro" name="appName" id="appName" value="${result.appName}" onkeyup="chkword(this, 100)">
                   </td>

               </tr>

               <tr>
                   <th scope="row"><label for="appUpdateMethod"><span class="redstar">*</span>APP 업데이트방식</label></th>
                   <td>
                       <customTagUi:code type="radio" cdGrp="APP_UPDATE_METHOD" name="appUpdateMethod" id="appUpdateMethod" cd="${result.appUpdateMethod}"
                                         prefix="<span class=radio_list>" postfix="</span>"/>
                   </td>
                   <th scope="row"><label for="appVersion"><span class="redstar">*</span>버전</label></th>
                   <td>
                       <input type="text" class="input_s_b w100pro" id="appVersion" name="appVersion" value="${result.appVersion}" onkeyup="chkword(this, 20)" >
                   </td>
               </tr>

               <tr>
                   <th scope="row"><label for="packageName"><span class="redstar">*</span>패키지명</label></th>
                   <td>
                       <input type="text" class="input_s_b w100pro" id="packageName" name="packageName" value="${result.packageName}" onkeyup="chkword(this, 255)">
                   </td>
                   <th scope="row"><label for="updateLink"><span class="redstar">*</span>업데이트링크</label></th>
                   <td>
                       <input type="text" class="input_s_b w100pro" id="updateLink" name="updateLink" value="${result.updateLink}" onkeyup="chkword(this, 255)">
                   </td>
               </tr>

               <tr>
                   <th scope="row">사용여부</th>
                   <td colspan="3" class="itemList">
                       <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="${result.useYn}"
                                         prefix="<span class=radio_list>" postfix="</span>"/>
                   </td>
               </tr>

           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnGoPreviousPage" class="btn_white_B01" onclick="javascript:history.back();">취소</button>
            <button type="button" id="btnModify" class="btn_gray_B01">수정완료</button>
        </div>
		<!-- 버튼 -->

        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchAppName" value='<c:out value="${search.searchAppName }" />'>
        <input type="hidden" name="searchType" value='<c:out value="${search.searchType }" />'>
        <input type="hidden" name="searchSdate" value='<c:out value="${search.searchSdate }" />'>
        <input type="hidden" name="searchEdate" value='<c:out value="${search.searchEdate }" />'>


        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${search.currentPageNo }" />'>
        <input type="hidden" name="sortOrder" value='<c:out value="${search.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

        <input type="hidden" id="appVersionId" name="appVersionId" value="${result.appVersionId}">

	</form>

</section>

<%@ include file="js/mposAppModify_JS.jsp"%>