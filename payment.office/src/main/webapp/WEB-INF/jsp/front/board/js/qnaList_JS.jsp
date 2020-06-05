<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){

		datePickerWrap("#searchFromDtS");
	    datePickerWrap("#searchToDtS");


		$("#btnCreate").click(function(){
			$("#frm").attr("action",contextRoot + "/board/qna/createQna.do");
			$("#frm").submit();
		});

	  	//검색버튼
	    $("#btnSearch").click(function(){
	        fn_doSearch(1);
	    });
	});
	function fn_showDetail(){
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
	}
	//검색 ,페이지 이동
	function fn_doSearch(pageNo){
		if(!isCompareFromToDate($("#searchFromDtS"), $("#searchToDtS"))){
			return;
		}
		$("#frm").attr("action" , contextRoot + "/board/qna/getQnaListAjax.do");
		$("#currentPageNo").val(pageNo);
		commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
	}
	//검색,페이지 이동 콜백
	function fn_searchCallback(data){
		$("#includeArea").empty();
		$("#includeArea").html(data);
		$("#btnCreate").click(function(){
            $("#frm").attr("action",contextRoot + "/board/qna/createQna.do");
            $("#frm").submit();
        });

	}
	//상세화면으로 이동
	function fn_goDetailPage(boardSeq){
		$("#searchBoardSeq").val(boardSeq);
		$("#frm").attr("action",contextRoot + "/board/qna/qnaDetail.do");
		$("#frm").submit();
	}

	//기간 셋팅
	function fn_setDate(inMonth){

		var now = new Date();

		var searchStartDt = now.yyyy_mm_dd();
		now.setMonth(now.getMonth()-inMonth);

		var seachEndDt = now.yyyy_mm_dd();

		$("#searchFromDtS").val(seachEndDt);
		$("#searchToDtS").val(searchStartDt);
	}
</script>