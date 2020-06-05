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

//리스트 페이지로 이동
function fn_goNotiModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/noti/notiModify.do");
	$("#moveFrm").submit();
}
//리스트 페이지로 이동
function fn_goNotiListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/noti/notiList.do");
	$("#moveFrm").submit();
}
</script>