<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
		$("#btnCancel").click(function(){
			fn_goQnaListPage();
		});

		$("#btnModify").click(function(){
			fn_goQnaModifyPage();
		});

	});
	//리스트 페이지로 이동
	function fn_goQnaListPage(){
		$("#moveFrm").attr("action",contextRoot + "/board/qna/qnaList.do");
		$("#moveFrm").submit();
	}

	//리스트 페이지로 이동
	function fn_goQnaModifyPage(){
		$("#moveFrm").attr("action",contextRoot + "/board/qna/qnaModify.do");
		$("#moveFrm").submit();
	}

</script>