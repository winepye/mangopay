<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/qnaDetail_JS.jsp"%>
<!--
  * @Class Name  : qnaCreatePage.jsp
  * @Description : qna작성화면
  * @Modification Information
  * @
  * @ 수정일                수정자      수정내용
  * @ 2018.10.14    이인희      최초 생성
-->
<section id="detail_contents">
    <form id="frm" name="frm" method="post">
        <h3 class="h2_table_title">1:1문의 상세</h3>
        <table id="templateProject" class="tb_left_st2" summary="qna 등록, 제목, 문의유형, 내용, 노출여부">
            <caption>1:1문의 상세</caption>
            <colgroup>
                <col width="12%" />
                <col width="*" />
                <col width="12%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="title">이름(업체명)</label></th>
                    <td><c:out value="${qnaBoardVo.title }" /></td>
                    <th scope="row"><label for="categCd">연락처</label></th>
                    <td><c:out value="${qnaBoardVo.userMobileNum }" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="title">이메일주소</label></th>
                    <td><c:out value="${qnaBoardVo.userEmailAddr }" /></td>
                    <th scope="row"><label for="categCd">작성일</label></th>
                    <td><fmt:formatDate value="${qnaBoardVo.createDate}" pattern="yyyy/MM/dd" /></td>
                </tr>
                <tr>
                    <th scope="row">내용</th>
                    <td colspan="3">
                   		<div class="editorContent"><c:out value="${qnaBoardVo.content }" escapeXml="false" /></div>
                    </td>
                </tr>
                <tr class = "addFileList">
                    <th scope="row">첨부파일</th>
                    <td colspan="3">
                         <!--첨부파일-->
                         <customTagUi:fileView atchFileGrpSeq="${qnaBoardVo.atchFileGrpSeq }" fileTypeCd="ETC" />
                         <!--//첨부파일//-->
                    </td>
                </tr>
            </tbody>
        </table>

        <h3>&nbsp;</h3>

        <c:if test="${isAnswer }">
            <h3 class="h2_table_title">1:1문의 답변 상세</h3>
            <table id="templateProject" class="tb_left_st2" summary="답변 공개여부,답변작성일,답변">
                <caption>1:1문의 답변 상세</caption>
                <colgroup>
                    <col width="12%" />
                    <col width="*" />
                    <col width="12%" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">답변 공개여부</th>
                        <td><customTagUi:code type="text" cdGrp="YN_COMMON" name="" cd="${boardAnswerVo.openYn}" /></td>
                        <th scope="row">답변 작성일</th>
                        <td><fmt:formatDate value="${boardAnswerVo.createDate}" pattern="yyyy/MM/dd" /></td>
                    </tr>
                    <tr>
                        <th scope="row">답변</th>
                        <td colspan="3">
                            <div class="editorContent"><c:out value="${boardAnswerVo.content }" escapeXml="false" /></div>
                        </td>
                    </tr>
                    <tr class = "addFileList">
	                   <th scope="row">첨부파일</th>
	                   <td colspan="3">
	                        <!--첨부파일-->
	                        <customTagUi:fileView atchFileGrpSeq="${boardAnswerVo.atchFileGrpSeq }" fileTypeCd="ETC" />
	                        <!--//첨부파일//-->
	                   </td>
	               </tr>
                </tbody>
            </table>
        </c:if>
		<!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <%-- <c:choose>
                <c:when test="${isAnswer }">
                    <button type="button" id="btnGoQnaAnswerModifyPage" class="btn_gray_B01">답변수정</button>
                </c:when>
                <c:otherwise>
                    <button type="button" id="btnGoQnaAnswerCreatePage" class="btn_gray_B01">답변등록</button>
                </c:otherwise>
            </c:choose> --%>

            <button type="button" id="btnGoQnaListPage" class="btn_white_B01">목록</button>
        </div>
        <!-- 버튼 -->

    </form>
    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <input type="hidden" name="searchContentType" value='<c:out value="${boardCriteria.searchContentType }" />'> <input type="hidden" name="searchContentText" value='<c:out value="${boardCriteria.searchContentText }" />'> <input type="hidden" name="currentPageNo" value='<c:out value="${boardCriteria.currentPageNo }" />'> <input type="hidden" name="searchBoardTypeCd" value='<c:out value="${boardCriteria.searchBoardTypeCd }" />'> <input type="hidden" name="searchBoardSeq" value='<c:out value="${boardCriteria.searchBoardSeq }" />'>
        <input type="hidden" name="searchQnaStatusCd" value='<c:out value="${boardCriteria.searchQnaStatusCd }" />'>
        <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
        <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>">
        <!-- 20개씩/40개씩/60개씩 보기 -->
        <input type="hidden" name = "recordCountPerPage" value='<c:out value="${boardCriteria.recordCountPerPage }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
    </form>
</section>