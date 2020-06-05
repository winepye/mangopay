<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/commJS.jsp"%>
<!--
    Description : 고객사관리 > 매장관 > 목록 > JS
-->
<script type="text/javascript" defer="defer">

$(document).ready(function(){

    // 검색영역 접기/열기
    $("#btnClose").click(function(){
      fn_searchAreaToggle();
    });

    /* ===================================================================Button Event Setting :S */

    // 검색 조건의 업종(하) disabled 처리 ==> 업종(상) 선택 시에 활성화 되도
    if ($("#searchPbizType").val() == '') {
      $("#searchBizType").val('');
      $("#searchBizType").prop('disabled', 'disabled');
    }
    else {
      $("#searchBizType").removeAttr("disabled");
      fn_changeBizTypeId();
    }

    // 검색 영역 날짜 셋팅
    datePickerWrap("#searchSdate");
    datePickerWrap("#searchEdate");
    fn_setDate(0, "day");
    fn_check(); // 날짜 셋팅 이후로

    //검색버튼
    $("#btnSearch").click(function(){
        fn_doSearch(1);
    });

    //초기화버튼
    $("#btnInit").click(function(){
        fn_doInit();
    });

    //일괄적용
    $("#saveBt").click(function(){
        fn_selectCheckedSave();
    });

    //전체선택
    /*$("#allChkYn").click(function(){
        console.log("====> 전체선택");
       fn_listAllCheck();
    });*/



    /* ====================================================================Button Event Setting :E */

    // 숫자만 입력가능하도록 처리
    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

});

// 전체선택
function fn_listAllCheck(obj){

    var chkFlag = $("#allChkYn").prop("checked");

    $("input[name=chkYn]:checkbox").each(function(){
        if(chkFlag){
            $(this).prop("checked", true);
        }else{
            $(this).prop("checked", false);
        }
    });
}


function fn_createJson(){


    var jsonStr = new Object; /* 체크된 항목 목록 저장*/
    var rowArr = new Array;

    var saveDataJson = new Object; /* 일괄적용할 데이터 저장*/

    $("input[name=chkYn]:checked").each(function() {
        var num = $(this).val();

        console.log("num : "+num);

        var classObj = new Object();

        classObj.shopTerminalId = num;

        rowArr.push(classObj);
        jsonStr.saveList = rowArr;

    });

    var rowArr2 = new Array;
    saveDataJson.taxDiv = $("#taxDiv").val();
    saveDataJson.taxRate = $("#taxRate").val();
    saveDataJson.svcAmtYn = $("#svcAmtYn").val();
    saveDataJson.svcChargeRate = $("#svcChargeRate").val();

    rowArr2.push(saveDataJson);
    jsonStr.saveColumn =  rowArr2;

    $("#jsonStr").val(JSON.stringify(jsonStr));

    console.log("====> jsonStr :: " + $("#jsonStr").val());

}

// 일괄적용 JSON
function fn_selectCheckedSave(){

    var processContinue = true; // 진행여부 체크
    var index = 0;

    $("input[name=chkYn]:checked").each(function() {
        index ++;
    });

    if(index == 0){
        alert("일괄적용을 위한 단말기정보가 없습니다.")
        return false;
    }

    if($("#taxDiv").val() == '' && $("#svcAmtYn").val() == ''){
        alert("과세형태 및 봉사료여부를 입력 후 적용가능합니다.");
        return false;
    }

    // 과세형태 선택 여부
    if(($("#taxDiv").val() == 'TAX_ON' || $("#taxDiv").val() == 'TAX_PARALLEL')
        && $("#taxRate").val() == '0'){
        if(confirm("부가세율을 0%로 일괄적용 하시겠습니까?")){
            // 확인 클릭 시
            processContinue = true;
        }else{
            processContinue = false;
            $("#taxRate").focus();
            return false;
        }
    }

    // 봉사료여부 선택 여부
    if($("#svcAmtYn").val() == 'Y' && $("#svcChargeRate").val() == '0'){
        if(confirm("봉사료율을 0%로 일괄적용 하시겠습니까?")){
            // 확인 클릭 시
            processContinue = true;
        }else{
            processContinue = false;
            $("#svcChargeRate").focus();
            return false;
        }
    }

    if(processContinue){
        fn_createJson();
        if(confirm("매장단말기 정보를 일괄적용하시겠습니까?")) {
            $("#saveFrm").attr("action",contextRoot + "/admin/shop/selectModifyShopAjax.do");
            commonAjaxSubmit("POST", $("#saveFrm"), fn_doModifyCallback);
        }
    }

}

/*
저장 콜백
*/
function fn_doModifyCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("정상적으로 저장되었습니다.");
        fn_doSearch(1);
    }else{
        alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }
}

// 검색영역 초기화
function fn_doInit(){
    $("#searchNmType").val('');
    $("#searchNm").val('');
    $("#searchServiceBizNum").val('');
    $("#searchShopMngCode").val('');
    $("#searchChargerName").val('');
    $("#searchServiceTelNum").val('');
    $("#searchAddr").val('');
    $("#searchPbizType").val('');
    $("#searchBizType").val('');
    fn_setDate(0, "day");
    $("#searchBizType").prop('disabled', 'disabled');
}

