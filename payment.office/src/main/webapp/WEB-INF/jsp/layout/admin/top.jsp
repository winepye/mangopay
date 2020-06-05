<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>


<style type="text/css">
#mask {
	position: absolute;
	z-index: 9000;
	background-color: #000;
	display: none;
	left: 0;
	top: 0;
}

#progress {
	position: fixed;
	z-index: 9000;
	display: none;
	left: 50%;
	top: 50%;
	width: 300px;
	height: 200px;
	text-align: center;
	margin-top: -150px;
	margin-left: -100px;
}
</style>
<!-- ** 사용자 설정 화면 사이즈를 위한 스크립트 ** -->
<script type="text/javascript">
	$(document).ready(function() {
		$("form").on("submit", function() {
			$(this).append($("#topMenuGrpStructSeq"));
			$(this).append($("#leftMenuGrpStructSeq"));
		})
	});

	//메뉴 url 이동 펑션
	function goMenuUrl(url, topMenuGrpStructSeq, leftMenuGrpStructSeq) {
		if (topMenuGrpStructSeq != "0")
			$("#topMenuGrpStructSeq").val(topMenuGrpStructSeq);
		if (leftMenuGrpStructSeq != "0")
			$("#leftMenuGrpStructSeq").val(leftMenuGrpStructSeq);

		$("#menuMoveFrm").attr("action", url);
		$("#menuMoveFrm").submit();
	}
	//화면 사이즈 설정(세션 스토리지에 저장해두고 화면전환시에도 유지)
	function setBodySize(s) { //1000, 1280, 1600, FULL
		var b = $('body');

		//세션설정
		if (s == undefined || s == null) { //FULL
			window.sessionStorage['setBodySize'] = null;
			window.sessionStorage['bodySize'] = null;

		} else { //특정 사이즈(1000, 1280, 1600, ...)
			window.sessionStorage['setBodySize'] = s;

			if ($(window).width() < window.sessionStorage['setBodySize']) {
				window.sessionStorage['bodySize'] = null;
			} else {
				window.sessionStorage['bodySize'] = s;
			}
		}

		//사이즈 변경
		if (window.sessionStorage['bodySize'] == 'null'
				|| window.sessionStorage['bodySize'] == null
				|| window.sessionStorage['bodySize'] == undefined) {
			b.width('100%');
		} else {
			b.width(s);
		}

	}
	//화면로딩후
	var resizeId;
	$(function() {

		if (window.sessionStorage['bodySize'] != undefined
				&& window.sessionStorage['bodySize'] != null
				&& window.sessionStorage['bodySize'] != 'null') {
			setBodySize(window.sessionStorage['bodySize']);
		}

		$(window).resize(function() { //사이즈 변경 이벤트리스너 설정

			clearTimeout(resizeId);
			resizeId = setTimeout(doneResizing, 0); //100 (ms)

		});

	});

	function doneResizing() {

		var b = $('body');
		var bWidth = $('body').width();
		//console.log('000000000 bWidth:::' + bWidth + ', $(window).width():::' + $(window).width());
		if (bWidth >= $(window).width()) { //윈도우 창이 내용보다 작거나 같으면
			//console.log('111111111 bWidth:::' + bWidth + ', $(window).width():::' + $(window).width());
			window.sessionStorage['bodySize'] = null; //bodySize 를 null 로하여
			b.width('100%'); //width 100% 로 한다.

		} else { //크면
			window.sessionStorage['bodySize'] = window.sessionStorage['setBodySize']; //사용자 설정 사이즈(null일 수도 있다)로
			b.width(window.sessionStorage['bodySize']);
		}
	}

	//아이작스 화면보호기
	$(window).ajaxStart(function() {
		progressView();
		wrapWindowByMask();
	});
	$(window).ajaxStop(function() {
		spinner_main.stop();
		$("#progress").hide();
		$('#mask').stop(true, true);
		$('#mask').hide();

	});

//로그아웃
function fn_doLogout(){
    $("#topFrm").attr("action" , contextRoot + "/admin/login/processAdminLogoutAjax.do");
    commonAjaxSubmit("POST", $("#topFrm"), fn_doLogoutCallBack);
}
//로그인 콜백
function fn_doLogoutCallBack(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='noti.login.logout' />");  //로그아웃되었습니다.
        $(location).attr('href', contextRoot+"/admin/login/login.do");
    }else{
        alert("<spring:message code='fail.common.msg' />");  //에러가 발생했습니다.
    }
}

	//프론트 홈페이지
	function fn_moveFrontPage(){
		$("#topFrm").attr("action",contextRoot+"/main/main.do").attr("method","post").submit();
	}
