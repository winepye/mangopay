<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
<!--
    $(window).load(function() {
        var strWidth;
        var strHeight;

        //innerWidth / innerHeight / outerWidth / outerHeight 지원 브라우저 
        if ( window.innerWidth && window.innerHeight && window.outerWidth && window.outerHeight ) {
            strWidth = $('#container').outerWidth() + (window.outerWidth - window.innerWidth);
            strHeight = $('#container').outerHeight() + (window.outerHeight - window.innerHeight);
        }
        else {
            var strDocumentWidth = $(document).outerWidth();
            var strDocumentHeight = $(document).outerHeight();
         
            window.resizeTo ( strDocumentWidth, strDocumentHeight );
         
            var strMenuWidth = strDocumentWidth - $(window).width();
            var strMenuHeight = strDocumentHeight - $(window).height();
         
            strWidth = $('#container').outerWidth() + strMenuWidth;
            strHeight = $('#container').outerHeight() + strMenuHeight;
        }
     
        //resize 
        window.resizeTo( strWidth, strHeight );
    }); 
/*
    //쿠키값 설정
    function setCookie(name, value, expiredays) {
        var today = new Date();
            today.setDate(today.getDate() + expiredays);
            document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';';
    }
*/
    //특정기간 다시 안보기
    function selectNoDisplay(popId, value, expiredays) {        
        setCookie(popId, value, expiredays);

        closePop();
    }

    //팝업 닫음
    function closePop(){
        self.close();
    }
//-->
</script>
<div id="container">
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
asdf<P>
<input type="checkbox" id="todayPop" name="todayPop" onClick="selectNoDisplay('userLvlModify', 'rangs', 1)"> 1일동안 그만보기
<input type="checkbox" id="weekPop" name="weekPop" onClick="selectNoDisplay('userLvlModify', 'rangs', 7)"> 7일동안 그만보기
<input type="checkbox" id="noPop" name="noPop" onClick="selectNoDisplay('userLvlModify', 'rangs', 1000)"> 앞으로 이창을 뛰우지 않음
</div>