<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
$(document).ready(function(){
    /* ====================================Button Event Setting :S */
    //수정페이지로 이동버튼
    $("#btnGoUserModifyPage").click(function(){
        fn_goUserModifyPage();
    });

    //목록버튼
    $("#btnGoUserListPage").click(function(){
        fn_goUserListPage();
    });


    //회원권한제한 등록/수정
    $("#btnAuthConstProc").click(function(){
        fn_processUserAuthConst();
    });

    //회원권한제한 등록/수정 팝업
    $("#btnUserAuthProc").click(function(){
        fn_openAuthProcPop();
    });

    //회원권한제한 등록/수정
    $("#btnAuthConstCancel").click(function(){
        fn_userAuthConstCancel();
    });

    //회원탈퇴 팝업 닫기
    $("#btnClose").click(function(){
    	$.unblockUI();
    });
    //권한설정 팝업 닫기
    $("#btnAuthConstClose").click(function(){
        $.unblockUI();
    });
    //권한취소 팝업 닫기
    $("#btnAuthConstCancelClose").click(function(){
        $.unblockUI();
    });
    //회원탈퇴 팝업 닫기
    $("#btnDoModifyRemitDtm").click(function(){
    	fn_userWithdrawConfirm();
    });
    //등급변경팝업 닫기
    $("#btnLvlModifyPopClose").click(function(){
    	 $.unblockUI();
    });

   //회원상태변경
   $("#btnModifyUserStatus").click(function(){
	   fn_chgUserStatus();
   });
   //Ib회원 정보 선택
   $("#btnModifyIbUserInfo").click(function(){
	  fn_selectIbUserInfo();
   });
   //Ib회원 정보 선택 닫기
   $("#btnModifyIbUserInfoClose").click(function(){
      fn_selectIbUserInfoClose();
   });

    /* ====================================Button Event Setting :E */

    $(".infoArea").hide();
    fn_moveTab('pointInfo');
    //팝업 영역 숨김
    $("#btnAuthCreatePop").hide();


    datePickerWrap("#inputStartDt","start","#inputEndDt");
    datePickerWrap("#inputEndDt","end","#inputStartDt");
    datePickerWrap("#remitDtmS");

});

function fn_goUserModifyPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/user/userModify.do");
	$("#moveFrm").submit();
}

//리스트 페이지로 이동
function fn_goUserListPage(){
	$("#moveFrm").attr("action",contextRoot + "/admin/user/userList.do");
	$("#moveFrm").submit();
}



//팝업오픈
function fn_openPop(type){
	$("#searchPopType").val(type);
	var url = '';
    switch(type){
    case 'addInfo':
    	url = contextRoot + "/admin/user/user/getUserAddInfoAjax.do";
    	break;
    case 'inDustInfo':
        url = contextRoot + "/admin/user/user/getUserInDustInfoAjax.do";
        break;
    case 'corpInfo':
        url = contextRoot + "/admin/user/user/getUserCorpInfoAjax.do";
        break;
    }
    $("#frm").attr("action" ,url);
    commonAjaxSubmit("POST", $("#frm"), fn_openPopback);
}
//팝업오픈Callback
function fn_openPopback(data){
    var popType = $("#searchPopType").val();
    $("#"+popType+"Area").empty();
    $("#"+popType+"Area").append(data);
    var title = '';
    switch(popType){
    case 'addInfo':
    	title = '주요경력';
        break;
    case 'inDustInfo':
    	title = '전공분야';
        break;
    case 'corpInfo':
    	title = '관심기업';
        break;
    }
    openModalPop(popType+"Area",title);

    $(".popClose").click(function(){
    	 $.unblockUI();
    	 $("#"+popType+"Area").hide();
    });

}

function fn_moveTab(type){
	$("#searchTabType").val(type);
    $("#tabUl li").removeClass("on");
    $("#tabLi_"+type).addClass("on");



    $(".infoArea").hide();
    $("#"+type+"Area").show();
}

//권한 취소 팝업 오픈
function fn_openAuthCancelPop(userAuthConstSeq){
    $("#userAuthConstSeq").val(userAuthConstSeq);
    var popModalDivId = "btnAuthCancelPop";
    openModalPop(popModalDivId,"권한 취소");
}


//권한 설정 팝업 오픈
function fn_openAuthProcPop(){
    //searchAreaReset("btnAuthCreatePop");
    var popModalDivId = "btnAuthCreatePop";
    openModalPop(popModalDivId,"권한 설정");
}
//회원권한제한 취소
function fn_userAuthConstCancel(){

    if($("#cnclRsn").val()==""){
        alert("<spring:message code='required.common.input' arguments='취소사유'/>");
        return;
    }

    $("#frm").attr("action",contextRoot + "/admin/user/user/modifyUserAuthConstCancelAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_userAuthConstCancelCallback);
}
//회원권한제한 취소 콜백
function fn_userAuthConstCancelCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
        fn_userAuthAreaReload();
    }else{
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}


