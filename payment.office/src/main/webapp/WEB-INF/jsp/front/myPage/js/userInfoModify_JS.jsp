<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript">
showLoadingImage("200px","-350px","985px","500px");
</script>
<script type="text/javascript" defer="defer">
 // 전역변수
 var certificationNumber = false;
 var timer;

$(document).ready(function(){

    $('#frm').validate({
        rules: {
            birthDay: { required: true, minlength : 6}
           ,telNo02: { required: true, minlength : 7}
           ,certificationNumber: { required: true}
           ,email1: { required: true}
           ,email2: { required: true}
        },
       	messages: {
            birthDay: {
        	   required: "<spring:message code='required.common.input' arguments='생년월일'/>"
        	   ,minlength : "<spring:message code='noti.myPage.birthDateInput6Degit' />"  /*생년월일은 6자리로 입력해 주시기 바랍니다.*/
           }
           ,telNo02: {required: "<spring:message code='required.common.input' arguments='휴대번호'/>"
        	   ,minlength : "<spring:message code='noti.myPage.mobileInputRight' />"  /*휴대번호를 바르게 입력해 주시기 바랍니다.*/
           }
           ,certificationNumber: {required: "<spring:message code='required.common.input' arguments='인증번호'/>"}
           ,email1: {required: "<spring:message code='required.common.input' arguments='이메일'/>"}
           ,email2: {required: "<spring:message code='required.common.input' arguments='이메일'/>"}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
             $(error.element).focus();
        },onsubmit: false
    });

    //생년월일 유효성 체크
    $("#birthDay").keyup(function(){
        fn_checkBirthDay();
    });
    //핸드폰번호
    $("#telNo02").keyup(function(){
        fn_checkTelNo($(this));
    });
    //핸드폰번호
    $("#telNo03").keyup(function(){
        fn_checkTelNo($(this));
    });
    //인증번호 요청 버튼
    $("#btnConfirmTelNo").click(function(){
        fn_reqConfirmNo();
    });
    //인증번호 확인 버튼
    $("#btnConfirmNoChk").click(function(){
        fn_confirmNoChk();
    });


    $("#emailDomainCd").change(function(){
        if($(this).val()!=""){
            $("#email2").val($(this).find("option:selected").text()).blur();
        }
        else{
            $("#email2").val('').blur();
        }
    });
    //취소
    $("#btnCancel").click(function(){
        fn_cancel();
    });
    //수정
    $("#btnModify").click(function(){
        fn_modifyMemberInfo();
    });

    hideLoadingImage();

});

//생년월일 유효성체크
function fn_checkBirthDay(){
    var birthDay = $("#birthDay").val();
    if(!isNumber(birthDay)){
        alert("<spring:message code='required.common.degit' arguments='생년월일'/>");
        $("#birthDay").val("");
        return false;
    }
    if(birthDay.length<6) {
        $("#wrong_noti_birthDay").show();
        return false;
    }

    if(!isValidDate(birthDay)){
        $("#wrong_noti_birthDay").show();
        return;
    }

    $("#wrong_noti_birthDay").hide();
    return true;

}
//핸드폰뒷자리 유효성체크
function fn_checkTelNo($telNo){
    var chkTelNo = $telNo.val();
    if(!isNumber(chkTelNo)){
        alert("<spring:message code='required.common.degit' arguments='전화번호'/>");
        $telNo.val("");
        return false;
    }
    return true;
}

