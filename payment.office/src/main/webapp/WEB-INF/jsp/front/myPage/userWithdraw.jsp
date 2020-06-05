<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/userWithdraw_JS.jsp"%>
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<form id = "frm" name = "frm" method="post">
<section id="contents">
	<!--탈퇴시유의사항-->
	<h3 class="h3_title_st mgt40">회원탈퇴시 유의사항</h3>
	<div class="withdraw_notiBox">
		<ol class="withdraw_notilist">
			<li><strong>1. 회원탈퇴 시 처리내용</strong>
				<ul class="list_st_dash">
					<li>지급대기중 성과보수 : 회원탈퇴시점으로 3~5일 이내 입금후, 개인정보가 삭제됩니다.</li>
					<li>적립 포인트 : 잔여 포인트는 소멸됩니다.</li>
					<li>회원정보 : 회원탈퇴 완료 시 당사 사이트 이용 권한이 삭제됩니다.</li>
				</ul></li>
			<li><strong>2. 회원탈퇴 시 게시물 관리</strong>
				<ul class="list_st_dash">
					<li>회원탈퇴 후 당사 사이트에 입력하신 게시물은 삭제되지 않으며, 회원정보 삭제로 인해 작성자 본인을 확인할
						수 없으므로 게시물 편집 및 삭제 처리가 원천적으로 불가능 합니다.</li>
					<li>게시물 삭제를 원하시는 경우에는 먼저 해당 게시물 삭제를 요청하신 후, 탈퇴를 신청하시기 바랍니다.</li>
				</ul></li>
			<li><strong>3. 회원탈퇴 후 재가입 규정</strong>
				<ul class="list_st_dash">
					<li>탈퇴 회원이 재가입하더라도 기존의 포인트와 실적내용등은 이미 소멸 되었으므로 재가입시에 적용되지
						않습니다.</li>
				</ul></li>
		</ol>
	</div>
	<p class="noti_p_agree">
		<label>
		  <input type="checkbox" id = "input_service"/>
		      <span>이용약관과 개인정보 수집 및 이용에 대한 안내를 모두 동의해주세요.</span>
	    </label>
	</p>
	<!--//탈퇴시유의사항//-->
	<c:if test="${sessionScope['scopedTarget.loginSessionInfo'].sessionUserTypeCd eq 'PARTNER'}">
		<!--탈퇴시처리내용-->
	     <div class="withdraw_infoBox mgt30">
	         <h4 class="info_title">[ <span>${sessionScope['scopedTarget.loginSessionInfo'].sessionUserId}</span>님의 회원탈퇴시 처리내용 ]</h4>
	         <p class="info_subtitle"><span class="mnt">지급대기 금액</span><span class="cash"><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${totalOutcomeAmt}" />원</span></p>
	         <p class="info_txt">회원탈퇴를 하시면 1주일이내로 지급처리가 될 예정이며 <br>지급완료 후에 회원님의 개인정보가 삭제됩니다.</p>
	     </div>
	     <!--//탈퇴시처리내용//-->
     </c:if>
	<!--회원정보인증-->
	<div class="member_editWrap">
		<h3 class="h3_title_st mgt40">
			기본정보입력<span class="title_noti">* 회원탈퇴를 위한 회원정보 인증 절차입니다. 회원가입
				시 등록 한 정보를 입력해 주세요.</span>
		</h3>
		<div class="joinBoxst">
			<dl class="joinList">
				<dt>
					아이디
				</dt>
				<dd>
					<p>
						${sessionScope['scopedTarget.loginSessionInfo'].sessionUserId}
					</p>
					 <p class="good_noti"></p>
				</dd>
				<dt>
					<label for="searchUserPwd">비밀번호</label>
				</dt>
				<dd>
					<p>
					   <input type="password" class="join_s_b w100pro" id="searchUserPwd" name="searchUserPwd" style="ime-mode: disabled;" maxlength="20" title="비밀번호" placeholder="8~20자리 영문, 숫자, 특수문자 중 2가지 이상 조합하여 사용하세요.">
					</p>
					<p class="wrong_noti" id="userPwd_check_wrong_format" style="display: none;">비밀번호 형식에 맞지 않습니다.</p>
					<p class="wrong_noti" id="userPwd_check_wrong_empty" style="display: none;">비밀번호를 입력해 주세요.</p>
					<p class="wrong_noti" id="userPwd_check_wrong_noti" style="display: none;">비밀번호가 일치하지 않습니다.</p>
					<p class="good_noti" id="userPwd_good_noti" style="display: none;">비밀번호가 일치합니다.</p>
				</dd>
				<dt>
					<label for="searchUserName">이름</label>
				</dt>
				<dd>
					<input type="text" class="join_s_b w100pro" id="searchUserName" name="searchUserName" style="ime-mode:active;" maxlength="20" title="이름 입력"/>
				</dd>
				<dt>
					<label for="telNo02">휴대번호</label>
				</dt>
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
				<dt>
					<label for="IDNAME07">인증번호입력</label>
				</dt>
				<dd>
					<p>
						<input type="text" class="join_s_b w_checknum" id="certificationNumber" name="certificationNumber" style="ime-mode:disabled;" disabled="disabled" maxlength="10"/>
	                    <button type="button" class="btn_join_gray" id = "btnConfirmNoChk">확인</button>
	                    <span class="limite_time" id="limitTime" style="display: none;">남은시간 (<span id = "remainMin">1</span>:<span id = "remainSec">30</span>)</span>
                    </p>
	                <p class="wrong_noti" id="wrong_noti_sms_confirm" style="display: none;">인증번호를 확인하고 다시 입력해 주세요.</p>
	                <p class="good_noti" id="good_noti_sms_confirm" style="display: none;">인증번호가 확인 되었습니다.</p>
				</dd>
			</dl>
		</div>
	</div>
	<!--//회원정보인증//-->
	<div class="bs_BtnBox_c">
		<button type="button" class="btn_white_B01" id = "btnCancel" >취소</button>
		<button type="button" class="btn_blue_B01 mgl10" id = "btnWithraw">탈퇴하기</button>
	</div>
	<!-- 검색이나 화면이동을 위한 데이터 -->
	<input type="hidden" id = "searchTelNo" name = "searchTelNo">
</section>
</form>