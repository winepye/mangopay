<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Daum에디터 - 이미지 첨부</title>
<script src='<c:url value="/resources/daumeditor/js/popup.js"/>' type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href='<c:url value="/resources/daumeditor/css/popup.css"/>' type="text/css"  charset="utf-8"/>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/jquery_ui/jquery-ui.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/jquery_ui/jquery-ui.structure.css"/>'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/jquery_ui/jquery-ui.theme.css"/>'>
<script type="text/JavaScript">
var port = "${pageContext.request.serverPort}" ==""?"":":${pageContext.request.serverPort}";
//<![CDATA[
var contextRoot="${pageContext.request.scheme}://${pageContext.request.serverName}"+port+"${pageContext.request.contextPath}";
</script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/fileUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.form.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/html5.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-1.10.2.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.min.js"></script>
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.form.js"></script>

<script type="text/javascript">
/* $(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        add: function (e, data) {
        	$("#btnRegist").click(function () {
	            var valid = true;
	            var re = /^.+\.((jpg)|(jpeg)|(gif)|(png)|(bmp))$/i;
	            $.each(data.files, function (index, file) {
	                if (!re.test(file.name)) {
	                	alert("<spring:message code='fail.common.saveJustImgFile' />");  //이미지 파일만 첨부 가능합니다.
	                    valid = false;
	                    return false;
	                }
	            });
	            if (valid)
	                data.submit();
        	});
        },

        done: function (e, data) {
            $.each(data.result, function (index, file) {
        		var rs_imageurl = contextRoot + "/common/file/downloadFile.do?atchFileSeq="+file.atchFileSeq;
        		var rs_filename = file.fileOrgnNm;
        		var rs_filesize = 0;//file.volume
        		rs_filesize = 0;
        		rs_filesize = parseInt(rs_filesize);
        		//alert("jsonData.fileSize : " + jsonData.fileSize + "\n" + "rs_filesize : " + rs_filesize);

        		var _mockdata = {
        				"imageurl" : rs_imageurl,
        				"filename" : rs_filename,
        				"filesize" : rs_filesize,
        				"imagealign" : "C",
        				"originalurl" : rs_imageurl,
        				"thumburl" : rs_imageurl
        			};
        		execAttach(_mockdata);
        		closeWindow();

            });
        }
    });

}); */
function uploadImg(){
	var re = /^.+\.((jpg)|(jpeg)|(gif)|(png)|(bmp))$/i;
    if (!re.test($("#fileupload").val())) {
        alert("<spring:message code='fail.common.saveJustImgFile' />");  //이미지 파일만 첨부 가능합니다.
        return;
    }
    var option = {
        url : fileUploadUrl,
        type : 'POST',
        dataType : "json",
        success : uploadImgCallback,
        error : function(req, status, error) { // ERROR FUNCTION
            if (req.status == "901") {
                alert("<spring:message code='noti.common.noContactAuth' />");  //접근권한이 없습니다.
                // location.href = history.back();
            } else{
                //alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
                window.location.href = contextRoot+"/common/error/errError.do"
            }
        }
    };
    $("#fForm").ajaxForm(option).submit();

}
function uploadImgCallback(data) {
	//alert(data[0].atchFileSeq)
        var rs_imageurl = contextRoot + "/common/file/downloadFile.do?atchFileSeq="+data.result.atchFileSeq;
        var rs_filename = data.result.fileOrgnNm;
        var rs_filesize = 0;//file.volume
        rs_filesize = 0;
        rs_filesize = parseInt(rs_filesize);
        //alert("jsonData.fileSize : " + jsonData.fileSize + "\n" + "rs_filesize : " + rs_filesize);

        var _mockdata = {
                "imageurl" : rs_imageurl,
                "filename" : rs_filename,
                "filesize" : rs_filesize,
                "imagealign" : "C",
                "originalurl" : rs_imageurl,
                "thumburl" : rs_imageurl
            };
        execAttach(_mockdata);
        closeWindow();
}

	function done() {
		$("#fForm").attr("target","ifm_frm_submit");
		$("#fForm").submit(function(){
			$("#ifm_frm_submit").load(function(){
				var timer2 = setInterval(function(){
					var returnText = "";
					returnText = $("#ifm_frm_submit").contents().text();
					if(returnText != ""){
						clearInterval(timer2);
						editorSet(returnText);
					}
				}, 500);
			});
		}).submit();
	}


	function getRealPath(input){

        var re = /^.+\.((jpg)|(jpeg)|(gif)|(png)|(bmp))$/i;
        if (!re.test($("#fileupload").val())) {
        	alert("<spring:message code='fail.common.saveJustImgFile' />");  //이미지 파일만 첨부 가능합니다.
            return;
        }
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
    			var imgHtml = "<img src='" + e.target.result + "' border='0' width='200' height='150' />";
    			$(".preview").remove();
    			$("#ids_form").append("<dd class='preview'>" + imgHtml + "</dd>");
            }
            reader.readAsDataURL(input.files[0]);
        }
	}

	function initUploader(){
        var _opener = PopupUtil.getOpener();
        if (!_opener) {
            alert("<spring:message code='fail.common.wrongPath' />");  //잘못된 경로로 접근하셨습니다.
            return;
        }
        var _attacher = getAttacher('image', _opener);
        registerAction(_attacher);
    }
// ]]>
</script>
</head>
<body onload="initUploader();">
<div class="wrapper">
	<div class="header">
		<h1>사진 첨부</h1>
	</div>
	<div class="body">
		<form name="fForm" id="fForm" method="post" enctype="multipart/form-data">
		<input type="hidden" id = "fileTypeCd" name = "fileTypeCd" value="EDT">
		<dl class="alert" id="ids_form">
		    <dt>사진 첨부 확인</dt>
		    <dd><input id="fileupload" type="file" name="file" onchange="getRealPath(this);" /><input type="hidden" id="real_path" name="real_path" value="" /></dd>
		</dl>
		</form>
	</div>
	<div class="footer" style="position:absolute;top:279px;width:100%;">
		<p><a href="#" onclick="closeWindow();" title="닫기" class="close">닫기</a></p>
		<ul>
			<li class="submit"><a href="javascript:;" id="btnRegist" title="등록" class="btnlink" onclick="uploadImg()">등록</a> </li>
			<li class="cancel"><a href="#" onclick="closeWindow();" title="취소" class="btnlink">취소</a></li>
		</ul>
	</div>
	<div style="display:none;width:200px;height:100px;">
	<iframe name="ifm_frm_submit" id="ifm_frm_submit" src="" style="width:100%;height:100%;"></iframe>
	</div>
</div>
</body>
</html>