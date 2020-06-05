<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){

	// 가맹점 코드 초기 선택 불가
	if($("#storeCode").val() == '0'){
	    $("#storeCode").prop("disabled", "disabled");
	}else{
		fn_changeCompanyId();
	}

    /* ====================================Button Event Setting :S */
    //저장
    $("#btnModifyUser").click(function(){
    	fn_doModifyUser();
    });

    //목록 페이지 이동
    $("#btnGoUserListPage").click(function(){
        fn_goUserListPage();
    });
    /* ====================================Button Event Setting :E */

    // 숫자만 입력가능하도록 처리
    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

    /* $("#userPassword").focusout(function(){
    	if($(this).val() != ""){
    		fn_changePassword();
    	}else{
    		$("#userPassword2").prop("disabled", "disabled");
    	}
    });

    $("#userPassword2").focusout(function(){
    	if($(this).val() != $("#userPassword").val()){
    		alert("비밀번호를 확인해주세요.");
    		$("#userPassword2").focus();
    		return false;
    	}
    }); */

});


//저장
function fn_doModifyUser(){

	if($("#userName").val() == ''){
		alert("사용자명을 입력하세요.");
		$("#userName").focus();
		return false;
	}

	if($("#userPassword").val() !==  $("#userPassword2").val()){
		alert("비밀번호를 확인하세요.")
		$("#userPassword2").focus();
		return false;
	}

	var selectedUseYn = $(':radio[name="useYn"]:checked').val();

	if(selectedUseYn == null){
		$("input:radio[name='useYn']:radio[value='Y']").prop("checked", true);
	}

	var userMobileNum;
	userMobileNum = $("#userMobileNum1").val() + "-"
	                     +$("#userMobileNum2").val() + "-"
	                     +$("#userMobileNum3").val();

	$("#userMobileNum").val(userMobileNum);

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

	$("#frm").attr("action",contextRoot + "/admin/user/modifyUserAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doModifyUserCallback);
}

//저장 콜백
function fn_doModifyUserCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("정상적으로 저장되었습니다.");
		fn_goUserDetailPage();
	}else{
		alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
	}
}

//리스트 페이지로 이동
function fn_goUserListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/user/userList.do");
	$("#moveFrm").submit();
}

//상세 페이지로 이동
function fn_goUserDetailPage(){
	$("#frm").attr("action",contextRoot + "/admin/user/userDetailAdmin.do");
	$("#frm").submit();
}

//현재날짜 셋팅
function fn_setDate(){
    var now = new Date();
    var searchStartDt = now.yyyy_mm_dd();
    $("#equipDate").val(searchStartDt);
}

function fn_changePassword(){
	$('#userPassword2').prop('disabled', false);
}


function fn_changePassword(){
	$('#userPassword').prop('disabled', false);
	$('#userPassword2').prop('disabled', false);
}

// 글자수 제한
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

//거래처정보변경 시 가맹점 정보 변경
function fn_changeCompanyId(){

	$("#storeCode").empty();
	$('#storeCode').append("<option value=\"0\" selected=\"selected\">선택하세요.</option>");

	if($("#companyInfoId").val() != "0"){

		$('#storeCode').prop('disabled', false);
		$("#companyId").val($("#companyInfoId").val());

		<c:forEach var="item" items="${storeInfoIdList}">

			if('${item.companyInfoId}' == $("#companyInfoId").val()){
				var option;
				<c:choose>
				    <c:when test="${item.storeCode eq result.storeCode}">
				    	option= $("<option value=\"${item.storeCode}\" selected=\"selected\">${item.storeName}-${item.bizRegNum}</option>");
				    </c:when>
				    <c:otherwise>
				    	option= $("<option value=\"${item.storeCode}\">${item.storeName}-${item.bizRegNum}</option>");
				    </c:otherwise>
				</c:choose>

			    $('#storeCode').append(option);
			}
		</c:forEach>

	}else{
		$("#storeCode").prop("disabled", "disabled");
	}

}


</script>