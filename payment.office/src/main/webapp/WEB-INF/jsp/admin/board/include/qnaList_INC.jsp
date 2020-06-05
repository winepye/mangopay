<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 템플릿 목록 -->
<table id="faqTable" class="tb_basic_st" summary="FAQ관리">
    <caption>FAQ목록</caption>
    <colgroup>
    	<col width="50px" />
        <col width="*" />
        <col width="100px" />
        <col width="100px" />
        <col width="100px" />
    </colgroup>
	<thead>
        <tr>
            <th scope="col"><label for=""><input type="checkbox" id="deleteBoardSeq" name='allChk' onclick="fn_allCheck(this);" /><span class="blind">전체선택</span></label></th>
            <th scope="col" >이름(업체명)</th>
            <th scope="col">연락처</th>
            <th scope="col">이메일주소</th>
            <th scope="col">작성일</th>

        </tr>
    </thead>
    <tbody>
		<c:forEach var = "data" items="${result.boardVolist }">
		<tr>
             <td>
           		<input type="checkbox" name = "deleteBoardSeq" value="<c:out value='${data.boardSeq }' />" onclick="javascript:fn_eachCheck(this);">
          		<span class="blind">선택</span>
             </td>
             <td class="txt_title"><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
             <td><c:out value='${data.userMobileNum }' /></td>
             <td><c:out value='${data.userEmailAddr }' /></td>
             <td><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
         </tr>
		</c:forEach>
		<c:if test="${fn:length(result.boardVolist) <= 0 }">
		<tr>
			<td class="nodata" colspan="6">조회된 데이터가 없습니다.</td>
		</tr>
		</c:if>
    </tbody>
</table>
<!-- page -->
<div class="btnPageZoneWrap">
	<div class="btnPageZone" id="btnPageZone">
		<customTagUi:pagiNavigation paginationInfo="${boardCriteria}" type="admin" jsFunction="fn_doSearch" />
	</div>
</div>
<!-- 버튼 -->
<!-- <div class="bs_BtnBox_l">
    <button type="button" id="btnDeleteQna" class="btn_white_B02">선택삭제</button>
</div> -->
<!-- 버튼 -->
<input type = "hidden" id = "listTotalCount" value="${boardCriteria.totalRecordCount }" >