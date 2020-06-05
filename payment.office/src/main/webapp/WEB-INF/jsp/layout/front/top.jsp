<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<style type="text/css">
#mask {
	position: absolute;
	z-index: 9000;
	background-color: #000;
	display: none;
	left: 0;
	top: 0;
	height: 100%;
}
#progress {
	position: fixed;
	z-index: 9000;
	display: none;
	left: 50%;
	top: 50%;
    width: 300px;
    height: 200px;
    text-align:center;
    margin-top: -150px;
    margin-left: -100px;
}
</style>
<!-- 화면 마스크용 -->
<div id="mask"></div>
<div id="progress"></div>


<div id="skipNavigation">
	<p><a href="#container">메뉴 건너뛰기</a></p>
</div>
<hr />
<div class="resolution">
	<a href="#" onClick="setSize(1000);">1000</a>
   	<a href="#" onClick="setSize(1160);">1160</a>
   	<a href="#" onClick="setSize('100%');">100%</a>
   	<a href="/index_current.jsp">현재상황</a>
</div>
<script>
$(document).ready(function(){
    $("form").on("submit",function(){
        $(this).append($("#topMenuGrpStructSeq"));
        $(this).append($("#leftMenuGrpStructSeq"));
    });

    //jquery validation
    $('#mainSearchFrm').validate({
        rules: {
        	searchContentText: { required: true, maxlength:100}
        },
        messages: {
        	searchContentText: { required: "<spring:message code='required.common.input' arguments='검색어'/>", maxlength: $.validator.format("{0}<spring:message code='required.common.maxlength' />")}
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
            $(error.element).focus();
        }
    });
});

//메뉴 url 이동 펑션
function goMenuUrl(url,topMenuGrpStructSeq,leftMenuGrpStructSeq){
    if(topMenuGrpStructSeq!="0")
           $("#topMenuGrpStructSeq").val(topMenuGrpStructSeq);
    if(leftMenuGrpStructSeq!="0")
           $("#leftMenuGrpStructSeq").val(leftMenuGrpStructSeq);

    $("#menuMoveFrm").attr("action" , url);
    $("#menuMoveFrm").submit();
}

function setSize(s){	//1000, 1280, 1600, full
	$('#wrap').css('width', s);
    $('#container_wrap').css('width', s);
    $('#footerArea').css('width', s);
}

//아이작스 화면보호기
$(window).ajaxStart(function(){
	progressView();
	wrapWindowByMask();
});
$(window).ajaxStop(function(){
	spinner_main.stop();
	$("#progress").hide();
	$('#mask').stop(true,true);
	$('#mask').hide();

});

//로그아웃
function fn_doLogout(){
    $("#topFrm").attr("action" , contextRoot + "/login/processWebLogoutAjax.do");
    commonAjaxSubmit("POST", $("#topFrm"), fn_doLogoutCallBack);
}
//로그인 콜백
function fn_doLogoutCallBack(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
    	alert("<spring:message code='noti.login.logout' />");  //로그아웃되었습니다.
        $(location).attr('href', contextRoot+"/main/main.do");
    }else{
        alert("<spring:message code='fail.common.msg' />");  //에러가 발생했습니다.
    }
}

function showlayer(id)
{if(id.style.display == 'none')
    {id.style.display='block';}
    else{id.style.display = 'none';}
}
</script>
<form id="topFrm" name = "topFrm"></form>
<form id="menuMoveFrm" name = "menuMoveFrm" method="post">
    <input type="hidden" name = "topMenuGrpStructSeq" id = "topMenuGrpStructSeq" value="${topMenuGrpStructSeq }">
    <input type="hidden" name = "leftMenuGrpStructSeq" id = "leftMenuGrpStructSeq" value="${leftMenuGrpStructSeq }">
