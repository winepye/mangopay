<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    datePickerWrap("#searchFromDtS"); /* 시작일 */
    datePickerWrap("#searchToDtS"); /* 종료일 */

    /* ====================================Button Popup Setting :S */
    //등록버튼
    $("#btnGoPopupCreatePage").click(function(){
        fn_goPopupCreatePage();
    });

    //삭제버튼
    $("#btnDeletePopup").click(function(){
        fn_deletePopup();
    });


    //검색버튼
    $("#btnSearch").click(function(){
        fn_doSearch(1);
    });

    //초기화버튼
    $("#btnInit").click(function(){
        fn_doInit();
    });
    /* ====================================Button Popup Setting :E */
});

//검색영역초기화
function fn_doInit(){
	fn_setDate('${Constants.SEARCH_DEFAULT_PER_MONTH }');
    $('#searchContentText').val('');
    $("input:radio[name='searchPopupYn']:radio[value='']").prop("checked", true);
}

//작성 페이지로 이동
function fn_goPopupCreatePage(){
	$("#frm").attr("action",contextRoot + "/admin/popup/popup/popupCreate.do");
	$("#frm").submit();
}

//검색 ,페이지 이동
function fn_doSearch(pageNo){
	$("#frm").attr("action" , contextRoot + "/admin/popup/popup/getPopupListAjax.do");
	$("#currentPageNo").val(pageNo);
	commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}
//검색,페이지 이동 콜백
function fn_searchCallback(data){
	$("#listArea").empty();
	$("#listArea").html(data);

	//등록버튼
    $("#btnGoPopupCreatePage").click(function(){
        fn_goPopupCreatePage();
    });

    //삭제버튼
    $("#btnDeletePopup").click(function(){
        fn_deletePopup();
    });
    $("#searchTotalCount").text($("#listTotalCount").val());
}

//선택 삭제
function fn_deletePopup(){
	var notiDeleteChkCnt = 0;
	$("#notiTable tbody input[type='checkbox']").each(function(){
		if($(this).prop("checked")) notiDeleteChkCnt++;
	});

	if(notiDeleteChkCnt==0){
		alert("<spring:message code='required.common.selected' arguments='게시글'/>");  //선택된 게시글이 없습니다.
		return;
	}

	if(!confirm("<spring:message code='request.common.delete' />")) return;  //삭제하시겠습니까?

	$("#frm").attr("action" , contextRoot + "/admin/popup/popup/deletEpopupAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_deletePopupCallback);
}
//선택 삭제 콜백
function fn_deletePopupCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.delete' />");  //정상적으로 삭제되었습니다.
		fn_doSearch($("#currentPageNo").val());
	}else{
		alert("<spring:message code='fail.common.delete' />");  //삭제가 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//상세화면으로 이동
function fn_goDetailPage(popupSeq){
	$("#searchPopupSeq").val(popupSeq);
	$("#frm").attr("action",contextRoot + "/admin/popup/popup/popupDetail.do");
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