<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script type="text/javascript">

    function fn_popUp(title, width, height, url){
        var windowW = width;  // 창의 가로 길이
        var windowH = height;  // 창의 세로 길이
        var left = Math.ceil((window.screen.width - windowW)/2);
        var top = Math.ceil((window.screen.height - windowH)/2);
        window.open(url,title,"scrollbars=yes,toolbar=yes,resizable=yes, top="+top+", left="+left+", height="+windowH+", width="+windowW);
    }

    // 글자수 제한
    function chkword(obj, maxByte, focusName) {

        var strValue = obj.value;
        var strLen = strValue.length;

        var totalByte = 0;
        var len = 0;
        var oneChar = "";
        var str2 = "";

        for (var i = 0; i < strLen; i++) {
            oneChar = strValue.charAt(i);
            totalByte++;

            // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
            if (totalByte <= maxByte) {
                len = i + 1;
            }
        }

        if(focusName == null){
            // 넘어가는 글자는 자른다.
            if (totalByte > maxByte) {
                alert(maxByte + "자를 초과 입력 할 수 없습니다.");
                str2 = strValue.substr(0, len);
                obj.value = str2;
                chkword(obj, 4000);
            }
        }else{
            if (totalByte >= maxByte) {
                if(focusName != ''){
                    $("#"+focusName).focus();

                    str2 = strValue.substr(0, len);
                    obj.value = str2;
                    chkword(obj, 4000);
                }
            }
        }
    }

    function fn_validationCheck(title, id){

        var returnFlag = false;
        var msg = title+"은(는) 필수 입력 항목입니다.";

        if($("#"+id).val() == ''){
            alert(msg);
            $("#"+id).focus();
            returnFlag = true;
        }
        return returnFlag;
    }

</script>