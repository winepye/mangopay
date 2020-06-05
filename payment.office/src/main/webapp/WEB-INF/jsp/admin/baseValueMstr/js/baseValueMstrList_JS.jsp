<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnCreate").click(function(){
        fn_openDetailPop();
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
    $('#searchBaseVal').val('');
    $("input:radio[name='searchUseYn']:radio[value='']").prop("checked", true);
    /* $("#menuSearchArea input").val(""); */
    /* $("#listViewCount").val("15"); */

}

//20개씩, 40개씩, 60개씩 보기
function fn_listChange(val){
   $("#recordCountPerPage").val(val);
   fn_doSearch("1");
}
function fn_saveFrmValidInit(){
    $('#saveFrm').validate({
        rules: {
            baseCd: { required: true, maxlength:50}
           , baseVal: { required: true, maxlength:255}
           , useYn: { required: true}
        },
        messages: {
            baseCd: { required: "<spring:message code='required.common.input' arguments='기준코드'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , baseVal: { required: "<spring:message code='required.common.input' arguments='기준값'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           , useYn: { required: "<spring:message code='required.common.useYn' />"}
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
    $("#frm").attr("action" , contextRoot + "/admin/baseMng/baseValueMstr/getBaseValueMstrListAjax.do");
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
    $("#searchTotalCount").text($("#listTotalCount").val());

}


//삭제
function fn_delete(){
  if(confirm("<spring:message code='request.common.delete' />")){  //삭제하시겠습니까?
      url = contextRoot + "/admin/baseMng/baseValueMstr/deleteBaseValueMstrAjax.do";
      $("#baseCd").val($("#searchBaseCd").val());
      $("#saveFrm").attr("action",url);
      commonAjaxSubmit("POST", $("#saveFrm"), fn_deleteCallback);
  }
}

//삭제 콜백
function fn_deleteCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.delete' />");  //정상적으로 삭제되었습니다.
         $.unblockUI();
         fn_doSearch();
    }else if (data.result == "<c:out value='${Constants.RESULT_EXIST }' />"){
        alert("<spring:message code='noti.baseValueMstr.exist' />");  //해당 기준코드는 회원의 계좌정보에서 사용중입니다.
    }else{
        alert("<spring:message code='fail.common.delete' />");  //삭제가 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}

//저장
function fn_doSave(){
    if(!$("#saveFrm").valid()) return;
    var url = contextRoot + "/admin/baseMng/baseValueMstr/createBaseValueMstrAjax.do";

    if($("#searchBaseCd").val()!=""){
        url = contextRoot + "/admin/baseMng/baseValueMstr/modifyBaseValueMstrAjax.do";
        $("#baseCd").val($("#searchBaseCd").val());
    }
    $("#saveFrm").attr("action",url);
    commonAjaxSubmit("POST", $("#saveFrm"), fn_doSaveCallback);
}
//저장 콜백
function fn_doSaveCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
         $.unblockUI();
         fn_doSearch();
    }else if (data.result == "<c:out value='${Constants.RESULT_EXIST }' />"){
        alert("<spring:message code='noti.baseValueMstr.dup' />");  //이미 존재하는 기준값코드입니다. 다른 기준값코드를 입력해 주세요.
    }else{
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}

//상세화면으로 이동
function fn_openDetailPop(baseCd){
    $("#searchBaseCd").val(baseCd);
    $("#frm").attr("action",contextRoot + "/admin/baseMng/baseValueMstr/baseValueMstrDetailAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_openDetailPopCallback);
}

//검색,페이지 이동 콜백
function fn_openDetailPopCallback(data){
    var popModalDivId = "createModal";

    $("#"+popModalDivId).empty();
    $("#"+popModalDivId).html(data);

    openModalPop(popModalDivId,"기준값마스터 상세/등록/수정");

    $("#btnCreateClose").click(function(){
         //모달창 닫기
         $.unblockUI();
    });

    //수정 저장 버튼
    $("#btnSave").click(function(){
        fn_doSave();
    });
  //삭제버튼
    $("#btnDelete").click(function(){
        fn_delete();
    });
    fn_saveFrmValidInit();

}

</script>