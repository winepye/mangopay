<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/login_JS.jsp"%>
<!--
  * @Class Name  : login.jsp
  * @Description : 관리자메인화면(로그인)
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->

<%@page import="kr.co.smartdatacorp.core.bean.session.LoginSessionInfo"%>
<%-- <c:if test="${sessionScope['scopedTarget.loginSessionInfo'].sessionUserInfoId != '' && sessionScope['scopedTarget.loginSessionInfo'].sessionUserInfoId ne null}">
    <jsp:forward page="/admin/main/adminMainList.do"></jsp:forward>
</c:if> --%>
<style>
body {
        background: white }
    section {
        background: black;
        color: white;
        border-radius: 1em;
        padding: 1em;
        position: absolute;
        top: 50%;
        left: 50%;
        margin-right: -50%;
        transform: translate(-50%, -50%) }
</style>
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">간편결제 관리자 LOGIN</h3>
       	<table id="templateProject" class="tb_left_st2" summary="간편결제 관리자 LOGIN">
           <caption>
               간편결제 관리자 LOGIN
           </caption>
           <colgroup>
               <col width="100px" />
               <col width="*" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row">
                   		<label for="searchUserId">아이디</label>
                   </th>
                   <td>
                   		<input id="searchUserId" name="searchUserId" class="input_s_b w100pro" maxlength="100" onkeypress="javascript:if(event.keyCode==13){fn_doLogin();}"/>
                   </td>
               </tr>
               <tr>
                   <th scope="row">
                   		<label for="searchUserPwd">비밀번호</label>
                   </th>
                   <td>
                   		<input type="password" id="searchUserPwd" name="searchUserPwd" class="input_s_b w100pro" maxlength="100" onkeypress="javascript:if(event.keyCode==13){fn_doLogin();}"/>
                   </td>
               </tr>
           </tbody>
       </table>

        <!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <button type="button" id="btnLogin" class="btn_gray_B01">로그인</button>
        </div>
        <!-- 버튼 -->

       <!--/ 버튼 /-->
        <input type="hidden" id="searchRedirectUrl" name="searchRedirectUrl" value="/report">
	</form>
</section>