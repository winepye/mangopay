<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 템플릿 목록 -->
<table id="menuTable" class="tb_basic_st" summary="기준값마스터 (기준코드, 기준값, 비고, 사용여부, 수정일, 수정자)">
    <caption>기준값마스터</caption>
    <colgroup>
        <col width="*" /> <!--기준코드-->
        <col width="80" /> <!--기준값-->
        <col width="*" /> <!--비고-->
        <col width="80" /> <!--사용여부-->
        <col width="90" /> <!--수정일-->
        <col width="100" /> <!--수정자-->
    </colgroup>
    <thead>
        <tr>
            <th scope="col">기준코드</th>
            <th scope="col">기준값</th>
            <th scope="col">비고</th>
            <th scope="col">사용여부</th>
            <th scope="col">수정일</th>
            <th scope="col">수정자</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var = "data" items="${result.baseValueMstrtVoList }">
            <tr>
                <td class="txt_title"><a href="javascript:fn_openDetailPop('${data.baseCd }')" ><c:out value="${data.baseCd }" /></a></td>
                <td class="txt_num">
                    <c:choose>
                    <c:when test="${fn:length(data.baseVal) > 10}">
                        <c:out value="${fn:substring(data.baseVal, 0, 8)}" />...
                    </c:when>
                    <c:otherwise>
                        <c:out value="${data.baseVal }" />
                    </c:otherwise>
                    </c:choose>
                </td>
                <td class="txt_left"><c:out value="${data.remark }" /></td>
                <td class="txt_eng"><c:out value="${data.useYn eq 'Y' ? '예' : '아니오' }" /></td>
                <td class="txt_date"><fmt:formatDate value="${data.updateDate}" pattern="yyyy/MM/dd"/></td>
                <td><c:out value="${data.editUserName }" /></td>
            </tr>
        </c:forEach>
        <c:if test="${fn:length(result.baseValueMstrtVoList) <= 0 }">
        <tr>
            <td class="nodata" colspan="6">조회된 데이터가 없습니다.</td>
        </tr>
        </c:if>
    </tbody>
</table>
<input type = "hidden" id = "listTotalCount" value="${baseValueMstrCriteria.totalRecordCount }" >
<!-- page -->
<div class="btnPageZoneWrap">
    <div class="btnPageZone" id="btnPageZone">
        <customTagUi:pagiNavigation paginationInfo="${baseValueMstrCriteria}" type="admin" jsFunction="fn_doSearch" />
    </div>
</div>

<!-- 메뉴관리화면 버튼 : S -->
<div class="bs_BtnBox_both">
    <span class="rightzone"><button type="button" id="btnCreate" class="btn_blue_B02">신규등록</button></span>
</div>
<!--/ 메뉴관리화면 버튼 : E /-->