<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<!--
  * @Class Name  : mainList_JS.jsp
  * @Description : admin > mainList_JS
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2016.05.26	이인희      최초 생성
-->
<script type="text/javascript" defer="defer">
$(document).ready(function(){

    //탐방 리포트 더보기 버튼
    $("#btnVisitReport").click(function(){
        fn_goPage('visitReport');
    });
    //탐방 리포트 더보기 버튼
    $("#btnGeneralReport").click(function(){
        fn_goPage('generalReport');
    });
    //가입회원 더보기 버튼
    $("#btnUser").click(function(){
        fn_goPage('user');
    });
    //성과지급 보수 더보기 버튼
    $("#btnUserOutcomeHist").click(function(){
        fn_goPage('userOutcomeHist');
    });
    //탐방예약 더보기 버튼
    $("#btnVisitReserv").click(function(){
        fn_goPage('visitReserv');
    });
    //탐방요청 더보기 버튼
    $("#btnCorpAnalReq").click(function(){
        fn_goPage('corpAnalReq');
    });
    //탐방일정 더보기 버튼
    $("#btnVisitSchdDtReserv").click(function(){
        fn_goPage('visitSchdDtReserv');
    });
    //POOL등록요청 더보기 버튼
    $("#btnPoolRegReq").click(function(){
        fn_goPage('poolRegReq');
    });
    //1:1문의  더보기 버튼
    $("#btnQnaBoard").click(function(){
        fn_goPage('qnaBoard');
    });
});

//더보기 화면 이동
function fn_goPage(pStr){

    var url = "";
    switch(pStr){
    case 'visitReport' :
    	url = "/admin/report/visit/visitReportList.do"; /*탐방 리포트*/
    	break;
    case 'generalReport' :
        url = "/admin/service/payment/getPaymentList.do"; /*탐방 리포트*/
        break;
    case 'visitReservAll' :
        $("#searchVisitType").val("");
        url = "/admin/visitReserv/visitReserv/visitReservList.do"; /*탐방 일정페이지 (더보기)*/
        break;
    case 'visitReserv' :
    	$("#searchVisitType").val("noReservSchd");
        url = "/admin/visitReserv/visitReserv/visitReservList.do"; /*탐방 일정페이지 (예약)*/
        break;
    case 'noReserv' :
        $("#searchVisitType").val("noReserv");
        url = "/admin/visitReserv/visitReserv/visitReservList.do"; /*탐방 일정페이지 (탐방예정)*/
        break;
    case 'cancelReserv' :
        $("#searchVisitType").val("cancelVisit");
        url = "/admin/visitReserv/visitReserv/visitReservList.do"; /*탐방 일정페이지 (탐방취소)*/
        break;
    case 'REQALL' :
        $("#searchAprvCd").val("");
        url = "/admin/corp/corpAnalReq/corpAnalReqList.do"; /*탐방 요청페이지 (ALL)*/
        break;
    case 'REQ' :
        $("#searchAprvCd").val("REQ");
        url = "/admin/corp/corpAnalReq/corpAnalReqList.do"; /*탐방 요청페이지 (요청대기)*/
        break;
    case 'APRV' :
        $("#searchAprvCd").val("APRV");
        url = "/admin/corp/corpAnalReq/corpAnalReqList.do"; /*탐방 요청페이지 (요청수락)*/
        break;
    case 'REJT' :
        $("#searchAprvCd").val("REJT");
        url = "/admin/corp/corpAnalReq/corpAnalReqList.do"; /*탐방 요청페이지 (요청거절)*/
        break;
    case 'USERDETAIL' :
    	$("#searchToDtS").val("");
    	$("#searchFromDtS").val("");
    	$("#searchUserStatusCd").val("");
        url = "/admin/user/user/userList.do"; /*회원 디테일 페이지*/
        break;
    case 'USERJOIN' :
    	var now = new Date();
    	$("#searchToDtS").val(now.yyyy_mm_dd());
    	now.setDate(now.getDate()-1);
    	$("#searchFromDtS").val(now.yyyy_mm_dd());
    	$("#searchUserStatusCd").val("");
        url = "/admin/user/user/userList.do"; /*회원 디테일(전날 가입) 페이지*/
        break;
    case 'USERJOINTODAY' :
        var now = new Date();
        $("#searchToDtS").val(now.yyyy_mm_dd());
        $("#searchFromDtS").val(now.yyyy_mm_dd());
        $("#searchUserStatusCd").val("");
        url = "/admin/user/user/userList.do"; /*회원 디테일(오늘 가입) 페이지*/
        break;
    case 'USERWITHDRW' :
    	$("#searchToDtS").val("");
        $("#searchFromDtS").val("");
        $("#searchUserStatusCd").val("WITHDRW");
        url = "/admin/user/user/userList.do"; /*회원 디테일 (탈퇴)페이지*/
        break;
    case 'USEROUTCOMEDETAIL' :
        url = "/admin/outcome/userOutcomeHist/userOutcomeHistList.do"; /*성과보수 목록 페이지*/
        break;
    case 'USEROUTCOMEJUDGEDETAIL' :
    	$("#searchRemitStatusCd").val("JUDGE")
        url = "/admin/outcome/userOutcomeHist/userOutcomeHistList.do"; /*성과보수 목록 페이지*/
        break;
    case 'QNANOANSWER' :
    	$("#searchQnaStatusCd").val("READ");
        url = "/admin/board/qna/qnaList.do"; /*1:1문의 목록 (미답변)*/
        break;
    case 'NOREMITUSEROUTCOME' :
        url = "/admin/outcome/userOutcomeHist/noRemitUserOutcomeSummaryList.do"; /*미지급 성과보수*/
        break;
    }

    $("#frm").attr("action",contextRoot + url);
    $("#frm").submit();
}
//성과보수 상세페이지 이동
function fn_moveUserOutcomeHistList(date){
	var dateArr =date.split("/");
	var year = dateArr[0];
	var month = dateArr[1];

	var lastDay = ( new Date( year, month, 0) ).getDate();

	$("#searchFromDtmS").val(year+"/"+month+"/"+"01");
	$("#searchToDtmS").val(year+"/"+month+"/"+lastDay);


	$("#frm").attr("action",contextRoot+"/admin/outcome/userOutcomeHist/userOutcomeHistList.do");
	$("#frm").submit();
}
</script>