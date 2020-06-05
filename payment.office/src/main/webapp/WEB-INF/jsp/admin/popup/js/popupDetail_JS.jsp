<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    /* ====================================Validation Ready */

    /* ====================================form jquery validation */

    /* ====================================Button Popup Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoPopupModifyPage").click(function(){
        fn_goPopupModifyPage();
    });

    //목록버튼
    $("#btnGoPopupListPage").click(function(){
        fn_goPopupListPage();
    });
    /* ====================================Button Popup Setting :E */
});

//리스트 페이지로 이동
function fn_goPopupModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/popup/popup/popupModify.do");
	$("#moveFrm").submit();
}
//리스트 페이지로 이동
function fn_goPopupListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/popup/popup/popupList.do");
	$("#moveFrm").submit();
}
</script>