<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/menuList_JS.jsp"%>
<!--
  * @Class Name  : menuList.jsp
  * @Description : 메뉴관리화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
    <!-- 검색 영역 -->
        <div class="adm_searchBox">
              <table id="reg_input_grid" class="adm_tb_search" summary="검색" id="searchArea">
                  <colgroup>
                      <col width="160" />
                      <col width="*" />
                      <col width="120" />
                      <col width="*" />
                  </colgroup>
                  <tbody>
                      <tr>
                          <th scope="row"><label for="searchContentType">메뉴명/업무유형/URL</label></th>
                          <td>
                              <select id="searchContentType" name = "searchContentType" class="sel_basic w100px" title="검색옵션선택">
					               <option value="" >검색옵션선택</option>
					               <option value="menuNm" <c:if test="${menuCriteria.searchContentType eq 'menuNm'}">selected="selected"</c:if>>메뉴명</option>
					               <option value="businessType" <c:if test="${menuCriteria.searchContentType eq 'businessType'}">selected="selected"</c:if>>업무유형</option>
					               <option value="menuUrl" <c:if test="${menuCriteria.searchContentType eq 'menuUrl'}">selected="selected"</c:if>>메뉴URL</option>
					          </select>
				             <input id="searchContentText" name = "searchContentText" type="text"
				                     placeholder="검색어를 입력하세요" onkeypress="if(event.keyCode==13) {fn_doSearch(1);return false;}"
				                     class="input_s_b w240px mgl5" title="FAQ검색" value="${menuCriteria.searchContentText }"/>
                          </td>
                          <th scope="row"  rowspan="2"><label for="searchBusinessTypeCd">업무유형 선택</label></th>
                          <td rowspan="2">
                              <customTagUi:code type="select" cdGrp="BUSINESS_TYPE_CD" name="searchBusinessTypeCd" id="searchBusinessTypeCd" attr='class="sel_basic"' subjectText="업무유형선택"/>
                          </td>
                      </tr>
                      <tr>
                          <th scope="row"><label for="searchFromDtS">기타</label></th>
                          <td >
                              <customTagUi:code type="select" cdGrp="MENU_TYPE_CD" name="searchMenuTypeCd"  attr='class="sel_basic"' subjectText="메뉴유형선택"/>
            <customTagUi:code type="select" cdGrp="MENU_LOCATION_CD" name="searchMenuLocationCd"  attr='class="sel_basic"' subjectText="메뉴위치선택"/>
            <customTagUi:code type="select" cdGrp="YN_COMMON" name="searchRepresentMenuYn"  attr='class="sel_basic"' subjectText="대표여부선택"/>
            <customTagUi:code type="select" cdGrp="YN_COMMON" name="searchUseYn"  attr='class="sel_basic"' subjectText="사용여부선택"/>
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
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${menuCriteria.totalRecordCount }</font> 건</span>
                </div>
            </div>
            <div class="rightblock">
                 <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onchange="javascript:fn_listChange(this.value)">
                    <option value="15" <c:if test="${menuCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${menuCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${menuCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

	<!--/ 게시판 정렬목록 /-->
	<div id = "listArea">
	 <jsp:include page="./include/menuList_INC.jsp"></jsp:include>
	</div>

	<!-- 검색이나 화면이동을 위한 데이터 -->
	<input type="hidden" id = "searchMenuSeq" name = "searchMenuSeq">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${menuCriteria.recordCountPerPage }">
	<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${menuCriteria.currentPageNo }">
</form>
</section>

<!-- 모달창 : 신규 메뉴등록 :S -->
<div id="createModal" style="display: none;">
</div>
<!-- 모달창 : 신규 메뉴등록 :E -->



