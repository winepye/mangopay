<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : generalReportList_JS.jsp
  * @Description : admin > generalReportList_JS
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.09	이인희      최초 생성
-->

<table id="reportTable" class="tb_basic_st" summary="일반리포트 목록 (등록일, 산업분류, 등급, 제목, 투자의견, 분석일주가, 현재주가, 작성자, 분석일, 조회수)">
    <caption>일반리포트 목록</caption>
    <colgroup>
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
		<col width="*"    />
    </colgroup>
    <thead>
        <tr>
          <th scope="col">가맹점명</th>
          <th scope="col">CAT ID</th>
          <th scope="col">거래고유번호</th>
          <th scope="col">거래일시</th>
          <th scope="col">진행상태</th>
          <th scope="col">발급사</th>
          <th scope="col">매입사</th>
          <th scope="col">승인번호</th>
          <th scope="col">금액(원)</th>
          <th scope="col">응답코드</th>
          <th scope="col">응답메시지</th>
          <th scope="col">승인취소</th>
        </tr>
    </thead>

    <tbody>
        <c:forEach var = "data" items="${result.reportVolist }" varStatus="i">
            <tr style="cursor:pointer;" onmouseenter="$(this).addClass('selected')" onmouseleave="$(this).removeClass()">
	          <td class="type01"><a href="javascript:fn_openDetailPage('${data.txId }');" ><strong><c:out value='${data.storeName }' /></strong></a></td>
	          <td><c:out value='${data.catId }' /></td>
	          <td><c:out value='${data.transSeqno }' /></td>
	          <td><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
	          <td><c:out value='${data.processStatusNameAdmin }' /></td>
	          <td><c:out value='${data.issuerName }' /></td>
	          <td><c:out value='${data.accepterName }' /></td>
	          <td class="type02"><c:out value='${data.approvalNumber }' /></td>
	          <td class="type03"><fmt:formatNumber value="${data.approvalAmount  }" pattern="#,###" /></td>
	          <td class="type02"><c:out value='${data.resultCode }' /></td>
	          <td class="type02"><c:out value='${data.resultMessage }' /></td>
	          <td>
	              <c:if test="${(data.processStatus eq 'APPROVE_COMPLETE' || data.processStatus eq 'CANCEL_REQUEST')
	                                   && (data.resultCode eq '0000')}">
	                  <button id="aaa" class="btn_white_B01" onclick="cancelApprove('${data.txId }'); return false;">승인취소</button>
	              </c:if>
	          </td>
	        </tr>
        </c:forEach>
        <c:if test="${fn:length(result.reportVolist) <= 0 }">
            <tr>
                <td class="nodata" colspan="11">조회된 데이터가 없습니다.</td>
            </tr>
        </c:if>
    </tbody>
</table>

<!--게시판페이지버튼-->
<div class="btnPageZoneWrap">
    <div class="btnPageZone" id="btnPageZone">
        <customTagUi:pagiNavigation paginationInfo="${serviceCriteria}" type="admin" jsFunction="fn_doSearch" />
    </div>
</div>
<!--//게시판페이지버튼//-->

<INPUT TYPE="hidden" id="listTotalCntHidden" value="${serviceCriteria.totalRecordCount } 건">