<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/commJS.jsp"%>

<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoModifyPage").click(function(){
        fn_goModifyPage();
    });

    //목록버튼
    $("#btnGoListPage").click(function(){
        fn_goListPage();
    });

    //일괄적용
    $("#saveBt").click(function(){
        fn_selectCheckedSave();
    });

    // 숫자만 입력가능하도록 처리
    $("input:text[numberOnly]").on("keyup", function() {
        $(this).val($(this).val().replace(/[^0-9]/g,""));
    });

    /* ====================================Button Event Setting :E */

});

// 매장정보 수정 팝업 생성
function fn_goShopModifyPop(shopInfoId){
    var url = contextRoot + "/admin/shop/modifyShopPop.do?shopInfoId=" + shopInfoId;
    fn_popUp('BrandDetailPop', 800, 300, url);
}

// 매장정보 수정 저장
function fn_goShopTerminalModify(shopInfoId){

    var shopTerminalId = $("#shopTerminalId").val();

    if(shopTerminalId == null || shopTerminalId == ''){
        alert("매장단말기를 선택하신 후 정보를 수정할 수 있습니다.");
        return false;
    }

    $("#selectedShopTerminalId").val($("#shopTerminalId").val());
    $("#selectedShopInfolId").val(shopInfoId);

    /* :::::::::::::::::: validation END ::::::::::::::::::::::::: */

    var serviceTelNum;
    serviceTelNum = $("#serviceTelNum1").val()+"-"+$("#serviceTelNum2").val()+"-"+$("#serviceTelNum3").val();
    $("#serviceTelNum").val(serviceTelNum);

    var serviceBizNum;
    serviceBizNum = $("#serviceBizNum1").val()+"-"+$("#serviceBizNum2").val()+"-"+$("#serviceBizNum3").val();
    $("#serviceBizNum").val(serviceBizNum);

    if(confirm("<spring:message code='request.common.save'/>")) {
        $("#shopTerminalDetailFrm").attr("action",contextRoot + "/admin/shop/modifyShopTeminalAjax.do");
        commonAjaxSubmit("POST", $("#shopTerminalDetailFrm"), fn_goShopModifyCallback);
    }
}

//저장 콜백
function fn_goShopModifyCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("정상적으로 저장되었습니다.");

    }else{
        alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }
}

// 매장정보 수정 후 처리
function fn_getChildData(obj){

    $("#companyName").text(obj.companyName);
    $("#brandName").text(obj.brandName);
    $("#shopName").text(obj.shopName);
    $("#shopMngCode").text(obj.shopMngCode);
    $("#shopTelNum").text(obj.shopTelNum);

    if(obj.useYn == 'Y'){
        $("#useYn").text('예');
    }else{
        $("#useYn").text('아니오');
    }
}

// 매장단말기 추가 팝업
function fn_goShopTerminalCreatePop(shopInfoId){
    var url = contextRoot + "/admin/shop/createShopTerminalPop.do?shopInfoId="+shopInfoId;
    fn_popUp('BrandDetailPop', 1100, 500, url);
}

//수정 페이지로 이동
function fn_goModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/shop/shopModify.do");
	$("#moveFrm").submit();
}

//리스트 페이지로 이동
function fn_goListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/shop/shopList.do");
	$("#moveFrm").submit();
}

function fn_goDetailList(shopTerminalNum){
    console.log("====> shopTerminalNum : " + shopTerminalNum);
}

//검색, 페이지 이동
function fn_getShopTerminalInfo(shopTerminalId, shopInfoId){

    console.log("====> shopTerminalId : " + shopTerminalId);
    console.log("====> shopInfoId : " + shopInfoId);

    $("#shopTerminalId").val(shopTerminalId);

    $("#shopTermianlFrm").attr("action" , contextRoot + "/admin/shop/getShopTerminalInfoAjax.do");
    commonAjaxSubmit("POST", $("#shopTermianlFrm"), fn_searchCallback);
}

