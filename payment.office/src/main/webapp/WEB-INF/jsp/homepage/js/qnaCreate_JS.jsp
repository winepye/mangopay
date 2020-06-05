<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
		$("#btnCancel").click(function(){
			fn_goQnaListPage();
		});

	  	//저장버튼
	    $("#btnSave").click(function(){
	    	fn_doCreateQna();
	    });
	  	//jquery validation
	    $('#frm').validate({
	        rules: {
	            title: { required: true, maxlength:100}
	           ,content: { required: true}
	           ,agree: { required: true}
	        },
	        messages: {
	            title: { required: "<spring:message code='required.common.input' arguments='이름을'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
	           ,content: { required: "<spring:message code='required.common.select' arguments='문의내용'/>"}
	           ,agree: { required: "<spring:message code='required.common.select' arguments='개인정보수집 동의'/>"}
	        },
	        showErrors: function(errorMap, errorList) {
	        },
	        invalidHandler : function (form, validator) {
	            var error = validator.errorList[0];
	            alert(error.message);
	            $(error.element).focus();
	        },onsubmit: false
	    });
	});

	//저장
	function fn_doCreateQna(){
		if(!$("#frm").valid()) return;

		if($('#userMobileNum').val() == ""){
	    	alert("연락처는 필수 입력입니다.");
	    	$('#userMobileNum').focus();
	        return;
	    }

	    if($(':radio[name="agree"]:checked').val() != "Y"){
	    	alert("개인정보수집에 동의하셔야 합니다.");
	    	$('#agree').focus();
	        return;
	    }

		$("#frm").attr("action",contextRoot + "/createQnaAjax.do");
		commonAjaxSubmit("POST", $("#frm"), fn_doCreateQnaCallback);
	}
	//저장 콜백
	function fn_doCreateQnaCallback(data){
		if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
			alert("문의하신 내용이 정상적으로 접수 되었습니다.");  //정상적으로 저장되었습니다.
			location.href = "/createQna.do";
		}else{
			alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
		}
	}


</script>