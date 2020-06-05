<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    $('#frm').validate({
        rules: {
            searchUserId: { required: true}
           ,searchUserPwd: { required: true}
        },
       	messages: {
            searchUserId: { required: "<spring:message code='required.common.input' arguments='아이디'/>"}
           ,searchUserPwd: { required: "<spring:message code='required.common.input' arguments='비밀번호'/>"}
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

  	//로그아웃버튼 : 미사용
    $("#btnLogout").click(function(){
        fn_doLogout();
    });

 	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name='searchUserId']").val(userInputId);

    if($("input[name='searchUserId']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
        $("#chk").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }

    $("#chk").change(function(){ // 체크박스에 변화가 있다면,
        if($("#chk").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='searchUserId']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });

    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='searchUserId']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#chk").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='searchUserId']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });

});

//로그인
function fn_doLogin(){
    if(!$("#frm").valid()) return;

    if($("#searchUserId").val() == ""){
        $("#usrId").focus();
        return;
    }
    if($("#searchUserPwd").val() == ""){
        $("#pw").focus();
        return;
    }

	$("#frm").attr("action" , contextRoot + "/login/processWebLoginAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doLoginCallBack);
}
//로그인 콜백
function fn_doLoginCallBack(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		//2016.09.12.이인희 팝업
        /* $.each(data.popupVoList, function( index, value ) {
        	if(getCookie("mainPopup_"+value.popupSeq) != "N"){
        		commonPopupOpen(value.popupSeq,400,400);
            }
        });
		//2016.08.11.이인희 등급변경알림
	    if(data.noConfirmUserLvlUpdateList!=undefined){
            //회원등급변경 미확인건 팝업실행
             $.each(data.noConfirmUserLvlUpdateList, function( index, value ) {
                 var popMessage  = "<spring:message code='noti.login.notiUserGrade1' />" + value.updateAftLvlNm + "<spring:message code='noti.login.notiUserGrade2' />";
                 //회원님의 등급이  으로 변경되었습니다.\n\n등급변경에 대한 문의사항은 1:1문의를 이용해 주시기 바랍니다.
                 alert(popMessage);
            });
	    } */

        //Redirect Url로 이동
		if($("#searchRedirectUrl").val()!=""){
			$(location).attr('href',contextRoot+$("#searchRedirectUrl").val());
		}
		else{
			$(location).attr('href', contextRoot+"/main/main.do"); /* 변경될수 있음 */
		}
	}else if(data.result == "<c:out value='${Constants.LOGIN_RESULT_DORMANT }' />"){  //휴면계정
		alert("<spring:message code='noti.login.notiDormantAccount' />");  //휴면계정으로 등록된 아이디 입니다.\\n휴면계정 재이용 신청 후 이용 가능합니다.
		$("#frm").attr("action",contextRoot + "/user/dormantAccount/gofindDormantAccountForm.do");
        $("#frm").submit();
	}else{
		$("#login_noti").css("display","");
	}
}

//로그아웃 : 미사용
function fn_doLogout(){
	$("#frm").attr("action" , contextRoot + "/login/processWebLogoutAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doLogoutCallBack);
}
//로그아웃 콜백 : 미사용
function fn_doLogoutCallBack(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='noti.login.logoutGoMain' />")  //로그아웃되었습니다. 메인페이지로 이동합니다.
		$(location).attr('href', contextRoot); /* 변경 될수 있음 */
	}else{
		alert("<spring:message code='fail.common.msg' />");  //에러가 발생했습니다.
	}
}

//아이디/비밀번호 찾기
function fn_gofindIdPasswordForm(pStr){
	if(pStr == "id"){
		$("#searchFindType").val(pStr);
		$("#frm").attr("action",contextRoot + "/user/findIdPassword/gofindIdPasswordForm.do");
		$("#frm").submit();
	}
	else{
		$("#searchFindType").val(pStr);
		$("#frm").attr("action",contextRoot + "/user/findIdPassword/gofindIdPasswordForm.do");
		$("#frm").submit();
	}
}

//회원가입(약관동의 화면으로 이동)
function fn_memberJoinForm(){
	$("#frm").attr("action",contextRoot + "/user/join/join.do");
	$("#frm").submit();
}
</script>