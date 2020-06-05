<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    datePickerWrap("#topStartDtS");
    datePickerWrap("#topEndDtS");

    /* ====================================form jquery validation */
    $('#frm').validate({
        rules: {
            title: { required: true, maxlength:100}
           ,categCd: { required: true}
           ,topStartDtS: { required: true}
           ,topEndDtS: { required: true}
        },
        messages: {
            title: { required: "<spring:message code='required.common.input' arguments='제목'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,categCd: { required: "<spring:message code='required.common.select' arguments='공지유형'/>"}
           ,topStartDtS: { required: "<spring:message code='required.common.input' arguments='TOP게시 시작일자'/>"}
           ,topEndDtS: { required: "<spring:message code='required.common.input' arguments='TOP게시 종료일자'/>"}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        },onsubmit: false
    });

    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnCreateNoti").click(function(){
        fn_doCreateNoti();
    });

    //리스트버튼
    $("#btnGoNotiListPage").click(function(){
        fn_goNotiListPage();
    });
    /* ====================================Button Event Setting :E */
});

//저장
function fn_doCreateNoti(){
	if(!$("#frm").valid()) return;

    if (!isExistEditorContent()) {
        alert("<spring:message code='required.common.input' arguments='내용'/>");
        Editor.focus();
        return;
    }

	$("#content").val(Editor.getCanvas().getContent());

	$("#frm").attr("action",contextRoot + "/admin/board/noti/createNotiAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doCreateNotiCallback);
}
//저장 콜백
function fn_doCreateNotiCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		fn_goNotiListPage();
	}else{
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//리스트 페이지로 이동
function fn_goNotiListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/noti/notiList.do");
	$("#moveFrm").submit();
}
</script>