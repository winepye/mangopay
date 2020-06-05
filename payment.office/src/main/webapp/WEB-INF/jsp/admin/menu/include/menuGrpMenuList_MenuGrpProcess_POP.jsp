<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : menuGrpProcess_INC.jsp
  * @Description : 메뉴 그룹 등록/수정
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.03	이인희      최초 생성
-->
<form id = "saveFrm" name = "saveFrm" method="post">
	<input type="hidden" name = "menuGrpSeq" id = "menuGrpSeq" value="${menuGrpVo.menuGrpSeq }">
	<table id="templateProject" class="tb_left_st2" summary="FAQ 등록, 제목, 카테고리, 내용, 노출여부">
	    <caption>
	        메뉴 그룹 등록/수정
	    </caption>
	    <colgroup>
	        <col width="20%" />
	        <col width="*" />
	    </colgroup>
	    <tbody>
	        <tr>
	            <th scope="row">
            		<label for="menuGrpNm">메뉴그룹명</label>
	            </th>
	            <td>
            		<input id="menuGrpNm" name="menuGrpNm" class="input_s_b w100pro" maxlength="100" placeholder="메뉴그룹명을 입력하세요." value="${menuGrpVo.menuGrpNm }"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row">
            		<label for="menuGrpDesc">메뉴그룹설명</label>
	            </th>
	            <td>
            		<input id="menuGrpDesc" name="menuGrpDesc" class="input_s_b w100pro" maxlength="100" placeholder="메뉴그룹설명을 입력하세요." value="${menuGrpVo.menuGrpDesc }"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row"><label for="menuLocationCd">메뉴위치</label></th>
	            <td>
	            	<customTagUi:code type="select" cdGrp="MENU_LOCATION_CD" cd="${menuGrpVo.menuLocationCd }" name="menuLocationCd" id="menuLocationCd" attr='class="sel_basic w240px"' subjectText="선택"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row"><label for="userTypeCd">회원유형코드</label></th>
	            <td>
	            	<customTagUi:code type="select" cdGrp="USER_TYPE_CD" cd="${menuGrpVo.userTypeCd }" name="userTypeCd" id="userTypeCd" attr='class="sel_basic w240px"' subjectText="선택"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row"><label for="menuGrpAuthTypeCd">메뉴그룹권한유형코드</label></th>
	            <td>
	            	<customTagUi:code type="select" cdGrp="MENU_GRP_AUTH_TYPE_CD" cd="${menuGrpVo.menuGrpAuthTypeCd }" name="menuGrpAuthTypeCd" id="menuGrpAuthTypeCd" attr='class="sel_basic w240px"' subjectText="선택"/>
	            	<!-- <select id = "menuGrpAuthTypeCd" name = "menuGrpAuthTypeCd" class="select_b">
	            	</select> -->
	            </td>
	        </tr>
			<tr>
	            <th scope="row">
	            	<label for="useYn">사용여부</label>
	            </th>
	            <td class="itemList">
	            	<customTagUi:code type="radio" cdGrp="YN_COMMON" cd = "${menuGrpVo==null?'Y':menuGrpVo.useYn }" name="useYn" id="useYn" prefix="<label>" postfix="</label>"/>
	            </td>
	        </tr>
	    </tbody>
	</table>
	<input type="hidden" id = "procMode" name = "procMode">
</form>
<!-- 버튼 -->
<div class="bs_BtnBox_c">
    <button type="button" id="btnCreateClose" class="btn_white_B01">닫기</button>
    <button type="button" id="btnSave" class="btn_gray_B01">저장</button>
</div>
<!-- 버튼 -->
