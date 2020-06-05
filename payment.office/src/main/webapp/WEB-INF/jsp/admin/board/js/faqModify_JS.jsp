<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Daum Editor Content Settiong */
	setEditorContent($("#content").val());

    $('#frm').validate({
        rules: {
            title: { required: true, maxlength:100}
           ,categCd: { required: true}
        },
        messages: {
            title: { required: "<spring:message code='required.common.input' arguments='제목'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,categCd: { required: "<spring:message code='required.common.select' arguments='FAQ유형'/>"}
        },
        showErrors: function(errorMap, errorList) {
        }, invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
                alert(validator.errorList[0].message);
                validator.errorList[0].element.focus();
            }
       },onsubmit: false
    });

    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnModifyFaq").click(function(){
        fn_doModifyFaq();
    });

    //리스트버튼
    $("#btnGoFaqListPage").click(function(){
        fn_goFaqListPage();
    });
    /* ====================================Button Event Setting :E */
});

//수정
function fn_doModifyFaq(){
	if(!$("#frm").valid()) return;

    if (!isExistEditorContent()) {
        alert("<spring:message code='required.common.input' arguments='내용'/>");
        Editor.focus();
        return;
    }

	$("#content").val(Editor.getCanvas().getContent());

	$("#frm").attr("action",contextRoot + "/admin/board/faq/modifyFaqAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doSaveCallback);
}
//저장 콜백
function fn_doSaveCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		fn_goFaqListPage();
	}else{
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//리스트 페이지로 이동
function fn_goFaqListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/faq/faqList.do");
	$("#moveFrm").submit();
}
</script>