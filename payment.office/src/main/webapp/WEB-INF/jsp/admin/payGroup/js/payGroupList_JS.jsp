<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<!--
  NAVI : admin > 간편결제관리 > 결제서비스그룹 관리 > 목록(js)
-->
<script type="text/javascript">

$(document).ready(function(){

  //검색버튼
  $("#btnSearch").click(function(){
      fn_doSearch(1);
  });

  // 숫자만 입력가능하도록 처리
  $("input:text[numberOnly]").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
  });

  // checkbox 클릭이벤트를 td영역으로 확대
  $(".chktd").click( function(event){
    if (!$(event.target).is( 'input')) {
      $( 'input:checkbox', this ).prop('checked' , function (i, value) {
        fn_onclickEvent($(this).val());
        return !value;
      });
    }
  });

  // checkbox 클릭이벤트를 td영역으로 확대
  $(".chktd2").click( function(event){
    if (!$(event.target).is( 'input')) {
      $( 'input:checkbox', this ).prop('checked' , function (i, value) {
        return !value;
      });
    }
  });

});


//정렬순서
function fn_doSort(type){

  var targetClass = $("#sort_column_prefix0").attr("class");

  if(targetClass == "sort_hightolow"){
    $("#sort_column_prefix0").removeClass("sort_hightolow");
    $("#sort_column_prefix0").addClass("sort_lowtohigh");

    $("#sortOrder").val("paymentMean");

    $("#sort_column_prefix0").text("사용여부 순");

  }else if(targetClass == "sort_lowtohigh"){
    $("#sort_column_prefix0").removeClass("sort_lowtohigh");
    $("#sort_column_prefix0").addClass("sort_hightolow");

    $("#sortOrder").val("useYn");


    $("#sort_column_prefix0").text("결제수단 순");
  }

  fn_doSearch(1);
}

// 임시 소팅
function fn_sort(arg){
  $("#sortOrder").val(arg);
  fn_doSearch(1);
}

//검색, 페이지 이동
function fn_doSearch(pageNo){

  $("#frm").attr("action" , contextRoot + "/admin/payServiceGroup/getPayServiceGroupListAjax.do");
  //$("#currentPageNo").val(pageNo);
  commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
}

//검색, 페이지 이동 콜백
function fn_searchCallback(data){
	$("#listArea").empty();
	$("#listArea").html(data);
	$("#searchTotalCount").text($("#listTotalCount").val());
}

/*
    목록 초기화
*/
function fn_initList(){

  var list = new Array();

  <c:if test="${fn:length(result.paySrvGroupList) <= 0 }">
  list.push("No customers Found");
  </c:if>

  <c:forEach var="data" items="${result.paySrvGroupList}">
  console.log("${data.paymentServiceId}");
  </c:forEach>

  console.log("====> " + list);

}

/*
    목록 저장
  */
function fn_listSave(){

  // ########## validation check ########## START #########################################

  if($("#searchPaymentGroup").val() == ''){
    alert("저장할 목록이 없습니다.")
    $("#searchPaymentGroup").focus();
    return false;
  }

  var index = 0;
  $("input[name=useYn]:checked").each(function() {
    index ++;
  });

  if(index == 0){
    alert("저장할 목록이 없습니다.")
    return false;
  }


  if(!fn_nullCheck('displayMethod', '노출방법'))
    return false;


  if(!fn_nullCheck('displayOrder', '노출순번'))
    return false;

  if(!fn_nullCheck('displayName', '노출명'))
    return false;


  // 결제수단 중복 체크
  var payMeanList = new Array();
  var continueFlag = false;
  var duplArr = new Array();
  $("input[name=useYn]:checked").each(function() {
    var num = $(this).val();

    for(var i=0; i < payMeanList.length; i++){
      if(payMeanList[i] == $("#paymentMeanNm_"+num).text()){
        continueFlag = true;
        duplArr.push($("#paymentMeanNm_"+num).text().trim());
        break;
      }
    }
    payMeanList.push($("#paymentMeanNm_"+num).text());
  });
  if(continueFlag){
    alert("결제수단은 중복하여 선택 할 수 없습니다. \n중복된 결제수단 : " + duplArr);
    return false;
  }

  // 노출순번 중복 체크
  var displayOrderList = new Array();
  var duplNum;
  var cntiFlag = false;
  $("input[name=useYn]:checked").each(function() {
    var num = $(this).val();

    for(var i=0; i < chkList.length; i++){
      if(displayOrderList[i] == $("#displayOrder_"+num).val()){
        duplNum = num;
        cntiFlag = true;
        return false;
      }
    }
    displayOrderList.push($("#displayOrder_"+num).val());
  });

  if(cntiFlag){
    alert("중복 번호가 있습니다.");
    $("#displayOrder_"+duplNum).focus();
    return false;
  }

  // ########## validation check ########## END #########################################

  var jsonStr = new Object;
  var rowArr = new Array;

  $("input[name=useYn]:checked").each(function() {
    var num = $(this).val();

    var classObj = new Object();

    classObj.paymentServiceId = num;
    classObj.displayMethod = $("#displayMethod_"+num).val();
    classObj.displayYn = $("#displayYn_"+num).val();
    classObj.displayOrder = $("#displayOrder_"+num).val();
    classObj.displayName = $("#displayName_"+num).val();
    classObj.displayImageUrl = $("#displayImageUrl_"+num).val();

    rowArr.push(classObj);
    jsonStr.formData = rowArr;

  });

  $("#jsonStr").val(JSON.stringify(jsonStr));
  $("#paymentGroup").val($("#searchPaymentGroup").val());

  if(confirm("<spring:message code='request.common.update'   />")) {
    $("#frm").attr("action",contextRoot + "/admin/payServiceGroup/modifyPayServiceGroupAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_doModifyCallback);
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


// 저장 시 널 체크
function fn_nullCheck(columnName, msg){

  var addMsg = "은(는) 필수 입력 항목입니다.";
  var returnFlag = true;

  // displayMethod check
  $("input[name=useYn]:checked").each(function() {
    var num = $(this).val();
    if($("#"+columnName+"_"+num).val() == ""){
      alert(msg+addMsg);
      $("#"+columnName+"_"+num).focus();
      returnFlag = false;
      return false;
    }
  });

  return returnFlag;

}






/*
 사용여부 선택/미선택에 대한 해당 로우 입력 필드 enable/disabled 처리
  */
function fn_onclickEvent(id){

  console.log($("#paymentMeanNm_"+id).text());

  var paymentMeanNm = $("#paymentMeanNm_"+id).text().trim();

  if($("#displayYn_"+id).attr('disabled')){

    $("#displayYn_"+id).removeAttr('disabled');
    $("#displayMethod_"+id).removeAttr('disabled');
    $("#displayOrder_"+id).removeAttr('disabled');
    $("#displayName_"+id).removeAttr('disabled');
    $("#displayImageUrl_"+id).removeAttr('disabled');

    if($("#displayName_"+id).val() == null || $("#displayName_"+id).val() == ''){
      $("#displayName_"+id).val(paymentMeanNm);
    }

  } else {

    $("#displayYn_"+id).attr('disabled', 'disabled');
    $("#displayMethod_"+id).attr('disabled', 'disabled');
    $("#displayOrder_"+id).attr('disabled', 'disabled');
    $("#displayName_"+id).attr('disabled', 'disabled');
    $("#displayImageUrl_"+id).attr('disabled', 'disabled');


  }
    //$("#paymentMeanNm_"+id).attr("style", "color:#000000")
  $("#displayOrder_"+id).val('');

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