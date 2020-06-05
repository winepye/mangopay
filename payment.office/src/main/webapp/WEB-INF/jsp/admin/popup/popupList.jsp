<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/popupList_JS.jsp"%>
<!--
  * @Class Name  : popupList.jsp
  * @Description : 팝업리스트화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2016.07.20	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
        <!-- 검색 영역 -->
        <div class="adm_searchBox">
	        <table id="reg_input_grid" class="adm_tb_search" summary="팝업검색 (제목/내용, 게시여부, 작성일)">
	            <caption>팝업검색</caption>
                <colgroup>
                    <col width="90" />
                    <col width="*" />
                    <col width="90" />
                    <col width="28%" />
                </colgroup>
	            <tbody>
	                <tr>
	                    <th scope="row"><label for="searchContentText">팝업 제목</label></th>
	                    <td class="vtwrap">
	                        <input id="searchContentText" name = "searchContentText" type="text" class="input_s_b w240px mgl5"
	                            placeholder="팝업 제목을 입력하세요." onkeypress="if(popup.keyCode==13) {fn_doSearch(1); return false;}"
	                            class="input_s_b w240px mgl5" title="팝업검색" value="${popupCriteria.searchContentText }" autocomplete="off" maxlength="100"/>
	                    </td>
	                    <th scope="row"><label for="searchPopupYnAll">팝업여부</label></th>
	                    <td class="itemList">
	                        <label for="searchPopupYnAll">
	                        <input type="radio" id="searchPopupYnAll" name="searchPopupYn" <c:if test="${popupCriteria.searchPopupYn eq '' || popupCriteria.searchPopupYn eq null}"> checked="checked" </c:if> value="" style="border: none;">
	                           <span>전체</span></label>
	                        <customTagUi:code type="radio" cdGrp="YN_COMMON" name="searchPopupYn" id="searchPopupYn" cd="${popupCriteria.searchPopupYn }" prefix="<span>" postfix="</span>"/>
	                    </td>
	                </tr>
	                <tr>
	                    <th scope="row"><label for="searchFromDtS">작성일</label></th>
	                    <td colspan="3" class="vtwrap">
	                        <input type="text" class="input_s_b w_date" id = "searchFromDtS" name = "searchFromDtS" value="<fmt:formatDate value="${popupCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>"/>
	                        <span>~</span>
	                        <input type="text" class="input_s_b w_date" id = "searchToDtS" name="searchToDtS" value="<fmt:formatDate value="${popupCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"/>
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
        <div class="bs_BtnBox_r">
            <button type="button" id="btnInit" class="btn_white_B01">초기화</button>
            <button type="button" id="btnSearch" class="btn_gray_B01">검색</button>
        </div>
        <!-- 검색 영역 -->

        <!-- 20개씩/40개씩/60개씩 보기 -->
        <div class="board_classic">
            <div class="left_block">
                <div class="pageCount">
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${popupCriteria.totalRecordCount }</font> 건</span>
                </div>
            </div>
            <div class="rightblock">
                 <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="javascript:fn_listChange(this.value)">
                    <option value="15" <c:if test="${popupCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${popupCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${popupCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 게시판 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="./include/popupList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${popupCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${popupCriteria.currentPageNo }">
		<input type="hidden" id = "searchPopupSeq" name = "searchPopupSeq">
	</form>
</section>