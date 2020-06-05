<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/findIdPass_JS.jsp"%>
<!--
  * @Class Name  : login.jsp
  * @Description : 관리자메인화면(로그인)
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14    이인희      최초 생성
  * @ 2016.05.16    이인희      퍼블적용
-->
<section id="detail_contents">
    <form id = "frm" name = "frm" method="post">
    <div class="joinWrap">
        <!--tab-->
        <div class="gtabZone count_n02">
            <ul id="tabMenu">
                <li id="tabId" onclick="fn_moveTab('id');">
                <a href="#this">아이디찾기</a>
                </li>
                <li id="tabPassword" onclick="fn_moveTab('password');">
                    <a href="#this">비밀번호 찾기</a>
                </li>
            </ul>
        </div>
        <!--//tab//-->
    </div>

    <div style="height: 5px"></div>

    <div id = "listArea">
        <jsp:include page="./include/findIdPass_INC.jsp"></jsp:include>
    </div>

    <!-- 검색이나 화면이동을 위한 데이터 -->
    <input type="hidden" id = "searchFindType" name = "searchFindType">
    <input type="hidden" id = "searchChkeckType" name = "searchChkeckType">
    <input type="hidden" id = "searchTelNo" name = "searchTelNo">
    </form>

</section>