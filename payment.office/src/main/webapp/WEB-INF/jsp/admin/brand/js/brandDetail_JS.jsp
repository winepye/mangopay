<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoBrandModifyPage").click(function(){
        fn_goBrandModifyPage();
    });

    //목록버튼
    $("#btnGoBrandListPage").click(function(){
        fn_goBrandListPage();
    });
    /* ====================================Button Event Setting :E */

});

//수정 페이지로 이동
function fn_goBrandModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/brand/brandModify.do");
	$("#moveFrm").submit();


}

//리스트 페이지로 이동
function fn_goBrandListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/brand/brandList.do");
	$("#moveFrm").submit();
}

</script>