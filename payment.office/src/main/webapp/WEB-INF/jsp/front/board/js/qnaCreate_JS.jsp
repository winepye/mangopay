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
	           ,categCd: { required: true}
	        },
	        messages: {
	            title: { required: "<spring:message code='required.common.input' arguments='제목'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
	           ,categCd: { required: "<spring:message code='required.common.select' arguments='문의유형'/>"}
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

	    if (!isExistEditorContent()) {
	        alert("<spring:message code='required.common.input' arguments='내용'/>");
	        Editor.focus();
	        return;
	    }

		$("#content").val(Editor.getCanvas().getContent());

		$("#frm").attr("action",contextRoot + "/board/qna/createQnaAjax.do");
		commonAjaxSubmit("POST", $("#frm"), fn_doCreateQnaCallback);
	}
	//저장 콜백
	function fn_doCreateQnaCallback(data){
		if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
			alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
			fn_goQnaListPage();
		}else{
			alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
		}
	}

	//리스트 페이지로 이동
	function fn_goQnaListPage(){
		$("#moveFrm").attr("action",contextRoot + "/board/qna/qnaList.do");
		$("#moveFrm").submit();
	}

</script>