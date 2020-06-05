<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">

//전역변수
var certificationNumber = false;

var timer;
$(document).ready(function(){

    //탭 디폴트 활성화 :아이디
    fn_moveTab();
    //핸드폰번호
    $("#telNo02").keyup(function(){
        fn_checkTelNo02();
    });

	$("#userPwd").blur(function(){
		if(!fn_checkValPwd()) return; //비밀번호 유효성체크
    });
	//비밀번호 유효성 체크
    $("#searchEmail").blur(function(){
        fn_checkEmail('searchEmail');
    });
    //인증번호 요청 버튼
    $("button[name='btnConfirmTelNo']").click(function(){
        fn_reqConfirmNo();
    });
    //인증번호 확인 버튼
    $("#btnConfirmNoChk").click(function(){
        fn_confirmNoChk();
    });

    //로그인버튼
    $("#btnGoLoginPage").click(function(){
        fn_goLoginPage();
    });
});
function fn_initPage(){
	if($("#searchChkeckType").val() == 'email'){
		$("#chkEmail").prop("checked",true);
	} else{
		$("#chkSms").prop("checked",true);
		$("#searchChkeckType").val("mobile");
	}

    certificationNumber = false;
    clearInterval(timer);
    $("#telNo01").val("010");
    $("input[type='text']").val("");
    fn_doChkeckType($("#searchChkeckType").val());
    $(".good_noti").hide();
    $(".wrong_noti").hide();
    $(".joinList").show();
    $(".passwordResult").hide();
    $(".idResult").hide();
    $("#limitTime").hide();
    $("#wrong_noti_sms").show();

}

//상단 탭 이동
function fn_moveTab(){
    fn_initPage();
    $("#tabId").addClass("on");
    $("#tabPassword").removeClass("on");
    $("#tabId").append("<em id=\"emId\" class=\"point\"></em>");
    $("#tabPassword emId").remove();
    $("#userIdArea").show();
}
//인증방식 선택
function fn_doChkeckType(type){
    switch(type){
    case 'mobile' :
        $("#wrong_noti_sms").show();
        $("#wrong_noti_email").hide();
        $("#mobileArea").show();
        $("#emailArea").hide();

        break;
    case 'email' :
        $("#wrong_noti_email").show();
        $("#wrong_noti_sms").hide();
        $("#emailArea").show();
        $("#mobileArea").hide();
        break;
    }
    clearInterval(timer);
    certificationNumber = false;
    $("#certificationNumber").attr("disabled","disabled");
    $("button[name='btnConfirmTelNo']").text("인증번호 전송");
    $("#limitTime").hide();
    $("#searchChkeckType").val(type);
}
//핸드폰뒷자리 유효성체크
function fn_checkTelNo02(){
    var chkTelNo = $("#telNo02").val();
    if(!isNumberMinus(chkTelNo)){
        alert("<spring:message code='required.common.degitDash' />");  //숫자와 - 만 입력 가능합니다.
        $("#telNo02").val("");
        return false;
    }
    return true;
}
//이메일 유효성 체크
function fn_checkEmail(id){
    var $email = $('#'+id);

    if( isEmail($email) == false ){
        $("#wrong_noti_email_error").show();
        return false;
    }
    $("#wrong_noti_email_error").hide();
    return true;
}

//인증번호요청
function fn_reqConfirmNo(){
    if($("#searchUserId").val()==""){
        alert("<spring:message code='required.common.input' arguments='아이디'/>");
        $("#searchUserId").focus();
        return;
    };

    clearInterval(timer);
    certificationNumber = false;
    $("#certificationNumber").attr("disabled","disabled");
    $("#limitTime").hide();

    if($("#searchChkeckType").val() == "mobile"){
        var chkTelNo = $("#telNo01").val()+$("#telNo02").val();
        chkTelNo = chkTelNo.split("-").join("");
        if(!isNumber(chkTelNo)||chkTelNo.length<10){
            alert("<spring:message code='noti.myPage.mobileInputRight' />");  //휴대번호를 바르게 입력하여 주시기 바랍니다.
            $("#telNo02").val("");
            return;
        }
        $("#searchTelNo").val(chkTelNo);
    }else if($("#searchChkeckType").val() == "email"){
        if(!fn_checkEmail('searchEmail')){
            return;
        }
    }

    $("#frm").attr("action" , contextRoot + "/user/findIdPassword/getReqConfirmNoByFindUserAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_reqConfirmNoCallback);
}
function fn_reqConfirmNoCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='noti.myPage.sendAuthNum' />");  //인증번호가 전송되었습니다. \\n인증번호 확인 후 정확히 입력해 주시기 바랍니다.
        $("#certificationNumber").attr("disabled",false);
        $("#limitTime").show();
        $("button[name='btnConfirmTelNo']").text("재전송");
        fn_limitTimeInit();
    }else if(data.result == "MOBILE_ERROR"){
    	alert("<spring:message code='noti.myPage.failSendAuthNum'  arguments='SMS' />");  //SMS 발송도중 오류가 발생하였습니다. 잠시후 다시 시도해 주시기 바랍니다.
    }else if(data.result == "EMAIL_ERROR"){
    	alert("<spring:message code='noti.myPage.failSendAuthNum'  arguments='EMAIL' />");  //EMAIL 발송도중 오류가 발생하였습니다. 잠시후 다시 시도해 주시기 바랍니다.
    }else{
    	alert("<spring:message code='noti.myPage.noUserInfo' />");  //일치하는 회원정보가 없습니다.
    }
}


