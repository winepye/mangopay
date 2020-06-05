<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>

<script type="text/javascript">
    $(document).ready(function(){

        /* ====================================Button Event Setting :S */
        //수정버튼
        $("#btnCreate").click(function(){
            fn_doCreate();
        });

        //리스트버튼
        $("#btnGoListPage").click(function(){
            fn_goListPage();
        });
        /* ====================================Button Event Setting :E */

        // 숫자만 입력가능하도록 처리
        $("input:text[numberOnly]").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });

    });

    //저장
    function fn_doCreate(){

        var addMsg = "은(는) 필수 입력 항목입니다.";

        /* :::::::::::::::::: validation START ::::::::::::::::::::::::: */

        var mobileType = $(':radio[name="mobileType"]:checked').val();
        var appUpdateMethod = $(':radio[name="appUpdateMethod"]:checked').val();

        if(mobileType == ''){
            alert("모바일타입"+addMsg);
            $("#mobileType").focus();
            return false;
        }

        if($("#appName").val() == ''){
            alert("APP명"+addMsg);
            $("#appName").focus();
            return false;
        }

        if(appUpdateMethod == ''){
            alert("APP 업데이트방식"+addMsg);
            $("#appUpdateMethod").focus();
            return false;
        }

        if($("#appVersion").val() == ''){
            alert("버전"+addMsg);
            $("#appVersion").focus();
            return false;
        }

        if($("#packageName").val() == ''){
            alert("패키지명"+addMsg);
            $("#packageName").focus();
            return false;
        }

        if($("#updateLink").val() == ''){
            alert("업데이트링크"+addMsg);
            $("#updateLink").focus();
            return false;
        }
        /* :::::::::::::::::: validation END ::::::::::::::::::::::::: */


        if(confirm("<spring:message code='request.common.save'   />")) {
            $("#frm").attr("action",contextRoot + "/admin/mposapp/createMposAppAjax.do");
            commonAjaxSubmit("POST", $("#frm"), fn_doCreateCallback);
        }

    }


    //저장 콜백
    function fn_doCreateCallback(data){
        if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
            alert("정상적으로 저장되었습니다.");
            fn_goListPage();
        }else{
            alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }
    }

    //리스트 페이지로 이동
    function fn_goListPage(){
        $("#frm").attr("action",contextRoot + "/admin/mposapp/mposAppList.do");
        $("#frm").submit();
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

            /*
                한글은 2로 할 경우
            if (escape(oneChar).length > 4) {
                totalByte += 2;
            } else {
                totalByte++;
            }*/
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

</script>