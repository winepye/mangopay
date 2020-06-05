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
//전역변수
var certificationNumber = false;
var timer;
$(document).ready(function() {
	//핸드폰번호
    $("#telNo02").keyup(function(){
        fn_checkTelNo02();
    });

    $("#searchUserPwd").blur(function(){
        if(!fn_checkValPwd()) return; //비밀번호 유효성체크
    });
    $("#searchUserPwd").keyup(function(){
    	$("#userPwd_check_wrong_noti").hide();
        $("#userPwd_good_noti").hide();
        $("#userPwd_check_wrong_empty").hide();
        $("#userPwd_check_wrong_format").hide();
    });
    //인증번호 요청 버튼
    $("button[name='btnConfirmTelNo']").click(function(){
        fn_reqConfirmNo();
    });
    //인증번호 확인 버튼
    $("#btnConfirmNoChk").click(function(){
        fn_confirmNoChk();
    });
    $("#btnCancel").click(function(){
        fn_cancel();
    });
    $("#btnWithraw").click(function(){
        fn_processWithdraw();
    });

});
//취소버튼
function fn_cancel(){
	if(confirm("<spring:message code='noti.myPage.doYouCancel' />")){  //취소하시겠습니까? 입력중이던 내용은 저장되지 않습니다.
        $("#frm").attr("action",contextRoot + "/myPage/main/myPage.do");
        $("#frm").submit();
    }
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
//비밀번호 체크
function fn_checkValPwd(){
    var userPwd = $("#searchUserPwd").val();
    if(userPwd == ""){
    	$("#userPwd_check_wrong_noti").hide();
   	    $("#userPwd_good_noti").hide();
   	    $("#userPwd_check_wrong_format").hide();
    	$("#userPwd_check_wrong_empty").show();
    	return false;
    }

    if(!isValidPasswd(userPwd)){
    	$("#userPwd_check_wrong_noti").hide();
        $("#userPwd_good_noti").hide();
        $("#userPwd_check_wrong_empty").hide();
    	 $("#userPwd_check_wrong_format").show();
        return false;
    }

    $("#frm").attr("action" , contextRoot + "/myPage/withdraw/getIsPwMatchAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_checkValPwdCallback);
    return true;
}
//비밀번호 체크 콜백
function fn_checkValPwdCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		$("#userPwd_check_wrong_noti").hide();
	    $("#userPwd_check_wrong_empty").hide();
	    $("#userPwd_check_wrong_format").hide();
		$("#userPwd_good_noti").show();
		return true;
    }else{
    	alert("<spring:message code='fail.common.select' />");  //조회에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    	return false;
    }
}
//인증번호요청
function fn_reqConfirmNo(){
    clearInterval(timer);
    certificationNumber = false;
    $("#certificationNumber").attr("disabled","disabled");
    $("#limitTime").hide();

    if(!fn_checkValPwd()){
    	$("#searchUserPwd").focus();
    	return;
    }

    if($("#searchUserName").val() == ""){
    	alert("<spring:message code='required.common.input' arguments='이름'/>");
        $("#searchUserName").focus();
        return;
    }

    var chkTelNo = $("#telNo01").val()+$("#telNo02").val();
    chkTelNo = chkTelNo.split("-").join("");
    if(!isNumber(chkTelNo)||chkTelNo.length<10){
        alert("<spring:message code='noti.myPage.mobileInputRight' />");  //휴대번호를 바르게 입력하여 주시기 바랍니다.
        $("#telNo02").val("");
        return;
    }
    $("#searchTelNo").val(chkTelNo);

    $("#frm").attr("action" , contextRoot + "/myPage/withdraw/getReqConfirmNoByuUerWithdrawAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_reqConfirmNoCallback);
}
function fn_reqConfirmNoCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='noti.myPage.sendAuthNum' />");  //인증번호가 전송되었습니다. \\n인증번호 확인 후 정확히 입력해 주시기 바랍니다.
        $("#certificationNumber").attr("disabled",false);
        $("#limitTime").show();
        $("#btnConfirmTelNo").text("재전송");
        fn_limitTimeInit();
    }else if(data.result == "<c:out value='${Constants.ERROR_MOBILE_CERTIFICATION }' />"){
        alert("<spring:message code='noti.myPage.failSendAuthNum'  arguments='SMS' />");  //SMS 발송도중 오류가 발생하였습니다. 잠시후 다시 시도해 주시기 바랍니다.
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
        $("#searchUserPwd").attr("disabled","disabled");
        $("#searchUserName").attr("disabled","disabled");
        $("#telNo01").attr("disabled","disabled");
        $("#telNo02").attr("disabled","disabled");
        $("#limitTime").hide();
        $("button[name='btnConfirmTelNo']").hide();
        $("#btnConfirmNoChk").hide();
    }else if(data.result == "<c:out value='${Constants.ERROR_CERTIFICATION_TIME_OUT }' />"){
    	alert("<spring:message code='noti.myPage.ovetimeOfAuthTime' />");  //인증가능한 시간이 초과되었습니다. 재전송버튼을 클릭하여 주시기 바랍니다.
    }else {
    	alert("<spring:message code='noti.myPage.checkAuthNumAndReinput' />");  //인증번호를 확인하고 다시 입력해 주시기 바랍니다.
    }
}
//탈퇴하기
function fn_processWithdraw(){
	if(!$("#input_service").prop("checked")){
		$("#input_service").focus();
		alert("<spring:message code='noti.myPage.confirmUserWithdrawAgree' />");  //회원탈퇴시 동의사항을 확인하여 주시기 바랍니다.
		return;
	}

	if(!certificationNumber){
		if(!fn_checkValPwd()){
	        $("#searchUserPwd").focus();
	        return;
	    }

	    if($("#searchUserName").val() == ""){
	        alert("<spring:message code='required.common.input' arguments='이름'/>");
	        $("#searchUserName").focus();
	        return;
	    }

		alert("<spring:message code='noti.myPage.authMobileRightNow' />");  //휴대전화를 인증해 주시기 바랍니다.
		$("#telNo02").focus();
		return;
	}
	$("#frm").attr("action" , contextRoot + "/myPage/withdraw/processUserWithdrawAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_processWithdrawCallback);
}
//탈퇴 콜백
function fn_processWithdrawCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='noti.myPage.completeUserWithdraw' />");  //회원탈퇴 되었습니다.\\n그동안 간편결제을 이용해 주셔서 감사합니다.
        $("#frm").attr("action" , contextRoot + "/myPage/withdraw/userWithdrawComplete.do").submit();
    }else{
    	alert("<spring:message code='noti.myPage.noUserInfo' />");  //일치하는 회원정보가 없습니다.
    }
}
</script>