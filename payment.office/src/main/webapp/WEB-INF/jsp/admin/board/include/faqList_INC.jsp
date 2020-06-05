<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 템플릿 목록 -->
<table id="faqTable" class="tb_basic_st" summary="자주묻는질문 목록 (FAQ유형, 제목, 게시여부, 조회수, 작성자, 작성일)">
    <caption>FAQ목록</caption>
    <colgroup>
    	 <col width="50"> <!--체크박스-->
         <col width="*"> <!--FAQ유형-->
         <col width="*"> <!--제목-->
         <col width="80"> <!--게시여부-->
         <col width="80"> <!--조회수-->
         <col width="*"> <!--작성자-->
         <col width="100"> <!--작성일-->
    </colgroup>
	<thead>
        <tr>
            <th scope="col"><label for=""><input type="checkbox" id="deleteBoardSeq" name='allChk' onclick="fn_allCheck(this);" /><span class="blind">전체선택</span></label></th>
            <th scope="col">FAQ유형</th>
            <th scope="col">제목</th>
            <th scope="col">게시여부</th>
            <th scope="col">조회수</th>
            <th scope="col">작성자</th>
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
             <td class="txt_type01"><customTagUi:code type="text" cdGrp="FAQ_CATEG_CD" name="" cd="${data.categCd}" /></td>
             <td class="txt_title"><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
             <td class="txt_eng"><c:out value="${data.openYn eq 'Y' ? '예' : '아니오' }" /></td>
             <td class="countnum"><c:out value="${data.viewCnt }" /></td>
             <td><c:out value="${data.userName }" /></td>
             <td class="txt_date"><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
         </tr>
		</c:forEach>
		<c:if test="${fn:length(result.boardVolist) <= 0 }">
		<tr>
			<td class="nodata" colspan="7">조회된 데이터가 없습니다.</td>
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
<div class="bs_BtnBox_both">
    <span class="leftzone"><button type="button" id="btnDeleteFaq" class="btn_white_B02">선택삭제</button></span>
    <span class="rightzone"><button type="button" id="btnGoFaqCreatePage" class="btn_blue_B02">신규 FAQ 등록</button></span>
</div>
<!-- 버튼 -->
<input type = "hidden" id = "listTotalCount" value="${boardCriteria.totalRecordCount }" >