// 검색영역 접기/열기
function fn_searchAreaToggle(){

    if($("#btnClose").text() == "검색영역 접기"){
    $("#btnClose").text("검색영역 열기")
    }else{
    $("#btnClose").text("검색영역 접기")
    }
    // 접기/열기 토글
    $("#searchArea").toggle();
}

// 업종(상위)정보변경 시 업종(하위) 정보 변경
function fn_changeBizTypeId(){

  $("#searchBizType").empty();
  $('#searchBizType').append("<option value=\"\" selected=\"selected\">선택하세요.</option>");

  if($("#searchPbizType").val() != ""){

    $('#searchBizType').prop('disabled', false);

    <c:forEach var="item" items="${result.bizTypeList}">
    var selectHtml;
    if('${item.parentCateCd}' == $("#searchPbizType").val()){
      var option = $("<option value=\"${item.cateCd}\" <c:if test="${item.cateCd eq result.bizType}">selected='selected'</c:if> >${item.cateNm}</option>");
      $('#searchBizType').append(option);
    }
    </c:forEach>

  }else{
    $("#searchBizType").prop("disabled", "disabled");
  }

}

// 날짜 셋팅 이후로
function fn_check(){
    $("#searchSdate").val($("#tempSdate").val());
    $("#searchEdate").val($("#tempEdate").val());
}

/*
  inNum : n일 or n월
  type : day, month
*/
function fn_setDate(inNum, type){

  var now = new Date();

  var searchStartDt = now.yyyy_mm_dd();

  if(type == "month"){
    now.setMonth(now.getMonth()-inNum);
    now.setDate(now.getDate() +1);
  }else if(type == "day"){
    now.setDate(now.getDate() - inNum);
  }

  var seachEndDt = now.yyyy_mm_dd();

  $("#searchSdate").val(seachEndDt);
  $("#searchEdate").val(searchStartDt);

}

// 종료일 선택 시 시작일 체크
function fn_checkFromDate(obj){

  var now = new Date();
  var seachEndDt = now.yyyy_mm_dd();

  var date1 = new Date($("#searchSdate").datepicker("getDate"));
  var date2 = new Date($("#searchEdate").datepicker("getDate"));

  if (date2 - date1 < 0){
    alert("종료일을 시작일 이후로 입력해주세요.");
    $("#searchEdate").val(seachEndDt);
    return false;
  }

}

//검색, 페이지 이동
function fn_doSearch(pageNo){

  if($("#searchNmType").val() != '' && $("#searchNm").val() == ''){
      alert('검색 조건을 선택한 경우 검색명을 입력하세요. ');
      $("#searchNm").focus();
      return false;
  }

  if($("#searchNmType").val() == '' && $("#searchNm").val() != ''){
      alert('검색 조건을 선택하세요. ');
      $("#searchNmType").focus();
      return false;
  }

  $("#frm").attr("action" , contextRoot + "/admin/shop/getShopListAjax.do");
  $("#currentPageNo").val(pageNo);
  commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}

//검색, 페이지 이동 콜백
function fn_searchCallback(data){
	$("#listArea").empty();
	$("#listArea").html(data);
	$("#searchTotalCount").text($("#listTotalCount").val());
}

//상세화면으로 이동
function fn_goDetailPage(shopInfoId){
	$("#shopInfoId").val(shopInfoId);

	$("#frm").attr("action",contextRoot + "/admin/shop/shopDetail.do");
	$("#frm").submit();
}


//20개씩, 40개씩, 60개씩 보기
function fn_listChange(val){
    $("#recordCountPerPage").val(val);
    fn_doSearch("1");
}

//정렬순서
function fn_doSort(type){

	if(type == 1){
		var targetClass = $("#sort_column_prefix0").attr("class");

		if(targetClass == "sort_hightolow"){
			$("#sort_column_prefix0").removeClass("sort_hightolow");
			$("#sort_column_prefix0").addClass("sort_lowtohigh");

			$("#sortOrder").val("A.SHOP_INFO_ID ASC");
		}else if(targetClass == "sort_lowtohigh"){
			$("#sort_column_prefix0").removeClass("sort_lowtohigh");
            $("#sort_column_prefix0").addClass("sort_hightolow");

			$("#sortOrder").val("A.SHOP_INFO_ID DESC");
		}
	}else if(type == 2){

	}

	fn_doSearch(1);
}
///////////////////////////////
//////////////////////////////

//등록페이지이동
function goCreatePage(){
	$("#frm").attr("action",contextRoot + "/admin/shop/shopCreate.do");
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


// 고객사명 클릭
function fn_goCompanyDetailPage(companyInfoId){
    var url = contextRoot + "/admin/shop/getCompanyDetailPop.do?companyInfoId=" + companyInfoId;
    fn_popUp('BrandDetailPop', 800, 450, url);
}

// 브랜드명 클릭
function fn_goBrandDetailPage(brandInfoId){
    var url = contextRoot + "/admin/shop/getBrandDetailPop.do?brandInfoId=" + brandInfoId;
    fn_popUp('BrandDetailPop', 800, 300, url);
}

// 매장 등록 팝업 생성
function fn_goCreatePopPage(){
    var url = contextRoot + "/admin/shop/createShopPop.do";
    fn_popUp('CreateShopPop', 800, 280, url);
}


</script>