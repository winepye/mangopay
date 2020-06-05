<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : notiList.jsp
  * @Description : 공지사항리스트화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
     <form id = "frm" name = "frm" method="post">
    <p>
        *배치 메서드명<input type="text" id = "batchMethodNm" name = "batchMethodNm" class="input_s_b">
    </p>
   <P>
        <a href="javascript:fn_doSend()">Send</a>
     </P>
    <br>
    <div id = "resultArea"></div>

    </form>

	<script type="text/javascript">
	$(document).ready(function(){


	});


	function fn_doSend(){

	}


	function fn_doSend(){
		if($("#batchMethodNm").val()==""){
			alert("메서드명을 입력해 주세요.");
			$("#batchMethodNm").focus();
			return;
		}
		$("#frm").attr("action" , contextRoot + "/sample/procBatchMethod.do");
		if(confirm("<spring:message code='request.common.execute' />")){  //실행하시겠습니까?
			commonAjaxSubmit("POST", $("#frm"), fn_doSendCallback);
		}
	}
	function fn_doSendCallback(data){
		alert('console로그를 확인해주세요.');
	}
	</script>