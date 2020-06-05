<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<section id="contents">
	<!--탈퇴완료-->
	<div class="withdraw_finish">
		<p class="finish_title">
			<span>회원탈퇴</span>가 완료되었습니다!
		</p>
		<p class="finish_txt">보다나은 서비스의 간편결제으로 다시 만나뵐수 있기를 바랍니다.</p>
		<p class="finish_BtnBox">
			<button type="button" class="btn_blue_B01 mgl10" onclick="window.location.href = contextRoot+ '/'">메인으로</button>
		</p>
	</div>
	<!--//탈퇴완료//-->
</section>