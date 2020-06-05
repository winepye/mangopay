<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<section id="contents">

    <div class="joinBoxst">
        <!--라디오 버튼 선택 -->
        <dl class="joinList" id="confirmWay">
            <dt>인증방식</dt>
            <dd>
                <p class="radioList">
                    <label><input type="radio" checked="checked" name="chk" id="chkSms" value="sms" onclick="fn_doChkeckType('mobile')"/><span>휴대전화로 인증</span></label>
                    <label><input type="radio" name="chk" id="chkEmail" value="email"onclick="fn_doChkeckType('email')"/><span>이메일로 인증</span></label>
                </p>
                <p class="wrong_noti" id="wrong_noti_sms" >* 회원정보에 등록한 휴대전화번호와 동일한 번호만 인증번호를 받을 수 있습니다.</p>
                <p class="wrong_noti" id="wrong_noti_email" style="display: none;">* 본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
            </dd>
        </dl>
        <!--라디오 버튼 선택 -->

        <dl class="joinList">
            <div id = "userNameArea">
                <dt><label for="searchUserName">이름<span class="point_red">*</span></label></dt>
                <dd><input type="text" class="join_s_b w100pro" id="searchUserName" name="searchUserName" style="ime-mode:active;" maxlength="20" title="이름 입력"/></dd>
            </div>
            <div id = "userIdArea">
                <dt><label for="searchUserId">아이디<span class="point_red">*</span></label></dt>
                <dd><input type="text" class="join_s_b w100pro" id="searchUserId" name="searchUserId" style="ime-mode:active;" maxlength="20" title="아이디 입력"/></dd>
            </div>
            <div id = "mobileArea">
                <dt><label for="telNo01">휴대번호<span class="point_red">*</span></label></dt>
                <dd>
                    <div class="addcombox">
                         <select id="telNo01" name="telNo01" class="join_sel_b w_mobile">
                            <option>010</option>
                            <option>011</option>
                            <option>016</option>
                            <option>017</option>
                            <option>018</option>
                            <option>019</option>
                          </select>
                         <input type="text" class="join_s_b w_mobile2" id="telNo02" name="telNo02" style="ime-mode:disabled;" maxlength="9" title="휴대전화 뒤에 8자리입력" />
                         <button type="button" class="btn_join_gray" name="btnConfirmTelNo" id = "btnConfirmTelNo">인증번호 전송</button>
                     </div>
                     <p class="good_noti" id="good_noti_sms_send" style="display: none;">인증번호가 전송되었습니다.</p>
                </dd>
            </div>
            <div id = "emailArea" style="display: none;">
                <dt><label for="searchEmail">이메일<span class="point_red">*</span></label></dt>
                <dd>
                    <div class="addcombox">
                        <input type="text" id="searchEmail" name="searchEmail" class="join_s_b w_email" title="이메일입력" style="ime-mode:disabled;"/>
                        <button type="button" class="btn_join_gray" name="btnConfirmTelNo">인증번호 전송</button>
                    </div>
                    <p class="wrong_noti" id="wrong_noti_email_error" style="display: none;">잘못된 이메일형식입니다. 다시입력해주세요.</p>
                    <p class="good_noti" id="good_noti_email_send" style="display: none;">인증번호가 전송되었습니다.</p>
                </dd>
            </div>
            <dt><label for="certificationNumber">인증번호입력<span class="point_red">*</span></label></dt>
            <dd>
                <p><input type="text" class="join_s_b w_checknum" id="certificationNumber" name="certificationNumber" style="ime-mode:disabled;" disabled="disabled" maxlength="10"/>
                    <button type="button" class="btn_join_gray" id = "btnConfirmNoChk">확인</button>
                    <span class="limite_time" id="limitTime" style="display: none;">남은시간 (<span id = "remainMin">1</span>:<span id = "remainSec">30</span>)</span>
                </p>
                <p class="wrong_noti" id="wrong_noti_sms_confirm" style="display: none;">인증번호를 확인하고 다시 입력해 주세요.</p>
                <p class="good_noti" id="good_noti_sms_confirm" style="display: none;">인증번호가 확인 되었습니다.</p>
            </dd>
        </dl>
        <dl class="joinList passwordResult">
            <dt>
                <label for="userPwd">비밀번호<span class="point_red">*</span></label>
            </dt>
            <dd>
                <p>
                    <input type="password" class="join_s_b w100pro" id="userPwd" name="userPwd" style="ime-mode: disabled;" maxlength="20" title="비밀번호" placeholder="8~20자리 영문, 숫자, 특수문자 중 2가지 이상 조합하여 사용하세요.">
                </p>
                <p class="wrong_noti" id="userPwd_check_wrong_noti" style="display: none;">비밀번호가 일치하지 않습니다.</p>
                <p class="good_noti" id="userPwd_good_noti" style="display: none;">사용가능한 비밀번호입니다.</p>
            </dd>
            <dt>
                <label for="userPwd_chkeck">비밀번호 재확인<span class="point_red">*</span></label>
            </dt>
            <dd>
                <p>
                    <input type="password" class="join_s_b w100pro" id="userPwd_chkeck" name="userPwd_chkeck" style="ime-mode: disabled;" maxlength="20" title="비밀번호 재확인" >
                </p>
                <p class="wrong_noti" id="userPwd_recheck_wrong_noti" style="display: none;">비밀번호가 일치하지 않습니다.</p>
                <p class="good_noti" id="userPwd_regood_noti" style="display: none;">비밀번호가 일치합니다.</p>
            </dd>
        </dl>
        <!-- 버튼 -->
        <div class="btnBox_idpass passwordResult">
            <button type="button" class="btn_blue_B01 mgl8" id = "btnFindPassword">비밀번호 변경</button>
        </div>
        <!--//버튼//-->
        <!--검색결과-->
        <div class="id_resultBox idResult" style="display: none" id="idResultBox">
            <p>고객님의 정보와 일치 하는 아이디입니다.</p>
            <p class="id_txt" id="idTxt"></p>
        </div>

        <!-- 버튼 -->
        <div class="btnBox_idpass idResult" style="display: none;" id="btnBoxIdpass">
            <button type="button" class="btn_white_B01" id="btnFindFassword" name="btnFindFassword" id="btnFindFassword" onclick="javascript:fn_moveTab('password');">비밀번호 찾기</button>
            <button type="button" class="btn_blue_B01 mgl8" id="btnLogin" name="btnLogin" id="btnLogin" onclick="javascript:fn_goLoginPage();">로그인</button>
        </div>
        <!--//버튼//-->

    </div>

    <!-- 고객센터 -->
    <p class="customer_noti">아이디 찾기에 문제가 있나요?<a href="${pageContext.request.contextPath}/board/faq/faqList.do">고객센터 바로가기</a></p>
    <!-- 고객센터 -->

</section>