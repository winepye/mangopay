<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoFaqModifyPage").click(function(){
        fn_goFaqModifyPage();
    });

    //목록버튼
    $("#btnGoFaqListPage").click(function(){
        fn_goFaqListPage();
    });
    /* ====================================Button Event Setting :E */
});

//리스트 페이지로 이동
function fn_goFaqModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/faq/faqModify.do");
	$("#moveFrm").submit();
}
//리스트 페이지로 이동
function fn_goFaqListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/board/faq/faqList.do");
	$("#moveFrm").submit();
}
</script>