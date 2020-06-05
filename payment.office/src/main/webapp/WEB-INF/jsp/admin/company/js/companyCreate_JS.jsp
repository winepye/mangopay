<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>

<script type="text/javascript" defer="defer">
$(document).ready(function(){

    // 제휴사정보 선택 disable
    //$("select[name=partnerInfoId]").attr("disable",true);

    $("#partnerInfoId").prop('disabled', 'disabled');

    /*if ($("#pizza").is(":checked")) {
        $("#pizza_kind").removeAttr("disabled");
    }
    else {
        $("#pizza_kind").prop('disabled', 'disabled');
    }*/

    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnCreateCompany").click(function(){
        fn_doCreateCompany();
    });

    //리스트버튼
    $("#btnGoCompanyListPage").click(function(){
        fn_goCompanyListPage();
    });
    /* ====================================Button Event Setting :E */

    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

    $("#storeZipBtn").click(function(){
        fn_searchZipCode();
    });

    $("#paymentType").change(function(){
       fn_selectPartnerInfoId();
    });

});

//
function fn_selectPartnerInfoId(){
    console.log($("#paymentType").val());

    if ($("#paymentType").val() == '' || $("#paymentType").val() == 'MPOS_PAY' ) {
        $("#partnerInfoId").val('');
        $("#partnerInfoId").prop('disabled', 'disabled');
    }
    else {
        $("#partnerInfoId").removeAttr("disabled");
    }
}

// daum 우편번호 검색 서비스 이용
function fn_searchZipCode(){

    // /WEB-INF/jsp/common/daumPost.jsp 이용
    // 인자값 (우편번호ID, 기본주소ID, 상세주소ID)
    searchZipCode("companyZip", "companyAddr1", "companyAddr2");
}

//저장
function fn_doCreateCompany(){

    var businessTypeVal = $(':radio[name="businessType"]:checked').val();
    var addMsg = "은(는) 필수 입력 항목입니다.";

    /* :::::::::::::::::: validation START ::::::::::::::::::::::::: */

    if($("#bizRegNum1").val() == ''){
        alert("사업자번호"+addMsg);
        $("#bizRegNum1").focus();
        return false;
    }

    if($("#bizRegNum2").val() == ''){
        alert("사업자번호"+addMsg);
        $("#bizRegNum2").focus();
        return false;
    }

    if($("#bizRegNum3").val() == ''){
        alert("사업자번호"+addMsg);
        $("#bizRegNum3").focus();
        return false;
    }

    /* if($("#corpNum1").val() == ''){
		alert("법인등록번호"+addMsg);
		$("#corpNum1").focus();
		return false;
	}

    if($("#corpNum2").val() == ''){
		alert("법인등록번호"+addMsg);
		$("#corpNum2").focus();
		return false;
	} */

    if($("#ceoName").val() == ''){
        alert("대표자명"+addMsg);
        $("#ceoName").focus();
        return false;
    }

    if($("#companyName").val() == ''){
        alert("회사명"+addMsg);
        $("#companyName").focus();
        return false;
    }

    /* if($("#companyZip").val() == ''){
        alert("사업장우편번호"+addMsg);
        $("#companyZip").focus();
        return false;
    }

    if($("#companyAddr1").val() == ''){
        alert("사업장주소"+addMsg);
        $("#companyAddr1").focus();
        return false;
    }

    if($("#companyAddr2").val() == ''){
        alert("사업장 상세주소"+addMsg);
        $("#companyAddr2").focus();
        return false;
    } */

    if($("#paymentType").val() == ''){
        alert("결제타입"+addMsg);
        $("#paymentType").focus();
        return false;
    }

    if($("#paymentType").val() == 'EASY_PAY' || $("#paymentType").val() == 'ALL'){
        if($("#partnerInfoId").val() == ''){
            alert("결제타입에 간편결제가 포함될 경우 제휴사정보ID"+addMsg);
            $("#partnerInfoId").focus();
            return false;
        }
    }

    /* :::::::::::::::::: validation END ::::::::::::::::::::::::: */

    /* 조합 */
    var bizRegNum;
    var corpNum;
    var telNum;

    // 1. 사업자 번호
    bizRegNum = $("#bizRegNum1").val()+"-"+$("#bizRegNum2").val()+"-"+$("#bizRegNum3").val();
    $("#bizRegNum").val(bizRegNum);

    // 2. 법인등록 번호
    corpNum = $("#corpNum1").val()+"-"+$("#corpNum2").val();
    $("#corpNum").val(corpNum);

    // 3. 대표번호
    telNum = $("#telNum1").val()+"-"+$("#telNum2").val()+"-"+$("#telNum3").val();
    $("#telNum").val(telNum);

    if(confirm("<spring:message code='request.common.save' />")) {
        $("#frm").attr("action",contextRoot + "/admin/company/createCompanyAjax.do");
        commonAjaxSubmit("POST", $("#frm"), fn_doCreateCompanyCallback);
    }

}


//저장 콜백
function fn_doCreateCompanyCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("정상적으로 저장되었습니다.");
		fn_goCompanyListPage();
	}else{
		alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
	}
}

//리스트 페이지로 이동
function fn_goCompanyListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/company/companyList.do");
	$("#moveFrm").submit();
}

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

function checkDuple() {
    alert("중복확인");
}


</script>