</form>
        <!--GNB-->
        <div id="gnb_wrap">
            <div class="gnb">
                <%-- <div class="famlySiteBox">
                    <dl class="famlySiteList">
                        <dt>FAMILY SITE</dt>
                        <dd><a href="http://www.naver.com/" target="_blank">네이버</a></dd>
                    </dl>
                </div> --%>
                <c:if test="${sessionScope['scopedTarget.loginSessionInfo'].isLogin == false}">
                    <div class="memberBox">
                        <ul class="memberList">
                            <li class="logbtn"><a href="${pageContext.request.contextPath}/login/login.do">로그인</a></li>

                        </ul>
                    </div>
                </c:if>
                <c:if test="${sessionScope['scopedTarget.loginSessionInfo'].isLogin == true}">
                    <div class="memberBox">
                        <ul class="memberList">
                            <li class="member_mn"><a href="#"><span>${sessionScope['scopedTarget.loginSessionInfo'].sessionUserName}</span>님</a></li>
                            <li class="logbtn"><a href="javascript:fn_doLogout()">로그아웃</a></li>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
        <!--//GNB//-->
        <!--로고+검색창+배너-->
        <%-- <div class="top_naviWrap">
            <div class="main_logoZone">
                <h1 class="logo">
	                <a href="${pageContext.request.contextPath}/main/main.do">
	                    <img src="${pageContext.request.contextPath}/resources/images/new/mp_logo.jpg" alt="간편결제"  height="50"  />
	                </a>
                </h1>
            </div>
        </div> --%>
        <!--//로고+검색창+배너//-->
        <!--로컬네비-->
        <div id="localNaviWrap">
            <ul class="lnb">
				<li>
				    <a href="${pageContext.request.contextPath}/main/main.do">HOME</a>
				    <ul class="sub_mn_list">
                        <li><a href="${pageContext.request.contextPath}/main/main.do">HOME</a></li>
                    </ul>
				</li>

                <c:forEach var = "data" items="${sessionScope['scopedTarget.loginSessionInfo'].menuGrpStructVoList}" varStatus="i">
		           <c:if test="${data.menuGrpStructSeq ne null and data.menuLocationCd eq reportLocation}">
		               <c:choose>
		                    <c:when test="${data.menuDepth eq 0}">
		                        <li <c:if test = '${topMenuGrpStructSeq eq data.menuGrpStructSeq }'>class = "current"</c:if>>
		                          <a href="javascript:goMenuUrl('${pageContext.request.contextPath}${data.menuUrl}','${data.menuGrpStructSeq}','0')">${data.screenDisplayMenuNm }</a>
		                            <div id = "menuTop_${data.menuGrpStructSeq }">

		                            </div>
		                        </li>
		                        <c:set var = "topMenuSeq" value="${topMenuSeq+1 }"/>
		                    </c:when>
		                    <c:when test="${data.menuDepth eq 1}">
		                        <script type="text/javascript">
		                        var $targetDiv = $("#menuTop_${data.parentMenuGrpStructSeq}");

		                        if($targetDiv.find(".sub_mn_list").length == 0){
		                            $targetDiv.append("<ul class='sub_mn_list'></ul>");
		                        }
		                        var stStr = "<li><a href='javascript:goMenuUrl(\"${pageContext.request.contextPath}${data.menuUrl}\",\"${data.parentMenuGrpStructSeq}\",0)'>";
		                        stStr+="${data.screenDisplayMenuNm }</a></li>";

		                        $targetDiv.find(".sub_mn_list").append(stStr);
		                        </script>
		                    </c:when>
		               </c:choose>
		           </c:if>
		       </c:forEach>

		       <!-- <li>&nbsp;</li>
		       <li>&nbsp;</li> -->

                <li class="showallBtn"><button type="button" id = "btnTopSiteMap" onclick="javascript:showlayer(lnb_all_sitemap)"><em>전체메뉴보기</em></button></li>
            </ul>
            <!--//로컬네비//-->
            <!--사이트맵-->
            <div id="lnb_all_sitemap" class="report_lnb_sitemap" style="display:none;">
                <div class="all_sitemapWrap">
                    <ul class="m_mn_list">
                        <li class="report_lnb_sitemap">
                            <a href="${pageContext.request.contextPath}/main/main.do">HOME</a>
                            <ul class="s_mn_list">
                                <li><a href="${pageContext.request.contextPath}/main/main.do">HOME</a></li>
                            </ul>
                        </li>

                        <c:forEach var = "data" items="${sessionScope['scopedTarget.loginSessionInfo'].menuGrpStructVoList}" varStatus="i">
		                   <c:if test="${data.menuGrpStructSeq ne null and data.menuLocationCd eq reportLocation}">
		                       <c:choose>
		                            <c:when test="${data.menuDepth eq 0}">
		                                <li class="report_lnb_sitemap">
		                                  <a href="javascript:goMenuUrl('${pageContext.request.contextPath}${data.menuUrl}','${data.menuGrpStructSeq}','0')">${data.screenDisplayMenuNm }</a>
		                                    <div id = "menuNavi_${data.menuGrpStructSeq }">

		                                    </div>
		                                </li>
		                                <c:set var = "topMenuSeq" value="${topMenuSeq+1 }"/>
		                            </c:when>
		                            <c:when test="${data.menuDepth eq 1}">
		                                <script type="text/javascript">
		                                var $targetDiv = $("#menuNavi_${data.parentMenuGrpStructSeq}");

		                                if($targetDiv.find(".s_mn_list").length == 0){
		                                    $targetDiv.append("<ul class='s_mn_list'></ul>");
		                                }
		                                var stStr = "<li><a href='javascript:goMenuUrl(\"${pageContext.request.contextPath}${data.menuUrl}\",\"${data.parentMenuGrpStructSeq}\",0)'>";
		                                stStr+="${data.screenDisplayMenuNm }</a></li>";

		                                $targetDiv.find(".s_mn_list").append(stStr);
		                                </script>
		                            </c:when>
		                       </c:choose>
		                   </c:if>
		               </c:forEach>
                        <!-- <li class="report_lnb_sitemap">&nbsp;</li> -->
                        <!-- <li class="last report_lnb_sitemap">&nbsp;</li> -->
                    </ul>
                </div>
            </div>
            <!--//사이트맵//-->
        </div>