//검색, 페이지 이동 콜백
function fn_searchCallback(data){
    $("#shopTerminalInfoArea").empty();
    $("#shopTerminalInfoArea").html(data);
}

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

    if($("#taxDivM").val() == '' && $("#svcAmtYnM").val() == ''){
        alert("과세형태 및 봉사료여부를 입력 후 적용가능합니다.");
        return false;
    }

    // 과세형태 선택 여부
    if(($("#taxDivM").val() == 'TAX_ON' || $("#taxDivM").val() == 'TAX_PARALLEL')
        && $("#taxRateM").val() == '0'){
        if(confirm("부가세율을 0%로 일괄적용 하시겠습니까?")){
            // 확인 클릭 시
            processContinue = true;
        }else{
            processContinue = false;
            $("#taxRateM").focus();
            return false;
        }
    }

    // 봉사료여부 선택 여부
    if($("#svcAmtYnM").val() == 'Y' && $("#svcChargeRateM").val() == '0'){
        if(confirm("봉사료율을 0%로 일괄적용 하시겠습니까?")){
            // 확인 클릭 시
            processContinue = true;
        }else{
            processContinue = false;
            $("#svcChargeRateM").focus();
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
        alert("정상적으로 일괄적용되었습니다.");
        location.reload(); // FIXME: 2019-01-14 refresh를 list 를 받아와 재구성해주는 방법으로 고려
    }else{
        alert("일괄적용을 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }
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
    saveDataJson.taxDiv = $("#taxDivM").val();
    saveDataJson.taxRate = $("#taxRateM").val();
    saveDataJson.svcAmtYn = $("#svcAmtYnM").val();
    saveDataJson.svcChargeRate = $("#svcChargeRateM").val();

    rowArr2.push(saveDataJson);
    jsonStr.saveColumn =  rowArr2;

    $("#jsonStr").val(JSON.stringify(jsonStr));

    console.log("====> jsonStr :: " + $("#jsonStr").val());

}

// 매장단말기 서비스제공자 저장
function fn_srvProvSave(){

    var shopTerminalId = $("#shopTerminalId").val();

    if(shopTerminalId == null || shopTerminalId == ''){
        alert("매장단말기를 선택하신 후 정보를 수정할 수 있습니다.");
        return false;
    }

    // 서비스제공자 중복 체크
    var srvProvList = new Array();
    var continueFlag = false;
    var duplArr = new Array();
    $("select[name=serviceProvider]").each(function() {
        var num = $("option:selected", this).text();
        console.log("====> " +$("option:selected", this).text());
        for(var i=0; i < srvProvList.length; i++){
            if(srvProvList[i] == num){
                continueFlag = true;
                duplArr.push(num);
                break;
            }
        }
        srvProvList.push(num);
    });
    if(continueFlag){
        alert("서비스제공자는 중복하여 선택 할 수 없습니다. \n중복된 결제수단 : " + duplArr);
        return false;
    }


    var jsonStr = new Object; /* 체크된 항목 목록 저장*/
    var rowArr = new Array;
    $("input[name=shopTerminalProviderId]").each(function() {
        var num = $(this).val();

        // console.log("num : "+num);

        var classObj = new Object();

        classObj.shopTerminalProviderId = num;
        classObj.shopTerminalId = shopTerminalId;
        classObj.serviceProvider = $("#serviceProvider_"+num).val();
        classObj.catId = $("#catId_"+num).val();
        classObj.serviceStoreId = $("#serviceStoreId_"+num).val();
        classObj.serviceStoreNum = $("#serviceStoreNum_"+num).val();
        classObj.serviceCheckYn = $("#serviceCheckYn_"+num).val();
        classObj.useYn = $("#useYn_"+num).val();

        rowArr.push(classObj);
        jsonStr.saveList = rowArr;

    });

    $("#srvProvJson").val(JSON.stringify(jsonStr));

    console.log("====> jsonStr :: " + $("#srvProvJson").val());

    if(confirm("<spring:message code='request.common.update'   />")) {
        $("#srvProvFrm").attr("action",contextRoot + "/admin/shop/mergeShopTerminalSrvProvAjax.do");
        commonAjaxSubmit("POST", $("#srvProvFrm"), fn_srvProvSaveCallback);
    }
}

function fn_srvProvSaveCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("정상적으로 저장되었습니다.");

        console.log($("#shopTerminalId").val()+"/"+ $("#shopInfoId").val())
        fn_getShopTerminalInfo($("#shopTerminalId").val(), $("#shopInfoId").val());

    }else{
        alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }
}


//코드 Row 추가
function fn_srvProvAddHtml(){

    var shopTerminalId = $("#shopTerminalId").val();

    if(shopTerminalId == null || shopTerminalId == ''){
        alert("매장단말기를 선택하신 후 정보를 수정할 수 있습니다.");
        return false;
    }

    if($("#nodata").val()== 0){
        $('#srvProvTable > tbody').empty();
    }

    var index = $("#addIndex").val();

    console.log("==> addIndex :: "+index);



    var trHtml = "<tr>";
    trHtml += "<td>";
    trHtml += "<input type=\"hidden\" name=\"shopTerminalProviderId\" value='new"+index+"'>";
    trHtml += " <select title='사용여부' name='serviceProvider' class='sel_basic w100pro' id='serviceProvider_new"+index+"'>";
    trHtml += "     <option value=''>선택</option>";
    trHtml += "     <option value='NICE'>나이스정보통신</option>";
    trHtml += "     <option value='NTAXREFUND'>TaxRefund</option>";
    trHtml += "     <option value='OLIVE'>올리브</option>";
    trHtml += "     <option value='KISS'>키스정보통신</option>";
    trHtml += "     <option value='SMARTRO'>스마트로</option>";
    trHtml += " </select>";
    trHtml += "</td>";

    trHtml += "<td><input type=\"text\" id=\"catId_new"+index+"\" name=\"catId\" class=\"input_s_b w100pro\" /></td>";
    trHtml += "<td><input type=\"text\" id=\"serviceStoreId_new"+index+"\" name=\"serviceStoreId\" class=\"input_s_b w100pro\" /></td>";
    trHtml += "<td><input type=\"text\" id=\"serviceStoreNum_new"+index+"\" name=\"serviceStoreNumSp\" class=\"input_s_b w100pro\" /></td>";

    trHtml += "<td>";
    trHtml += " <select title='서비스체크여부' name='serviceCheckYn' class='sel_basic w100pro' id='serviceCheckYn_new"+index+"'>";
    trHtml += "     <option value='Y'>예</option>";
    trHtml += "     <option value='N'>아니요</option>";
    trHtml += " </select>";
    trHtml += "</td>";

    trHtml += "<td>";
    trHtml += " <select title='사용여부' name='useYn' class='sel_basic w100pro' id='useYn_new"+index+"'>";
    trHtml += "     <option value='Y'>예</option>";
    trHtml += "     <option value='N'>아니요</option>";
    trHtml += " </select>";
    trHtml += "</td>";

    trHtml += "</td>";
    trHtml += "<td><button type='button' class='btn_white_B01' onclick='javascript:fn_deleteRowCode(this);'>삭제</button></td>";

    trHtml += "</tr>";

    $('#srvProvTable').append(trHtml);

    index++;
    $("#addIndex").val(index);
}

//코드 테이블 Row 삭제
function fn_deleteRowCode(obj){
    if(!confirm("삭제하시겠습니까?")) return;
    var tr = $(obj).parent().parent();
    tr.remove();
}

</script>