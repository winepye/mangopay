/**
 * ajaxRequest.js
 *
 * ajax request 처리하는 공통 js
 *
 * (*필요 js : jquery, jquery-ui, jquery.blockUI)
 */

/**
 * 공통 ajax request
 *
 * @param pgType :
 *            "POST" "GET"
 * @param url :
 *            request url
 * @param paramObj :
 *            parameter object
 * @param callbackFn :
 *            callback function
 * @param isAsync :
 *            true(async) or false(sync)
 */
function commonAjax(pgType, url, paramObj, callbackFn, isAsync) {

	if($(".number").length>0){
		$(".number").each(function(){
			$(this).val($(this).val().split(",").join(""));
		})
	}

	// async or sync
	var async = true; // default : async(비동기)
	if (isAsync != null) {
		async = isAsync;
	}

	// 상태값 update
	$.ajax({
		type : pgType, // "POST" "GET"
		url : url, // PAGEURL
		dataType : "json",
		data : paramObj, // parameter object
		timeout : 30000, // 제한시간 지정(millisecond)
		cache : false, // true, false
		success : callbackFn, // SUCCESS FUNCTION
		async : async,
		error : function(req, status, error) { // ERROR FUNCTION
			if (req.status == "901") {
				alert("접근권한이 없습니다.");
				// location.href = history.back();
			}else if (req.status == "900") {
				alert("로그인이 필요한 서비스 입니다.");
				var $redirectInput = $("<input></input>").attr("name","searchRedirectUrl").val(window.location.pathname);
				$("#topFrm").attr("method","post");
				$("#topFrm").attr("action",contextRoot+"/login/login.do");
				$("#topFrm").submit();
			} else if (req.status == "905") {
				alert("로그인이 필요한 서비스 입니다.");
				var $redirectInput = $("<input></input>").attr("name","searchRedirectUrl").val(window.location.pathname);
				$("#topFrm").attr("method","post");
				$("#topFrm").attr("action",contextRoot+"/admin/login/login.do");
				$("#topFrm").submit();
			} else{
				//alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
				window.location.href = contextRoot+"/common/error/errError.do";
			}
		},
		complete: function(data){
			fn_numberFormatForNumberClass();
		}
	});
}

/**
 * 공통 ajax request (동기방식!!으로 호출)
 *
 * @param pgType :
 *            "POST" "GET"
 * @param url :
 *            request url
 * @param paramObj :
 *            parameter object
 * @param callbackFn :
 *            callback function
 */
function commonAjaxForSync(pgType, url, paramObj, callbackFn) {
	commonAjax(pgType, url, paramObj, callbackFn, false); // async : false 로
															// 주어 동기방식으로 처리
}
/**
 * 공통 ajax request (동기방식!!으로 호출)
 *
 * @param pgType :
 *            "POST" "GET"
 * @param url :
 *            request url
 * @param paramObj :
 *            parameter object
 * @param callbackFn :
 *            callback function
 */
function commonAjaxSubmit(pgType, $frm, callbackFn, isAsync) {
	if($(".number").length>0){
		$(".number").each(function(){
			$(this).val($(this).val().split(",").join(""));
		})
	}

	// async or sync
	var async = true; // default : async(비동기)
	if (isAsync != null) {
		async = isAsync;
	}

	var frmId = $frm.attr("id");
	if ($(".blockMsg").length > 0) {
		$(".blockMsg").find("select").each(function(i) {
			var value = $(this).val();
			$(this).find("option").each(function(i) {
				if ($(this).val() == value)
					$(this).attr("selected", "selected");
			})
		});
		if ($(".blockMsg #" + frmId).length == 0) {
			$frm.append($(".blockMsg").clone());
		}
	}
	var paramJson = $frm.serialize();
	$("#" + frmId + " .blockMsg").remove();

	if (uploadList) {
		var fileChk = uploadList.length;
		if (fileChk > 0) {
			for (var i = 0; i < fileChk; i++) {
				paramJson += "&uploadList=" + uploadList[i];
			}
		}
	}
	// 상태값 update
	$.ajax({
		type : pgType, // "POST" "GET"
		url : $frm.attr("action"), // PAGEURL
		data : paramJson, // parameter object
		timeout : 30000, // 제한시간 지정(millisecond)
		cache : false, // true, false
		success : function(data){
			if(data.substring(0,1)=="{"){
				data = $.parseJSON(data);
			}
			callbackFn(data); // SUCCESS FUNCTION
		},
		async : async,
		error : function(req, status, error) { // ERROR FUNCTION
			if (req.status == "901") {
				alert("접근권한이 없습니다.");
				// location.href = history.back();
			}else if (req.status == "900") {
				alert("로그인이 필요한 서비스 입니다.");
				var $redirectInput = $("<input></input>").attr("name","searchRedirectUrl").val(window.location.pathname);
				$("#topFrm").attr("method","post");
				$("#topFrm").attr("action",contextRoot+"/login/login.do");
				$("#topFrm").submit();
			} else if (req.status == "905") {
				alert("로그인이 필요한 서비스 입니다.");
				var $redirectInput = $("<input></input>").attr("name","searchRedirectUrl").val(window.location.pathname);
				$("#topFrm").attr("method","post");
				$("#topFrm").attr("action",contextRoot+"/admin/login/login.do");
				$("#topFrm").submit();
			} else{
				//alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
				window.location.href = contextRoot+"/common/error/errError.do";
			}
		},
		complete: function(data){
			fn_numberFormatForNumberClass();
		}
	});
}

