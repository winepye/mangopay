<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="keywords" content="간편결제" />
	<meta name="description" content="간편결제" />
	<meta name="author" content="MP솔루션스 1670-1772 louis@mpsolutions.kr" />
	<meta name="copyright" content="COPYRIGHT@ MP Solutions All Rights Reserved." />


    <title>간편결제</title>
	<link href="${pageContext.request.contextPath}/resources/images/report_favicon.ico" rel="shortcut icon" type="image/x-icon">  <!-- icon -->

	<!-- ============== style css :S ============== -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jstree/style.min.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />" />                  <!-- jstree -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery_ui/jquery-ui.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />">                           <!-- jquery-ui -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"/>				<!-- design css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/monthPicker.min.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"/>               <!-- monthPicker css -->

	<style>
		::-webkit-file-upload-button { cursor:pointer; }
		.editorContent {word-wrap:break-word;white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-break:break-all;}
		.editorContent table {word-wrap:break-word;white-space:normal;word-break:break-all;}
		.editorContent tbody {word-wrap:break-word;white-space:normal;word-break:break-all;}
		.editorContent td {word-wrap:break-word;white-space:normal;word-break:break-all;}
		.editorContent tbody td {border-top:0px; border-left:0px;padding:0px;text-align: center;}
		.fileAttchViewTd {padding:0px 0px 5px 5px;border-left:0px!important;border-top:0px!important;}
	</style>
	<!-- ============== style css :E ============== -->

	<script>var contextRoot="${pageContext.request.contextPath}";</script><!-- necessary! to import js files -->
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/html5.js"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-1.10.2.js"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.min.js"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.form.js"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery-ui.js"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.blockUI.js"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.validate.js"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.maskedinput.min.js"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/monthPicker.min.js"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/jstree/jstree.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/spin.js"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/arrayUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/dateUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/domUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/eventUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/fileUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/otherUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/stringUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/xmlUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>
    <script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/util/formUtil.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}'/>"></script>
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/commonReport.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />" defer="defer"></script><!-- jquery , ajaxRequest, etc -->
	<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/ajaxRequestReport.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>

	<!-- 0516퍼블반영 -->
<script type="text/javascript">
	$(document).ready(function(){
		fn_numberFormatForNumberClass();

		$("form").on("submit",function(){
			if($(".number").length>0)
                $(".number").val($(".number").val().split(",").join(""));
	    });

	});
    //레이어 보였다 안보였다
    function showlayer($id){
        if($id.css("display") != 'none'){
           $(".tooltip_box").hide();
           return;
        }
        $(".tooltip_box").hide();
       if($id.css("display") == 'none'){$id.css("display",'block');}
       else{$id.css("display",'none')}
       }

</script>


