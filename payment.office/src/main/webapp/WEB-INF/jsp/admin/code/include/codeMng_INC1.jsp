<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<form id = "codeFrm" name = "codeFrm" method="post">
    <table id="codeTable" class="tb_basic_st" summary="코드관리(코드, 코드명, 정렬순서, 비고, 사용여부, 삭제)" arrayVoName="codeVoList" >
        <caption>코드</caption>
        <colgroup>
            <col width="*" /> <!--코드-->
            <col width="*" /> <!--코드명-->
            <col width="110" /> <!--정렬순서-->
            <col width="*" /> <!--비고-->
            <col width="80" /> <!--사용여부-->
            <col width="60" /> <!--삭제-->
        </colgroup>
        <thead>
            <tr>
                <th scope="col">코드</th>
                <th scope="col">코드명</th>
                <th scope="col">정렬순서</th>
                <th scope="col">비고</th>
                <th scope="col">사용여부</th>
                <th scope="col">삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var = "data" items="${result.codeVoList }" varStatus="i">
            <tr id="codeTableTr">
                 <td><input type="text" id="cd"       name="cd"       class="input_s_b w100pro" value="<c:out value="${data.cd     }" />" placeholder="코드 입력"></td>
                 <td><input type="text" id="cdNm"     name="cdNm"     class="input_s_b w100pro" value="<c:out value="${data.cdNm   }" />" placeholder="코드명 입력"></td>
                 <td><input type="text" id="sortOrd"  name="sortOrd"  class="input_s_b w100pro" value="<c:out value="${data.sortOrd}" />" placeholder="정렬순서 입력"></td>
                 <td><input type="text" id="remark"   name="remark"   class="input_s_b w100pro" value="<c:out value="${data.remark }" />" placeholder="비고 입력"></td>
                 <td><customTagUi:code type="select" cdGrp="YN_COMMON" cd = "${data==null?'Y':data.useYn }" id="codeUseYn" name="useYn" attr='class="sel_basic w100pro"' /></td>
                 <td><button type="button" class="btn_grayline" onclick="javascript:fn_deleteRowCode(this);">삭제</button></td>
             </tr>
            </c:forEach>
            <c:if test="${fn:length(result.codeVoList) <= 0 }">
            <tr>
                <td id="codeTableNoData" class="nodata" colspan="6">조회된 데이터가 없습니다.</td>
            </tr>
            </c:if>
        </tbody>
    </table>

    <input type="hidden" name="cdGrp" value="">
</form>