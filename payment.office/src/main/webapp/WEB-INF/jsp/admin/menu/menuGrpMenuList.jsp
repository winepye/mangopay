<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.smartdatacorp.core.bean.session.LoginSessionInfo" %>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/menuGrpMenuList_JS.jsp"%>
<!--
  * @Class Name  : menuList.jsp
  * @Description : 메뉴관리화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14    이인희      최초 생성
-->
<form id = "frm" name = "frm" method="post">
    <section id="detail_contents">
        <div class="board_classic">
            <div class="rightblock">
                <a href="#" id="btnCreate" class="btn_wh_bevel">신규</a>
            </div>
        </div>

       <div class="adm_searchBox">
       <table class="adm_tb_search" summary="그룹명, 메뉴위치, 메뉴그룹설명, 회원 유형, 사용여부, 등록자, 등록일, 수정자, 수정일">
           <caption>
                   메뉴그룹
           </caption>
          <colgroup>
              <col width="80" />
              <col width="*" />
          </colgroup>
           <tbody>
               <tr>
                   <th scope="col">메뉴그룹</th>
                   <td class="pd0">
                       <dl class="groupList">
                           <dt>일반회원</dt>
                           <c:forEach var = "data" items="${menuGrpVoList}">
                                <c:if test="${data.userTypeCd eq 'GENERAL' or data.userTypeCd eq 'NONMEMBER'}">
                                   <dd><label><input type="radio" name="searchMenuGrpSeq" value="${data.menuGrpSeq }" id="searchMenuGrpSeq"/><span>${data.menuGrpNm }</span></label></dd>
                                </c:if>
                           </c:forEach>
                       </dl>
                       <dl class="groupList">
                           <dt>기업회원</dt>
                           <c:forEach var = "data" items="${menuGrpVoList}">
                                <c:if test="${data.userTypeCd eq 'COMPANY'}">
                                   <dd><label><input type="radio" name="searchMenuGrpSeq" value="${data.menuGrpSeq }" id="searchMenuGrpSeq"/><span>${data.menuGrpNm }</span></label></dd>
                                </c:if>
                           </c:forEach>
                       </dl>
                       <dl class="groupList">
                           <dt>파트너회원</dt>
                           <c:forEach var = "data" items="${menuGrpVoList}">
                                <c:if test="${data.userTypeCd eq 'PARTNER'}">
                                   <dd><label><input type="radio" name="searchMenuGrpSeq" value="${data.menuGrpSeq }" id="searchMenuGrpSeq"/><span>${data.menuGrpNm }</span></label></dd>
                                </c:if>
                           </c:forEach>
                       </dl>
                       <dl class="groupList">
                           <dt>관리자</dt>
                           <c:forEach var = "data" items="${menuGrpVoList}">
                                <c:if test="${data.userTypeCd eq 'SYS_MNG' or data.userTypeCd eq 'OPER_MNG'  }">
                                   <dd><label><input type="radio" name="searchMenuGrpSeq" value="${data.menuGrpSeq }" id="searchMenuGrpSeq"/><span>${data.menuGrpNm }</span></label></dd>
                                </c:if>
                           </c:forEach>
                       </dl>
                   </td>
               </tr>
           </tbody>
       </table>
       </div>
       <div id = "menuGrpDetailArea">
       </div>
       <div id = "menuGrpMenuListArea">
       </div>

    <!-- 메뉴그룹 사용여부를 업데이트하기위한 파라미터 -->
    <input type="hidden" name = "menuGrpSeq" id = "menuGrpSeq">
    <input type="hidden" name = "businessTypeCd" id = "businessTypeCd">
    <input type="hidden" name = "searchMenuSeq" id = "searchMenuSeq">
    <!-- 모달창 오픈시 작성/수정을 판단하기위한 파라미터 -->
    <input type="hidden" name = "mode" id = "mode">
    </section>
</form>

<!-- 모달창 : 신규 메뉴등록 :S -->
<div id="createModal" style="display: none;">
</div>
<!-- 모달창 : 신규 메뉴등록 :E -->