//인증번호 요청후 확인까지 타임머
function fn_limitTimeInit(){
    var remainMin = 1;
    var remainSec = 29;
    var innerRemainSec;
    timer = setInterval(function () {
    	// 설정
        innerRemainSec=remainSec<10?"0"+remainSec:remainSec
        $("#remainSec").text(innerRemainSec);
        $("#remainMin").text(remainMin);

        if(remainMin == 0 && remainSec == 0 ){

            if(certificationNumber) return;

            alert("<spring:message code='noti.myPage.ovetimeOfAuthTime' />");  //인증가능한 시간이 초과되었습니다. 재전송버튼을 클릭하여 주시기 바랍니다.
            $("#certificationNumber").attr("disabled","disabled");
            $("#limitTime").hide();
            $("#certificationNumber").val("");
            clearInterval(timer); /* 타이머 종료 */
        }else{
            remainSec--;
            // 분처리
            if(remainSec < 0){
                remainMin--;
                remainSec = 59;
            }
        }
    }, 1000); /* millisecond 단위의 인터벌 */
}
//인증번호 확인
function fn_confirmNoChk(){
    if($("#certificationNumber").attr("disabled")=="disabled"){
        if(certificationNumber){
        	alert("<spring:message code='noti.myPage.alreadAuth' />");  //이미 인증하셨습니다.
            return;
        }
        alert("<spring:message code='noti.myPage.sendAuthNumFirst' />");  //인증번호 전송을 먼저 해주시기 바랍니다.
        return;
    }

    $("#frm").attr("action" , contextRoot + "/user/common/processReqConfirmNoAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_confirmNoChkCallback);

}
//인증번호 확인 콜백
function fn_confirmNoChkCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='noti.myPage.completeAuthNum' />");  //인증되었습니다.
        certificationNumber = true;
        $("#certificationNumber").attr("disabled","disabled");
        $("#limitTime").hide();
        $("#btnConfirmTelNo").text("인증번호 전송");
        fn_processResultStep();
    }else if(data.result == "<c:out value='${Constants.ERROR_CERTIFICATION_TIME_OUT }' />"){
    	alert("<spring:message code='noti.myPage.ovetimeOfAuthTime' />");  //인증가능한 시간이 초과되었습니다. 재전송버튼을 클릭하여 주시기 바랍니다.
    }else {
    	alert("<spring:message code='noti.myPage.checkAuthNumAndReinput' />");  //인증번호를 확인하고 다시 입력해 주시기 바랍니다.
    }
}
//인증번호 확인 콜백 ***
function fn_processResultStep(){
    var type = $("#searchFindType").val();
    $("#frm").attr("action" , contextRoot + "/user/dormantAccount/getConfirmNumberAgreeDormantAccountAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_goConfirmNumberAgreeCallBack);
}
//확인 버튼 콜백
function fn_goConfirmNumberAgreeCallBack(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
    	alert("<spring:message code='noti.user.recoverDormantAccount' />");  //휴면계정이 복구되었습니다.\n\n로그인 후 정상이용 가능합니다.
    	$(location).attr('href', contextRoot + "/login/login.do");
    }
    else{
    	alert("<spring:message code='noti.myPage.noUserInfo' />");  //일치하는 회원정보가 없습니다.
    }
}
//비밀번호 변경
function fn_doUpdatePassword(){
    if(!fn_checkValPwd()){
        $("#userPwd").focus();
        return;

    }
    $("#frm").attr("action" , contextRoot + "/user/password/modifyUserPasswordAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_doModifyUserPasswordCallBack);
}
//비밀번호 변경 콜백
function fn_doModifyUserPasswordCallBack(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
    	alert("<spring:message code='noti.myPage.confirmChangePw' />");  //비밀번호가 변경되었습니다. 다시 로그인해 주시기 바랍니다.
        $("#frm").attr("action",contextRoot + "/login/login.do");
        $("#frm").submit();
    }
    else{
    	alert("<spring:message code='fail.common.request' arguments='비밀번호변경'/>");  //비밀번호변경에 실패했습니다. 담당자에게 문의하시기 바랍니다.
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

    if(!isValidPasswd(userPwd)){
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
//로그인 페이지 이동
function fn_goLoginPage(){
    $("#frm").attr("action",contextRoot + "/login/login.do").submit();
}

</script>