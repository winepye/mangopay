<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : reqMessage_JS.jsp
  * @Description : front > My Page > reqMessage_JSjsp
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2020.05.31	psj      최초 생성
-->
<script type="text/javascript" defer="defer">

$(document).ready(function() {

    $('#frm').validate({
        rules: {
        	requestAmount: { required: true}
    		,requestMessageType: { required: true}
    		,requestPhone: { required: true,isNum: true, minlength : 10, maxlength : 11}
        },
       	messages: {
       		 requestAmount: { required: "충전금액을 선택해 주세요."}
        	,requestMessageType: { required: "충전방법을 선택해 주세요."}
        	,requestPhone: {
                required: '결제요청 모바일번호를 입력하여 주세요.'
                ,isNum : '결제요청 모바일번호는 숫자만 입력해 주세요.'
                ,minlength : "올바른 모바일번호를 입력해 주세요."
                ,maxlength : "올바른 모바일번호를 입력해 주세요."
            }
        },
        showErrors: function(errorMap, errorList) {
        },
        invalidHandler : function (form, validator) {
            var error = validator.errorList[0];
            alert(error.message);
             $(error.element).focus();
        },onsubmit: false
    });

    //확인버튼
    $("#btnReqMessage").click(function(){
        fn_reqMessage();
    });

});

//확인
function fn_reqMessage(){
    if(!$("#frm").valid()) return;

    $("#frm").attr("action",contextRoot + "/myPage/message/reqMessageAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_reqMessageCallback);
}
//확인 콜백
function fn_reqMessageCallback(data){

    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){

    	if(data.requestMessageType == "<c:out value='${Constants.REQUEST_MESSAGE_TYPE_SERVICE_PAYMENT }' />"){
    		alert("요청하신 모바일번호로 결제요청 메시지가 발송되었습니다.");
    	}else{
    		alert("요청이 완료되었습니다.");
    	}
    }else{
        alert("메세지 충전 요청에 실패하였습니다. 다시 시도하여 주십시요.");  //
    }
}

</script>