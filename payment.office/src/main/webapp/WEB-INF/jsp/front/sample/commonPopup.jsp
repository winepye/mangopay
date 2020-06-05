<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<script type="text/javascript">
<!--
/*
function getCookie(name){
    var name = name + '=';
    var idxStart, idxEnd, strEnd;
    var i = 0;
    while(i <= document.cookie.length) {
        idxStart = i;
        idxEnd   = (i + name.length);

        if(document.cookie.substring(idxStart, idxEnd) == name) {
            if((strEnd = document.cookie.indexOf(';', idxEnd)) == -1) strEnd = document.cookie.length;

            return document.cookie.substring(idxEnd, strEnd);
        }

        i = document.cookie.indexOf('', i) + 1;

        if(i == 0) break;
    }

    return '';
}
*/
function popOpen(name, value, popWidth, popHeight){
    if(getCookie(name) != value) {
        var winWidth    = document.body.clientWidth;   // 현재창의 너비
        var winHeight   = document.body.clientHeight;	// 현재창의 높이
        var winX        = window.screenX; //현재창의 x좌표
        var winY        = window.screenY; //현재창의 y좌표
        //var winX = window.screenX || window.screenLeft || 0;    // 현재창의 x좌표
        //var winY = window.screenY || window.screenTop  || 0;    // 현재창의 y좌표

        var popX = winX + (winWidth - popWidth)/2;
        var popY = winY + (winHeight - popHeight)/2;
        /*
        var popX = Math.ceil((window.screen.width - popWidth)/2);
        var popY = Math.ceil((window.screen.height - popHeight)/2);
        */
        window.open(contextRoot + "/sample/commonPopupChild.do",'samplePop','width='+popWidth+',height='+popHeight+',top='+popY+',left='+popX+'');
    }
    else{
        //쿠키에서 팝업안뜨도록 제어 됨
    }
}
/*
function delCookie(name){
    var expireDate = new Date();

    //어제 날짜를 쿠키 소멸 날짜로 설정한다.
    expireDate.setDate( expireDate.getDate() - 1 );
    document.cookie = name + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
}
*/
//-->
</script>


<button type="button" class="btn_list" id = "btnViewChange" onclick="popOpen('userLvlModify', 'rangs', 500, 300)">
    <em>팝업1</em>
</button>
<button type="button" class="btn_list" id = "btnViewChange" onclick="deleteCookie('userLvlModify')">
    <em>쿠키삭제</em>
</button>