<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 템플릿 목록 -->
<table id="notiTable" class="tb_basic_st" summary="공지사항 List (공지유형, 제목, 탑공지기간, 게시여부, 조회수, 작성자, 작성일)">
    <caption>공지사항 List</caption>
    <colgroup>
       <col width="50"> <!--체크박스-->
       <col width=""> <!--공지유형-->
       <col width=""> <!--제목-->
       <col width="*"> <!--탑공지기간-->
       <col width=""> <!--게시여부-->
       <col width=""> <!--조회수-->
       <col width=""> <!--작성자-->
       <col width=""> <!--작성일-->
    </colgroup>
	<thead>
        <tr>
            <th scope="col"><label for=""><input type="checkbox" id="deleteBoardSeq" name='allChk' onclick="fn_allCheck(this);" /><span class="blind">전체선택</span></label></th>
            <th scope="col">공지유형</th>
            <th scope="col">제목</th>
            <th scope="col">탑공지기간</th>
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
             <td><customTagUi:code type="text" cdGrp="NOTI_CATEG_CD" name="" cd="${data.categCd}" /></td>
             <td class="txt_title"><a href="javascript:fn_goDetailPage('<c:out value='${data.boardSeq }' />')"><c:out value="${data.title }" /></a></td>
             <td class="txt_date"><fmt:formatDate value="${data.topStartDt}" pattern="yyyy/MM/dd"/> ~ <fmt:formatDate value="${data.topEndDt}" pattern="yyyy/MM/dd"/></td>
             <td class="txt_eng"><c:out value="${data.openYn eq 'Y' ? '예' : '아니오' }" /></td>
             <td class="count_num"><c:out value="${data.viewCnt }" /></td>
             <td><c:out value="${data.userName }" /></td>
             <td class="txt_date"><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd"/></td>
         </tr>
		</c:forEach>
		<c:if test="${fn:length(result.boardVolist) <= 0 }">
		<tr>
			<td class="nodata" colspan="8">조회된 데이터가 없습니다.</td>
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
    <span class="leftzone"><button type="button" id="btnDeleteNoti" class="btn_white_B02">선택삭제</button></span>
    <span class="rightzone"><button type="button" id="btnGoNotiCreatePage" class="btn_blue_B02">신규 공지사항 등록</button></span>
</div>
<!-- 버튼 -->
<input type = "hidden" id = "listTotalCount" value="${boardCriteria.totalRecordCount }" >