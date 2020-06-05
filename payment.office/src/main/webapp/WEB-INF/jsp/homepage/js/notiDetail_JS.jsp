<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    /* ====================================Validation Ready */

    /* ====================================form jquery validation */

    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoNotiModifyPage").click(function(){
        fn_goNotiModifyPage();
    });

    //목록버튼
    $("#btnGoNotiListPage").click(function(){
        fn_goNotiListPage();
    });
    /* ====================================Button Event Setting :E */
});

// 수정 페이지로 이동
function fn_goNotiModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/homepage/notiModify.do");
	$("#moveFrm").submit();
}

// 리스트 페이지로 이동
function fn_goNotiListPage(){
	$("#moveFrm").attr("action",contextRoot + "/homepage/notiList.do");
	$("#moveFrm").submit();
}

// 이전글 - 다음글 페이지로 이동
function fn_goPreNext(boardSeq) {
	$("#searchBoardSeq").val(boardSeq);
	if($("#searchBoardSeq").val() == ""){
		return false;
	}
	$("#frm").attr("action",contextRoot + "/homepage/notiDetail.do");
	$("#frm").submit();
}
</script>