/**
 * 공통 파일 업로드 Ajax
 *
 * @param pgType :
 *            "POST" "GET"
 * @param url :
 *            request url
 * @param $file :
 *            전송 대상이 되는 제이쿼리 파일 (간편결제 프로젝트에서는 단건 업로드만 허용한다.)
 * @param callbackFn :
 *            callback function
 * @param isAsync :
 *            true(async) or false(sync)
 */
function commonFileUploadAjax(fileTagId, fileTypeCd, callbackFn, isAsync) {
	uploadTarget = fileTagId;
	fileTypeTarget = fileTypeCd;

	if (getFileSize(fileTagId) > 1024 * 1024 * 10) {
		alert("첨부파일은 10mb를 넘을수 없습니다.");
		return;
	}

	if ($("#fileArea_"+fileTypeCd+" #file_maxVolume_" + fileTypeCd).val() != undefined
			&& $("#file_maxVolume_" + fileTypeCd).val() != "") {

		if (getFileSize(fileTagId) > 1024 * 1024 * parseInt($("#fileArea_"+fileTypeCd+" #file_maxVolume_" + fileTypeCd).val())) {
			alert("첨부파일은 "+$("#fileArea_"+fileTypeCd+" #file_maxVolume_" + fileTypeCd).val()+"mb를 넘을수 없습니다.");
			return;
		}
		$("#topFrm").append($("#fileArea_"+fileTypeCd+" #file_maxVolume_" + fileTypeCd).clone());
		$("#topFrm").find("#file_maxVolume_" + fileTypeCd).attr("name","file_maxVolume");
	}

	if ($("#fileView_" + fileTypeCd).find("li").length == $("#file_maxCount_" + fileTypeCd).val()) {
		alert("해당 파일은 최대 " + $("#file_maxCount_" + fileTypeCd).val()
				+ " 개까지 첨부 가능합니다.");
		return;
	}
	// async or sync
	var async = true; // default : async(비동기)
	if (isAsync != null) {
		async = isAsync;
	}
	$file = $("#" + fileTagId);

	$file.attr("name", "file");
	$("#topFrm").append($file);
	$("#topFrm").append("<input name = 'fileTypeCd' value = '" + fileTypeCd + "'></input>");
	if ($("#fileArea_"+fileTypeCd+" #fileAllowExtType").val() != undefined
			&& $("#fileArea_"+fileTypeCd+" #fileAllowExtType").val() != "") {
		$("#topFrm").append($("#fileArea_"+fileTypeCd+" #fileAllowExtType").clone());
	}

	if ($("#fileArea_"+fileTypeCd+" #viewMode").val() != undefined
			&& $("#fileArea_"+fileTypeCd+" #viewMode").val() != "") {
		$("#topFrm").append($("#fileArea_"+fileTypeCd+" #viewMode").clone());
	}


	$("#topFrm").attr("enctype", "multipart/form-data");
	var option = {
		url : fileUploadUrl,
		type : 'POST',
		dataType : "json",
		success : callbackFn,
		error : function(req, status, error) { // ERROR FUNCTION
			if (req.status == "901") {
				alert("접근권한이 없습니다.");
				// location.href = history.back();
			} else{
				//alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
				window.location.href = contextRoot+"/common/error/errError.do"
			}
		}
	};
	$("#topFrm").ajaxForm(option).submit();

}

/////////////////////////////////
/// 아래 이인희 추가
/////////////////////////////////
function commonAjaxParam(pgType, url, param, callbackFn) {
	var async = false; // default : async(비동기)
	$.ajax({
		type : pgType, // "POST" "GET"
		url : url, // PAGEURL
		data : param, // parameter object
		timeout : 30000, // 제한시간 지정(millisecond)
		cache : false, // true, false
		success : function(data){
			if(data.substring(0,1)=="{"){
				data = $.parseJSON(data);
			}
			callbackFn(data); // SUCCESS FUNCTION
		},
		async : async,
		error : function(req, status, error) { // ERROR FUNCTION
			//navigator.splashscreen.hide();
			//status : timeout, error
			if(status == "timeout"){
				alert('서버에 접속할 수 없습니다.\n데이터 통신이 지연되고 있거나,\n서버 점검중일 수 있습니다.\n\n잠시후 재접속을 시도 하시기 바랍니다.');
				//setTimeout("navigator.app.exitApp()",1000*5);  //3초후 종료
				window.location.href = contextRoot+"/common/error/errError.do"
			}else{

				alert('요청하신 페이지를 찾을 수 없거나, 시스템에 다른 문제가 발생했습니다.');
				window.location.href = contextRoot+"/common/error/errError.do"
			}
		},
		complete: function(data){
			//alert('complete');
		}
	});
}