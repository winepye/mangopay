<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<!--
  * @Class Name  : userList_JS.jsp
  * @Description : admin > userList_JS
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2016.05.04	이인희      최초 생성
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
    /* datePickerWrap("#searchFromDtS");
    datePickerWrap("#searchToDtS"); */

    //sms Pop open..
    /* $("#btnOpenSmsPopPage").click(function(){
    	fn_openSmsPop();
    }); */

});

//등록페이지이동
function goUserCreatePage(){
	$("#frm").attr("action",contextRoot + "/admin/user/userCreate.do");
	$("#frm").submit();
}

//검색영역초기화
function fn_doInit(){
    searchAreaReset("searchArea");
    //fn_setDate('${Constants.SEARCH_DEFAULT_PER_MONTH }');
}

//검색, 페이지 이동
function fn_doSearch(pageNo){
	$("#frm").attr("action" , contextRoot + "/admin/user/user/getUserListAjax.do");
	$("#currentPageNo").val(pageNo);
	commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}

//검색, 페이지 이동 콜백
function fn_searchCallback(data){
	$("#listArea").empty();
	$("#listArea").html(data);

	$("#searchTotalCount").text($("#listTotalCount").val());

	/* $("#btnOpenSmsPopPage").click(function(){
	    fn_openSmsPop();
	}); */
}

//상세화면으로 이동
function fn_goDetailPage(userInfoId){
	$("#searchUserInfoId").val(userInfoId);
	$("#frm").attr("action",contextRoot + "/admin/user/userDetailAdmin.do");
	$("#frm").submit();
}

//중/소분류 조회
function fn_getIndustCategDepthList(id, depth, val){
    $("#searchIndustCategId").val(id);
    $("#searchCategDepth").val(depth);
    $("#searchIndustCategCd").val(val);
    if(parseInt(depth)<4){
        $("#frm").attr("action" , contextRoot + "/user/common/getIndustCategDepthListAjax.do");
        commonAjaxSubmit("POST", $("#frm"), fn_searchIndustCategDepthListCallback);
    }
}
//중/소분류 조회 콜백
function fn_searchIndustCategDepthListCallback(data){
	var industCategId = $("#searchIndustCategId").val();
    var categDepth = $("#searchCategDepth").val();
    var stStr = "";
    var num = industCategId.substring(industCategId.length-1,industCategId.length); //뒤의 끝자리 숫자 가져옴

    if(industCategId.indexOf("Top") > -1){industCategId = "industCateg2Depth_"+num;}
    else{industCategId = "industCategCd_"+num;}

    /* 화면 그리기 시작 */
    $("#"+industCategId).empty();
    if(categDepth == '2' ){
        stStr ="<option value=''>중분류</option>";
        $("#"+"industCategCd_"+num).empty();
        $("#"+"industCategCd_"+num).append("<option value = ''>소분류</option>");
        }
    else{stStr ="<option value=''>소분류</option>";}

    for(var index = 0; index < data.result.length; index++ ){
        stStr += '<option value='+data.result[index].industCategCd+'>'+data.result[index].industCategNm+'</option>';
    }
    $("#"+industCategId).append(stStr);
    /* 화면 그리기 종료 */
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

			$("#sortOrder").val("USER_INFO_ID ASC");
		}else if(targetClass == "sort_lowtohigh"){
			$("#sort_column_prefix0").removeClass("sort_lowtohigh");
            $("#sort_column_prefix0").addClass("sort_hightolow");
			$("#sortOrder").val("USER_INFO_ID DESC");
		}
	}else if(type == 2){

	}

	fn_doSearch(1);
}
</script>