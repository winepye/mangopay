<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){
	    fn_showDetail();

	  	//검색버튼
	    $("#btnSearch").click(function(){
	        fn_doSearch(1);
	    });
	});
	function fn_showDetail(){
	  //상세보기
	    $(".faq_title").each(function(){
	        $(this).on("click",function(){
	        	$(this).parent().next(".qnaZone").toggle();
                if($(this).parent().next(".qnaZone").css("display") == "none"){
                	$(this).children().css('font-weight', '').css('color','');
                    $(this).prev().css('font-weight', '').css('color','');
                }
                else{
                    $(this).children().css('font-weight', 'bolder').css('color','black');
                    $(this).prev().css('font-weight', 'bolder').css('color','black');
                }
	        })
	    });
	}
	//검색 ,페이지 이동
	function fn_doSearch(pageNo){
		$("#frm").attr("action" , contextRoot + "/board/faq/getFaqListAjax.do");
		$("#currentPageNo").val(pageNo);
		commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
	}
	//검색,페이지 이동 콜백
	function fn_searchCallback(data){
		$("#includeArea").empty();
		$("#includeArea").html(data);
		fn_showDetail();
	}
	
	//탭 목록 클릭
    function fn_setCategCd(categCd) {
        $("#searchCategCd").val(categCd);
        $("#tabUl li").each(function(i) {
            $(this).removeClass();
            $(this).children("em:first").remove();
            if ($(this).attr("id") == "tabLi_" + categCd){
                $(this).addClass("on");
                $(this).append("<em class='point'></em>");
            }
        })

        fn_doSearch("1");
    }

</script>