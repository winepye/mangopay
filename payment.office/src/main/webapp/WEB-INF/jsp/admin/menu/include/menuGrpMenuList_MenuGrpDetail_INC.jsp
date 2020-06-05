<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : menuGrpDetail_INC.jsp
  * @Description : 메뉴상세
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.03	이인희      최초 생성
-->
<h2 class="h2_table_title mgt30"><span class="lspwide">${menuGrpVo.menuGrpNm }</span> <button type="button" id="btnModify" class="btn_grayline">수정</button></h2>
<table class="tb_left_st2">
	<colgroup>
		<col width="12%" />
		<col width="*%" />
		<col width="12%" />
		<col width="*%" />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">그룹명</th>
			<td>${menuGrpVo.menuGrpNm }</td>
			<th scope="row">메뉴위치</th>
			<td class="txt_eng">
			     <customTagUi:code type="text" cdGrp="MENU_LOCATION_CD" name="menuLocationCd" cd="${menuGrpVo.menuLocationCd }" />
			</td>
		</tr>
		<tr>
			<th scope="row">메뉴그룹설명</th>
			<td colspan="3">${menuGrpVo.menuGrpDesc }</td>
		</tr>
		<tr>
			<th scope="row">회원 유형</th>
			<td>
			     <c:if test="${menuGrpVo.userTypeCd eq 'NONMEMBER'}">
			         비로그인
			     </c:if>
			     <customTagUi:code type="text" cdGrp="USER_TYPE_CD" name="userTypeCd" cd="${menuGrpVo.userTypeCd }" />
			</td>
			<th scope="row">사용여부</th>
			<td class="txt_eng">${menuGrpVo.useYn }</td>
		</tr>
		<tr>
			<th scope="row">등록자</th>
			<td>${menuGrpVo.regUserName }</td>
			<th scope="row">등록일</th>
			<td class="txt_date"><fmt:formatDate value="${menuGrpVo.createDate }" pattern="yyyy/MM/dd"/></td>
		</tr>
		<tr>
			<th scope="row">수정자</th>
			<td>${menuGrpVo.editUserName }</td>
			<th scope="row">수정일</th>
			<td class="txt_date"><fmt:formatDate value="${menuGrpVo.updateDate }" pattern="yyyy/MM/dd"/></td>
		</tr>
	<!-- 	<tr>
			<td colspan="4">
				<div class="board_classic">
					<div class="rightblock">
						<a href="#" class="btn_wh_bevel" id = "btnModify">수정</a>
					</div>
				</div>
			</td>
		</tr> -->
	</tbody>
</table>