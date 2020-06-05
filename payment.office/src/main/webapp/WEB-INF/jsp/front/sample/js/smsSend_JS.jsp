<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">

$(document).ready(function() {


});

function fn_sendSms(){
    $("#frm").attr("action",contextRoot + "/sample/smsDoSend.do");
    commonAjaxSubmit("POST", $("#frm"), fn_sendSmsCallback);
}

function fn_sendSmsCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
    	alert("<spring:message code='success.common.sendSuccess' arguments='SMS'/>");  //{0}(이)가 전송 성공하였습니다.
    }else{
    	alert("<spring:message code='fail.common.sendFail' arguments='SMS'/>");  //{0}(이)가 전송 실패하였습니다.
    }
}
</script>