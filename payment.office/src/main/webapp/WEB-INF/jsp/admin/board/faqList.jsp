<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/faqList_JS.jsp"%>
<!--
  * @Class Name  : faqList.jsp
  * @Description : FAQ리스트화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
        <!-- 검색 영역 -->
        <div class="adm_searchBox">
            <!-- <div id="codeGroupDetailArea" style="background-color:#FFFFFF; float:right; width:100%;"> -->
                    <table id="reg_input_grid" class="adm_tb_search" summary="자주묻는질문 검색 (제목/내용, FAQ유형, 게시여부, 작성일)">
                        <caption>자주묻는질문 검색</caption>
                        <colgroup>
                            <col width="10%">
                            <col width="40%">
                            <col width="10%">
                            <col width="40%">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row"><label for="searchContentType">제목/내용</label></th>
                                <td class="vtwrap">
                                    <select id="searchContentType" name = "searchContentType" class="sel_basic w100px" title="FAQ검색">
                                        <option value="title" <c:if test="${boardCriteria.searchContentType eq 'title'}">selected="selected"</c:if>>제목</option>
                                        <option value="content" <c:if test="${boardCriteria.searchContentType eq 'content'}">selected="selected"</c:if>>내용</option>
                                    </select>
                                    <input id="searchContentText" name = "searchContentText" type="text"
                                        placeholder="검색어를 입력하세요." onkeypress="if(event.keyCode==13) {fn_doSearch(1); return false;}"
                                        class="input_s_b w240px mgl5" title="FAQ검색" value="${boardCriteria.searchContentText }" autocomplete="off" maxlength="20"/>
                                </td>
                                <th scope="row"><label for="searchCategCdAll">FAQ유형</label></th>
                                <td class="itemList">
                                    <label for="searchCategCdAll">
	                                    <input type="radio" id="searchCategCdAll" name="searchCategCd" <c:if test="${boardCriteria.searchCategCd eq '' || boardCriteria.searchCategCd eq null}"> checked="checked" </c:if>  value="" style="border: none;">
	                                    <span>전체</span>
                                    </label>
                                    <customTagUi:code type="radio" cdGrp="FAQ_CATEG_CD" name="searchCategCd" id="searchCategCd" cd="${boardCriteria.searchCategCd }" prefix="<span class=radio_list>" postfix="</span>"/>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="searchOpenYnAll">게시여부</label></th>
                                <td class="itemList">
                                    <label for="searchOpenYnAll">
	                                    <input type="radio" id="searchOpenYnAll" name="searchOpenYn" <c:if test="${boardCriteria.searchOpenYn eq '' || boardCriteria.searchOpenYn eq null}"> checked="checked" </c:if> value="">
	                                    <span>전체</span>
                                    </label>
                                    <customTagUi:code type="radio" cdGrp="YN_COMMON" name="searchOpenYn" id="searchOpenYn" cd="${boardCriteria.searchOpenYn }" prefix="<span class=radio_list>" postfix="</span>"/>
                                </td>
                                <th scope="row"><label for="searchFromDtS">작성일</label></th>
                                <td class="vtwrap">
                                    <input type="text" class="input_s_b w_date" id = "searchFromDtS" name = "searchFromDtS" value="<fmt:formatDate value="${boardCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>"/>
                                    <span>~</span>
                                    <input type="text" class="input_s_b w_date" id = "searchToDtS" name="searchToDtS" value="<fmt:formatDate value="${boardCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"/>
                                    <span id="searchDateBtArea" class="btn_monthset mgl10">
                                         <button type="button" id="searchDate_1" onclick="javascript:fn_setDate(1)" onclick="javascript:fn_setDate(1)" class="left_r">1개월</button>
                                         <button type="button" id="searchDate_3" onclick="javascript:fn_setDate(3)" onclick="javascript:fn_setDate(3)" class="">3개월</button>
                                         <button type="button" id="searchDate_6" onclick="javascript:fn_setDate(6)" onclick="javascript:fn_setDate(6)" class="right_r">6개월</button>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
           <!--  </div> -->
        </div>
        <div class="bs_BtnBox_r">
            <button type="button" id="btnInit" class="btn_white_B01">초기화</button>
            <button type="button" id="btnSearch" class="btn_gray_B01">검색</button>
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
	        <jsp:include page="./include/faqList_INC.jsp"></jsp:include>
		</div>
		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${boardCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${boardCriteria.currentPageNo }">
		<input type="hidden" id = "searchBoardSeq" name = "searchBoardSeq">
	</form>
</section>