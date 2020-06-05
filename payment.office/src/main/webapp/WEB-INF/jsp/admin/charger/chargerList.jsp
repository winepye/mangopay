<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/chargerList_JS.jsp"%>
<!--
  * @Class Name  : chargerList.jsp
  * @Description : 담당자리스트화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
        <!-- 검색 영역 -->
        <div class="adm_searchBox">
               <table id="reg_input_grid" class="adm_tb_search" summary="담당자검색 (제목/내용, 게시여부, 작성일)">
                   <caption>담당자</caption>
                   <colgroup>
                       <col width="90" />
                       <col width="*" />
                       <col width="90" />
                       <col width="28%" />
                   </colgroup>
                   <tbody>
                       <tr>
                           <th scope="row"><label for="searchContentType">검색조건</label></th>
                           <td class="vtwrap">
                               <customTagUi:code type="select" cdGrp="CHARGER_TYPE" name="searchContentType" id="searchContentType"
                                   cd="${chargerCriteria.searchContentType}" attr='class="sel_basic w100px"' subjectText="전체"/>
                                <input id="searchContentText" name = "searchContentText" type="text"
                                   placeholder="검색어를 입력하세요." onkeypress="if(event.keyCode==13) {fn_doSearch(1); return false;}"
                                   class="input_s_b w240px mgl5" title="담당자검색" value="${chargerCriteria.searchContentText }" autocomplete="off" maxlength="20"/>
                           </td>
                           <th scope="row"><label for="searchOpenYnAll">담당자명</label></th>
                           <td class="itemList">
                               <input id="searchChargerName" name = "searchChargerName" type="text"
                                   placeholder="검색어를 입력하세요." onkeypress="if(event.keyCode==13) {fn_doSearch(1); return false;}"
                                   class="input_s_b w240px mgl5" title="담당자검색" value="${chargerCriteria.searchContentText }" autocomplete="off" maxlength="20"/>
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
                        <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${chargerCriteria.totalRecordCount }</font> 건</span>
                    </div>
            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="javascript:fn_listChange(this.value)">
                    <option value="15" <c:if test="${chargerCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${chargerCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${chargerCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

        <!--/ 게시판 정렬목록 /-->
        <div id = "listArea">
	        <jsp:include page="./include/chargerList_INC.jsp"></jsp:include>
		</div>

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${chargerCriteria.recordCountPerPage }">
		<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${chargerCriteria.currentPageNo }">
		<input type="hidden" id = "chargerInfoId" name = "chargerInfoId">
	</form>
</section>