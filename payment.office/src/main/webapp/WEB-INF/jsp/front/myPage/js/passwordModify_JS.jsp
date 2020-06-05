<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : myReportList_JS.jsp
  * @Description : mypage > myReportList_JS
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.09	이인희      최초 생성
-->
<script type="text/javascript" defer="defer">
$(document).ready(function() {

    $('#frm').validate({
        rules: {
            userPwd: { required: true}
           ,userPwd_chkeck: { required: true}
        },
       	messages: {
            userPwd: { required: "<spring:message code='required.common.input' arguments='비밀번호'/>"}
           ,userPwd_chkeck: { required: "<spring:message code='required.common.input' arguments='비밀번호 재확인'/>"}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
             $(error.element).focus();
        },onsubmit: false
    });

    //확인버튼
    $("#btnModifyPassword").click(function(){
        fn_doModifyPassword();
    });

    //비밀번호 유효성 체크
    $("#userPwd").blur(function(){
        $("#userPwd").val($.trim($("#userPwd").val()));
        fn_checkValPwd();
        //if(!fn_checkValPwd()) return; //비밀번호 유효성체크
    });
    //비밀번호 유효성 체크
    $("#userPwd_chkeck").blur(function(){
        $("#userPwd_chkeck").val($.trim($("#userPwd_chkeck").val()));
        fn_checkValPwd();
        //if(!fn_checkValPwd()) return; //비밀번호 유효성체크
    });

    $("#btnCancel").click(function(){
    	fn_cancel();
    });
});
//취소버튼
function fn_cancel(){
    if(confirm("<spring:message code='noti.myPage.doYouCancel' />")){  //취소하시겠습니까? 입력중이던 내용은 저장되지 않습니다.
        $("#frm").attr("action",contextRoot + "/myPage/main/myPage.do");
        $("#frm").submit();
    }
}
//확인
function fn_doModifyPassword(){
    if(!$("#frm").valid()) return;

    if(!fn_checkValPwd()){
        $("#userPwd").focus();
        return;
    }

    $("#frm").attr("action",contextRoot + "/myPage/password/modifyPasswordAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_doModifyPasswordCallback);
}
//확인 콜백
function fn_doModifyPasswordCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("비밀번호가 변경되었습니다. 다시 로그인해 주시기 바랍니다.");  //비밀번호가 변경되었습니다. 다시 로그인해 주시기 바랍니다.
        $(location).attr('href', contextRoot + "/login/login.do");
    }else{
        alert("비밀번호변경에 실패했습니다. 담당자에게 문의하시기 바랍니다.");  //비밀번호변경에 실패했습니다. 담당자에게 문의하시기 바랍니다.
    }
}

//비밀번호 유효성 체크
function fn_checkValPwd(){

    $("#userPwd_recheck_wrong_noti").css("display","none");
    $("#userPwd_check_wrong_noti").css("display","none");
    $("#userPwd_regood_noti").css("display","none");
    $("#userPwd_good_noti").css("display","none");

    if( $('#userPwd').val() == ""){
        $("#userPwd_check_wrong_noti").css("display","block").text("<spring:message code='required.common.input' arguments='비밀번호'/>");
        return false;
    }
    var userPwd = $('#userPwd').val();

    if(isPasswordFormat(userPwd)){
        $("#userPwd_check_wrong_noti").css("display","block").text("<spring:message code='noti.myPage.inputPwChar' />");  //8~20자리 영문, 숫자, 특수문자 중 2가지 이상 조합하여 사용하시기 바랍니다.
        return false;
    }

    $("#userPwd_good_noti").css("display","block");

    if($('#userPwd_chkeck').val()==""){
        $("#userPwd_recheck_wrong_noti").css("display","block").text("<spring:message code='required.common.reqInfo'/>");  //필수정보 입니다.
        return false;
    }else if( userPwd != $('#userPwd_chkeck').val() ){
        /* $('#userPwd_chkeck').focus(); */
        $("#userPwd_recheck_wrong_noti").css("display","block").text("<spring:message code='noti.myPage.noMatchPw' />");  //비밀번호가 일치하지 않습니다.
        return false;
    }else{
        $("#userPwd_regood_noti").css("display","block");
    }
    $("#userPwd_recheck_wrong_noti").css("display","none");
    $("#userPwd_check_wrong_noti").css("display","none");
    return true;
}

</script>