//회원권한제한 등록/수정
function fn_processUserAuthConst(){

    if($("#inputStartDt").val()==""){
        alert("<spring:message code='required.common.input' arguments='시작일'/>");
        return;
    }
    if($("#inputEndDt").val()==""){
        alert("<spring:message code='required.common.input' arguments='종료일'/>");
        return;
    }
    if($("#regRsn").val()==""){
        alert("<spring:message code='required.common.input' arguments='등록사유'/>");
        return;
    }
    if($("#menuGrpSeqSelect").val()==""){
        alert("<spring:message code='required.common.select' arguments='메뉴그룹'/>");
        return;
    }

	$("#frm").attr("action",contextRoot + "/admin/user/user/processUserAuthConstAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_processUserAuthConstCallback);
}

//회원권한제한 등록/수정 콜백
function fn_processUserAuthConstCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
        fn_userAuthAreaReload();
    }else if(data.result == "EXIST"){
        alert("<spring:message code='noti.user.authExist' />");  //설정 기간중 이미 설정된 권한이 있습니다. 취소 후 저장해 주시기 바랍니다.
    }else{
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}


//권한/제한 영역 리로드
function fn_userAuthAreaReload(){
	$("#moveFrm").attr("action","").attr("method","post").submit();
}

function fn_openUserWithdrawConfirmPop(userOutComeAmtJudge){
	if(userOutComeAmtJudge>0){
        if(confirm("<spring:message code='noti.user.existAmtJudge' />")){
        	//해당 회원에게 심사중인 리포트가 있습니다. 먼저 심사결과를 입력해주십시요.\\n성과보수 화면으로 이동하시겠습니까?
            $("#frm").attr("action",contextRoot + "/admin/outcome/userOutcomeHist/userOutcomeHistList.do").submit();
        }
        return;
    }
	var popModalDivId = "userWithdrawPopArea";
	openModalPop(popModalDivId,"심사결과", "350px", "", "40%", "45%");
}
//탈퇴 진행중 회원 탈퇴 확정
function fn_userWithdrawConfirm(){
    if($("#remitDtm").val() == ""){
    	alert("<spring:message code='required.common.input' arguments='지급일'/>");
    	$("#remitDtm").focus();
    	return;
    }
	$("#frmPop").attr("action",contextRoot + "/admin/user/user/modifyUserWithdrawConfirmAjax.do");
    commonAjaxSubmit("POST", $("#frmPop"), fn_userWithdrawConfirmCallback);
}
//탈퇴 진행중 회원 탈퇴 확정 콜백
function fn_userWithdrawConfirmCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
        window.location.reload();
    }else{
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}

//연도별성과표 검색,페이지 이동
function fn_moveTabOutcomeSummary(type){
	fn_moveTab(type);
    fn_showUserOutcomeSummary("");
}

function fn_showUserOutcomeSummary(searchYear){
	$("#searchYear").val(searchYear);
    $("#frm").attr("action" , contextRoot + "/admin/user/user/getUserDetailOutcomeSummaryAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_showUserOutcomeSummaryCallback);
}

//연도별성과표 검색,페이지 이동 콜백
function fn_showUserOutcomeSummaryCallback(data){
    $("#outcomeSummaryArea").empty();
    $("#outcomeSummaryArea").html(data);

    getYearSelectBox("#searchYearS","current");

    if($("#searchYear").val() != "")  $("#searchYearS").val($("#searchYear").val());
}

//Ib User정보 영역
function fn_selectIbUserInfo(){
    $("#btnModifyIbUserInfo").hide();
    //$("#btnModifyIbUserInfoClose").show();
	$("#frm").attr("action" , contextRoot + "/admin/user/user/getIbUserInfoAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_selectIbUserInfoCallback);
}
//Ib User 정보 콜백
function fn_selectIbUserInfoCallback(data){
    $("#ibUserTd").html(data);
    $("#ibUserTr").show();
}

//Ib User정보 영역
function fn_selectIbUserInfoClose(){
    $("#btnModifyIbUserInfo").hide();
    //$("#btnModifyIbUserInfoClose").show();
    $("#frm").attr("action" , contextRoot + "/admin/user/user/getIbUserInfoAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_selectIbUserInfoCallback);
}
</script>