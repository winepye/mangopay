<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>

<script type="text/javascript" defer="defer">
$(document).ready(function(){

    datePickerWrap("#searchFromDtS"); /* 시작일 */
    datePickerWrap("#searchToDtS"); /* 종료일 */

    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnGoFaqCreatePage").click(function(){
        fn_goFaqCreatePage();
    });

    //삭제버튼
    $("#btnDeleteFaq").click(function(){
        fn_deleteFaq();
    });

    //검색버튼
    $("#btnSearch").click(function(){
        fn_doSearch(1);
    });


    //초기화버튼
    $("#btnInit").click(function(){
        fn_doInit();
    });
    /* ====================================Button Event Setting :E */
});

//검색영역초기화
function fn_doInit(){
	fn_setDate('${Constants.SEARCH_DEFAULT_PER_MONTH }');
    $('#searchContentType').val('title');
    $('#searchContentText').val('');
    $("input:radio[name='searchCategCd']:radio[value='']").prop("checked", true);
    $("input:radio[name='searchOpenYn']:radio[value='']").prop("checked", true);
}

//작성 페이지로 이동
function fn_goFaqCreatePage(){
	$("#frm").attr("action",contextRoot + "/admin/board/faq/faqCreate.do");
	$("#frm").submit();
}

//검색 ,페이지 이동
function fn_doSearch(pageNo){
	$("#frm").attr("action" , contextRoot + "/admin/board/faq/getFaqBoardListAjax.do");
	$("#currentPageNo").val(pageNo);
	commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}
//검색,페이지 이동 콜백
function fn_searchCallback(data){
	$("#listArea").empty();
	$("#listArea").html(data);

	//등록버튼
    $("#btnGoFaqCreatePage").click(function(){
        fn_goFaqCreatePage();
    });

    //삭제버튼
    $("#btnDeleteFaq").click(function(){
        fn_deleteFaq();
    });
    $("#searchTotalCount").text($("#listTotalCount").val());

}

//선택 삭제
function fn_deleteFaq(){
	var faqDeleteChkCnt = 0;
	$("#faqTable tbody input[type='checkbox']").each(function(){
		if($(this).prop("checked")) faqDeleteChkCnt++;
	});

	if(faqDeleteChkCnt==0){
		alert("<spring:message code='required.common.selected' arguments='게시글'/>");  //선택된 게시글이 없습니다.
		return;
	}

	if(!confirm("<spring:message code='request.common.delete' />")) return;  //삭제하시겠습니까?

	$("#frm").attr("action" , contextRoot + "/admin/board/faq/deleteFaqAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_deleteFaqCallback);
}
//선택 삭제 콜백
function fn_deleteFaqCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.delete' />");  //정상적으로 삭제되었습니다.
		fn_doSearch($("#currentPageNo").val());
	}else{
		alert("<spring:message code='fail.common.delete' />");  //삭제가 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//상세화면으로 이동
function fn_goDetailPage(boardSeq){
	$("#searchBoardSeq").val(boardSeq);
	$("#frm").attr("action",contextRoot + "/admin/board/faq/faqDetail.do");
	$("#frm").submit();
}

//20개씩, 40개씩, 60개씩 보기
function fn_listChange(val){
    $("#recordCountPerPage").val(val);
    fn_doSearch("1");
}

//1개월, 3개월, 6개월 기간 셋팅
function fn_setDate(inMonth){

    var now = new Date();

    var searchStartDt = now.yyyy_mm_dd();
    now.setMonth(now.getMonth()-inMonth);

    var seachEndDt = now.yyyy_mm_dd();

    $("#searchFromDtS").val(seachEndDt);
    $("#searchToDtS").val(searchStartDt);
}
</script>