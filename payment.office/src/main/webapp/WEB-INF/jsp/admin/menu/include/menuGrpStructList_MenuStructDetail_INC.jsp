<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : menuStructDetail_INC.jsp.jsp
  * @Description : 메뉴구조상세
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.03	이인희      최초 생성
-->
<div class="frblock">
<c:choose>
	<c:when test="${menuGrpStructVo == null}">
		<table class="tb_left_st2">
			<colgroup>
				<col width="70px;" />
				<col width="100px" />
				<col width="10px" />
				<col width="200px" />
				<col width="20px" />
                <col width="20px" />
			</colgroup>
			<tbody>
				<tr>
					<tr>
			            <td colspan="6" style="text-align: center;">최상위 ROOT입니다.</td>
			        </tr>
				</tr>
			</tbody>
		</table>
	</c:when>
	<c:otherwise>

	    <h3 class="h3_table_title">메뉴그룹상세</h3>
	    <div class="bs_BtnBox_r">
	        <button type="button" onclick="fn_deleteMenuStruct()" class="btn_white_s01">삭제</button>
	        <button type="button" onclick="fn_modifyScreenNm()" class="btn_gray_s01">수정</button>
	    </div>
		<table class="tb_left_st2">
			<colgroup>
                <col width="120px;" />
                <col width="200px" />
                <col width="90px" />
                <col width="90px" />
                <col width="70px" />
                <col width="20px" />
            </colgroup>
			<tbody>
				<tr>
					<th scope="row">화면표시메뉴명</th>
					<td><input type="text" id="screenDisplayMenuNm" name="screenDisplayMenuNm" maxlength="100" class="input_s_b w100pro" value="${menuGrpStructVo.screenDisplayMenuNm }" /></td>
					<th scope="row">말단여부</th>
                    <td><customTagUi:code type="select" cdGrp="YN_COMMON" cd = "${menuGrpStructVo.nodeYn==null?'Y':menuGrpStructVo.nodeYn }" id="nodeYn" name="nodeYn" prefix="<label>" postfix="</label>"/></td>
                    <th scope="row">순서</th>
                    <td><input type="text" id="sortOrd" name="sortOrd" class="input_s_b w100pro" maxlength="100" value="${menuGrpStructVo.sortOrd }" /></td>
                </tr>
                <tr>
					<th scope="row">URL</th>
					<td colspan="5">${menuGrpStructVo.menuUrl}</td>
				</tr>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>

<!--/ 게시판 정렬목록 /-->
<div id = "menuGrpMenuListArea" style="width:100%;overflow-x:auto">
</div>
