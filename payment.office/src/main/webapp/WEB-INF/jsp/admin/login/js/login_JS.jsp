<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){

	$('#searchUserId').focus();

	//var isLogin =  "${sessionScope['scopedTarget.loginSessionInfo'].isLogin}";

	//if(isLogin == 'true') $(location).attr('href',contextRoot+"/admin/main/adminMainList.do");

    $('#frm').validate({
        rules: {
            searchUserId: { required: true}
           ,searchUserPwd: { required: true}
        },
        messages: {
            searchUserId: { required: "<spring:message code='required.common.input' arguments='아이디'/>"}
           ,searchUserPwd: { required: "<spring:message code='required.common.select' arguments='비밀번호'/>"}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        },onsubmit: false
    });

	  	//로그인버튼
	    $("#btnLogin").click(function(){
	        fn_doLogin();
	    });
	});

	$(document).ready(function(){
	  	//로그아웃버튼
	    $("#btnLogout").click(function(){
	        fn_doLogout();
	    });
	});

	//로그인
	function fn_doLogin(){
	    if(!$("#frm").valid()) return;

        $("#frm").attr("action" , contextRoot + "/admin/login/processAdminLoginAjax.do");
		commonAjaxSubmit("POST", $("#frm"), fn_doLoginCallBack);
	}
	//로그인 콜백
	function fn_doLoginCallBack(data){
        if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
            $(location).attr('href',contextRoot+"/admin/main/adminMainList.do");
            /* if($("#searchRedirectUrl").val()){
                $(location).attr('href',$("#searchRedirectUrl").val());
            }
            else{
                $(location).attr('href',contextRoot+"/admin/main/adminIndex.do");
            } */
        }else{
            alert("일치하는 회원정보가 없습니다. 아이디와 패스워드를 확인해 주시기 바랍니다.");
        }
	}

	//로그아웃
	function fn_doLogout(){
		$("#frm").attr("action" , contextRoot + "/admin/login/processAdminLogoutAjax.do");
		commonAjaxSubmit("POST", $("#frm"), fn_doLogoutCallBack);
	}
	//로그인 콜백
	function fn_doLogoutCallBack(data){
        if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
            alert("<spring:message code='noti.login.logout' />");  //로그아웃되었습니다.
            $(location).attr('href', contextRoot+"/admin/login/login.do");
        }else{
            alert("<spring:message code='fail.common.msg' />");  //에러가 발생했습니다.
        }
	}

</script>