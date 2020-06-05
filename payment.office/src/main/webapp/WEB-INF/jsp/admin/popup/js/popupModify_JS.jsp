<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

	datePickerWrap("#popupStartDtS");
    datePickerWrap("#popupEndDtS");

    /* ====================================form jquery validation */
    $('#frm').validate({
        rules: {
            title: { required: true, maxlength:100}
           ,popupYn: { required: true}
           ,popupStartDtS: { required: true}
           ,popupEndDtS: { required: true}
        },
        messages: {
            title: { required: "<spring:message code='required.common.input' arguments='팝업 제목'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,popupYn: { required: "<spring:message code='required.common.select' arguments='팝업여부'/>"}
           ,popupStartDtS: { required: "<spring:message code='required.common.input' arguments='팝업 시작일자'/>"}
           ,popupEndDtS: { required: "<spring:message code='required.common.input' arguments='팝업 종료일자'/>"}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        },onsubmit: false
    });
    /* ====================================Daum Editor Content Settiong */
	setEditorContent($("#content").val());

    //등록버튼
    $("#btnModifyPopup").click(function(){
        fn_doModifyPopup();
    });

    //리스트버튼
    $("#btnGoPopupListPage").click(function(){
        fn_goPopupListPage();
    });
    /* ====================================Button Popup Setting :E */
});

//수정
function fn_doModifyPopup(){
	if(!$("#frm").valid()) return;

	if($("#popupStartDtS").val() == ""){
        alert("<spring:message code='required.common.input' arguments='팝업 시작일자'/>");
        $("#popupStartDtS").focus();
        return;
    }else if($("#popupEndDtS").val() == ""){
        alert("<spring:message code='required.common.input' arguments='팝업 종료일자'/>");
        $("#popupEndDtS").focus();
        return;
    }
	if (!isExistEditorContent()) {
        alert("<spring:message code='required.common.input' arguments='내용'/>");
        Editor.focus();
        return;
    }

	$("#content").val(Editor.getCanvas().getContent());

	$("#frm").attr("action",contextRoot + "/admin/popup/popup/modifyPopupAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doSaveCallback);
}
//저장 콜백
function fn_doSaveCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		fn_goPopupListPage();
	}else{
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//리스트 페이지로 이동
function fn_goPopupListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/popup/popup/popupList.do");
	$("#moveFrm").submit();
}
</script>