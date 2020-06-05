<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<meta charset="utf-8">
<title>간편결제</title>
<meta property="og:url" content="https://report.synergynet.co.kr">
<meta property="og:title" content="간편결제">
<meta property="og:image" content="${pageContext.request.contextPath}/resources/images/og_report.png">
<meta property="og:description" content="간편결제 : 공정하고 객관적인 기업분석보고서 공유서비스">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="간편결제" />
<meta name="description" content="간편결제" />
<meta name="author" content="MP솔루션스 1670-1772 louis@mpsolutions.kr" />
<meta name="copyright" content="COPYRIGHT@ MP Solutions All Rights Reserved." />

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/report_favicon.ico" type="image/x-icon" />

<!-- ============== style css :S ============== -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jstree/style.min.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />" />                  <!-- jstree -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery_ui/jquery-ui.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />">                           <!-- jquery-ui -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/styleFront.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"/>				<!-- design css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/monthPicker.min.css?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"/>				<!-- monthPicker css -->

<style>
::-webkit-file-upload-button { cursor:pointer; }
#slideshow { width:100%; }
#slideshow li { width:100%; display:block; }
#slideshow li.vi01 { background:url(${pageContext.request.contextPath}/resources/images/main/img_main_visual01.jpg) no-repeat center top; height:480px; min-width:960px; }
#slideshow li.vi02 { background:url(${pageContext.request.contextPath}/resources/images/main/img_main_visual02.jpg) no-repeat center top; height:480px; min-width:960px; }
#slideshow li.vi03 { background:url(${pageContext.request.contextPath}/resources/images/main/img_main_visual03.jpg) no-repeat center top; height:480px; min-width:960px; }

.editorContent {word-wrap:break-word;white-space:pre-wrap;white-space:-moz-pre-wrap;white-space:-pre-wrap;white-space:-o-pre-wrap;word-break:break-all;}
.editorContent table {word-wrap:break-word;white-space:normal;word-break:break-all;}
.editorContent tbody {word-wrap:break-word;white-space:normal;word-break:break-all;}
.editorContent td {word-wrap:break-word;white-space:normal;word-break:break-all;}
.editorContent tbody td {border-top:0px; border-left:0px;padding:0px;text-align: center;}

.fileAttchViewTd {padding:0px 0px 5px 5px;border:0px;}
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
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/commonReport.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script><!-- jquery , ajaxRequest, etc -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/resources/js/ajaxRequestReport.js?<c:out value='${Constants.DELPOYEE_DATE_VERSION}' />"></script>

<script type="text/javascript">
	$(document).ready(function(){

		   fn_numberFormatForNumberClass();

           $("form").on("submit",function(){
        	   if($(".number").length>0)
        		    $(".number").val($(".number").val().split(",").join(""));
           });
		   $('body').click(function(e){
			   if($("#lnb_all_sitemap").css("display")=='block'){
				   if(e.target.id != 'btnTopSiteMap'&&e.target.className != 'report_lnb_sitemap')
					    $("#lnb_all_sitemap").hide();
			   }
		   });

		   var filter = "win16|win32|win64|mac|macintel";
            if ( navigator.platform  ) {
                if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
                    if($("#wrap").length>0){
                        $("#wrap").css("width","1160px");
                    }
                }
            }
		});
</script>
<div class="loadingWrap" style="display: none;z-index: 100">
	<div class="loadingBox">
	    <p class="loading_txt">로딩중입니다. 잠시만 기다려주세요.</p>
	</div>
</div>
