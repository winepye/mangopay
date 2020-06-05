<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

디테일 화면~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>

기업명 : ${reservationVo.cpnNm}<br>
탐방일 : <fmt:formatDate value="${reservationVo.visitSchdDt}" pattern="yyyy/MM/dd"/><br>
<button onclick="fn_delete()">삭제</button>
<form id = "frm" name = "frm" >
	<input type="hidden" id = "searchCorpInfoSeq" name = "searchCorpInfoSeq" value="${reservationVo.corpInfoSeq }">
</form>

<script>
	function fn_delete(){
	    $("#frm").attr("action",contextRoot + "/sample/deleteCalReservationAjax.do");
		commonAjaxSubmit("POST", $("#frm"), fn_deleteCallback);
	}
	function fn_deleteCallback(data){
	    alert(data.result);
	    window.opener.location.reload();
	    window.close();
	}
</script>