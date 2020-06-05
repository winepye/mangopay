<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>

<script type="text/javascript" defer="defer">
$(document).ready(function(){

    datePickerWrap("#topStartDtS");
    datePickerWrap("#topEndDtS");

    /* ====================================form jquery validation */
    $('#frm').validate({
        rules: {
            title: { required: true, maxlength:100}
           ,categCd: { required: true}
           ,topStartDtS: { required: true}
           ,topEndDtS: { required: true}
        },
        messages: {
            title: { required: "<spring:message code='required.common.input' arguments='제목'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
           ,categCd: { required: "<spring:message code='required.common.select' arguments='공지유형'/>"}
           ,topStartDtS: { required: "<spring:message code='required.common.input' arguments='TOP게시 시작일자'/>"}
           ,topEndDtS: { required: "<spring:message code='required.common.input' arguments='TOP게시 종료일자'/>"}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        },onsubmit: false
    });
    /* ====================================Daum Editor Content Settiong */
	setEditorContent($("#content").val());

    //등록버튼
    $("#btnModifyCharger").click(function(){
        fn_doModifyCharger();
    });

    //리스트버튼
    $("#btnGoChargerListPage").click(function(){
        fn_goChargerListPage();
    });

    //우편번호 검색 클릭시
    $("#zipBtn").click(function(){
        fn_searchZipCode();
    });

    //담당자유형 선택시
    $("#chargerType").change(function(){
    	fn_changeChargerType();
    });

    fn_changeChargerType();
    var chargerType = $("#chargerType").val();
    if(chargerType == "SERVICE_CHARGER"){  //서비스제공자
    	$("#serviceProvider").val("${result.serviceProvider}");
	}else if(chargerType == "COMPANY_CHARGER"){  //고객사
		$("#companyInfoId").val("${result.companyInfoId}");
	}else if(chargerType == "BRAND_CHARGER"){  //브랜드
		$("#companyInfoId").val("${result.companyInfoId}");
		$('#brandInfoId').val("${result.brandInfoId}");
		fn_changeCompanyId();
	}else if(chargerType == "SHOP_CHARGER"){  //매장
		$("#companyInfoId").val("${result.companyInfoId}");
		$('#brandInfoId').val("${result.brandInfoId}");
		$('#shopInfoId').val("${result.shopInfoId}");
		fn_changeCompanyId();
		fn_changeBrandId();
	}



    /* ====================================Button Event Setting :E */
});

//daum 우편번호 검색 서비스 이용
function fn_searchZipCode(){
    // /WEB-INF/jsp/common/daumPost.jsp 이용
    // 인자값 (우편번호ID, 기본주소ID, 상세주소ID)
    searchZipCode("companyZip", "companyAddr1", "companyAddr2");
}

//수정
function fn_doModifyCharger(){
	if(!$("#frm").valid()) return;


	if($("#chargerType").val() == ''){
		alert("담당자유형을 선택하세요.");
		$("#chargerType").focus();
		return false;
	}
	if($("#chargerName").val() == ''){
		alert("담당자명을 입력하세요.");
		$("#chargerName").focus();
		return false;
	}
	if($("#mobileNum1").val() == ''){
		alert("핸드폰번호를 입력하세요.");
		$("#mobileNum1").focus();
		return false;
	}

	if($("#mobileNum2").val() == ''){
		alert("핸드폰번호를 입력하세요.");
		$("#mobileNum2").focus();
		return false;
	}

	if($("#mobileNum3").val() == ''){
		alert("핸드폰번호를 입력하세요.");
		$("#mobileNum3").focus();
		return false;
	}

	var mobileNum = $("#mobileNum1").val() + "-" +$("#mobileNum2").val() + "-" +$("#mobileNum3").val();
	$("#mobileNum").val(mobileNum);

	if(($("#companyTelNum1").val() != '') && ($("#companyTelNum2").val() != '') && ($("#companyTelNum3").val() != '')){
		var companyTelNum = $("#companyTelNum1").val() + "-" +$("#companyTelNum2").val() + "-" +$("#companyTelNum3").val();
		$("#companyTelNum").val(companyTelNum);
	}

	$("#frm").attr("action",contextRoot + "/admin/charger/modifyChargerAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_doSaveCallback);
}
//저장 콜백
function fn_doSaveCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		fn_goChargerListPage();
	}else{
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//리스트 페이지로 이동
function fn_goChargerListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/charger/chargerList.do");
	$("#moveFrm").submit();
}

//담당자유형 선택시
function fn_changeChargerType(){
	var chargerType = $("#chargerType").val();

	$("#serviceProvider").val("");
	$("#companyInfoId").val("0");
	$("#brandInfoId").val("0");
	$("#shopInfoId").val("0");

	if(chargerType == "SERVICE_CHARGER"){  //서비스제공자
		$("#serviceProvider").prop("disabled", false);
		$("#companyInfoId").prop("disabled", true);
		$("#brandInfoId").prop("disabled", true);
		$("#shopInfoId").prop("disabled", true);

		$("#chargerTypeDesc").html("서비스제공자를 선택해 주세요");
		$("#serviceProvider").focus();
	}else if(chargerType == "COMPANY_CHARGER"){  //고객사
		$("#serviceProvider").prop("disabled", true);
		$("#companyInfoId").prop("disabled", false);
		$("#brandInfoId").prop("disabled", true);
		$("#shopInfoId").prop("disabled", true);

		$("#chargerTypeDesc").html("고객사를 선택해 주세요");
		$("#companyInfoId").focus();
	}else if(chargerType == "BRAND_CHARGER"){  //브랜드
		$("#serviceProvider").prop("disabled", true);
		$("#companyInfoId").prop("disabled", false);
		$("#brandInfoId").prop("disabled", false);
		$("#shopInfoId").prop("disabled", true);

		$("#chargerTypeDesc").html("고객사 > 브랜드를 선택해 주세요");
		$("#companyInfoId").focus();
	}else if(chargerType == "SHOP_CHARGER"){  //매장
		$("#serviceProvider").prop("disabled", true);
		$("#companyInfoId").prop("disabled", false);
		$("#brandInfoId").prop("disabled", false);
		$("#shopInfoId").prop("disabled", false);

		$("#chargerTypeDesc").html("고객사 > 브랜드 > 매장을 선택해 주세요");
		$("#companyInfoId").focus();
	}
}

//고객사정보변경 시 가맹점 정보 변경
function fn_changeCompanyId(){

	$("#brandInfoId").empty();
	$('#brandInfoId').append("<option value=\"0\" selected=\"selected\">선택하세요.</option>");

	$("#shopInfoId").empty();
	$('#shopInfoId').append("<option value=\"0\" selected=\"selected\">선택하세요.</option>");

	if($("#companyInfoId").val() != "0"){

		$('#brandInfoId').prop('disabled', false);
		//$("#companyId").val($("#companyInfoId").val());

		<c:forEach var="item" items="${brandInfoList}">
			if('${item.companyInfoId}' == $("#companyInfoId").val()){
				var option;
				<c:choose>
				    <c:when test="${item.brandInfoId eq result.brandInfoId}">
				    	option= $("<option value=\"${item.brandInfoId}\" selected=\"selected\">${item.brandName}</option>");
				    </c:when>
				    <c:otherwise>
				    	option= $("<option value=\"${item.brandInfoId}\">${item.brandName}</option>");
				    </c:otherwise>
				</c:choose>

			    $('#brandInfoId').append(option);
			}
		</c:forEach>

	}else{
		$("#brandInfoId").prop("disabled", "disabled");
	}
}

//브랜드정보변경 시 가맹점 정보 변경
function fn_changeBrandId(){

	$("#shopInfoId").empty();
	$('#shopInfoId').append("<option value=\"0\" selected=\"selected\">선택하세요.</option>");

	if($("#brandInfoId").val() != "0"){

		$('#shopInfoId').prop('disabled', false);
		//$("#companyId").val($("#companyInfoId").val());

		<c:forEach var="item" items="${shopInfoList}">
			if('${item.brandInfoId}' == $("#brandInfoId").val()){
				var option;
				<c:choose>
				    <c:when test="${item.brandInfoId eq result.brandInfoId}">
				    	option= $("<option value=\"${item.shopInfoId}\" selected=\"selected\">${item.shopName}</option>");
				    </c:when>
				    <c:otherwise>
				    	option= $("<option value=\"${item.shopInfoId}\">${item.shopName}</option>");
				    </c:otherwise>
				</c:choose>

			    $('#shopInfoId').append(option);
			}
		</c:forEach>

	}else{
		$("#shopInfoId").prop("disabled", "disabled");
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