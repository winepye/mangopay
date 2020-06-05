<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoStoreModifyPage").click(function(){
        fn_goStoreModifyPage();
    });

    //목록버튼
    $("#btnGoStoreListPage").click(function(){
        fn_goStoreListPage();
    });
    /* ====================================Button Event Setting :E */

});

//수정 페이지로 이동
function fn_goStoreModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/store/storeModify.do");
	$("#moveFrm").submit();
}

//리스트 페이지로 이동
function fn_goStoreListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/store/storeList.do");
	$("#moveFrm").submit();
}

</script>