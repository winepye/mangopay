<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">

$(document).ready(function() {


});

function fn_sendEmail(){
    $("#frm").attr("action",contextRoot + "/sample/emailDoSend.do");
    commonAjaxSubmit("POST", $("#frm"), fn_sendEmailCallback);
}

function fn_sendEmailCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.sendSuccess' arguments='이메일'/>");  //{0}(이)가 전송 성공하였습니다.
    }else{
    	alert("<spring:message code='fail.common.sendFail' arguments='이메일'/>");  //{0}(이)가 전송 실패하였습니다.
    }
}
</script>