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
        *요청날짜<input type="text" id = "searchDate" name = "searchDate" class="input_s_b w_date">
    </p>
      <P>
        <a href="javascript:fn_reqCorpInfo('1')">1.기업 정보 요청 실행(매일 오전 1시 배치 실행)</a>
     </P>
     <P>
        <a href="javascript:fn_reqCorpInfo('2')">2.직원정보를 동기화(매일 오전 1시 20분 배치 실행)</a>
     </P>
     <P>
        <a href="javascript:fn_reqCorpInfo('3')">3.탐방정보를 동기화(화~토 오전 2시 배치 실행)</a>
     </P>
     <P>
        <a href="javascript:fn_reqCorpInfo('4')">4.주가정보를 동기화(화~토 오전 1시 40분 배치 실행)</a>
     </P>
     <P>
        <a href="javascript:fn_reqCorpInfo('5')">5.기업좌표 동기화(매일 03시에 실행,요청날짜 없음)</a>
     </P>
   <!--  <P>
        <a href="javascript:fn_reqCorpInfo('6')">6.Ib 파일 테스트 동기화</a>
     </P> -->
    <br>
    <div id = "resultArea"></div>

    <input type="hidden" name = "apiKey" id = "apiKey">
    </form>

	<script type="text/javascript">
	$(document).ready(function(){
		datePickerWrap("#searchDate"); /* 종료일 */

	});
	function fn_reqCorpInfo(apiKey){
		if($("#searchDate").val()==""){
			alert("요청날짜를 입력해 주세요.");
			$("#searchDate").focus();
			return;
		}
		$("#apiKey").val(apiKey);
		$("#frm").attr("action" , contextRoot + "/sample/reqCorpInfo.do");
		if(confirm("<spring:message code='request.common.execute' />")){  //실행하시겠습니까?
			commonAjaxSubmit("POST", $("#frm"), fn_reqCorpInfoCallback);
		}
	}
	function fn_reqCorpInfoCallback(data){
		$("#resultArea").text(data.result);
	}
	function checkRegisteredPassportNum() {
			$.ajax({
		         type: "POST"
				,url: "/rest/memos/"
			    ,dataType: "json"
			    ,contentType: 'application/json'
			    ,data: "{\"reportSeq\":1,\"title\":\"title\",\"visitDt\":\"2016-05-01\"}"
			    ,success: function(result){
		        	// 전송 성공 여부
		        	alert(result.result);
		        }
		        ,statusCode: {
		            404: function() {
		              alert('sssss');
		            }
		          }
		    });
	}
	</script>