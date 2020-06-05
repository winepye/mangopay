<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<%--<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>--%>
<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>

<script type="text/javascript" defer="defer">
$(document).ready(function(){

    datePickerWrap("#equipDate");
    fn_setDate();

    /* ====================================Button Event Setting :S */
    //등록버튼
    $("#btnCreateStore").click(function(){
        fn_doCreateStore();
    });

    //리스트버튼
    $("#btnGoStoreListPage").click(function(){
        fn_goStoreListPage();
    });
    /* ====================================Button Event Setting :E */

    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

    $("#storeZipBtn").click(function(){
        fn_searchZipCode();
    });

    $("#taxType").change(function(){
    	fn_changeTax();
    });



});

// daum 우편번호 검색 서비스 이용
function fn_searchZipCode(){
    // /WEB-INF/jsp/common/daumPost.jsp 이용
    // 인자값 (우편번호ID, 기본주소ID, 상세주소ID)
    searchZipCode("storeZip", "storeAddr1", "storeAddr2");
}

//저장
function fn_doCreateStore(){

	if($("#catId").val() == ''){
		alert("CAT ID를 입력하세요.");
		$("#catId").focus();
		return false;
	}

	if($("#partnerInfoId").val() == '0'){
		alert("제휴사정보 ID를 선택하세요.");
		$("#partnerInfoId").focus();
		return false;
	}

	if($("#storeName").val() == ''){
		alert("가맹점명을 입력하세요.");
		$("#storeName").focus();
		return false;
	}

	if($("#bizRegNum1").val() == '' || $("#bizRegNum2").val() == '' || $("#bizRegNum3").val() == ''){
		alert("사업자번호를 입력하세요.");
		$("#bizRegNum1").focus();
		return false;
	}


	if($("#companyInfoId").val() == '0'){
		alert("거래처 정보를 선택하세요.");
		$("#companyInfoId").focus();
		return false;
	}

	$("#frm").attr("action",contextRoot + "/admin/store/createStoreAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doCreateStoreCallback);
}

//저장 콜백
function fn_doCreateStoreCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("정상적으로 저장되었습니다.");
		fn_goStoreListPage();
	}else{
		alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
	}
}

//리스트 페이지로 이동
function fn_goStoreListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/store/storeList.do");
	$("#moveFrm").submit();
}

//현재 날짜 셋팅
function fn_setDate(){
    var now = new Date();
    var searchStartDt = now.yyyy_mm_dd();
    $("#equipDate").val(searchStartDt);
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

//부가세선택시 부가세율 자동셋팅
function fn_changeTax(){

	if($("#taxType").val() == "TAX_ON"){  //과세
		$("#taxRate").val("10");
	}else if($("#taxType").val() == "TAX_OFF"){  //면세
		$("#taxRate").val("0");
	}else if($("#taxType").val() == "TAX_PARALLEL"){  //과세 면세 겸업
		$("#taxRate").val("10");
	}else{
		$("#taxRate").val("0");
	}

}


</script>