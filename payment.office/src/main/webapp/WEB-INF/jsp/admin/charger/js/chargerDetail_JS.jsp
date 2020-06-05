<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    /* ====================================Validation Ready */

    /* ====================================form jquery validation */

    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoChargerModifyPage").click(function(){
        fn_goChargerModifyPage();
    });

    //목록버튼
    $("#btnGoChargerListPage").click(function(){
        fn_goChargerListPage();
    });
    /* ====================================Button Event Setting :E */
});

//리스트 페이지로 이동
function fn_goChargerModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/charger/chargerModify.do");
	$("#moveFrm").submit();
}
//리스트 페이지로 이동
function fn_goChargerListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/charger/chargerList.do");
	$("#moveFrm").submit();
}
</script>