<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/baseValueMstrList_JS.jsp"%>
<!--
  * @Class Name  : baseValueMstrList.jsp
  * @Description : 기준값마스터 코드 관리화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.08.03    이인희      최초 생성
-->
<form id = "frm" name = "frm" method="post">
<section id="detail_contents">
    <!-- 검색 영역 -->
        <div class="adm_searchBox">
            <table id="reg_input_grid" class="adm_tb_search" summary="기준값마스터 (기준값, 사용여부)">
                <caption>기준값마스터</caption>
                <colgroup>
                    <col width="80" />
                    <col width="*" />
                    <col width="100" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><label for="searchBaseVal">기준값</label></th>
                        <td>
                            <input id="searchBaseVal" name = "searchBaseVal" type="text"
                                     placeholder="기준값을 입력하세요." onkeypress="if(event.keyCode==13){ fn_doSearch(1); return false; }"
                                     class="input_s_b w100pro" title="기준값검색" value="${baseValueMstrCriteria.searchBaseVal }"  autocomplete="off" maxlength="50"/>
                        </td>
                        <th scope="row"><label for="searchUseYnAll">사용여부</label></th>
                        <td class="itemList">
                             <label><input type="radio" id="searchUseYnAll" name="searchUseYn" <c:if test="${bnkMstrCriteria.searchUseYn eq '' || bnkMstrCriteria.searchUseYn eq null}"> checked="checked" </c:if> value="" ><span>전체</span></label>
                             <customTagUi:code type="radio" cdGrp="YN_COMMON" name="searchUseYn" id="searchUseYn" cd="${bnkMstrCriteria.searchUseYn }" prefix="<span class=radio_list>" postfix="</span>"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="bs_BtnBox_r">
            <button type="button" id="btnInit" class="btn_white_B01">초기화</button>
            <button type="button" id="btnSearch" class="btn_gray_B01 mgl5">검색</button>
        </div>
        <!-- 검색 영역 -->

        <!-- 20개씩/40개씩/60개씩 보기 -->
        <div class="board_classic">
            <div class="left_block">
                <div class="pageCount">
                    <strong>전체</strong><span id="listTotalCnt"><font id ="searchTotalCount">${baseValueMstrCriteria.totalRecordCount }</font> 건</span>
                </div>
            </div>
            <div class="rightblock">
                <select id="listViewCount" class="sel_basic selshowst" title="목록 갯수설정" onChange="fn_listChange(this.value);">
                    <option value="15" <c:if test="${baseValueMstrCriteria.recordCountPerPage eq '15'}">selected="selected"</c:if>>15개씩 보기</option>
                    <option value="30" <c:if test="${baseValueMstrCriteria.recordCountPerPage eq '30'}">selected="selected"</c:if>>30개씩 보기</option>
                    <option value="45" <c:if test="${baseValueMstrCriteria.recordCountPerPage eq '45'}">selected="selected"</c:if>>45개씩 보기</option>
                </select>
            </div>
        </div>
        <!-- 20개씩/40개씩/60개씩 보기 -->

    <!--/ 게시판 정렬목록 /-->
    <div id = "listArea">
        <jsp:include page="./include/baseValueMstrList_INC.jsp"></jsp:include>
    </div>

    <!-- 검색이나 화면이동을 위한 데이터 -->
    <input type="hidden" id = "searchBaseCd" name = "searchBaseCd">
    <input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${baseValueMstrCriteria.recordCountPerPage }">
    <input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${baseValueMstrCriteria.currentPageNo }">
</section>
</form>

<!-- 모달창 : 신규 메뉴등록 :S -->
<div id="createModal" style="display: none;">
</div>
<!-- 모달창 : 신규 메뉴등록 :E -->

