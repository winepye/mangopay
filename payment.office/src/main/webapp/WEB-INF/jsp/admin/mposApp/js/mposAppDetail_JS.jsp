<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoModifyPage").click(function(){
        fn_goModifyPage();
    });

    //목록버튼
    $("#btnGoListPage").click(function(){
        fn_goListPage();
    });
    /* ====================================Button Event Setting :E */

});

//수정 페이지로 이동
function fn_goModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/mposapp/mposAppModify.do");
	$("#moveFrm").submit();


}

//리스트 페이지로 이동
function fn_goListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/mposapp/mposAppList.do");
	$("#moveFrm").submit();
}

</script>