<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 상단네비게이터 Copy Me :S-->
<div class="con_titleZone" id = "navigagionArea">
    <h2 class="h2_title">화면 타이틀</h2>
    <div class="location">
        <span class="divide">프로젝트</span><span class="divide">템플릿 관리</span><span class="divide current">템플릿 등록</span><span class="btn_PagePrint"><a href=""><img src="${pageContext.request.contextPath}/resources/images/common/btn/btn_page_print.gif" alt="인쇄" /></a></span>
    </div>
</div>
<!-- 상단네비게이터 Copy Me :E-->
<c:forEach var="data" items="${sessionScope['scopedTarget.loginSessionInfo'].menuGrpStructVoList}" varStatus="i">
    <c:if test="${data.menuTypeCd eq 'MENU' and data.menuLocationCd eq reportLocation}">
            <c:if test="${data.menuUrl eq pageUrl}">
            <script type="text/javascript">
                $("#navigagionArea").empty();
                $("#navigagionArea").append("<h2 class=\"h2_title\">${data.menuNm}</h2>");
                </script>
            </c:if>
            <c:choose>
                <c:when test="${topMenuGrpStructSeq eq data.menuGrpStructSeq}">
                    <div  class="location" id = "navigation_${data.menuGrpStructSeq }" style="display: none;">
                        <span class="divide">${data.screenDisplayMenuNm }</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <script type="text/javascript">
                        $("#navigation_${data.topMenuGrpStructSeq}").append("<span id = 'navigationChild_${data.menuGrpStructSeq }'  style=\"display: none;\" class=\"divide\">${data.screenDisplayMenuNm }</span>")
                    </script>
                </c:otherwise>
            </c:choose>
            <c:if test="${data.nodeYn eq 'Y' and data.menuUrl eq currentUrl}">
                <script type="text/javascript">

                $("#navigationChild_${data.parentMenuGrpStructSeq}").show();
                $("#navigationChild_${data.menuGrpStructSeq}").show();
                $("#navigation_${data.topMenuGrpStructSeq}").show();
                $("#navigation_${data.topMenuGrpStructSeq}").append("<span class=\"btn_PagePrint\"><a href='javascript:fn_printPage()'><img src=\"${pageContext.request.contextPath}/resources/images/common/btn/btn_page_print.gif\" alt=\"인쇄\" /></a></span>");
                $("#navigagionArea").append($("#navigation_${data.topMenuGrpStructSeq}"));
                </script>
            </c:if>
    </c:if>
</c:forEach>