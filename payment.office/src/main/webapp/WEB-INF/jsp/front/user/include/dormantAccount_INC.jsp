<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

    <div class="joinBoxst">
        <!--라디오 버튼 선택 -->
        <dl class="joinList" id="confirmWay">
            <dt>인증방식</dt>
            <dd>
                <p class="radioList">
                    <label><input type="radio" checked="checked" name="chk" id="chkSms" value="sms" onclick="fn_doChkeckType('mobile')"/><span>휴대전화로 인증</span></label>
                    <label><input type="radio" name="chk" id="chkEmail" value="email" onclick="fn_doChkeckType('email')"/><span>이메일로 인증</span></label>
                </p>
                <p class="wrong_noti" id="wrong_noti_sms" >* 회원정보에 등록한 휴대전화번호와 동일한 번호만 인증번호를 받을 수 있습니다.</p>
                <p class="wrong_noti" id="wrong_noti_email" style="display: none;">* 본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
            </dd>
        </dl>
        <!--라디오 버튼 선택 -->

        <dl class="joinList">
            <div id = "userIdArea">
                <dt><label for="searchUserId">아이디<span class="point_red">*</span></label></dt>
                <dd><input type="text" class="join_s_b w100pro" id="searchUserId" name="searchUserId"  maxlength="20" title="아이디 입력"  value='<c:out value="${userCriteria.searchUserId}"/>' /></dd>
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

    </div>

    <!-- 고객센터 -->
    <p class="customer_noti">휴면계정 재이용신청에 문제가 있나요?<a href="${pageContext.request.contextPath}/board/faq/faqList.do">고객센터 바로가기</a></p>
    <!-- 고객센터 -->
