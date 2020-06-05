<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/passwordModify_JS.jsp"%>
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
    <!--비밀번호재설정-->
    <div class="member_editWrap">
        <h3 class="h3_title_st mgt40">비밀번호 재설정</h3>
        <div class="joinBoxst">
            <dl class="joinList">
                <dt>아이디</dt>
                <dd><div class="idtxt">${sessionScope['scopedTarget.loginSessionInfo'].sessionUserId}</div></dd>
                <dt><label for="userPwd">새비밀번호</label></dt>
                <dd>
                    <p><input type="password" class="join_s_b w100pro" id="userPwd" name="userPwd" style="ime-mode: disabled;" maxlength="20" title="비밀번호" placeholder="8~20자리 영문, 숫자, 특수문자 중 2가지 이상 조합하여 사용하시기 바랍니다."></p>
                    <p class="wrong_noti" id="userPwd_check_wrong_noti" style="display: none;">비밀번호가 일치하지 않습니다.</p>
                    <p class="good_noti" id="userPwd_good_noti" style="display: none;">사용가능한 비밀번호입니다.</p>
                </dd>
                <dt><label for="userPwd_chkeck">새비밀번호 확인</label></dt>
                <dd>
                    <p><input type="password" class="join_s_b w100pro" id="userPwd_chkeck" name="userPwd_chkeck" style="ime-mode: disabled;" maxlength="20" title="비밀번호 재확인"></p>
                    <p class="wrong_noti" id="userPwd_recheck_wrong_noti" style="display: none;">비밀번호가 일치하지 않습니다.</p>
                    <p class="good_noti" id="userPwd_regood_noti" style="display: none;">비밀번호가 일치합니다.</p>
                </dd>
            </dl>
        </div>
    </div>
    <!--//비밀번호재설정//-->
    <div class="bs_BtnBox_c">
        <button type="button" class="btn_white_B01" id = "btnCancel">취소</button>
        <button type="button" class="btn_blue_B01 mgl10" id="btnModifyPassword">등록</button>
    </div>
    <p class="notice_mark mgt40"><span class="mark"><em>!</em></span><strong>비밀번호 설정에 대해 알려드립니다.</strong></p>
    <div class="idpass_noticeBox">
        <ul class="dot_list_st02">
            <li>비밀번호는 대소문자를 구별하여 8~20자리 숫자 또는 영문을 사용할 수 있습니다. (반드시 영문을 한 자 이상 포함해야 합니다.)</li>
            <li>특수문자(!,@,#$.%.^.&amp;.*.(.))를 사용하시면 더욱 안전합니다.</li>
        </ul>
    </div>
</form>
</section>