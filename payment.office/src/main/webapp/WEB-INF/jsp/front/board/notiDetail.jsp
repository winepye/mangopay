<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/notiDetail_JS.jsp"%>
<!--
  * @Class Name  : notiDetail.jsp
  * @Description : 공지사항상세화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2016.05.03	이인희      최초 생성
-->
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />
<section id="contents">
	<!--공지사항-->
	<form id = "frm" name = "frm" method="post">
	<article id="board_conbox">
		<div class="board_title mgt40">
            <div class="writerinfo"><span><em><fmt:formatDate value="${notiBoardVo.createDate}" pattern="yyyy.MM.dd"/></em></span><span>조회수<em>(<c:out value="${notiBoardVo.viewCnt }" />)</em></span>
            </div>
            <div class="titlecon">
                <span class="bs_num"><c:out value='${notiBoardVo.boardSeq }' /></span>
                <c:out value="${notiBoardVo.title }" />
            </div>
		</div>
		<div class="board_contents">
            <div class="editorContent"><c:out value="${notiBoardVo.content }" escapeXml="false"/></div>
		</div>

		<!--첨부파일리스트-->
	    <div class="view_fileListWrap">
			<dl class="view_fileList">
				<dt>첨부파일</dt>
				<dd>
		          	<ul class="in_fileList">
		          		<!--첨부파일-->
							<customTagUi:fileView atchFileGrpSeq="${notiBoardVo.atchFileGrpSeq }" fileTypeCd="ETC" />
						<!--//첨부파일//-->
		              	<!-- <li><a href="#">우리티아이 회사 IR_20150513.docx</a><span>82KB</span><a href="#" class="fileDelete"><em>삭제</em></a></li>
		              	<li><a href="#">우리티아이 투자제안서 IR_20150513.docx</a><span>97KB</span><a href="#" class="fileDelete"><em>삭제</em></a></li>
		              	<li><a href="#">우리티아이 보고서_20150513.docx</a><span>310KB</span><a href="#" class="fileDelete"><em>삭제</em></a></li> -->
		           </ul>
				</dd>
			</dl>
		</div>
		<!--//첨부파일리스트//-->

 		<ul class="board_s_list">
			<li>이전글
				<span class="mgl30"></span>
				<c:if test="${empty preNotiBoardVo}"> 이전글이 없습니다.</c:if>
				<c:if test="${not empty preNotiBoardVo}">
			 		<a href="javascript: fn_goPreNext('<c:out value= "${preNotiBoardVo.boardSeq}" />')">${preNotiBoardVo.title}</a>
				</c:if>
			</li>
			<li>다음글
				<span class="mgl30"></span>
				<c:if test="${empty postNotiBoardVo}"> 다음글이 없습니다.</c:if>
				<c:if test="${not empty postNotiBoardVo}">
					<a href="javascript: fn_goPreNext('<c:out value= "${postNotiBoardVo.boardSeq}" />')">${postNotiBoardVo.title}</a>
				</c:if>
			</li>
		</ul>
		<input type="hidden" id = "searchBoardSeq" name = "searchBoardSeq" />
	</article>
	<!--//공지사항//-->
	<div class="bs_BtnBox_c">
		<a href="#" id="btnGoNotiListPage" class="btn_white_B01">목록</a>
		<!-- <a href="#" id="btnGoNotiModifyPage" class="btn_blue_B01 mgl10">수정</a> -->
	</div>
	</form>
    <form id = "moveFrm" name = "moveFrm" method = "post">
       <input type="hidden" name = "searchContentType" value='<c:out value="${boardCriteria.searchContentType }" />'>
       <input type="hidden" name = "searchContentText" value='<c:out value="${boardCriteria.searchContentText }" />'>
       <input type="hidden" name = "currentPageNo" value='<c:out value="${boardCriteria.currentPageNo }" />'>
       <input type="hidden" name = "searchBoardTypeCd" value='<c:out value="${boardCriteria.searchBoardTypeCd }" />'>
       <input type="hidden" name = "searchBoardSeq" value='<c:out value="${boardCriteria.searchBoardSeq }" />'>
	</form>
</section>