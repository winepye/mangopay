<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript">
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
</script>
<h1 class="h_logo">&nbsp;
<%-- <a href="${pageContext.request.contextPath}/main/main.do"><img src="${pageContext.request.contextPath}/resources/images/new/mp_logo.jpg" alt="간편결제" /></a> --%>
</h1>