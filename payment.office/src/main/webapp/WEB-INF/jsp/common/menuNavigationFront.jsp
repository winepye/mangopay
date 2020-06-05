<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<div id="location">
    <div class="loca_page">
        <span class="home"><em>Home</em></span><span class="divide">간편결제</span>
    </div>
</div>
<div class="loca_btn" id = "locationBtnArea" style="display: none;">
    <button type="button" class="print" onclick="fn_printPage()"><em>인쇄</em></button>
    <!--뷰어다운로드-->
 <div id="viewerpro_wrap" style="display:none;">
     <div class="relative_wrap">
         <p class="viewpro_title">뷰어프로그램 &nbsp; 다운로드</p>
         <dl class="first hwp">
             <dt><a href="http://www.hanfriends.com/" target="_blank" title="한글">한글 뷰어</a></dt>
             <dd><a href="http://www.hanfriends.com/" target="_blank" title="한글">한글과컴퓨터에서 개발하여 배포하는 한글 전용 뷰어 프로그램으로<br>문서(*.hwp파일) 을 읽을 수 있는 프로그램입니다.</a></dd>
         </dl>
         <dl class="excel">
             <dt><a href="http://www.microsoft.com/ko-kr/download/details.aspx?id=10" target="_blank" title="MS엑셀">MS엑셀 뷰어</a></dt>
             <dd><a href="http://www.microsoft.com/ko-kr/download/details.aspx?id=10" target="_blank" title="MS엑셀">Microsoft사의 워드 프로그램 한글 MS Word로 제작된<br>문서(*.doc파일)을 읽을 수 있는 프로그램입니다.</a></dd>
         </dl>
         <dl class="ppt">
             <dt><a href="http://www.microsoft.com/ko-kr/download/details.aspx?id=6" target="_blank" title="MS파워포인트">MS파워포인트 뷰어</a></dt>
             <dd><a href="http://www.microsoft.com/ko-kr/download/details.aspx?id=6" target="_blank" title="MS파워포인트">Microsoft사의 프로그램인 POWER POINT로 제작된<br>문서(*.ppt파일) 을 읽을 수 있는 프로그램입니다.</a></dd>
         </dl>
         <dl class="word">
             <dt><a href="http://www.microsoft.com/ko-kr/download/details.aspx?id=4" target="_blank" title="MS워드">MS워드 뷰어</a></dt>
             <dd><a href="http://www.microsoft.com/ko-kr/download/details.aspx?id=4" target="_blank" title="MS워드">Microsoft사의 워드 프로그램 한글 MS Word로 제작된<br>문서(*.doc파일) 을 읽을 수 있는 프로그램입니다.</a></dd>
         </dl>
         <dl class="pdf">
             <dt><a href="http://www.korea.adobe.com/products/acrobat/readstep2.html" target="_blank" title="아크로뱃 리더">아크로뱃 리더</a></dt>
             <dd><a href="http://www.korea.adobe.com/products/acrobat/readstep2.html" target="_blank" title="아크로뱃 리더">Adobe사의 Acrobat 문서인 (*.pdf파일)을 읽을 수 있게 해주는<br>필수프로그램. 인터넷(IE, Netscape) 플러그인으로도 사용가능</a></dd>
         </dl>
         <button type="button" class="btn_close" onClick="javascript:showlayer(viewerpro_wrap);"><em>창닫기</em></button>
     </div>
 </div>
 <!--//뷰어다운로드//-->
</div>
<c:forEach var="data" items="${sessionScope['scopedTarget.loginSessionInfo'].menuGrpStructVoList}" varStatus="i">
    <c:if test="${data.menuGrpStructSeq ne null and data.menuLocationCd eq reportLocation}">
            <c:choose>
                <c:when test="${topMenuGrpStructSeq eq data.menuGrpStructSeq}">
                    <div class="loca_page" id = "navigation_${data.menuGrpStructSeq }" style="display: none;">
                        <span class="home"><em>Home</em></span>
                        <span class="divide"><a href = "javascript:goMenuUrl('${pageContext.request.contextPath}${data.menuUrl}','0','${data.menuGrpStructSeq}')">${data.screenDisplayMenuNm }</a></span>
                    </div>
                </c:when>
                <c:otherwise>
                    <script type="text/javascript">
                        $("#navigation_${data.topMenuGrpStructSeq}")
                        .append("<span id = 'navigationChild_${data.menuGrpStructSeq }'  style=\"display: none;\" class=\"divide\"><a href = \"javascript:goMenuUrl('${pageContext.request.contextPath}${data.menuUrl}','0','${data.menuGrpStructSeq}')\">${data.screenDisplayMenuNm }</a></span>")
                    </script>
                </c:otherwise>
            </c:choose>
            <c:if test="${data.nodeYn eq 'Y' and data.menuUrl eq currentUrl}">
                <script type="text/javascript">
                $("#location").empty();
                $("#navigationChild_${data.parentMenuGrpStructSeq}").show();
                $("#navigationChild_${data.menuGrpStructSeq}").show();
                $("#navigationChild_${data.menuGrpStructSeq}").addClass("current");
                $("#navigation_${data.topMenuGrpStructSeq}").show();
                $("#locationBtnArea").show();
                $("#location").append($("#locationBtnArea"));
                $("#location").append($("#navigation_${data.topMenuGrpStructSeq}"));
                </script>
            </c:if>
    </c:if>
</c:forEach>