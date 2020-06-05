<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
	    /* fn_showDetail(); */

	  	//검색버튼
	    $("#btnSearch").click(function(){
	        fn_doSearch(1);
	    });
	    //등록버튼
	    $("#btnGoNotiCreatePage").click(function(){
	        fn_goNotiCreatePage();
	    });
	});
	/* function fn_showDetail(){
	  //상세보기
	    $(".faq_title").each(function(){
	        $(this).on("click",function(){
	            if($(this).attr("class")=="faq_title"){
		            $(this).parent().next(".qnaZone").show();
					$(this).attr("class","faq_title_open");
	            }else{
	                $(this).parent().next(".qnaZone").hide();
					$(this).attr("class","faq_title");
	            }

	        })
	    });
	} */
	//검색 ,페이지 이동
	function fn_doSearch(pageNo){
		$("#frm").attr("action" , contextRoot + "/getNotiListAjax.do");
		$("#currentPageNo").val(pageNo);
		commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
	}
	//검색,페이지 이동 콜백
	function fn_searchCallback(data){
		$("#includeArea").empty();
		$("#includeArea").html(data);
		/* fn_showDetail(); */
	}
	//상세화면으로 이동
	function fn_goDetailPage(boardSeq){
		$("#searchBoardSeq").val(boardSeq);
		$("#frm").attr("action",contextRoot + "/notiDetail.do");
		$("#frm").submit();
	}
/* 	//작성 페이지로 이동
	function fn_goNotiCreatePage(){
		$("#frm").attr("action",contextRoot + "/notiCreate.do");
		$("#frm").submit();
	} */
</script>