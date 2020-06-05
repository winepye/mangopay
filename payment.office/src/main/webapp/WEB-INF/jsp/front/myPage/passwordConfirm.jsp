<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/passwordConfirm_JS.jsp"%>
<!--
  * @Class Name  : myReportList.jsp
  * @Description : front > 나의 리포트 조회
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.09	이인희      최초 생성
-->
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<section id="contents">
<form id = "frm" name = "frm" method="post">
    <!--비밀번호확인-->
    <h3 class="h3_title_st mgt40">비밀번호 재확인</h3>
    <div class="top_agree_box">
        <p>개인정보 보호를 위해 회원님의 비밀번호를 한번 더 입력해 주세요.</p>
    </div>
    <div class="my_joinBoxst">
        <dl class="joinList">
            <dt>아이디</dt>
            <dd><div class="idtxt">${sessionScope['scopedTarget.loginSessionInfo'].sessionUserId}</div></dd>
            <dt><label for="searchUserPwd">비밀번호</label></dt>
            <dd>
                <p>
                    <input type="password" class="join_s_b w100pro" id="searchUserPwd" name="searchUserPwd" onkeypress="if(event.keyCode==13) {fn_confirmPassword(); return false;}"
                        placeholder="8~20자리 영문, 숫자, 특수문자 중 2가지 이상 조합하여 사용하시기 바랍니다.">
                </p>
                <!-- <p class="wrong_noti" id="searchUserPwd_check_wrong_noti">비밀번호를 다시 입력해 주세요</p> -->
            </dd>
        </dl>
    </div>
    <div class="idpass_BtnBox_c"><button type="button" class="btn_join_gray" id="btnPasswordConfirm">확인</button></div>
    <p class="notice_mark mgt40"><span class="mark"><em>!</em></span><strong>회원정보관리에 대해 알려드립니다.</strong></p>
    <div class="idpass_noticeBox">
        <ul class="dot_list_st02">
            <li>간편결제은  회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는 기재하신 회원정보가 공개되지 않습니다.</li>
            <li>개인정보가 변경된 경우, 보다 정확한 서비스를 위해 개인정보를  항상 업데이트 해 주시기 바랍니다.</li>
        </ul>
    </div>
    <!--//비밀번호확인//-->
</form>
</section>