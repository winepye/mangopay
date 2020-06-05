<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<!--
  * @Class Name  : storeList.jsp
  * @Description : admin > 가맹점 목록 조회
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.04	 이인희      최초 생성
-->
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    /* ====================================Button Event Setting :S */
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

	$("#searchStoreId").val("");
	$("#searchStoreName").val("");

	fn_doSearch(1);
}

//검색, 페이지 이동
function fn_doSearch(pageNo){
	$("#frm").attr("action" , contextRoot + "/admin/store/getStoreListAjax.do");
	$("#currentPageNo").val(pageNo);
	commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}

//검색, 페이지 이동 콜백
function fn_searchCallback(data){
	$("#listArea").empty();
	$("#listArea").html(data);
	$("#searchTotalCount").text($("#listTotalCount").val());
}

//상세화면으로 이동
function fn_goDetailPage(storeCode){
	$("#storeCode").val(storeCode);
	$("#selectedStoreCode").val(storeCode);
	$("#frm").attr("action",contextRoot + "/admin/store/storeDetail.do");
	$("#frm").submit();
}

//20개씩, 40개씩, 60개씩 보기
function fn_listChange(val){
    $("#recordCountPerPage").val(val);
    fn_doSearch("1");
}

//정렬순서
function fn_doSort(type){

	if(type == 1){
		var targetClass = $("#sort_column_prefix0").attr("class");

		if(targetClass == "sort_hightolow"){
			$("#sort_column_prefix0").removeClass("sort_hightolow");
			$("#sort_column_prefix0").addClass("sort_lowtohigh");

			$("#sortOrder").val("CREATE_DATE ASC");
		}else if(targetClass == "sort_lowtohigh"){
			$("#sort_column_prefix0").removeClass("sort_lowtohigh");
            $("#sort_column_prefix0").addClass("sort_hightolow");

			$("#sortOrder").val("CREATE_DATE DESC");
		}
	}else if(type == 2){

	}

	fn_doSearch(1);
}
///////////////////////////////
//////////////////////////////

//등록페이지이동
function goStoreCreatePage(){
	$("#frm").attr("action",contextRoot + "/admin/store/storeCreate.do");
	$("#frm").submit();
}

</script>