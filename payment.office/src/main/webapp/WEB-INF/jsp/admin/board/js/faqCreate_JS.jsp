<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

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
    $("#btnCreateFaq").click(function(){
        fn_doCreateFaq();
    });

    //리스트버튼
    $("#btnGoFaqListPage").click(function(){
        fn_goFaqListPage();
    });
    /* ====================================Button Event Setting :E */
});

//저장
function fn_doCreateFaq(){
	if(!$("#frm").valid()) return;

    if (!isExistEditorContent()) {
        alert("<spring:message code='required.common.input' arguments='내용'/>");
        Editor.focus();
        return;
    }

	$("#content").val(Editor.getCanvas().getContent());

	$("#frm").attr("action",contextRoot + "/admin/board/faq/createFaqAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doCreateFaqCallback);
}
//저장 콜백
function fn_doCreateFaqCallback(data){
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
//파일업로드
function fn_fileUpload(fileTagId , fileTypeCd ){

	commonFileUploadAjax(fileTagId ,fileTypeCd ,fn_fileUploadCallBack);
}
//파일 업로드 콜백
function fn_fileUploadCallBack(data){
	alert(data.result.path);
	alert("삭제");
	commonAjaxForSync("POST", contextRoot + "/common/file/deleteAjax.do", {"atchFileSeq":data.result.atchFileSeq}, deleteCallback);

}
function deleteCallback(data){
	alert("성공");
}
</script>