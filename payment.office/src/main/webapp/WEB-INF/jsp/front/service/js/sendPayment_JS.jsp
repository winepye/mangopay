<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : sendPayment_JS.jsp
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
		//청구서발송 선택삭제
		$("#btnDelete").click(function(){
			fn_doDelete();
		});
		//청구서발송 전체발송
		$("#btnSendAll").click(function(){
			fn_send("all");
		});
		//청구서발송 선택발송
		$("#btnSend").click(function(){
			fn_send("chk");
		});

		//청구서 개별추가 버튼
		$("#btnCreatePayment").click(function(){
			createPayment();
		});

		//청구서 개별추가 초기화 버튼
		$("#btnCreatePaymentInit").click(function(){
			createPaymentInit();
		});

		//엑셀 템플릿 다운
		$("#btnTemplateExcelDown").click(function(){
			downTemplateFile();
		});
		//엑셀 템플릿 다운
	/* 	$("#btnCustomerAdd").click(function(){
			openCustomerGroupPop();
		}); */

	});
	//사용자그룹팝업 오픈
	function openCustomerGroupPop2(){
		$("#customerPopFrm").attr("action",contextRoot + "/service/userGroup/getCustomerGroupList/pop.do");
        commonAjaxSubmit("POST", $("#customerPopFrm"), openCustomerGroupPopCallback);
	}
	//사용자그룹팝업 오픈 콜백
	function openCustomerGroupPopCallback(data){
		$("#pop_wrap").empty();
		$("#pop_wrap").html(data);
		openModalPop("customerGroupPop","","1100px","596px","3%","23%");

		//팝업닫기
	    $("#closeCustomerPop").click(function(){
	        $.unblockUI();
	    });

	}
	//엑셀템플릿다운
	function downTemplateFile(){
		$('#templateFrm').attr({target: '_blank', action  : '${pageContext.request.contextPath}/resources/template/mp_excel_template.xlsx'}).submit();
	}
	//청구서발송
	function fn_send(type){

		$("#paymentTable").find("input[name='chkPaymentTable']").attr("sendTarget_yn","n");
		var $sendEle = null;
		if(type == "all"){
			$sendEle = $("#paymentTable").find("input[name='chkPaymentTable']");

			if($sendEle.length == 0){
				alert("전송 대상을 추가해 주세요.");
				return;
			}
		}else{
			$sendEle = $("#paymentTable").find("input[name='chkPaymentTable']:checked");

			if($sendEle.length == 0){
				alert("전송 대상을 선택해 주세요.");
				return;
			}
		}

		//전송 테이터 생성
		var paramObj = new Object();

		//발송방식
		var sendType = $("input[name='sendType']:checked").val();

		paramObj.sendType = sendType;

		var sendList = new Array();

		$sendEle.each(function(i){
			var $target = $(this).parent().parent().parent()

			var paymentName = $target.find("input[name='paymentName']").val()
			var paymentPhone = $target.find("input[name='paymentPhone']").val()
			var paymentAmount = $target.find("input[name='paymentAmount']").val()
			var paymentDescription = $target.find("input[name='paymentDescription']").val()

			var pamentObj = new Object();
			pamentObj.paymentName = paymentName;
			pamentObj.paymentPhone = paymentPhone;
			pamentObj.paymentAmount = paymentAmount;
			pamentObj.paymentDescription = paymentDescription;

			sendList.push(pamentObj);
		});

		//paramObj.sendList = JSON.parse(JSON.stringify(sendList));
		paramObj.sendList = JSON.stringify(sendList);
		//paramObj.sendList = sendList;


		if(!confirm(sendList.length+" 건의 청구서를 발송 요청 하시겠습니까?")) return;

		$sendEle.attr("sendTarget_yn","y");

    	var url = "/service/payment/sendPaymentAjax.do";

    	commonAjax("POST", url, paramObj, fn_sendCallback);

	}

	//청구서 발송 콜백
	function fn_sendCallback(data){
		alert("success")

		if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
			alert("청구서가 발송되었습니다.");

			$("#paymentTable").find("input[name='chkPaymentTable'][sendTarget_yn='y']").parent().parent().parent().remove();
			if($("#paymentTable").find("input[name='chkPaymentTable']").length ==0){
				$("#noList").show();
				$("#chkPaymentTable").prop("checked",false);
			}
	    }else{
	        alert("청구서 발송에 실패하였습니다. 다시 시도하여 주십시요.");  //
	    }

	}


	//청구서발송 선택삭제
	function fn_doDelete(){
		var $deleteEle = $("#paymentTable").find("input[name='chkPaymentTable']:checked");

		if($deleteEle.length == 0){
			alert("삭제할 대상이 없습니다.");
			return;
		}

		$deleteEle.parent().parent().parent().remove();

		if($("#paymentTable").find("input[name='chkPaymentTable']").length ==0){
			$("#noList").show();

			$("#chkPaymentTable").prop("checked",false);
		}

	}

	//개별추가
	function createPayment(){
		if(!$("#createPaymentfrm").valid()) return;

		var createPaymentName = $("#createPaymentName").val();
		var createPaymentPhone = $("#createPaymentPhone").val();
		var createPaymentAmount = $("#createPaymentAmount").val();
		var createPaymentDescription = $("#createPaymentDescription").val();

		addList("건별발송",createPaymentName,createPaymentPhone,createPaymentAmount,createPaymentDescription);

		createPaymentInit();
	}
	//청구서 개별추가 초기화 버튼
	function createPaymentInit(){
		var createPaymentName = $("#createPaymentName").val("");
		var createPaymentPhone = $("#createPaymentPhone").val("");
		var createPaymentAmount = $("#createPaymentAmount").val("");
		var createPaymentDescription = $("#createPaymentDescription").val("");
	}

	//청구서 발송 리스트에 데이터를 추가한다.
	function addList(addTypeNm,paymentName,paymentPhone,paymentAmount,paymentDescription){
		var stStr = "";
		stStr +="<tr>"
		stStr +='<td><label><input type="checkbox" name="chkPaymentTable" onclick="fn_eachCheck(this);" /></label></td>';
		stStr +="<td>"+addTypeNm+"</td>";
		stStr +="<td>"+paymentName;
		stStr +="<input type='hidden' name = 'paymentName' value = '"+paymentName+"'>"+"</td>";

		stStr +="<td>"+paymentPhone;
		stStr +="<input type='hidden' name = 'paymentPhone' value = '"+paymentPhone+"'>"+"</td>";

		var paymentAmount = paymentAmount.split(",").join("")

		stStr +="<td>"+devUtil.fn_getNumberFormat(paymentAmount);
		stStr +="<input type='hidden' name = 'paymentAmount' value = '"+paymentAmount+"'>"+"</td>";

		stStr +="<td>"+paymentDescription;
		stStr +="<input type='hidden' name = 'paymentDescription' value = '"+paymentDescription+"'>"+"</td>";

		stStr +="</tr>";

		$("#noList").hide();

		$("#paymentTable tbody").append(stStr);
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

		if(headers.length !=4){
			alert("올바른 템플릿 엑셀 파일을 사용해 주세요.");
			return;
		}else{
			var validHeader = ["수취인명","모바일번호","청구금액","청구사유"]

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
				var createPaymentName = excelJson[j][validHeader[0]];
				var createPaymentPhone = excelJson[j][validHeader[1]];
				var createPaymentAmount = excelJson[j][validHeader[2]].toString();
				var createPaymentDescription = excelJson[j][validHeader[3]];

				if(createPaymentName==null){
					alert((j+2)+"행 : 수취인명을 입력해 주세요.");
					is_valid = false;
					return false;
				}

				if(createPaymentName.length>20){

					alert((j+2)+"행 : 수취인명은 20자 이내로 입력해 주세요.");
					is_valid = false;
					return false;
				}

				createPaymentPhone = createPaymentPhone.split("-").join("");

				if(!isMobileNumber(createPaymentPhone)){
					alert((j+2)+"행 : 올바른 모바일번호를 입력해 주세요.");
					is_valid = false;
					return false;
				}

				if(createPaymentDescription==null){
					alert((j+2)+"행 : 청구사유를 입력하여 주세요.");
					is_valid = false;
					return false;
				}
				if(createPaymentDescription.length<5){

					alert((j+2)+"행 : 청구사유는 최소5자이상 입력해 주세요.");
					is_valid = false;
					return false;
				}

				if(createPaymentDescription.length>150){

					alert((j+2)+"행 : 청구사유는 최대 150자까지 입력 가능합니다.");
					is_valid = false;
					return false;
				}

				if(!is_valid) return;
				addList("엑셀업로드",createPaymentName,createPaymentPhone,createPaymentAmount,createPaymentDescription);

			}
			initFileArea();



		}

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
	function sendCustomerInfoList(paramObj){
		var sendList = paramObj.sendList;

		var createPaymentAmount = paramObj.customerAmount
		var createPaymentDescription = paramObj.customerUserReason
		for(var i = 0 ;i <sendList.length;i++){
			var createPaymentName = sendList[i].customerNm
			var createPaymentPhone = sendList[i].customerPhone
			addList("사용자그룹",createPaymentName,createPaymentPhone,createPaymentAmount,createPaymentDescription);
		}

		$.unblockUI();
	}

</script>