//인증번호요청
function fn_reqConfirmNo(){
    clearInterval(timer);
    $("#telNo02,#telNo03").off();
    certificationNumber = false;
    $("#certificationNumber").attr("disabled","disabled");
    $("#limitTime").hide();
    var chkTelNo = $("#telNo01").val()+$("#telNo02").val()+$("#telNo03").val();
    chkTelNo = chkTelNo.split("-").join("");
    if(!isNumber(chkTelNo)||chkTelNo.length<10){
        alert("<spring:message code='noti.myPage.mobileInputRight' />");  //휴대번호를 바르게 입력해 주시기 바랍니다.
        $("#telNo02,#telNo03").val("");
        return;
    }
    if($("#telNo").val() == toPhoneFormat(chkTelNo)){
        alert("<spring:message code='noti.myPage.mobileSameNumber' />");  //현재 사용중이신 휴대폰 번호 입니다.
        return;
    }
    $("#telNo").val(toPhoneFormat(chkTelNo));
    $("#frm").attr("action" , contextRoot + "/user/common/getReqConfirmNoAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_reqConfirmNoCallback);
}
function fn_reqConfirmNoCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='noti.myPage.sendAuthNum' />");   //인증번호가 전송되었습니다. \\n인증번호 확인 후 정확히 입력해 주시기 바랍니다.
        $("#certificationNumber").attr("disabled",false);
        $("#limitTime").show();
        $("#btnConfirmTelNo").text("재전송");
        $("#btnConfirmTelNo").hide();
        fn_limitTimeInit();
    }else if(data.result == "<c:out value='${Constants.RESULT_EXIST }' />"){
       if(confirm("<spring:message code='noti.myPage.mobileSameNumberGoSearchId' />")){
    	   //입력하신 휴대번호로 가입한 이력이 있습니다.\\nID찾기 후 이용해 주십시오.\\nID찾기 화면으로 이동하시겠습니까?"
           window.location.href = contextRoot + "/user/findIdPassword/gofindIdPasswordForm.do"
       }
    }else{
        alert("<spring:message code='noti.myPage.failSendAuthNum'  arguments='인증번호' />");  //인증번호 발송도중 오류가 발생하였습니다. 잠시후 다시 시도해 주시기 바랍니다.
    }
}
//인증번호 요청후 확인까지 타임머
function fn_limitTimeInit(){
    var remainMin = 1;
    var remainSec = 29;
    var innerRemainSec;

    telChkNo1 = $("#telNo01").val();
    telChkNo2 = $("#telNo02").val();
    telChkNo3 = $("#telNo03").val();

    $("#telNo01").on("change",function(){
        if($(this).val() != telChkNo1){
            if(confirm("<spring:message code='noti.myPage.changeMobileSendAgain' />")){  //휴대번호를 변경하시면 인증번호를 재전송 하셔야 합니다.\\n변경하시겠습니까?
                $("#certificationNumber").attr("disabled","disabled");
                $("#limitTime").hide();
                $("#certificationNumber").val("");
                $("#btnConfirmTelNo").show();
                clearInterval(timer); /* 타이머 종료 */
                $("#telNo01").off();
                $("#telNo02").off();
                $("#telNo03").off();
            }else{
                $(this).val(telChkNo2);
            }
        }
    });

    $("#telNo02").on("keyup",function(){
        if($(this).val() != telChkNo2){
        	if(confirm("<spring:message code='noti.myPage.changeMobileSendAgain' />")){  //휴대번호를 변경하시면 인증번호를 재전송 하셔야 합니다.\\n변경하시겠습니까?
                $("#certificationNumber").attr("disabled","disabled");
                $("#limitTime").hide();
                $("#certificationNumber").val("");
                $("#btnConfirmTelNo").show();
                clearInterval(timer); /* 타이머 종료 */
                $("#telNo01").off();
                $("#telNo02").off();
                $("#telNo03").off();
            }else{
                $(this).val(telChkNo2);
            }
        }
    });

    $("#telNo03").on("keyup",function(){
        if($(this).val() != telChkNo3){
        	if(confirm("<spring:message code='noti.myPage.changeMobileSendAgain' />")){  //휴대번호를 변경하시면 인증번호를 재전송 하셔야 합니다.\\n변경하시겠습니까?
                $("#certificationNumber").attr("disabled","disabled");
                $("#limitTime").hide();
                $("#certificationNumber").val("");
                $("#btnConfirmTelNo").show();
                clearInterval(timer); /* 타이머 종료 */
                $("#telNo01").off();
                $("#telNo02").off();
                $("#telNo03").off();
            }else{
                $(this).val(telChkNo3);
            }
        }
    });

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
            $("#btnConfirmTelNo").show();
            clearInterval(timer); /* 타이머 종료 */
            $("#telNo01").off();
            $("#telNo02").off();
            $("#telNo03").off();
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
        alert("<spring:message code='noti.myPage.inputMobileAfterSend' />");  //휴대번호를 입력 후 인증번호 전송 버튼을 눌러주시기 바랍니다.
        return;
    }

    $("#frm").attr("action" , contextRoot + "/user/common/processReqConfirmNoAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_confirmNoChkCallback);

}
function fn_confirmNoChkCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='noti.myPage.completeAuthInputSaveButton' />");  //인증되었습니다. 하단의 저장 버튼을 눌러 변경 내용을 저장해 주시기 바랍니다.
        certificationNumber = true;
        $("#certificationNumber").attr("disabled","disabled");
        $("#limitTime").hide();
        clearInterval(timer);
        $("#btnConfirmTelNo").text("재전송").hide();
        $("#telNo01").attr("disabled","disabled");
        $("#telNo02").attr("disabled","disabled");
    }else if(data.result == "<c:out value='${Constants.ERROR_CERTIFICATION_TIME_OUT }' />"){
        alert("<spring:message code='noti.myPage.ovetimeOfAuthTime' />");  //인증가능한 시간이 초과되었습니다. 재전송버튼을 클릭하여 주시기 바랍니다.
    }else {
    	alert("<spring:message code='noti.myPage.checkAuthNumAndReinput' />");  //인증번호를 확인하고 다시 입력해 주시기 바랍니다.
    }
}


//수정하기
function fn_modifyMemberInfo(){
	//이름 필수체크
	if($("#userName").val() == ""){
		alert("이름을 입력하여 주시기 바랍니다.")
        $("#userName").focus();
        return;
    }

	//휴대전화 필수체크
    if($("#telNo01").val()=="" || $("#telNo02").val()=="" || $("#telNo03").val()==""){
    	alert("휴대번호를 입력하여 주시기 바랍니다.")
        $("#email1").focus();
        return;
    }

    //이메일 필수체크
    if($("#userEmailAddr1").val()==""){
    	alert("이메일을 입력하여 주시기 바랍니다.")
        $("#email1").focus();
        return;
    }
    if($("#userEmailAddr2").val()==""){
    	alert("이메일을 입력하여 주시기 바랍니다.")
        $("#email1").focus();
        return;
    }

    var userMobileNum = $("#userMobileNum1").val() + "-" + $("#userMobileNum2").val() + "-" + $("#userMobileNum3").val();
    $("#userMobileNum").val(userMobileNum);

    var userEmailAddr = $("#userEmailAddr1").val() + "@" + $("#userEmailAddr2").val();
    $("#userEmailAddr").val(userEmailAddr);


    $("#frm").attr("action" , contextRoot + "/myPage/userInfo/processUserInfoModifyAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_processUserJoinCallback);
}
//가입후 콜백
function fn_processUserJoinCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("정상적으로 수정되었습니다.");
        $("#frm").attr("action",contextRoot + "/main/main.do");
        $("#frm").submit();
    }else{
        alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }
}


//취소버튼
function fn_cancel(){
    if(confirm("<spring:message code='noti.myPage.doYouCancel' />")){  //취소하시겠습니까? 입력중이던 내용은 저장되지 않습니다.
        $("#frm").attr("action",contextRoot + "/myPage/main/myPage.do");
        $("#frm").submit();
    }
}
</script>