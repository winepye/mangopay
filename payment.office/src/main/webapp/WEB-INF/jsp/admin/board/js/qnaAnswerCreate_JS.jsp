<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnCreateQna").click(function(){
    	fn_doCreateQna();
    });

    //리스트버튼
    $("#btnGoQnaListPage").click(function(){
        fn_goQnaListPage();
    });
    /* ====================================Button Event Setting :E */
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

	$("#frm").attr("action",contextRoot + "/admin/board/qna/createQnaAnswerAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doCreateNotiCallback);
}
//저장 콜백
function fn_doCreateNotiCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		fn_goQnaDetailPage();
	}else{
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//리스트 페이지로 이동
function fn_goQnaListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/qna/qnaList.do");
	$("#moveFrm").submit();
}
//상세 페이지로 이동
function fn_goQnaDetailPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/qna/qnaDetail.do");
	$("#moveFrm").submit();
}
</script>