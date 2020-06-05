<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<script type="text/javascript">

$(document).ready(function(){
	$("#btnWindowClose").click(function(){
        //윈도우창 닫기
        window.close();
   });
	$("#btnWindowClose2").click(function(){
        //윈도우창 닫기
        window.close();
   });
	//var imgWidth = $("#img1").width() +50;
	//var imgHeight = $("#img1").height() + 90;
	//window.resizeTo(imgWidth,imgHeight);

	$("#popupOpenChk").change(function(){ // 체크박스에 변화가 있다면,
        setCookie("mainPopup_"+"${popupVo.popupSeq}", "N", 1);
        window.close();
    });
});


/* $(function(){
    //팝업 내부 사이즈 초기화
    var window_height = $(window).height() - 100;
    $("textarea[name='pop_content']").css("height",window_height);

    //팝업창 사이즈 변경에 의한 알림창 css 변경
    $(window).resize(function() {
          resizeContent();
    });
}); */

/* function resizeContent(){
     var window_height = $(window).height() - 100;
     $("textarea[name='pop_content']").height(window_height);
} */

//창 닫기 클릭시 쿠키 처리
/* function closeWin() {
    if(document.getElementById("check_today").checked){
        setCookie("cookie_1", "done", 1); // 쿠기 만료일 하루 뒤
        window.close();
    }else{
        window.close();
    }
}
 */
//쿠기설정
/* function setCookie(name, value, expiredays){
    var today = new Date();
    today.setDate( today.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";";
} */

</script>

 <div id="pop_wrap">
    <div class="pop_titleZone">
        <h1 class="title"><c:out value="${popupVo.title}"/></h1>
        <button id="btnWindowClose" type="button" class="btn_popclose"><em>닫힘</em></button>
    </div>
    <!--팝업컨텐츠-->
    <div class="pop_container">
        <p><c:out value="${popupVo.content}" escapeXml="false"/></p>
    </div>
    <div class="closeforever"  style="width:100%;position:fixed!important; ">
        <label><input type="checkbox" id="popupOpenChk" /><span>오늘은 그만보기</span></label>
        <!-- <label style="text-align: right"><button type="button" class="btn_white_B01" >닫기</button></label> -->
    </div>
</div>
