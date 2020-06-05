<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
var $chkBox;
$(document).ready(function(){
    //메뉴그룹 선택
    $("input[name='searchMenuGrpSeq']").on("click",fn_menuGrpSelect);

    //등록버튼
    $("#btnCreate").click(function(){
        fn_openCreatePop('create');
    });

});
//메뉴 그룹메뉴 테이블 체크박스 올 체크
function fn_menuTableAllChk(){
	if($("input[name='allChk']").prop("checked")){
	    $("#menuTable input[type='checkbox']").each(function(){
	        $(this).prop("checked",true);
	    });
	}else{
		$("#menuTable input[type='checkbox']").each(function(){
            $(this).prop("checked",false);
        });
	}
}
//개별 사용 체크박스 클릭시 이벤트
function fn_useMenuSeqChkClick($this){
	$("input[name*='_chkBox']").each(function(i){
        var chkItemTrName = $(this).attr("name").substring(0,$(this).attr("name").lastIndexOf("_"));

        var isAllchk = true;
        $("."+chkItemTrName+"_tr input[name='useMenuSeqList']").each(function(i){
            if(!$(this).prop("checked")){
                isAllchk = false;
            }

        });
        if(isAllchk)
            $(this).prop("checked",true);
        else {
        	$(this).prop("checked",false);
        	$("input[name='allChk']").prop("checked",false);
        }
    })
}
//작성,수정 모달팝업의 벨리데이션 셋팅
function fn_saveFrmValidInit(){
    $('#saveFrm').validate({
        rules: {
            menuGrpNm: { required: true, maxlength:100}
           , menuGrpDesc: { required: true, maxlength:100}
           , userTypeCd: { required: true}
           , menuLocationCd: { required: true}
        },
        messages: {
            menuGrpNm: { required: "<spring:message code='required.common.input' arguments='메뉴그룹명'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , menuGrpDesc: { required: "<spring:message code='required.common.input' arguments='메뉴그룹설명'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , userTypeCd: { required: "<spring:message code='required.common.select' arguments='회원유형'/>"}
           , menuLocationCd: { required: "<spring:message code='required.common.select' arguments='메뉴위치'/>"}
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
function fn_doSearch(){
    $("#frm").attr("action" , contextRoot + "/admin/authMng/menuGrp/getMenuGrpListAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}
//검색,페이지 이동 콜백
function fn_searchCallback(data){
    $("#searchMenuGrpSeq").empty();
    $("#menuGrpDetailArea").empty();
    $("#menuGrpMenuListArea").empty();

    var stStr = "";

    for(var i = 0 ; i <data.menuGrpVoList.length ; i++){
        stStr += "<option value=\""+data.menuGrpVoList[i].menuGrpSeq+"\">"+data.menuGrpVoList[i].menuGrpNm+"</option>";
    }
    $("#searchMenuGrpSeq").append(stStr);

}

//메뉴그룹 셀렉트리스트 박스 선택
function fn_menuGrpSelect(){
    if($("#searchMenuGrpSeq").val()=="") return;

    $("#menuGrpSeq").val("");
    $("#businessTypeCd").val("");
    $("#searchBusinessTypeCdGrp").val("");
    $("#frm").attr("action" , contextRoot + "/admin/authMng/menuGrp/getMenuGrpDetailAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_menuGrpSelectCallback);
}
//메뉴그룹 셀렉트리스트 박스 선택 콜백
function fn_menuGrpSelectCallback(data){
    $("#menuGrpDetailArea").empty();
    $("#menuGrpDetailArea").html(data);
    fn_menuGrpMenuSelect();

    $("#btnModify").click(function(){
        fn_openCreatePop('modify');
    });

}

//메뉴그룹 메뉴 리스트 조회
function fn_menuGrpMenuSelect(searchBusinessTypeCdGrp){
    if($("#searchMenuGrpSeq").val()=="") return;

    $("#searchBusinessTypeCdGrp").val(searchBusinessTypeCdGrp);

    $("#frm").attr("action" , contextRoot + "/admin/authMng/menuGrp/getMenuGrpMenuListAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_menuGrpMenuSelectCallback);
}

//메뉴그룹 메뉴리스트  콜백
function fn_menuGrpMenuSelectCallback(data){
    $("#menuGrpMenuListArea").empty();
    $("#menuGrpMenuListArea").html(data);
    fn_chkAllClick();

    $(".menuBusinessLi").removeClass("select");
    $("#authMenu_"+$("#searchBusinessTypeCdGrp").val()).addClass("select");

}

//메뉴 구분별 접었다 펴기
function fn_toggleMenu(businessTypeCd){
    var toggleClass = $("#"+businessTypeCd+"_sort").attr("class");
    var innerToggleClass = toggleClass=='sort_lowtohigh'?'sort_hightolow':'sort_lowtohigh'
    $("#"+businessTypeCd+"_sort").removeClass();
    $("#"+businessTypeCd+"_sort").addClass(innerToggleClass);
    $("."+businessTypeCd+"_tr").toggle();
}

//비지니스타입별 allchk
function fn_businessTypeAllChk(businessType){
    if($("#"+businessType+"_chkBox").prop("checked")){
        $("."+businessType+"_tr").each(function(i){
            $(this).find("input[type='checkbox']").prop("checked",true);
        });
    }else{
    	$("input[name='allChk']").prop("checked",false);
        $("."+businessType+"_tr").each(function(i){
            $(this).find("input[type='checkbox']").prop("checked",false);
        });
    }
}

//저장
function fn_doSaveMenuList(){
	var isUseMenuGrpMenu = true;

	$("#menuTable tbody tr").each(function(){
		if(!$(this).find("input[name='useMenuSeqList']").prop("checked")){
	        if($(this).find("input[name='grpMenuListUseYn']").val()=="Y") {
	            isUseMenuGrpMenu = false;
	            return;
	        }
		}
    });

	if(!isUseMenuGrpMenu) {
        alert("<spring:message code='noti.menu.isUseMenuGrpMenu' />");  //선택된 메뉴중 구조화된 메뉴가 있습니다. 그룹구조관리에서 사용여부를 확인한 후 재시도해 주시기 바랍니다.
        return;
    }

    if(confirm("<spring:message code='request.common.save' />")){  //저장하시겠습니까?
        $("#menuGrpSeq").val($("#searchMenuGrpSeq:checked").val());
        $("#businessTypeCd").val($("#searchBusinessTypeCdGrp").val());
        $("#frm").attr("action",contextRoot + "/admin/authMng/menuGrp/modifyMenuGrpMenuAjax.do");
        commonAjaxSubmit("POST", $("#frm"), fn_doSaveMenuListCallback);
    }
}

//저장 콜백
function fn_doSaveMenuListCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
        $("#menuGrpSeq").val("");
        $("#businessTypeCd").val("");
        //fn_menuGrpMenuSelect();
    }else{
        fn_menuGrpMenuSelect();
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}
//온로드 후에 비지느스타입별 all체크되어있는지 확인
function fn_chkAllClick(){
    $("input[name*='_chkBox']").each(function(i){
        var chkItemTrName = $(this).attr("name").substring(0,$(this).attr("name").lastIndexOf("_"));

        var isAllchk = true;
        $("."+chkItemTrName+"_tr input[name='useMenuSeqList']").each(function(i){
            if(!$(this).prop("checked")){
                isAllchk = false;
            }

        });
        if(isAllchk)
            $(this).prop("checked",true);
    })
}

//작성 수정팝업
function fn_openCreatePop(mode){
    $("#mode").val(mode);
    $("#frm").attr("action",contextRoot + "/admin/authMng/menuGrp/menuGrpMenuPopupAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_openCreatePopCallback);
}

//검색,페이지 이동 콜백
function fn_openCreatePopCallback(data){
    $("#createModal").empty();
    $("#createModal").html(data);
    openModalPop("createModal","메뉴그룹등록");

    //비회원추가
    $("select[name=userTypeCd] option:eq(0)").after("<option value='NONMEMBER'>비회원</option>");

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

//저장
function fn_doSave(){
    if(!$("#saveFrm").valid()) return;
    $("#procMode").val($("#mode").val());
    var url = contextRoot + "/admin/authMng/menuGrp/processMenuGrpAjax.do";

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
    }else{
        alert("<spring:message code='noti.menu.isUseMenuGrpPresident' />");  //해당 회원유형코드에 대표 메뉴그룹이 이미 존재합니다.
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
    	fn_doSaveMenuDetail();
    });
    fn_saveFrmValidInit();

}

//저장
function fn_doSaveMenuDetail(){
    if(!$("#saveFrm").valid()) return;
    var url = contextRoot + "/admin/authMng/menu/createMenuAjax.do";

    if($("#searchMenuSeq").val()!=""){
        url = contextRoot + "/admin/authMng/menu/modifyMenuAjax.do";
        $("#menuSeq").val($("#searchMenuSeq").val());
    }
    $("#saveFrm").attr("action",url);
    commonAjaxSubmit("POST", $("#saveFrm"), fn_doSaveMenuDetailCallback);
}
//저장 콜백
function fn_doSaveMenuDetailCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
        //모달창 닫기
         $.unblockUI();
         fn_menuGrpMenuSelect();
    }else{
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}
//메뉴 디테일 벨리데이션
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
             menuNm: { required: "<spring:message code='required.common.select' arguments='메뉴명'/>",maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , menuUrl: { required: "<spring:message code='required.common.select' arguments='메뉴URL'/>",maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
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
</script>