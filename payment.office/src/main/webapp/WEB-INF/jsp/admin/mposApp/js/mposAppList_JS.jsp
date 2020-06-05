<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<!--
  * @Class Name  : mposAppList_JS.jsp
  * @Description : admin > APP 버전관리 > MPOS 버전관리 JS
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.12.27	    이인희      최초 생성
-->
<script type="text/javascript" defer="defer">

$(document).ready(function(){

    // 날짜 셋팅
    datePickerWrap("#searchSdate");
    datePickerWrap("#searchEdate");
    fn_setDate(0, "day");

    fn_check(); // 날짜 셋팅 이후로

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

function fn_check(){

    console.log("====> tempSdate :: " + $("#tempSdate").val());
    console.log("====> tempEdate :: " + $("#tempEdate").val());

    $("#searchSdate").val($("#tempSdate").val());
    $("#searchEdate").val($("#tempEdate").val());
    
}

/*
  inNum : n일 or n월
  type : day, month
*/
function fn_setDate(inNum, type){

  var now = new Date();

  var searchStartDt = now.yyyy_mm_dd();

  if(type == "month"){
    now.setMonth(now.getMonth()-inNum);
    now.setDate(now.getDate() +1);
  }else if(type == "day"){
    now.setDate(now.getDate() - inNum);
  }

  var seachEndDt = now.yyyy_mm_dd();

  $("#searchSdate").val(seachEndDt);
  $("#searchEdate").val(searchStartDt);

}

// 종료일 선택 시 시작일 체크
function fn_checkFromDate(obj){

  var now = new Date();
  var seachEndDt = now.yyyy_mm_dd();

  var date1 = new Date($("#searchSdate").datepicker("getDate"));
  var date2 = new Date($("#searchEdate").datepicker("getDate"));

  if (date2 - date1 < 0){
    alert("종료일을 시작일 이후로 입력해주세요.");
    $("#searchEdate").val(seachEndDt);
    return false;
  }

}


//검색영역초기화
function fn_doInit(){

	$("#searchAppName").val("");
    fn_check(); // 날짜 셋팅 이후로

	fn_doSearch(1);
}

//검색, 페이지 이동
function fn_doSearch(pageNo){

  console.log("====> period :: " + $("#searchType").val());
  console.log("====> 시작일 :: " + $("#searchSdate").val());
  console.log("====> 종료일 :: " + $("#searchEdate").val());

  $("#frm").attr("action" , contextRoot + "/admin/mposapp/getMposAppListAjax.do");
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
function fn_goDetailPage(appVersionId){
	$("#appVersionId").val(appVersionId);

	$("#frm").attr("action",contextRoot + "/admin/mposapp/mposAppDetail.do");
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

			$("#sortOrder").val("A.APP_VERSION_ID ASC");
		}else if(targetClass == "sort_lowtohigh"){
			$("#sort_column_prefix0").removeClass("sort_lowtohigh");
            $("#sort_column_prefix0").addClass("sort_hightolow");

			$("#sortOrder").val("A.APP_VERSION_ID DESC");
		}
	}else if(type == 2){

	}

	fn_doSearch(1);
}


//등록페이지이동
function goCreatePage(){
	$("#frm").attr("action",contextRoot + "/admin/mposapp/mposAppCreate.do");
	$("#frm").submit();
}

</script>