</script>
<form id="topFrm" name="topFrm"></form>

<!-- 화면 마스크용 -->
<div id="mask"></div>
<div id="progress"></div>
<div id="skipNavigation">
	<p>
		<a href="#detail_contents">메뉴 건너뛰기</a>
	</p>
</div>
<hr />
<!--header-->
<header id="IB_Navi">

	<!--// gnb //-->
	<div id="IB_Lnb">
		<h1 class="logo">
			<a href="${pageContext.request.contextPath}/admin/main/adminMainList.do" title="메인페이지로 이동">
			<img src="${pageContext.request.contextPath}/resources/images/new/mp_logo.jpg" style="width:161px;height:60px;" alt="간편결제 logo" /></a>
		</h1>
		<!--gnb-->
		<div id="IB_Gnb">
	        <span>
					${sessionScope['scopedTarget.loginSessionInfo'].sessionUserName}(<customTagUi:code type="text" cdGrp="USER_TYPE_CD" name=""
						cd="${sessionScope['scopedTarget.loginSessionInfo'].sessionUserTypeCd}" />)
			</span>
			<button type="button" class="btn_logout" onclick="fn_doLogout()"><em class="blind">로그아웃</em></button>
            <button type="button" class="btn_homepage" onclick="fn_moveFrontPage()"><em class="blind">간편결제 홈페이지</em></button>
		</div>
		<c:set var="topMenuSeq" value="1" />
		<div class="Lnb_Wrap">
			<ul class="Lnb_MN_Zone">
				<c:forEach var="data" items="${sessionScope['scopedTarget.loginSessionInfo'].menuGrpStructVoList}" varStatus="i">
					<c:if test="${data.menuGrpStructSeq ne null and data.menuLocationCd eq reportLocation}">
						<c:choose>
							<c:when test="${data.menuDepth eq 0}">
								<li class="menuTopLi <c:if test = '${topMenuGrpStructSeq eq data.menuGrpStructSeq }'>current</c:if>
								"><a href="javascript:goMenuUrl('${pageContext.request.contextPath}${data.menuUrl}','${data.menuGrpStructSeq}','0')"
									class="mn_icon0${topMenuSeq }">${data.screenDisplayMenuNm }</a>
									<div id="menuTop_${data.menuGrpStructSeq }"></div></li>
								<c:set var="topMenuSeq" value="${topMenuSeq+1 }" />
							</c:when>
							<c:when test="${data.menuDepth eq 1}">
								<script type="text/javascript">
									var $targetDiv = $("#menuTop_${data.parentMenuGrpStructSeq}");

									if ($targetDiv.find(".Lnb_smn_list").length == 0) {
										$targetDiv
												.append("<ul class='Lnb_smn_list'></ul>");
									}
									var stStr = "<li><a href='javascript:goMenuUrl(\"${pageContext.request.contextPath}${data.menuUrl}\",\"${data.parentMenuGrpStructSeq}\",0)'>";
									stStr += "${data.screenDisplayMenuNm }</a></li>";

									$targetDiv.find(".Lnb_smn_list").append(
											stStr);
								</script>
							</c:when>
						</c:choose>
					</c:if>
				</c:forEach>

				<li class="menuTopLi"><a href="#" >&nbsp;</a></li>

				<script type="text/javascript">
			    $(".Lnb_MN_Zone .menuTopLi").eq(0).addClass("first");
			    $(".Lnb_MN_Zone .menuTopLi").eq($(".Lnb_MN_Zone .menuTopLi").length-1).addClass("last");

				// FIXME: 2018-12-31 임시로 메뉴 사이즈 변경 (.menuTopLi 클래스가 존재하지 않음)
			    console.log("====> " + $("ul.Lnb_MN_Zone > li").size());
				var liCnt = $("ul.Lnb_MN_Zone > li").size();
				var _size = 100 / liCnt;

				console.log("====> _size" + _size);
				$(".menuTopLi").width(_size+'%');
				</script>
			</ul>
		</div>
	</div>
</header>
<!--// header //-->
<!--  body resize :S -->

<!--  body resize :E -->
