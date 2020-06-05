<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    //코드그룹 입력
    $('#codeGroupFrm').validate({
        rules: {
            cdGrp       : { required: true, maxlength:100}
           ,cdGrpNm     : { required: true, maxlength:100}
           ,remark      : { maxlength:100}
        },
        messages: {
            cdGrp      : { required: "<spring:message code='required.common.input' arguments='코드그룹명'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,cdGrpNm    : { required: "<spring:message code='required.common.input' arguments='코드그룹'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,remark     : { maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        },onsubmit: false
    });

    /* ====================================Button Event Setting :S */
    //신규버튼
    $("#btnNewCodeGroup").click(function(){
        fn_newCodeGroup();
    });

    //코드그룹 저장버튼
    $("#btnCreateCodeGroup").click(function(){
	    if(!$("#codeGroupFrm").valid()) return;
        fn_createCodeGroup();
    });

    //코드 저장버튼
    $("#btnCreateCode").click(function(){

        fn_setCodeFrmValidator();

	    if(!$("#codeFrm").valid()) return;
        fn_createCode();
    });

    //코드행추가 버튼
    $("#btnAddRowCode").click(function(){
        fn_addRowCode();
    });

    /*

    //검색버튼
    $("#btnSearch").click(function(){
        fn_doSearch(1);
    });

    //삭제버튼
    $("#btnDeleteQna").click(function(){
        fn_deleteQna();
    });
    */
    /* ====================================Button Event Setting :E */
});

//코드 생성(Delete Insert)
function fn_createCode(){
    var formId              = "codeFrm";
    var tableId             = "codeTable";
    var inputEndNameArray   = ["cd", "cdNm", "sortOrd", "remark", "useYn"];

    if($('#cd').length < 1){
        alert("<spring:message code='noti.lvlCode.lvlCd' />");  //입력된 코드가 없습니다. 코드를 입력해 주시기 바랍니다.
        return false;
    }

    //코드 중복 체크
    if(fn_isDuplicateInputValue("cd")) {
        alert("<spring:message code='noti.code.dup' />");  //코드가 중복되었습니다. 코드를 확인해 주시기 바랍니다.
        return false;
    }

    $("#codeFrm input[name='cdGrp']").val($("#searchCdGrp").val());

    if($("#codeFrm input[name='cdGrp']").val() == ""){
        alert("<spring:message code='required.common.select' arguments='코드그룹'/>");
        return false;
    }

    fn_renameTableInputForList(formId, tableId, inputEndNameArray);

    $("#codeFrm").attr("action" , contextRoot + "/admin/baseMng/code/createCodeListAjax.do");
	commonAjaxSubmit("POST", $("#codeFrm"), fn_createCodeCallback);
}

