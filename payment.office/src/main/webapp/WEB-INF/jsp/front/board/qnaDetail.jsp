<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/qnaDetail_JS.jsp"%>

<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<section id="contents">
	<table class="board_view_st01 mgt40" summary="1:1 문의 보기(문의유형, 제목, 문의내용, 답변내용)" >
		<caption>1:1 문의 상세보기</caption>
			<colgroup>
				<col width="14%" />
				<col width="*" />
			</colgroup>
		<tbody>
			<tr>
				<th scope="row">문의유형</th>
				<td><customTagUi:code type="text" cdGrp="QNA_CATEG_CD" name="boardType2" cd="${qnaBoardVo.categCd }" /></td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td class="Q_title">${qnaBoardVo.title }</td>
			</tr>

			<tr>
				<th scope="row">문의내용</th>
				<td class="pdReset">
					<div class="Q_conbox">
                        <pre style="word-wrap:break-word;white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-break:break-all;">
						${qnaBoardVo.content }
                        </pre>
					</div>
					<!--첨부파일-->
					<ul class="in_fileList">
						<customTagUi:fileView atchFileGrpSeq = "${qnaBoardVo.atchFileGrpSeq }" fileTypeCd="ETC"/>
					</ul>
					<!--//첨부파일//-->
				</td>
			</tr>

			<c:choose>
				<c:when test="${qnaAnswerVo eq null}">
					<!-- 답변내용이 없는 경우 -->
					<tr>
						<th scope="col">답변내용</th>
						<td class="notyet_A">문의사항에 대한 답변을 준비중입니다.</td>
					</tr>
					<!--//답변내용이 없는 경우//-->
				</c:when>
				<c:otherwise>
					<tr>
						<th scope="row">답변내용</th>
						<td class="pdReset">
							<div class="A_conbox">
								<p class="A_title">${sessionUserName }님 반갑습니다. 문의하신 내용의 답변입니다.</p>
								${qnaAnswerVo.content }
								<p class="A_notice">* 추가질문이나 더 궁금하신 부분이 있으시면 전화상담과 문의게시판에 추가문의 해주시면 친절하게 안내해드리겠습니다.</p>
							</div>
							<!--첨부파일-->
							<ul class="in_fileList">
								<!-- <li><a href="#">우리티아이 회사 IR_20150513.docx</a><span>82KB</span><a href="#" class="fileDelete"><em>삭제</em></a></li>
								<li><a href="#">우리티아이 투자제안서 IR_20150513.docx</a><span>97KB</span><a href="#" class="fileDelete"><em>삭제</em></a></li>
								<li><a href="#">우리티아이 보고서_20150513.docx</a><span>310KB</span><a href="#" class="fileDelete"><em>삭제</em></a></li> -->
								<customTagUi:fileView atchFileGrpSeq = "${qnaAnswerVo.atchFileGrpSeq }" fileTypeCd="ETC"/>
							</ul>
							<!--//첨부파일//-->
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<div style="height: 30px"></div>

	<!--//게시판페이지버튼// 원본 -->
	<div class="bs_BtnBox_c">
		<button type="button" class="btn_white_B01" id = "btnCancel">목록</button>
		<c:if test="${qnaAnswerVo eq null}"><button type="button" class="btn_blue_B01 mgl10" id = "btnModify">수정</button></c:if>
	</div>

	<form id = "moveFrm" name = "moveFrm" method = "post">
		<!-- 검색조건 유지를 위한 파라미터 :S -->
		<input type="hidden" name = "searchContentType" value='<c:out value="${boardCriteria.searchContentType }" />'>
		<input type="hidden" name = "searchContentText" value='<c:out value="${boardCriteria.searchContentText }" />'>
		<input type="hidden" name = "currentPageNo" value='<c:out value="${boardCriteria.currentPageNo }" />'>
		<input type="hidden" name = "searchBoardTypeCd" value='<c:out value="${boardCriteria.searchBoardTypeCd }" />'>
		<input type="hidden" name = "searchBoardSeq" value='<c:out value="${boardCriteria.searchBoardSeq }" />'>
      	<input type="hidden" name = "searchFromDtS" value='<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>'>
      	<input type="hidden" name = "searchToDtS" value='<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>'>
		<!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>

</section>