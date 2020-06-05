<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<script>

$(document).ready(function(){
	var imgWidth = $("#img1").width();
	var imgHeight = $("#img1").height();
	if(imgWidth > 0 && imgWidth < 480){
		window.resizeTo(imgWidth ,imgHeight+ 73);
	}
});

</script>
<div style="text-align:center;" >
    <img   id="img1"  style="max-width:480px;" src="${pageContext.request.contextPath}/common/file/downloadFile.do?atchFileSeq=${atchFileSeq }" alt="" />
</div>
