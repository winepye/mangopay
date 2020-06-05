<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/menuGrpStructList_JS.jsp"%>
<!--
  * @Class Name  : menuGrpStructList.jsp
  * @Description : 메뉴구조관리화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.03    이인희      최초 생성
-->
<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
<div class="adm_searchBox">
      <table class="adm_tb_search" summary="탐방리포트검색 (일자, 투자추천여부, 회원명, 회원ID, 제목)">
          <caption>탐방리포트검색</caption>
          <colgroup>
              <col width="100">
              <col width="*">
          </colgroup>
          <tbody>
              <tr>
                  <th scope="row"><label for="searchMenuGrpSeqSelect">메뉴그룹</label></th>
                  <td class="vtwrap">
                      <select id="searchMenuGrpSeqSelect" class="sel_basic ht22">
                          <c:forEach var = "data" items="${menuGrpVoList }">
                       <option value="${data.menuGrpSeq }_${data.menuLocationCd}">${data.menuGrpNm }</option>
                   </c:forEach>
                      </select>
                      <span id="searchDateBtArea" class="btn_monthset mgl5"><button type="button" id="menuCopyBtn" class="both_r" onclick="fn_nodeControll('copy')">메뉴복사</button></span>
                  </td>
              </tr>
          </tbody>
      </table>
</div>
<div id = "menuTreeArea"></div>


    <input type="hidden" id = "searchMenuGrpSeq" name = "searchMenuGrpSeq">
    <input type="hidden" id = "searchMenuLocation">

    <!-- 노드 컨텐츠박스 컨트롤을 위한 히든값 -->
    <input type="hidden" id = "nodeControll" name = "nodeControll">
    <input type="hidden" id = "nodeCopyTargetStructSeq" name = "nodeCopyTargetStructSeq">
    <input type="hidden" id = "nodeCopyTargetStructParentSeq" name = "nodeCopyTargetStructParentSeq">
    <input type="hidden" id = "nodeCopyTargetGrpSeq" name = "nodeCopyTargetGrpSeq">
    <input type="hidden" id = "nodeCount">
    <input type="hidden" id = "nodeCopyTargetLocation">

    <!-- 선택노드 유지를 위한 히든값 -->
    <input type="hidden" id = "selectedNodeId">
    <input type="hidden" id = "selectedNm">
    <!-- 저장 수정 조회를 위한 히든값 -->
    <input type="hidden" id = "menuGrpStructSeq" name = "menuGrpStructSeq">
    <input type="hidden" id = "menuGrpSeq" name = "menuGrpSeq">
    <input type="hidden" id = "searchMenuGrpStructSeq" name = "searchMenuGrpStructSeq">
    <input type="hidden" id = "searchParentMenuGrpStructSeq" name = "searchParentMenuGrpStructSeq">
    <input type="hidden" id = "searchMenuDepth" name = "searchMenuDepth" value="0">
    <input type="hidden" id = "searchTopMenuGrpStructSeq" name = "searchTopMenuGrpStructSeq" value="0">
    <input type="hidden" id = "searchBusinessTypeCd" name = "searchBusinessTypeCd">
</form>
</section>
