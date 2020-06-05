<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : customerGroupList_JS.jsp
  * @Description :
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05  psj      최초 생성
-->
<script type="text/javascript" defer="defer">
	$(document).ready(function() {

		$('#createPaymentfrm').validate({
			rules : {
				createPaymentName : {required: true,maxlength : 20}
				,createPaymentPhone: { required: true,isNum: true, minlength : 10, maxlength : 11}
				,createPaymentAmount: { required: true,  maxlength : 11}
				,createPaymentDescription: { required: true, minlength : 5,  maxlength : 150}
			},
			messages : {
				createPaymentName: {
					required: "수취인명을 입력해 주세요."
					,maxlength: "수취인명은 20자 이내로 입력해 주세요."
					}
				,createPaymentPhone: {
	                required: '모바일번호를 입력하여 주세요.'
	                ,isNum : '모바일번호는 숫자만 입력해 주세요.'
	                ,minlength : "올바른 모바일번호를 입력해 주세요."
	                ,maxlength : "올바른 모바일번호를 입력해 주세요."
	            }
				,createPaymentAmount: {
	                required: '청구금액을 입력하여 주세요.'
	                ,maxlength : "올바른 청구금액을 입력해 주세요."
	            }
				,createPaymentDescription: {
	                required: '청구사유를 입력하여 주세요.'
	                ,minlength : '청구사유는 최소5자이상 입력해 주세요.'
	                ,maxlength : "청구사유는 최대 150자까지 입력 가능합니다."
	            }
			},
			showErrors : function(errorMap, errorList) {
			},
			invalidHandler : function(form, validator) {
				var error = validator.errorList[0];
				alert(error.message);
				$(error.element).focus();
			},
			onsubmit : false
		});
		//사용자 그룹 추가 팝업오픈
		$("#btnAddCustomerGroup").click(function(){
			openCustomerGroupPop();
		});
		//사용자 그룹 추가 팝업오픈
		$("#btnAddCustomerGroup2").click(function(){
			openCustomerGroupPop();
		});

		//사용자 그룹 선택삭제
		$("#btnDeleteCustomerGroup").click(function(){
			deleteCustomerGroup();
		});


		//팝업닫기
	    $(".closePop").click(function(){
	        $.unblockUI();
	    });

	  	//사용자그룹추가
	    $("#btnSaveCustomerGroup").click(function(){
	        createCustomerGroup();
	    });
	  	//사용자그룹수정
	    $("#btnModifyCustomerGroup").click(function(){
	        modifyCustomerGroup();
	    });
	  	//사용자그룹검색
	    $("#btnSearch").click(function(){
		    searchCustomerGroup(1);
	    });
	});

	function selectCustomer(){

		var customerUserReason = $("#customerUserReason").val();
		var customerAmount = $("#customerAmount").val();

		if(customerUserReason == ""){
			alert("청구사유를 입력해 주세요");
			return;
		}

		if(customerAmount == ""){
			alert("청구금액을 입력해 주세요");
			return;
		}
		//전송 테이터 생성
		var paramObj = new Object();

		var sendList = new Array();
		var $target = $("input[name='chkCustomerGroupDetail']:checked");

		if($target.length == 0 ){
			alert("발송대상을 선택해 주세요.");
			return;
		}

		$target.each(function(i){
			var customerNm = $(this).parent().parent().parent().find("input[name='customerNm']").val();
			var customerPhone = $(this).parent().parent().parent().find("input[name='customerPhone']").val();
			var description = $(this).parent().parent().parent().find("input[name='description']").val();
			var pamentObj = new Object();
			pamentObj.customerNm = customerNm;
			pamentObj.customerPhone = customerPhone;
			pamentObj.description = description;

			sendList.push(pamentObj);
		});

		paramObj.sendList = sendList
		paramObj.customerUserReason = customerUserReason
		paramObj.customerAmount = customerAmount
		parent.sendCustomerInfoList(paramObj);
	}
	//사용자그룹유저 저장/수정
	function procCustomerGroupDetail(){
		if($("#searchCustomerGroupId").length == 0 ){
			alert("잘못된 접근입니다.");
			return;
		}

		var searchCustomerGroupId = $("#searchCustomerGroupId").val();

		//전송 테이터 생성
		var paramObj = new Object();
		paramObj.customerGroupId = searchCustomerGroupId;

		var sendList = new Array();

		var isValid = true;

		$("#customerGroupDetailTable tbody tr").each(function(i){
			var customerGroupDetailId = $(this).find("input[name='customerGroupDetailId']").val();

			var deleteYn = $(this).find("input[name='deleteYn']").val();

			if(!customerGroupDetailId||!deleteYn){
				alert("잘못된 접근입니다.");
				isValid = false;
				return false;
			}
			var customerNm = $(this).find("input[name='customerNm']").val();

			if(customerNm == ""){
				alert("사용자명을 입력해 주세요.");
				$(this).find("input[name='customerNm']").focus();
				isValid = false;
				return false;
			}
			var customerPhone = $(this).find("input[name='customerPhone']").val();
			if(customerPhone == ""){
				alert("모바일번호를 입력해 주세요.");
				$(this).find("input[name='customerPhone']").focus();
				isValid = false;
				return false;
			}
			if(!isMobileNumber(customerPhone)){
				alert("올바른 모바일번호를 입력해 주세요.");
				$(this).find("input[name='customerPhone']").focus();
				isValid = false;
				return false;
			}

			var description = $(this).find("input[name='description']").val();
			if(description == ""){
				alert("비고를 입력해 주세요.");
				$(this).find("input[name='description']").focus();
				isValid = false;
				return false;
			}

			var pamentObj = new Object();
			pamentObj.customerGroupDetailId = customerGroupDetailId;
			pamentObj.deleteYn = deleteYn;
			pamentObj.customerNm = customerNm;
			pamentObj.customerPhone = customerPhone;
			pamentObj.description = description;

			sendList.push(pamentObj);


		});

		if(!isValid) return;

		paramObj.sendList = JSON.stringify(sendList)

    	var url = "/service/userGroup/procCustomerGroupDetail.do";

    	commonAjax("POST", url, paramObj, procCustomerGroupDetailCallback);

	}
	//
	function procCustomerGroupDetailCallback(data){
		if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
			alert("저장되었습니다.");

			isGroupDetailChg = false;
			getCustomerGroupDetail($("#searchCustomerGroupId").val());

			var pageIndex = $("#groupFrm").find("input[name='currentPageNo']").val()
			searchCustomerGroup(pageIndex);
	    }else{
	        alert("저장에 실패하였습니다. 다시 시도하여 주십시요.");  //
	    }
	}
	//사용자그룹유저삭제
	function addCustomerUserDelete(obj){

		if($("#customerGroupDetailTable tbody tr:visible").length == 1){
			alert("최소 1개이상 입력해 주세요.");
			return;
		}
		var $target = $(obj).parent().parent();
		var customerGroupDetailId = $target.find("input[name='customerGroupDetailId']").val();

		if(customerGroupDetailId == "0") $target.remove();
		else{
			$target.find("input[name='deleteYn']").val("Y");
			$target.hide();
		}

		isGroupDetailChg = true;
	}
	//엑셀업로드
	function addExcelCustomerList(customerNm,customerPhone,description){

		var stStr = "";
		stStr += '<tr id="customerGroupDetailTr_0" class = "customerGroupDetailTr">';
		stStr += '<td><label><input type="checkbox" name="chkCustomerGroupDetail" value="0" onclick="fn_eachCheck(this);" /></label>';
		stStr += '<input type="hidden" name = "customerGroupDetailId" value="0"><input type="hidden" name = "deleteYn" value="N"></td>';
		stStr += '<td ><input type="text" class="input_s_b w100pro" name="customerNm" value="'+customerNm+'"></td>';
		stStr += '<td ><input type="text" class="input_s_b w100pro" name="customerPhone" placeholder="(-)제외" value="'+customerPhone+'"></td>';
		stStr += '<td ><input type="text" class="input_s_b w100pro" name="description" value="'+description+'"></td>';
		stStr += '<td >';
		stStr += '<button style="border:1px solid #C9C097;background:#ffffff;width: 12px;" onclick="addCustomerUserArea()">+</button>&nbsp;';
		stStr += '<button style="border:1px solid #C9C097;background:#ffffff;width: 12px;" onclick="addCustomerUserDelete(this)">-</button>';
		stStr += '</td></tr>';

		$("#customerGroupDetailTable tbody").append(stStr);

		isGroupDetailChg = true;
	}
	//사용자그룹유저추가영역
	function addCustomerUserArea(){
		if($("#customerGroupDetailTable").length ==0 ){
			return;
		}

		if($(".customerGroupDetailTr").length ==0){
			$("#customerGroupDetailTable tbody").empty();
		}

		var stStr = "";
		stStr += '<tr id="customerGroupDetailTr_0" class = "customerGroupDetailTr">';
		stStr += '<td><label><input type="checkbox" name="chkCustomerGroupDetail" value="0" onclick="fn_eachCheck(this);" /></label>';
		stStr += '<input type="hidden" name = "customerGroupDetailId" value="0"><input type="hidden" name = "deleteYn" value="N"></td>';
		stStr += '<td ><input type="text" class="input_s_b w100pro" name="customerNm" value=""></td>';
		stStr += '<td ><input type="text" class="input_s_b w100pro" name="customerPhone" placeholder="(-)제외" value=""></td>';
		stStr += '<td ><input type="text" class="input_s_b w100pro" name="description" value=""></td>';
		stStr += '<td >';
		stStr += '<button style="border:1px solid #C9C097;background:#ffffff;width: 12px;" onclick="addCustomerUserArea()">+</button>&nbsp;';
		stStr += '<button style="border:1px solid #C9C097;background:#ffffff;width: 12px;" onclick="addCustomerUserDelete(this)">-</button>';
		stStr += '</td></tr>';

		$("#customerGroupDetailTable tbody").append(stStr);

		isGroupDetailChg = true;
	}
	//사용자 그룹 상세 검색
	function getCustomerGroupDetail(customerGroupId){
		$(".customerGroupTr").css("background-color","");
		$("#customerGroupTr_"+customerGroupId).css("background-color","#f0f8ff");

		//전송 테이터 생성
		var paramObj = new Object();

		var searchText = "";

		if($("#searchText2").length>0){
			searchText = $("#searchText2").val();
		}

		paramObj.customerGroupId = customerGroupId;
		paramObj.searchText = searchText;

		var url = "/service/userGroup/getCustomerGroupDetailPopAjax.do";

		commonAjaxParam("POST", url, paramObj, getCustomerGroupDetailCallback);
	}
	//사용자 그룹 상세 검색 콜백
	function getCustomerGroupDetailCallback(data){
		$("#customerGroupDetailArea").html(data);

		fn_numberFormatForNumberClass();
	}
	//사용자 그룹 수정 팝업 오픈
	function openCustomerModifyPop(customerGroupId,groupNm,description){
		var popModalDivId = "customerGroupPop";

		$(".customerGroupCreate").hide();
		$(".customerGroupModify").show();

		$("#customerGroupIdPop").val(customerGroupId);
		$("#groupNm").val(groupNm);
		$("#description").val(description);

        openModalPop(popModalDivId,"");
	}
	//사용자 그룹 선택 삭제
	function deleteCustomerGroup(){
		//전송 테이터 생성
		var paramObj = new Object();

		var $target = $("input[name='chkCustomerGroup']:checked")

		if($target.length==0){
			alert("삭제할 사용자그룹을 선택해 주세요.");
			return;
		}

		var deleteStr="";

		$target.each(function(i){
			if(i!=0) deleteStr +=",";
			deleteStr+=$(this).val();
		})


		paramObj.deleteStr = deleteStr;

		if(!confirm("삭제하시겠습니까?")) return;

		var url = "/service/userGroup/deleteCustomerGroup.do";

    	commonAjax("POST", url, paramObj, deleteCustomerGroupCallback);
	}

	//사용자 그룹 선택 삭제 Callback
	function deleteCustomerGroupCallback(data){
		if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
			alert("삭제되었습니다.");
			searchCustomerGroup(1);
	    }else{
	        alert("저장에 실패하였습니다. 다시 시도하여 주십시요.");  //
	    }
	}
	//사용자 그룹 조회 AJAX
	function searchCustomerGroup(pageNo){
		$("#groupFrm").attr("action",contextRoot + "/service/userGroup/getCustomerGroupListAjax.do");
		$("#groupFrm").find("input[name='currentPageNo']").val(pageNo);
		commonAjaxSubmit("POST", $("#groupFrm"), searchCustomerGroupCallbakc);
	}
	//사용자 그룹 조회 AJAX 콜백
	function searchCustomerGroupCallbakc(data){
		$("#includeArea").empty();
		$("#includeArea").html(data);

		var searchCustomerGroupId = $("#searchCustomerGroupId").val();

		$("#customerGroupTr_"+searchCustomerGroupId).css("background-color","#f0f8ff");
	}
	//사용자그룹추가 팝업오픈
	function openCustomerGroupPop(){
		var popModalDivId = "customerGroupPop";

		$(".customerGroupCreate").show();
		$(".customerGroupModify").hide();

		$("#groupNm").val("");
		$("#description").val("");

        openModalPop(popModalDivId,"");
	}
	//사용자그룹수정
	function modifyCustomerGroup(){
		var groupNm = $("#groupNm").val();
		var description = $("#description").val();
		var customerGroupIdPop = $("#customerGroupIdPop").val();

		if(groupNm == ""){
			alert("사용자그룹명을 입력해 주세요.");
			return;
		}

		if(description == ""){
			alert("비고를 입력해 주세요.");
			return;
		}

		if(customerGroupIdPop == ""){
			alert("잘못된 접근입니다. 페이지 새로고침 후 다시 시도해 주세요.");
			return;
		}

		//전송 테이터 생성
		var paramObj = new Object();
		paramObj.groupNm = groupNm;
		paramObj.description = description;
		paramObj.customerGroupId = customerGroupIdPop;

		var url = "/service/userGroup/modifyCustomerGroup.do";

    	commonAjax("POST", url, paramObj, modifyCustomerGroupCallback);

	}
	//사용자그룹수정콜백
	function modifyCustomerGroupCallback(data){
		if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
			alert("수정되었습니다.");
			var pageIndex = $("#groupFrm").find("input[name='currentPageNo']").val()
			searchCustomerGroup(pageIndex);
			$.unblockUI();
	    }else{
	        alert("저장에 실패하였습니다. 다시 시도하여 주십시요.");  //
	    }
	}
	//사용자그룹추가
	function createCustomerGroup(){
		var groupNm = $("#groupNm").val();
		var description = $("#description").val();

		if(groupNm == ""){
			alert("사용자그룹명을 입력해 주세요.");
			return;
		}

		if(description == ""){
			alert("비고를 입력해 주세요.");
			return;
		}

		//전송 테이터 생성
		var paramObj = new Object();
		paramObj.groupNm = groupNm;
		paramObj.description = description;

		var url = "/service/userGroup/createCustomerGroup.do";

    	commonAjax("POST", url, paramObj, createCustomerGroupback);

	}

	//그룹추가 콜백
	function createCustomerGroupback(data){
		if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
			alert("저장되었습니다.");
			searchCustomerGroup(1);
			$.unblockUI();
	    }else{
	        alert("저장에 실패하였습니다. 다시 시도하여 주십시요.");  //
	    }
	}

	//엑셀템플릿다운
	function downTemplateFile(){
		$('#templateFrm').attr({target: '_blank', action  : '${pageContext.request.contextPath}/resources/template/mp_customer_excel_template.xlsx'}).submit();
	}

	//엑셀 파일 파싱
	function excelExport(event){
		excelExportCommon(event, ecxcelCallback);
	}
	function excelExportCommon(event, callback){
	    var input = event.target;
	    var reader = new FileReader();
	    reader.onload = function(){
	        var fileData = reader.result;
	        var wb = XLSX.read(fileData, {type : 'binary'});
	        var sheetNameList = wb.SheetNames; // 시트 이름 목록 가져오기
	        var firstSheetName = sheetNameList[0]; // 첫번째 시트명
	        var firstSheet = wb.Sheets[firstSheetName]; // 첫번째 시트
	        callback(firstSheet);
	    };
	    reader.readAsBinaryString(input.files[0]);
	}

	// 엑셀 파싱 및 추가
	function ecxcelCallback(sheet){
		var headers = get_header_row(sheet);

		if(headers.length !=3){
			alert("올바른 템플릿 엑셀 파일을 사용해 주세요.");
			return;
		}else{
			var validHeader = ["사용자명","모바일번호","비고"]

			var is_validHeader = true;

			for(var i = 0 ; i <headers.length;i++){
				if(headers[i]!=validHeader[i]){
					is_validHeader = false;
				}
			}


			if(!is_validHeader){
				alert("올바른 템플릿 엑셀 파일을 사용해 주세요.");
				return;
			}

			//내용파싱
			var excelJson = XLSX.utils.sheet_to_json (sheet);

			var is_valid = true;
			for(var j = 0 ; j < excelJson.length ; j++){
				var customerNm = excelJson[j][validHeader[0]];
				var customerPhone = excelJson[j][validHeader[1]];
				var description = excelJson[j][validHeader[2]].toString();

				if(customerNm==null){
					alert((j+2)+"행 : 사용자명을 입력해 주세요.");
					is_valid = false;
					return false;
				}

				customerPhone = customerPhone.split("-").join("");

				if(!isMobileNumber(customerPhone)){
					alert((j+2)+"행 : 올바른 모바일번호를 입력해 주세요.");
					is_valid = false;
					return false;
				}

				if(description==null){
					alert((j+2)+"행 : 비고를 입력하여 주세요.");
					is_valid = false;
					return false;
				}

				if(!is_valid) return;
				addExcelCustomerList(customerNm,customerPhone,description);

			}
		}
		initFileArea();

	}

	// 파일 초기화
	function initFileArea(){
		var $initFile = $("#excelFileBuf").clone(true);
		$("#excelFile").remove();

		$initFile.attr("id","excelFile");

		$("#btnExcelUpload").append($initFile);
	}

	function get_header_row(sheet) {
	    var headers = [];
	    var range = XLSX.utils.decode_range(sheet['!ref']);
	    var C, R = range.s.r; /* start in the first row */
	    /* walk every column in the range */
	    for(C = range.s.c; C <= range.e.c; ++C) {
	        var cell = sheet[XLSX.utils.encode_cell({c:C, r:R})] /* find the cell in the first row */

	        var hdr = "UNKNOWN " + C; // <-- replace with your desired default
	        if(cell && cell.t) hdr = XLSX.utils.format_cell(cell);

	        headers.push(hdr);
	    }
	    return headers;
	}

</script>