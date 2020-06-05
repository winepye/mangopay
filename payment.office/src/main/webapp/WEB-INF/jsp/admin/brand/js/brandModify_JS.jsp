<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>

<script type="text/javascript" defer="defer">
$(document).ready(function(){

    if ($("#bizTypeParent").val() == '0') {
        $("#bizType").val('0');
        $("#bizType").prop('disabled', 'disabled');
    }
    else {
        $("#bizType").removeAttr("disabled");
        fn_changeBizTypeId();
    }

    /* ====================================Button Event Setting :S */
    //수정버튼
    $("#btnModifyBrand").click(function(){
    	fn_doModifyBrand();
    });

    //리스트버튼
    $("#btnGoBrandListPage").click(function(){
        fn_goBrandListPage();
    });
    /* ====================================Button Event Setting :E */

    // 숫자만 입력가능하도록 처리
    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

});

// 업종(상위)정보변경 시 업종(하위) 정보 변경
function fn_changeBizTypeId(){

    $("#bizType").empty();
    $('#bizType').append("<option value=\"0\" selected=\"selected\">선택하세요.</option>");

    if($("#bizTypeParent").val() != "0"){

        $('#bizType').prop('disabled', false);

        <c:forEach var="item" items="${bizTypeList}">
        var selectHtml;
        if('${item.parent}' == $("#bizTypeParent").val()){
            var option = $("<option value=\"${item.data}\" <c:if test="${item.data eq result.bizType}">selected='selected'</c:if> >${item.label}</option>");
            $('#bizType').append(option);
        }
        </c:forEach>

    }else{
        $("#bizType").prop("disabled", "disabled");
    }

}


//저장
function fn_doModifyBrand(){

    var shopPayType = $(':radio[name="shopPayType"]:checked').val();
    var addMsg = "은(는) 필수 입력 항목입니다.";

    /* :::::::::::::::::: validation START ::::::::::::::::::::::::: */

    if($("#companyInfoId").val() == ''){
        alert("고객사명"+addMsg);
        $("#companyInfoId").focus();
        return false;
    }

    if($("#brandName").val() == ''){
        alert("브랜드명"+addMsg);
        $("#brandName").focus();
        return false;
    }

    if($("#bizTypeParent").val() == '0'){
        alert("업종(상위)"+addMsg);
        $("#bizTypeParent").focus();
        return false;
    }

    if($("#bizType").val() == '0'){
        alert("업종(하위)"+addMsg);
        $("#bizType").focus();
        return false;
    }

    /* :::::::::::::::::: validation END ::::::::::::::::::::::::: */

    // 대표번호
    var telNum;
    telNum = $("#telNum1").val()+"-"+$("#telNum2").val()+"-"+$("#telNum3").val();
    $("#telNum").val(telNum);

    if(confirm("<spring:message code='request.common.update'   />")) {
        $("#frm").attr("action",contextRoot + "/admin/brand/modifyBrandAjax.do");
        commonAjaxSubmit("POST", $("#frm"), fn_doModifyBrandCallback);
    }

}


//저장 콜백
function fn_doModifyBrandCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("정상적으로 저장되었습니다.");
		fn_goBrandDetailPage();
	}else{
		alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
	}
}

//리스트 페이지로 이동
function fn_goBrandListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/brand/brandList.do");
	$("#moveFrm").submit();
}

//상세 페이지로 이동
function fn_goBrandDetailPage(){
	$("#frm").attr("action",contextRoot + "/admin/brand/brandDetail.do");
	$("#frm").submit();
}

// 글자수 제한
function chkword(obj, maxByte, focusName) {

    var strValue = obj.value;
    var strLen = strValue.length;

    var totalByte = 0;
    var len = 0;
    var oneChar = "";
    var str2 = "";

    for (var i = 0; i < strLen; i++) {
        oneChar = strValue.charAt(i);

        /*
        	한글은 2로 할 경우
        if (escape(oneChar).length > 4) {
            totalByte += 2;
        } else {
            totalByte++;
        }*/
        totalByte++;

        // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
        if (totalByte <= maxByte) {
            len = i + 1;
        }
    }

    if(focusName == null){
        // 넘어가는 글자는 자른다.
        if (totalByte > maxByte) {
            alert(maxByte + "자를 초과 입력 할 수 없습니다.");
            str2 = strValue.substr(0, len);
            obj.value = str2;
            chkword(obj, 4000);
        }
    }else{
        if (totalByte >= maxByte) {
            if(focusName != ''){
                $("#"+focusName).focus();

                str2 = strValue.substr(0, len);
                obj.value = str2;
                chkword(obj, 4000);
            }
        }
    }
}

</script>