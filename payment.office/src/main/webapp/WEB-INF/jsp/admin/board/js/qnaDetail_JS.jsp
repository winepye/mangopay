<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    /* ====================================Button Event Setting :S */
    //답변등록페이지로 이동버튼
    $("#btnGoQnaAnswerCreatePage").click(function(){
        fn_goGoQnaAnswerCreatePage();
    });

  	//답변수정페이지로 이동버튼
    $("#btnGoQnaAnswerModifyPage").click(function(){
        fn_goGoQnaAnswerModifyPage();
    });

    //목록버튼
    $("#btnGoQnaListPage").click(function(){
        fn_goQnaListPage();
    });
    /* ====================================Button Event Setting :E */
});

//답변등록 페이지로 이동
function fn_goGoQnaAnswerCreatePage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/qna/qnaAnswerCreate.do");
	$("#moveFrm").submit();
}
//답변수정 페이지로 이동
function fn_goGoQnaAnswerModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/qna/qnaAnswerModify.do");
	$("#moveFrm").submit();
}
//리스트 페이지로 이동
function fn_goQnaListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/qna/qnaList.do");
	$("#moveFrm").submit();
}
</script>