<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<div>
<div class="con_title_zone">
    <h2 class="h2_title">
        <span id = "titleArea"><em class="eng" id = "jspTitle"></em></span>
        <em class="title_ex" id = "jspDesc"></em>
        <!-- <em class="title_ex" id = "jspDesc"></em> -->
    </h2>
</div>
</div>
<c:forEach var="data" items="${sessionScope['scopedTarget.loginSessionInfo'].menuGrpStructVoList}" varStatus="i">
    <c:if test="${data.menuUrl eq pageUrl and data.menuLocationCd eq reportLocation}">
        <script type="text/javascript">
        $("#jspTitle").text("${data.menuNm}");
        if("${data.screenDesc}"!=""){
            $("#jspDesc").html("${data.screenDesc}");
        }else{
        	$("#titleArea").css("background","none");
        }
        </script>
    </c:if>
</c:forEach>