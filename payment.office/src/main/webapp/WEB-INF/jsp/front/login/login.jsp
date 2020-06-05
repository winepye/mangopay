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
  * @
-->

<%@page import="kr.co.smartdatacorp.core.bean.session.LoginSessionInfo"%>

<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">

		<!--로그인-->
		<div class="loginBox">
			<dl class="inputlogin">
				<dt><label for="idname01">아이디</label></dt>
				<dd><input type="text" id="searchUserId" name="searchUserId" class="login_s_b w100pro" style="ime-mode:disabled;" onkeypress="javascript:if(event.keyCode==13){fn_doLogin();}"/></dd>
		    </dl>
			<dl class="inputlogin">
				<dt><label for="idname02">비밀번호</label></dt>
		        <dd><input type="password" id="searchUserPwd" name="searchUserPwd" class="login_s_b w100pro" style="ime-mode:disabled;" onkeypress="javascript:if(event.keyCode==13){fn_doLogin();}"/>
					<p class="login_noti" id="login_noti" style="display:none;">아이디 또는 비밀번호를 다시 확인하세요.</p>
		            <%-- <p class="customer_noti">아이디 찾기에 문제가 있나요? <a href="${pageContext.request.contextPath}/board/faq/faqList.do" target="_self">고객센터 바로가기</a></p> --%>
		        </dd>
		    </dl>
		    <div class="login_option">
		    	<div class="idcheck">
		    		<label>
		    			<input type="checkbox" id="chk" name="chk"/>
		    			<span>아이디저장</span></label>
				</div>
		        <!-- <ul class="op_btn">
		            <li><a href="#" id="btnIdSearch" onclick="javascript:fn_gofindIdPasswordForm('id');">아이디 찾기</a></li>
		            <li><a href="#" id="btnPwSearch" onclick="javascript:fn_gofindIdPasswordForm('password');">비밀번호 찾기</a></li>
		        </ul> -->
		    </div>
		</div>

		<!--//로그인//-->
		<%-- <c:if test="${sessionScope['scopedTarget.loginSessionInfo'].sessionUserInfoId == '' || sessionScope['scopedTarget.loginSessionInfo'].sessionUserInfoId eq null}"> --%>
			<button type="button" class="btn_login_st" id="btnLogin"><span class="icon_check">로그인</span></button>
		<%-- </c:if> --%>
		<!--//로그인//-->

		<!-- 검색이나 화면이동을 위한 데이터 -->
		<input type="hidden" id = "searchFindType" name = "searchFindType">
		<input type="hidden" id = "searchRedirectUrl" name = "searchRedirectUrl" value="${param.searchRedirectUrl }">

	</form>

</section>