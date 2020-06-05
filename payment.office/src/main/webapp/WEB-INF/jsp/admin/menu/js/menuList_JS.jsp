<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnCreate").click(function(){
    	fn_openDetailPop();
    });

    //삭제버튼
    $("#btnDelete").click(function(){
        fn_delete();
    });

    //검색버튼
    $("#btnSearch").click(function(){
        fn_doSearch(1);
    });



    //삭제버튼
    $(".board_classic .leftblock select").change(function(){
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
    $("#searchContentText").val("");
    $("#searchArea input,select").each(function(){
    	if($(this).attr("id") !="listViewCount"){
    		$(this).val("");
    	}

    });
}

//20개씩, 40개씩, 60개씩 보기
function fn_listChange(val){
   $("#recordCountPerPage").val(val);
   fn_doSearch("1");
}
function fn_saveFrmValidInit(){
	$('#saveFrm').validate({
        rules: {
             menuNm: { required: true, maxlength:100}
           , menuUrl: { required: true, maxlength:100}
           , menuLocationCd: { required: true}
           , menuTypeCd: { required: true}
           , businessTypeCd: { required: true}
           , menuDesc: { required: true, maxlength:100}
           , title: { required: true, maxlength:100}
           , categCd: { required: true}
        },
        messages: {
             menuNm: { required: "<spring:message code='required.common.input' arguments='메뉴명'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , menuUrl: { required: "<spring:message code='required.common.input' arguments='메뉴URL'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , menuLocationCd: { required: "<spring:message code='required.common.select' arguments='메뉴위치'/>"}
           , menuTypeCd: { required: "<spring:message code='required.common.select' arguments='메뉴유형'/>"}
           , businessTypeCd: { required: "<spring:message code='required.common.select' arguments='업무유형'/>"}
           , menuDesc: { required: "<spring:message code='required.common.input' arguments='메뉴설명'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , title: { required: "<spring:message code='required.common.input' arguments='제목'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , categCd: { required: "<spring:message code='required.common.select' arguments='카테고리'/>"}
        },showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        },onsubmit: false
    });
}
//검색 ,페이지 이동
function fn_doSearch(pageNo){
	$("#frm").attr("action" , contextRoot + "/admin/authMng/menu/getMenuListAjax.do");
	if(pageNo)
		   $("#currentPageNo").val(pageNo);
	commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}
//검색,페이지 이동 콜백
function fn_searchCallback(data){
	$("#listArea").empty();
	$("#listArea").html(data);

	//등록버튼
    $("#btnCreate").click(function(){
        fn_openDetailPop();
    });

    //삭제버튼
    $("#btnDelete").click(function(){
        fn_delete();
    });
    $("#searchTotalCount").text($("#listTotalCount").val());
}

//선택 삭제
function fn_delete(){
	var deleteChkCnt = 0;
	var isUseMenuGrpMenu = true;
	$("#menuTable tbody input[type='checkbox']").each(function(){
		if($(this).prop("checked")) {
			deleteChkCnt++;
			if($(this).parent().find("input[name='grpMenuListUseYn']").val() == 'Y') isUseMenuGrpMenu = false;
		}
	});

	if(deleteChkCnt==0){
		alert("<spring:message code='required.common.selected' arguments='메뉴'/>");  //선택된 메뉴가 없습니다.
		return;
	}

	if(!isUseMenuGrpMenu) {
		alert("<spring:message code='noti.menu.selectedMenuInuse' />");  //선택된 메뉴중에 사용중인 메뉴가 있습니다.
		return;
	}
    if(confirm("<spring:message code='request.common.delete' />")){  //삭제하시겠습니까?
		$("#frm").attr("action" , contextRoot + "/admin/authMng/menu/deleteMenuAjax.do");
		commonAjaxSubmit("POST", $("#frm"), fn_deleteMenuCallback);
    }
}
//선택 삭제 콜백
function fn_deleteMenuCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.delete' />");  //정상적으로 삭제되었습니다.
		fn_doSearch($("#currentPageNo").val());
	}else{
		alert("<spring:message code='fail.common.delete' />");  //삭제가 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//저장
function fn_doSave(){
	if(!$("#saveFrm").valid()) return;
	var url = contextRoot + "/admin/authMng/menu/createMenuAjax.do";

	if($("#searchMenuSeq").val()!=""){
		url = contextRoot + "/admin/authMng/menu/modifyMenuAjax.do";
		$("#menuSeq").val($("#searchMenuSeq").val());
	}
	$("#saveFrm").attr("action",url);
	commonAjaxSubmit("POST", $("#saveFrm"), fn_doSaveCallback);
}
//저장 콜백
function fn_doSaveCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		//모달창 닫기
		 $.unblockUI();
		 fn_doSearch();
	}else if(data.result == "<c:out value='${Constants.RESULT_EXIST }' />"){
        alert("<spring:message code='noti.common.existCode' arguments='메뉴URL'/>");  //이미 등록된 메뉴URL 입니다.
    }else if(data.result == "<c:out value='${Constants.ERROR_BUSINESS_TYPE_DUP }' />"){
        alert("<spring:message code='noti.menu.resultBusinessTypeDup' />");  //선택하신 업무유형에 이미 지정된 대표메뉴가 있습니다.
    }else{
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//상세화면으로 이동
function fn_openDetailPop(menuSeq){
	$("#searchMenuSeq").val(menuSeq);
	$("#frm").attr("action",contextRoot + "/admin/authMng/menu/menuDetailAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_openDetailPopCallback);
}

//검색,페이지 이동 콜백
function fn_openDetailPopCallback(data){
    var popModalDivId = "createModal";

	$("#"+popModalDivId).empty();
	$("#"+popModalDivId).html(data);

    openModalPop(popModalDivId,"메뉴등록");

	$("#btnCreateClose").click(function(){
		 //모달창 닫기
		 $.unblockUI();
	});

	//수정 저장 버튼
    $("#btnSave").click(function(){
        fn_doSave();
    });
    fn_saveFrmValidInit();

}

</script>