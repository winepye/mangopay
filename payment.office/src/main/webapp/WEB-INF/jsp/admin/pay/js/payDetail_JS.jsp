<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoPayModifyPage").click(function(){
        fn_goPayModifyPage();
    });

    //목록버튼
    $("#btnGoPayListPage").click(function(){
        fn_goPayListPage();
    });
    /* ====================================Button Event Setting :E */

});

//수정 페이지로 이동
function fn_goPayModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/payService/payServiceModify.do");
	$("#moveFrm").submit();


}

//리스트 페이지로 이동
function fn_goPayListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/payService/payServiceList.do");
	$("#moveFrm").submit();
}

</script>