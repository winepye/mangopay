<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

	// 가맹점 코드 초기 선택 불가
    $("#storeCode").prop("disabled", "disabled");

    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnCreateUser").click(function(){
        fn_doCreateUser();
    });

    //리스트버튼
    $("#btnGoUserListPage").click(function(){
        fn_goUserListPage();
    });
    /* ====================================Button Event Setting :E */

    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

});

//저장
function fn_doCreateUser(){

	var userMobileNum;
	userMobileNum = $("#userMobileNum1").val() + "-"
	                     +$("#userMobileNum2").val() + "-"
	                     +$("#userMobileNum3").val();

	$("#userMobileNum").val(userMobileNum);

	if($("#userName").val() == ''){
		alert("사용자명을 입력하세요.");
		$("#userName").focus();
		return false;
	}

	if($("#userId").val() == ''){
		alert("사용자 ID를 입력하세요.");
		$("#userId").focus();
		return false;
	}

	if($("#userPassword").val() == ""){
		alert("비밀번호를 입력하세요.")
		$("#userPassword").focus();
		return false;
	}else if($("#userPassword2").val() == ""){
		alert("비밀번호를 입력하세요.")
		$("#userPassword2").focus();
		return false;
	}else{
		if($("#userPassword").val() !==  $("#userPassword2").val()){
			alert("비밀번호를 확인하세요.")
			$("#userPassword2").focus();
			return false;
		}
	}

	/* if($("#userEmailAddr").val() == ''){
		alert("이메일을 입력하세요.");
		$("#userEmailAddr").focus();
		return false;
	}

	if($("#userMobileNum1").val() == ''){
		alert("핸드폰번호를 입력하세요.");
		$("#userMobileNum1").focus();
		return false;
	}

	if($("#userMobileNum2").val() == ''){
		alert("핸드폰번호를 입력하세요.");
		$("#userMobileNum2").focus();
		return false;
	}

	if($("#userMobileNum3").val() == ''){
		alert("핸드폰번호를 입력하세요.");
		$("#userMobileNum3").focus();
		return false;
	} */

	if($("#companyInfoId").val() == '0'){
		alert("거래처정보를 선택하세요.");
		$("#companyInfoId").focus();
		return false;
	}

	if($("#storeCode").val() == '0'){
		alert("가맹점을 선택하세요.");
		$("#storeCode").focus();
		return false;
	}

	if($("#userTypeCd").val() == ''){
		alert("회원여부를 선택하세요.");
		$("#userTypeCd").focus();
		return false;
	}

	$("#frm").attr("action",contextRoot + "/admin/user/createUserAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doCreateUserCallback);
}

//저장 콜백
function fn_doCreateUserCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("정상적으로 저장되었습니다.");
		fn_goUserListPage();
	}else{
		alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
	}
}

//리스트 페이지로 이동
function fn_goUserListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/user/userList.do");
	$("#moveFrm").submit();
}

//현재 날짜 셋팅
function fn_setDate(){
    var now = new Date();
    var searchStartDt = now.yyyy_mm_dd();
    $("#equipDate").val(searchStartDt);
}

// 거래처정보변경 시 가맹점 정보 변경
function fn_changeCompanyId(){

	$("#storeCode").empty();
	$('#storeCode').append("<option value=\"0\" selected=\"selected\">선택하세요.</option>");

	if($("#companyInfoId").val() != "0"){

		$('#storeCode').prop('disabled', false);
		$("#companyId").val($("#companyInfoId").val());

		<c:forEach var="item" items="${storeInfoIdList}">
			var selectHtml;
			if('${item.companyInfoId}' == $("#companyInfoId").val()){
				var option = $("<option value=\"${item.storeCode}\">${item.storeName}-${item.bizRegNum}</option>");
			    $('#storeCode').append(option);
			}
		</c:forEach>

	}else{
		$("#storeCode").prop("disabled", "disabled");
	}

}

function chkword(obj, maxByte) {

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

    // 넘어가는 글자는 자른다.
    if (totalByte > maxByte) {
        alert(maxByte + "자를 초과 입력 할 수 없습니다.");
        str2 = strValue.substr(0, len);
        obj.value = str2;
        chkword(obj, 4000);
    }
}


</script>