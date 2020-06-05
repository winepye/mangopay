<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
(function($) {
    $.fn.ellipsis = function() {
        return this.each(function() {
            var el = $(this);

            if (el.css("overflow") == "hidden") {
                var text = el.html();
                var multiline = el.hasClass('multiline');
                var t = $(this.cloneNode(true)).hide().css('position',
                        'absolute').css('overflow', 'visible').width(
                        multiline ? el.width() : 'auto').height(
                        multiline ? 'auto' : el.height());

                el.after(t);

                function height() {
                    return t.height() > el.height();
                }
                ;
                function width() {
                    return t.width() > el.width();
                }
                ;

                var func = multiline ? height : width;

                while (text.length > 0 && func()) {
                    text = text.substr(0, text.length - 1);
                    t.html(text + "...");
                }

                el.html(t.html());
                t.remove();
            }
        });
    };
})(jQuery);
$(".re_ellipsis").ellipsis();
$(document).ready(function(){
	datePickerWrap("#searchFromDtS");
    datePickerWrap("#searchToDtS");

    //퍼블과 화면의 flot가 다름
    $("img").css("float","left");

    $("#btnSearch").click(function(){
    	fn_doSearch(1);
    })
});

//검색 ,페이지 이동
function fn_doSearch(pageNo){
    if(!isCompareFromToDate($("#searchFromDtS"), $("#searchToDtS"))){
        return;
    }
    if($("#searchContentText2").val()==""){
    	alert("<spring:message code='required.common.input' arguments='검색어'/>");
    	return;
    }
    if($("#isSearchInResult").is(":checked")){
    	$("#searchContentText").val($("#searchContentText").val()+","+$("#searchContentText2").val());
    }else{
    	$("#searchContentText").val($("#searchContentText2").val());
    }

    $("#frm").attr("action" , contextRoot + "/main/getSearchResultAjax.do");
    $("#currentPageNo").val(pageNo);
    commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}
//검색,페이지 이동 콜백
function fn_searchCallback(data){
    $("#includeArea").empty();
    $("#includeArea").html(data);
}

//기간 셋팅
function fn_setDate(inMonth){

	if(inMonth == 99){
		$("#searchFromDtS").val("");
	    $("#searchToDtS").val("");
	    return;
	}

    var now = new Date();

    var searchStartDt = now.yyyy_mm_dd();
    now.setMonth(now.getMonth()-inMonth);

    var seachEndDt = now.yyyy_mm_dd();

    $("#searchFromDtS").val(seachEndDt);
    $("#searchToDtS").val(searchStartDt);
}
//더보기
function fn_moreView(type){
	$("#searchReportKindCd").val(type);
	if($("#searchReportKindCd").val()=='VISIT'){
		$("#currentPageNo").val(parseInt($("#generalResultCurrentPageNo").val())+1);

    }else if($("#searchReportKindCd").val()=='GENERAL'){
    	$("#currentPageNo").val(parseInt($("#visitResultCurrentPageNo").val())+1);
    }
	$("#frm").attr("action" , contextRoot + "/main/getSearchMoreResultAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_moreViewCallback);
}
//더보기콜백
function fn_moreViewCallback(data){
	var targetId;
	if($("#searchReportKindCd").val()=='VISIT'){
		targetId = 'visitResultArea';
		$("#btnVisitMore").remove();

	}else if($("#searchReportKindCd").val()=='GENERAL'){
		targetId = 'generalResultArea';
		$("#btnGeneralMore").remove();
	}
	$("#"+targetId).append(data);

}
//더보기 버튼
function fn_morePage(type){
    switch(type){
    case 'reportVisit':
        $("#frm").attr("action",contextRoot+"/report/visit/visitReportList.do");
        break;
    case 'reportGeneral':
        $("#frm").attr("action",contextRoot+"/report/general/generalReportList.do");
        break;
    }

    $("#frm").submit();

}

</script>