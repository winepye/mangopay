<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoCompanyModifyPage").click(function(){
        fn_goCompanyModifyPage();
    });

    //목록버튼
    $("#btnGoCompanyListPage").click(function(){
        fn_goCompanyListPage();
    });
    /* ====================================Button Event Setting :E */

});

//수정 페이지로 이동
function fn_goCompanyModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/company/companyModify.do");
	$("#moveFrm").submit();
}

//리스트 페이지로 이동
function fn_goCompanyListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/company/companyList.do");
	$("#moveFrm").submit();
}

</script>