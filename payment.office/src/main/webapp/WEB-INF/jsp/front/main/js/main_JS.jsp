<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" defer="defer">
var idChk = false;
$(document).ready(function(){
	//컷박스 초기셋팅
    for(var i = 0 ; i <$("div[id*='cutBoxArea']").length-1;i++){
    	$(".visualNavi").append("<li><button type=\"button\" onclick=\"fn_moveCutBox("+(i+1)+")\"><em>0</em></button></li>");
    }
	//로그인버튼
    $("#btnLogIn").click(function(){
        fn_doLogin();
    });
    // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name='searchUserId']").val(userInputId);

    if($("input[name='searchUserId']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
    	idChk = true;
    	$('.inpChk').css({"background":"url(${pageContext.request.contextPath}/resources/images/main/ico_checked.png)", 'background-repeat' : 'no-repeat', 'background-position':'center center'});
    }

    $(".idChkbox").click(function(){ // 체크박스에 변화가 있다면,
    	if(idChk){
    		idChk = false;

    		$('.inpChk').css({"background":"url(${pageContext.request.contextPath}/resources/images/main/ico_non_checked.png)", 'background-repeat' : 'no-repeat', 'background-position':'center center'});

            //$(".inpChk").css("background", "${pageContext.request.contextPath}/resources/images/main/ico_non_checked.png"); // ID 저장하기를 체크 상태로 해제.
            deleteCookie("userInputId");
    	}else{
    		idChk = true;

    		$('.inpChk').css({"background":"url(${pageContext.request.contextPath}/resources/images/main/ico_checked.png)", 'background-repeat' : 'no-repeat', 'background-position':'center center'});
    		//$(".inpChk").css("background", "${pageContext.request.contextPath}/resources/images/main/ico_checked.png"); // ID 저장하기를 체크 상태로 두기.
    		 var userInputId = $("input[name='searchUserId']").val();
             setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
    	}

    });

    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='searchUserId']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#chk").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='searchUserId']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });

    var rate = 90/maxCnt;
    $.each(summaryInfoArray,function(key,value){
        var industCategCd = key.split("key").join("");
        $("#rp_totalCnt_"+industCategCd).text(summaryInfoArray[key][2]);
        $("#rp_visit_cnt_"+industCategCd).text(summaryInfoArray[key][0]);
        $("#rp_general_cnt_"+industCategCd).text(summaryInfoArray[key][1]);

        $("#rp_visit_"+industCategCd).css("height",(summaryInfoArray[key][0]*rate)+"px");
        $("#rp_general_"+industCategCd).css("height",(summaryInfoArray[key][1]*rate)+"px");
    });

    //팝업
    <c:forEach var="data" items="${popupVoList }">
	    if(getCookie("mainPopup_"+"${data.popupSeq }") != "N"){
	    	commonPopupOpen("${data.popupSeq }",400,400);
	    }
    </c:forEach>

    $('.bxslider').bxSlider({
        mode:'fade',  //전환효과는 페이드
        auto: true,   // 롤링은 자동
        speed: 700    // 롤링 스피드
     });

    $('#notiListUl').bxSlider({
        mode:'vertical',  //전환효과는 페이드
        auto: true,   // 롤링은 자동
        speed: 700,    // 롤링 스피드
        nextSelector:'#notiNext',
        prevSelector:'#notiPrev',
        pager: false
     });

    /* if($('#notiListUl li').length>1){
    	$('#notiListUl').animate({top: '-=50.4'}, 3000,fn_moveCutBox());
    } */
});
var cutBoxCnt = 0;
//컷박스 이동
function fn_moveCutBox(){
    alert(cutBoxCnt)
	if(parseInt($("#notiListUl").css("top"))==($('#notiListUl li').length-1)*50.4*-1){
		//cutBoxCnt--;
        $('#notiListUl').animate({top: '+=50.4'}, 3000,cutBoxCnt--);
    }else{
    	//cutBoxCnt++;
    	$('#notiListUl').animate({top: '-=50.4'}, 3000,cutBoxCnt++);
    }
}
//더보기 버튼
function fn_morePage(type){
	switch(type){
	case 'paymentList':
	    $("#frm").attr("action",contextRoot+"/service/payment/getPaymentList.do");
		break;
	case 'notiList':
        $("#frm").attr("action",contextRoot+"/board/noti/notiList.do");
        break;
	case 'qnaList':
        $("#frm").attr("action",contextRoot+"/board/qna/qnaList.do");
        break;
	case 'faqList':
        $("#frm").attr("action",contextRoot+"/board/faq/faqList.do");
        break;
	case 'createQna':
        $("#frm").attr("action",contextRoot+"/board/qna/createQna.do");
        break;
	case 'myInfoModify':
        $("#frm").attr("action",contextRoot+"/myPage/userInfo/userInfoModify.do");
        break;
	case 'myPageMain':
        $("#frm").attr("action",contextRoot+"/myPage/main/myPage.do");
        break;
	}

	$("#frm").submit();

}

//공지사항 상세화면
function fn_goNotiDetailPage(boardSeq){
	 $("#searchBoardSeq").val(boardSeq);
     $("#frm").attr("action", contextRoot + "/board/noti/notiDetail.do");
     $("#frm").submit();
}

//로그인
function fn_doLogin(){
    if($("#searchUserId").val() == ""){
    	alert("<spring:message code='required.common.input' arguments='아이디'/>");
        $("#searchUserId").focus();
        return;
    }
    if($("#searchUserPwd").val() == ""){
    	alert("<spring:message code='required.common.input' arguments='비밀번호'/>");
        $("#searchUserPwd").focus();
        return;
    }

    if(idChk){
    	var userInputId = $("#searchUserId").val();
    	setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
    }else{
         deleteCookie("userInputId");
    }

    $("#frm").attr("action" , contextRoot + "/login/processWebLoginAjax.do");
    commonAjaxSubmit("POST", $("#frm"), fn_doLoginCallBack);
}
//로그인 콜백
function fn_doLoginCallBack(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
    	//2016.09.12.이인희 팝업
    	/* $.each(data.popupVoList, function( index, value ) {
    		if(getCookie("mainPopup_"+value.popupSeq) != "N"){
    			commonPopupOpen(value.popupSeq,400,400);
            }
        }); */

    	$("#topFrm").attr("action","").attr("method","post").submit();
        //window.location.reload();

    }else{
        alert("아이디 또는 비밀번호를 다시 확인하세요.");
    }
}
//아이디/비밀번호 찾기
function fn_gofindIdPasswordForm(pStr){
    if(pStr == "id"){
        $("#searchFindType").val(pStr);
        $("#frm").attr("action",contextRoot + "/user/findIdPassword/gofindIdPasswordForm.do");
        $("#frm").submit();
    }
    else{
        $("#searchFindType").val(pStr);
        $("#frm").attr("action",contextRoot + "/user/findIdPassword/gofindIdPasswordForm.do");
        $("#frm").submit();
    }
}

//회원가입(약관동의 화면으로 이동)
function fn_memberJoinForm(){
    $("#frm").attr("action",contextRoot + "/user/join/join.do");
    $("#frm").submit();
}
//베너 클릭시 이동페이지
function fn_moveBannerPage(url){
	$("#frm").attr("method","GET");
	$("#frm").attr("action,url");
	$("#frm").submit()
}
</script>