//코드생성 콜백
function fn_createCodeCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.

        fn_getCodeList($("#searchCdGrp").val());
	}else{
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//코드 폼 Validate 적용
function fn_setCodeFrmValidator(){
    //코드 입력
    $('#codeFrm').validate({
        rules: {
            cd      : { required: true, maxlength:100}
           ,cdNm    : { required: true, maxlength:100}
           ,sortOrd : { required: true, digits:true, maxlength:4}
        },
        messages: {
            cd      : { required: "<spring:message code='required.common.input' arguments='코드'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,cdNm    : { required: "<spring:message code='required.common.input' arguments='코드명'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,sortOrd : { required: "<spring:message code='required.common.input' arguments='정렬순서'/>", digits: "<spring:message code='required.common.degit' arguments='정렬순서'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        },onsubmit: false
    });
}

//신규버튼 클릭
function fn_newCodeGroup(){
    /*
    $("#cdGrp"      ).val("");
    $("#cdGrpNm"    ).val("");
    $("#parentCdGrp").val("");
    $("#remark"     ).val("");

    $("#codeGroupUseYn_N").prop("checked", true);

    $("#cdGrp").attr('readonly', false);

    //검색코드그룹 초기화
    $("#searchCdGrp").val('');

    fn_getCodeList("");
    */
    
    window.location.href = contextRoot +"/admin/baseMng/code/codeMng.do";
}

//코드그룹클릭
function fn_getCodeGroupDetail(cdGrp){
	$("#searchFrm").attr("action" , contextRoot + "/admin/baseMng/code/getCodeGroupDetailAjax.do");
	$("#searchCdGrp").val(cdGrp);
    $("#cdGrp").attr('readonly', true);

    $("li[role='CODE']").attr("class","");
    $("#"+cdGrp).attr("class","select");

	commonAjaxSubmit("POST", $("#searchFrm"), fn_getCodeGroupDetailCallback);
}
//코드그룹 상세 콜백
function fn_getCodeGroupDetailCallback(data){

    $("#cdGrp"      ).val(data.codeGroupVo.cdGrp      );
    $("#cdGrpNm"    ).val(data.codeGroupVo.cdGrpNm    );
    $("#parentCdGrp").val(data.codeGroupVo.parentCdGrp);
    $("#remark"     ).val(data.codeGroupVo.remark     );

    $("#codeGroupUseYn").val(data.codeGroupVo.useYn);

    fn_getCodeList($("#cdGrp").val());
}

//코드목록
function fn_getCodeList(cdGrp){
	$("#searchFrm").attr("action" , contextRoot + "/admin/baseMng/code/getCodeListAjax.do");
	$("#searchCdGrp").val(cdGrp);
	commonAjaxSubmit("POST", $("#searchFrm"), fn_getCodeListCallback);
}
//코드목록 콜백
function fn_getCodeListCallback(data){
	$("#listArea1").empty();
	$("#listArea1").html(data);
}

//코드그룹저장
function fn_createCodeGroup(){
    if($("#searchCdGrp").val() == '') {
	    $("#codeGroupFrm").attr("action" , contextRoot + "/admin/baseMng/code/createCodeGroupAjax.do");
    }
    else{
	    $("#codeGroupFrm").attr("action" , contextRoot + "/admin/baseMng/code/modifyCodeGroupAjax.do");
    }

	commonAjaxSubmit("POST", $("#codeGroupFrm"), fn_createCodeGroupCallback);
}

//코드그룹저장 콜백
function fn_createCodeGroupCallback(data){
    alert(data.message);

    if($("#searchCdGrp").val() == '') {
        window.location.href = contextRoot +"/admin/baseMng/code/codeMng.do";
    }
    else{
        fn_getCodeGroupDetail(data.cdGrp);
    }
}

//배열로 Request를 처리하기 위해 Name을 배열에 맞도록 조정
function fn_renameTableInputForList(formId, tableId, inputEndNameArray){

    var arrayVoName = $("#"+tableId).attr("arrayVoName");

    var targetTableTrs = $("#"+tableId+" TR");
    var targetTableTrsLength = targetTableTrs.length - 1;

    for(var i = 0; i < inputEndNameArray.length; i++){

        var inputArray = $("#"+formId+" input[name$='"+inputEndNameArray[i]+"']");

        if(inputArray.length == 0) {
            inputArray = $("#"+formId+" select[name$='"+inputEndNameArray[i]+"']");
        }

        var inputArrayMultiCount = inputArray.length / targetTableTrsLength;

        for(var j = 0; j < inputArray.length; j++){
            $(inputArray[j]).attr("name", arrayVoName + "["+parseInt(j/inputArrayMultiCount)+"]."+inputEndNameArray[i]);
        }
    }
}

//동일한 값을 가지고 있는지 체크
function fn_isDuplicateInputValue(inputName){
    var inputArray = $("input[name='"+inputName+"']");

    var inputValueArray = [];

    for(var i = 0; i < inputArray.length; i++){
        inputValueArray.push($(inputArray[i]).val());
    }

    return isDuplicateValue(inputValueArray);
}

//코드 Row 추가
function fn_addRowCode(){
    var trHtml = "<tr id='codeTableTr'>                                                                                                  ";
        trHtml += "<td><input name='cd' class='input_s_b w100pro' id='cd' type='text' placeholder='코드 입력'></td>                   ";
        trHtml += "<td><input name='cdNm' class='input_s_b w100pro' id='cdNm' type='text' placeholder='코드명 입력'></td>             ";
        trHtml += "<td><input name='sortOrd' class='input_s_b w100pro' id='sortOrd' type='text' placeholder='정렬순서 입력'></td>     ";
        trHtml += "<td><input name='remark' class='input_s_b w100pro' id='remark' type='text' placeholder='비고 입력'></td>           ";
        trHtml += "<td>                                                                                                                  ";
        trHtml += " <select title='사용여부' name='useYn' class='sel_basic w100pro' id='codeUseYn'>                                                 ";
        trHtml += "     <option value='Y'>예</option>                                                                                    ";
        trHtml += "     <option value='N'>아니요</option>                                                                                ";
        trHtml += " </select>                                                                                                            ";
        trHtml += "</td>                                                                                                                 ";
        trHtml += "<td><button type='button' class='btn_grayline' onclick='javascript:fn_deleteRowCode(this);'>삭제</button></td>             ";
        trHtml += "</tr>                                                                                                                 ";

    $("#codeFrm input[name='cdGrp']").val($("#searchCdGrp").val());

    if($("#codeFrm input[name='cdGrp']").val() == ""){
        alert("<spring:message code='required.common.select' arguments='코드그룹'/>");
        return false;
    }

    if($('#codeTableNoData').length > 0){
        $('#codeTable > tbody:last > tr:last').remove();
    }

    $('#codeTable').append(trHtml);
}

//코드 테이블 Row 삭제
function fn_deleteRowCode(obj){
	if(!confirm("<spring:message code='request.common.delete' />")) return;  //삭제하시겠습니까?
    var tr = $(obj).parent().parent();
    tr.remove();
}
</script>