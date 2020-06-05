<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : baseValueMstrList_POP.jsp
  * @Description : 기준마스터 코드 상세/등록/수정
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.08.03    이인희      최초 생성
-->
<form id = "saveFrm" name = "saveFrm" method="post">
    <table id="templateProject" class="tb_left_st2" summary="기준마스터 등록/수정 (기준코드, 기준값, 비고, 사용여부)">
        <caption>기준마스터 상세/등록/수정</caption>
        <colgroup>
            <col width="120" />
            <col width="*" />
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">
                    <label for="baseCd"><span class="redstar">*</span>기준코드</label>
                </th>
                <td>
                    <c:choose>
                        <c:when test="${empty baseValueMstrVo.baseCd}">
                            <input id="baseCd" name="baseCd" class="input_s_b w100pro" maxlength="50" placeholder="기준코드를 입력하세요." value="${baseValueMstrVo.baseCd }"/>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${baseValueMstrVo.baseCd }" />
                            <input type="hidden"  id="baseCd" name="baseCd"  value="${baseValueMstrVo.baseCd }"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th scope="row">
                    <label for="baseVal"><span class="redstar">*</span>기준값</label>
                </th>
                <td>
                    <input id="baseVal" name="baseVal" class="input_s_b w100pro" maxlength="255" placeholder="기준값을 입력하세요." value="${baseValueMstrVo.baseVal }"/>
                </td>
            </tr>
            <tr>
                <th scope="row">
                    <label for="remark">비고</label>
                </th>
                <td>
                    <input id="remark" name="remark" class="input_s_b w100pro" maxlength="100" placeholder="비고를 입력하세요." value="${baseValueMstrVo.remark }"/>
                </td>
            </tr>
            <tr>
                <th scope="row">
                    <label for="useYn"><span class="redstar">*</span>사용여부</label>
                </th>
                <td class="itemList">
                    <customTagUi:code type="radio" cdGrp="YN_COMMON" cd = "${baseValueMstrVo==null?'Y':baseValueMstrVo.useYn }" name="useYn" prefix="<label>" postfix="</label>"/>
                </td>
            </tr>
        </tbody>
    </table>
</form>
<!-- 메뉴 등록/수정 팝업 버튼 -->
<div class="bs_BtnBox_c">
    <button type="button" id="btnCreateClose" class="btn_white_B01">닫기</button>
    <button type="button" id="btnSave" class="btn_gray_B01">저장</button>
    <c:if test="${not empty baseValueMstrVo.baseCd}">
    <button type="button" id="btnDelete" class="btn_gray_B01">삭제</button>
    </c:if>
</div>
<!--/ 메뉴 등록/수정 팝업 버튼 /-->
