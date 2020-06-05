<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/qnaList_JS.jsp"%>
<!--
  * @Class Name  : qnaList.jsp
  * @Description : QNA리스트화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
        <!-- 검색 영역 -->
        <div class="adm_searchBox">
              <table id="reg_input_grid" class="adm_tb_search" summary="1:1문의 검색 (제목/내용, 답변상태, 작성일)">
                  <caption>1:1문의 검색</caption>
                  <colgroup>
                      <col width="90" />
                      <col width="*" />
                      <col width="80" />
                      <col width="*" />
                  </colgroup>
                  <tbody>
                      <tr>
                          <th scope="row"><label for="searchContentType">제목/내용</label></th>
                          <td>
				               <select id="searchContentType" name = "searchContentType" class="sel_basic w100px" title="1:1문의검색">
				                   <option value="title" <c:if test="${boardCriteria.searchContentType eq 'title'}">selected="selected"</c:if>>제목</option>
				                   <option value="content" <c:if test="${boardCriteria.searchContentType eq 'content'}">selected="selected"</c:if>>내용</option>
				               </select>
                               <input id="searchContentText" name = "searchContentText" type="text"
                                  placeholder="검색어를 입력하세요." onkeypress="if(event.keyCode==13) {fn_doSearch(1); return false;}"
                                  class="input_s_b w240px mgl5" title="1:1문의검색" value="${boardCriteria.searchContentText }" autocomplete="off" maxlength="20"/>
                          </td>
                          <%-- <th scope="row"><label for="searchQnaStatusCdAll">답변상태</label></th>
                          <td class="itemList">
                              <label for="searchQnaStatusCdAll">
                                  <input type="radio" id="searchQnaStatusCdAll" name="searchQnaStatusCd" <c:if test="${boardCriteria.searchQnaStatusCd eq '' || boardCriteria.searchQnaStatusCd eq null}"> checked="checked" </c:if> value="">
                                  <span>전체</span>
                              </label>
                              <customTagUi:code type="radio" cdGrp="QNA_STATUS_CD" name="searchQnaStatusCd" id="searchQnaStatusCd" cd="${boardCriteria.searchQnaStatusCd }" prefix="<span>" postfix="</span>"/>
                          </td> --%>
                      </tr>
                      <tr>
                          <th scope="row"><label for="searchFromDtS">작성일</label></th>
                          <td colspan="3">
                              <input type="text" class="input_s_b w_date" id = "searchFromDtS" name = "searchFromDtS" readonly="readonly" value="<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>"/>
                              <span>~</span>
                              <input type="text" class="input_s_b w_date" id = "searchToDtS" name="searchToDtS" readonly="readonly" value="<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"/>
                              <span id="searchDateBtArea" class="btn_monthset mgl10">
                                  <button type="button" id="searchDate_1" onclick="javascript:fn_setDate(1)" class="left_r">1개월</button>
                                  <button type="button" id="searchDate_3" onclick="javascript:fn_setDate(3)" class="">3개월</button>
                                  <button type="button" id="searchDate_6" onclick="javascript:fn_setDate(6)" class="right_r">6개월</button>
                              </span>
                          </td>
                      </tr>
                  </tbody>
              </table>
        </div>
        <div class="board_classic">
            <div class="rightblock"><a href="#" id="btnSearch" class="btn_wh_bevel">검색</a></div>
            <div class="rightblock">&nbsp;&nbsp;</div>
            <div class="rightblock"><a href="#" id="btnInit" class="btn_wh_bevel">초기화</a></div>
        </div>
        <!-- 검색 영역 -->

        <!-- 20개씩/40개씩/60개씩 보기 -->
        <div class="board_classic">
            <div class="left_block">
                    <div class="pageCount">
                        <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${boardCriteria.totalRecordCount }</font> 건</span>
                    </div>
            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="javascript:fn_listChange(this.value)">
                    <option value="15" <c:if test="${boardCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${boardCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${boardCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 게시판 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="./include/qnaList_INC.jsp"></jsp:include>
		</div>
		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${boardCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${boardCriteria.currentPageNo }">
		<input type="hidden" id = "searchBoardSeq" name = "searchBoardSeq">
	</form>
</section>