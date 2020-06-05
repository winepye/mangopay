<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : menuCreate_INC.jsp
  * @Description : 메뉴 등록/수정
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.03	이인희      최초 생성
-->
<form id = "saveFrm" name = "saveFrm" method="post">
	<input type="hidden" name = "menuSeq" id = "menuSeq">
	<table id="templateProject" class="tb_left_st2" summary="FAQ 등록, 제목, 카테고리, 내용, 노출여부">
        <caption>메뉴 등록/수정</caption>
        <colgroup>
            <col width="150" />
            <col width="*" />
        </colgroup>
	    <tbody>
	        <tr>
                <th scope="row">
                    <label for="menuNm"><span class="redstar">*</span>메뉴명</label>
                </th>
                <td>
                    <input id="menuNm" name="menuNm" class="input_s_b w100pro" maxlength="100" placeholder="제목을 입력하세요." value="${menuVo.menuNm }"/>
                </td>
            </tr>
	        <tr>
	            <th scope="row">
            		<label for="menuDesc"><span class="redstar">*</span>메뉴설명</label>
	            </th>
	            <td>
            		<input id="menuDesc" name="menuDesc" class="input_s_b w100pro" maxlength="100" placeholder="메뉴설명을 입력하세요." value="${menuVo.menuDesc }"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row"><label for="businessTypeCd"><span class="redstar">*</span>업무유형</label></th>
	            <td>
            		<customTagUi:code type="select" cdGrp="BUSINESS_TYPE_CD" cd="${menuVo.businessTypeCd }" name="businessTypeCd" id="businessTypeCd" attr='class="sel_basic w240px"' subjectText="선택"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row"><label for="menuTypeCd"><span class="redstar">*</span>메뉴유형</label></th>
	            <td>
            		<customTagUi:code type="select" cdGrp="MENU_TYPE_CD" cd="${menuVo.menuTypeCd }" name="menuTypeCd" id = "menuTypeCd" attr='class="sel_basic w240px"' subjectText="선택"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row"><label for="menuLocationCd"><span class="redstar">*</span>메뉴위치</label></th>
	            <td>
	            	<customTagUi:code type="select" cdGrp="MENU_LOCATION_CD" cd="${menuVo.menuLocationCd }" name="menuLocationCd" id="menuLocationCd" attr='class="sel_basic w240px"' subjectText="선택"/>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row">
            		<label for="menuUrl"><span class="redstar">*</span>메뉴URL</label>
	            </th>
	            <td>
            		<input id="menuUrl" name="menuUrl" class="input_s_b w100pro" maxlength="100" placeholder="메뉴URL을 입력하세요." value="${menuVo.menuUrl }" />
	            </td>
	        </tr>
	        <tr>
	            <th scope="row">
	            	<label for="representMenuYn"><span class="redstar">*</span>대표메뉴여부</label>
	            </th>
	            <td><c:if test="${menuVo.grpMenuListUseYn ne 'Y' }">
	            	<customTagUi:code type="radio" cdGrp="YN_COMMON" cd = "${menuVo==null?'Y':menuVo.representMenuYn }" name="representMenuYn" id="representMenuYn" prefix="<label>" postfix="</label>"/>
	            	</c:if>
	            	<c:if test="${menuVo.grpMenuListUseYn eq 'Y' }">
                        <customTagUi:code type="text" cdGrp="YN_COMMON" cd = "${menuVo==null?'Y':menuVo.representMenuYn }" name="representMenuYn" id="representMenuYn" prefix="<label>" postfix="</label>"/>
                        <input type="hidden" name = "representMenuYn" value="${menuVo.representMenuYn }">
                        <br>*구조화된 메뉴입니다.<br> 대표메뉴여부를 변경하시려면 메뉴그룹구조관리에서 사용여부를 체크하세요.
                    </c:if>
	            </td>
	        </tr>
	        <tr>
	            <th scope="row">
	            	<label for="useYn"><span class="redstar">*</span>사용여부</label>
	            </th>
	            <td>
	            	<customTagUi:code type="radio" cdGrp="YN_COMMON" cd = "${menuVo==null?'Y':menuVo.useYn }" name="useYn" id="useYn" prefix="<label>" postfix="</label>"/>
	            </td>
	        </tr>
            <tr>
                <th scope="row">
                    <label for="loginYn"><span class="redstar">*</span>로그인필요여부</label>
                </th>
                <td>
                    <customTagUi:code type="radio" cdGrp="YN_COMMON" cd = "${menuVo==null?'Y':menuVo.loginYn }" name="loginYn" id="loginYn" prefix="<label>" postfix="</label>"/>
                </td>
            </tr>
            <tr>
                <th scope="row">
                    <label for="screenDesc">화면표시메뉴설명</label>
                </th>
                <td>
                    <input id="screenDesc" name="screenDesc" class="input_s_b w100pro" maxlength="100" placeholder="화면표시메뉴설명을 입력하세요." value="${menuVo.screenDesc }"/>
                </td>
            </tr>
	        <tr>
	            <th scope="row">
            		<label for="sortOrd"><span class="redstar">*</span>정렬순서</label>
	            </th>
	            <td>
            		<input id="sortOrd" name="sortOrd" class="input_s_b w240px" maxlength="3" value="0" style="width: 70px;" value="${menuVo.sortOrd }"/>
	            </td>
	        </tr>
	    </tbody>
	</table>
</form>

<!-- 버튼 -->
<div class="bs_BtnBox_c">
    <button type="button" id="btnCreateClose" class="btn_white_B01">닫기</button>
    <button type="button" id="btnSave" class="btn_gray_B01">저장</button>
</div>
<!-- 버튼 -->
