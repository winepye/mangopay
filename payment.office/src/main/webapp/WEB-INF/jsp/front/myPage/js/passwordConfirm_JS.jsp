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
           searchUserPwd: { required: true}
        },
       	messages: {
           searchUserPwd: { required: "<spring:message code='required.common.input' arguments='비밀번호'/>"}
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
    $("#btnPasswordConfirm").click(function(){
        fn_confirmPassword();
    });

    //비밀번호 유효성 체크
    /* $("#searchUserPwd").blur(function(){
        $("#searchUserPwd").val($.trim($("#searchUserPwd").val()));
        fn_checkValPwd();
        //if(!fn_checkValPwd()) return; //비밀번호 유효성체크
    }); */
});

//확인
function fn_confirmPassword(){
    if(!$("#frm").valid()) return;

    /* if(!fn_checkValPwd()){
        $("#searchUserPwd").focus();
        return;
    } */
    $("#frm").attr("action",contextRoot + "/myPage/password/confirmPasswordAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_confirmPasswordCallback);
}
//확인 콜백
function fn_confirmPasswordCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        $("#frm").attr("action",contextRoot + "${url}").submit();
    }else{
        alert("<spring:message code='noti.myPage.failInputPw' />");  //입력하신 비밀번호가 현재 비밀번호와 일치 하지 않습니다.\\n다시 입력해 주시기 바랍니다.
    }
}

</script>