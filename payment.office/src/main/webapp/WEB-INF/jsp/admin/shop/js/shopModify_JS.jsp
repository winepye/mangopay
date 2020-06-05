<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>

<script type="text/javascript">
$(document).ready(function(){

    /* ====================================Button Event Setting :S */
    //수정버튼
    $("#btnModify").click(function(){
        fn_doModify();
    });

    //리스트버튼
    $("#btnGoPayListPage").click(function(){
        fn_goPayListPage();
    });
    /* ====================================Button Event Setting :E */

    // 숫자만 입력가능하도록 처리
    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

});

//저장
function fn_doModifyPay(){

    var addMsg = "은(는) 필수 입력 항목입니다.";

    /* :::::::::::::::::: validation START ::::::::::::::::::::::::: */

    if($("#serviceProvider").val() == ''){
        alert("서비스제공자"+addMsg);
        $("#serviceProvider").focus();
        return false;
    }

    if($("#paymentMean").val() == ''){
        alert("결제수단"+addMsg);
        $("#paymentMean").focus();
        return false;
    }

    if($("#paymentMethod").val() == '0'){
        alert("결제방식"+addMsg);
        $("#paymentMethod").focus();
        return false;
    }

    /* :::::::::::::::::: validation END ::::::::::::::::::::::::: */


    if(confirm("<spring:message code='request.common.update'   />")) {
        $("#frm").attr("action",contextRoot + "/admin/payService/modifyPayServiceAjax.do");
        commonAjaxSubmit("POST", $("#frm"), fn_doModifyPayCallback);
    }

}


//저장 콜백
function fn_doModifyPayCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("정상적으로 저장되었습니다.");
		fn_goPayDetailPage();
	}else{
		alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
	}
}

//리스트 페이지로 이동
function fn_goPayListPage(){
	$("#frm").attr("action",contextRoot + "/admin/payService/payServiceList.do");
	$("#frm").submit();
}

//상세 페이지로 이동
function fn_goPayDetailPage(){
	$("#frm").attr("action",contextRoot + "/admin/payService/payServiceDetail.do");
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