<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.co.smartdatacorp.core.bean.session.LoginSessionInfo"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.abcwrap { width:950px; margin:0 auto 40px; }
.abc { width:100%; border-collapse:collapse; border-spacing:0; font-size:12px; color:#000; }
.abc thead th { background:#dadada; border:#bbb solid 1px; padding:6px 6px; font-weight:bold; }
.abc tbody th { background:#ededed; border:#cfcfcf solid 1px; text-align:left;  padding:4px 6px; }
.abc tbody td { border:#cfcfcf solid 1px; padding:4px 6px; }
.txt_center { text-align:center; }
</style>
<body>
<section class="abcwrap">
<P><P><P>
로그인 ID : ${sessionScope['scopedTarget.loginSessionInfo'].sessionUserId}<P>
로그인 사용자명  : ${sessionScope['scopedTarget.loginSessionInfo'].sessionUserName}<P>
</section>
<section class="abcwrap">
<!-- ==========================간편결제 Front Index Pag 작성 start=====================================  -->
<h4><a href="${pageContext.request.contextPath}/admin/main/adminMainList.do">어드민이동</a></h4>
<h3>간편결제 FRONT Index Page</h3>
<table id = "indexTable" border="1" id = "indexTable" class="abc">
     <colgroup>
        <col width="200">
        <col width="300">
        <col width="150">
        <col width="150">
        <col width="*">
    </colgroup>
    <tbody>
        <tr>
            <td>업무단위</td>
            <td>화면명</td>
            <td>url</td>
            <td>작성자</td>
            <td>comment</td>
        </tr>
        <!-- ==========================작성 start=====================================  -->
        <!-- ========================== 메인페이지 ===================================== -->
        <tr>
            <td>메인페이지 </td>
            <td>메인페이지</td>
            <td><a href="${pageContext.request.contextPath}/main/main.do">/main/main.do</a></td>
            <td>이인희</td>
            <td>프론트 메인페이지</td>
        </tr>
        <!-- ========================== 예제페이지 ===================================== -->
        <tr>
            <td rowspan="7">예제페이지 </td>
            <td>예제페이지</td>
            <td><a href="${pageContext.request.contextPath}/gateway/guide.front_tlf">/gateway/guide.front_tlf</a></td>
            <td>이인희</td>
            <td>프론트 예제페이지</td>
        </tr>
        <tr>
            <td>Code Taglib </td>
            <td><a href="${pageContext.request.contextPath}/sample/codeTaglib.do">/sample/codeTaglib.do</a></td>
            <td>이인희</td>
            <td>Code Taglib</td>
        </tr>
        <tr>
            <td>우편번호1 </td>
            <td><a href="${pageContext.request.contextPath}/sample/postSample.do">/sample/postSample.do</a></td>
            <td>이인희</td>
            <td>우편번호 아이디가 zipCd, 주소는 addr일 경우 Include방식</td>
        </tr>
        <tr>
            <td>우편번호2 </td>
            <td><a href="${pageContext.request.contextPath}/sample/postSample2.do">/sample/postSample2.do</a></td>
            <td>이인희</td>
            <td>우편번호 아이디가 zipCd, 주소는 addr가 아닌경우 jsp:include방식</td>
        </tr>
        <tr>
            <td>sms발송 </td>
            <td><a href="${pageContext.request.contextPath}/sample/smsSend.do">/sample/smsSend.do</a></td>
            <td>이인희</td>
            <td>sms발송</td>
        </tr>
        <tr>
            <td>email발송 </td>
            <td><a href="${pageContext.request.contextPath}/sample/emailSend.do">/sample/emailSend.do</a></td>
            <td>이인희</td>
            <td>email발송</td>
        </tr>
        <tr>
            <td>팝업, 쿠키 </td>
            <td><a href="${pageContext.request.contextPath}/sample/commonPopup.do">/sample/commonPopup.do</a></td>
            <td>이인희</td>
            <td>팝업, 쿠키 </td>
        </tr>
        <!-- ========================== 일반 리포트  start ===================================== -->
        <tr>
            <td rowspan="2">리포트</td>
            <td>일반 리포트</td>
            <td><a href="${pageContext.request.contextPath}/report/general/generalReportList.do">/report/general/generalReportList.do</a></td>
            <td>이인희</td>
            <td>일반 리포트</td>
        </tr>
        <!-- ========================== 일반 리포트 end ===================================== -->
        <!-- ========================== 탐방 리포트 start ===================================== -->
        <tr>
            <td>탐방 리포트</td>
            <td><a href="${pageContext.request.contextPath}/report/visit/visitReportList.do">/report/visit/visitReportList.do</a></td>
            <td>이인희</td>
            <td>탐방 파트너</td>
        </tr>
        <!-- ========================== 탐방 리포트 start ===================================== -->
        <!-- ========================== 고객센터 start ===================================== -->
        <tr>
            <td rowspan="3">고객센터 </td>
            <td>자주묻는질문(FAQ)</td>
            <td><a href="${pageContext.request.contextPath}/board/faq/faqList.do">/board/faq/faqList.do</a></td>
            <td>이인희</td>
            <td>faq</td>
        </tr>
        <tr>
            <td>1:1문의 목록</td>
            <td><a href="${pageContext.request.contextPath}/board/qna/qnaList.do">/board/qna/qnaList.do</a></td>
            <td>이인희</td>
            <td>1:1문의 목록</td>
        </tr>
        <tr>
            <td>공지사항</td>
            <td><a href="${pageContext.request.contextPath}/board/noti/notiList.do">/board/noti/notiList.do</a></td>
            <td>이인희</td>
            <td>공지사항 목록</td>
        </tr>
        <!-- ========================== 고객센터 end     ===================================== -->
        <!-- ========================== 로그인 start ===================================== -->
        <tr>
            <td>로그인 </td>
            <td>로그인</td>
            <td><a href="${pageContext.request.contextPath}/login/login.do">/login/login.do</a></td>
            <td>이인희</td>
            <td>Hidden에 searchRedirectUrl로 로그인 후 이동할 곳을 저장하고 있음</td>
        </tr>
        <!-- ========================== 로그인 end ===================================== -->

        <!-- ========================== 공지사항 start ===================================== -->
        <tr>
            <td>리포트</td>
            <td>분석대상기업정보</td>
            <td><a href="${pageContext.request.contextPath}/corp/analizeInto/analizeIntoCorpList.do">/corp/analizeInto/analizeIntoCorpList.do</a></td>
            <td>이인희</td>
            <td>분석대상기업정보 목록</td>
        </tr>
        <!-- ========================== 공지사항 end     ===================================== -->

        <!-- ========================== 회원가입완료 start ===================================== -->
        <tr>
            <td>회원가입완료</td>
            <td>회원가입완료</td>
            <td><a href="${pageContext.request.contextPath}/user/join/joinSuccessForm.do">/user/join/joinSuccessForm.do</a></td>
            <td>이인희</td>
            <td>분석대상기업정보 목록</td>
        </tr>
        <!-- ========================== 회원가입완료 end     ===================================== -->

        <!-- ========================== MyPage start ===================================== -->
        <tr>
            <td rowspan="12">MyPage</td>
            <td>MyPage메인</td>
            <td><a href="${pageContext.request.contextPath}/myPage/main/myPage.do">/myPage/main/myPage.do</a></td>
            <td>이인희</td>
            <td>MyPage메인</td>
        </tr>
        <tr>
            <td>관심리포트</td>
            <td><a href="${pageContext.request.contextPath}/myPage/interestReport/interestReportList.do">/myPage/interestReport/interestReportList.do</a></td>
            <td>이인희</td>
            <td>관심리포트 목록</td>
        </tr>
        <tr>
            <td>관심기업리포트</td>
            <td><a href="${pageContext.request.contextPath}/myPage/interestCorpReport/interestCorpReportList.do">/myPage/interestCorpReport/interestCorpReportList.do</a></td>
            <td>이인희</td>
            <td>관심기업리포트 목록</td>
        </tr>
        <tr>
            <td>전공분야리포트</td>
            <td><a href="${pageContext.request.contextPath}/myPage/interestIndustReport/interestIndustReportList.do">/myPage/interestIndustReport/interestIndustReportList.do</a></td>
            <td>이인희</td>
            <td>전공분야리포트 목록</td>
        </tr>
        <tr>
            <td>전공분야관리</td>
            <td><a href="${pageContext.request.contextPath}/myPage/interestIndust/interestIndustList.do">/myPage/interestIndust/interestIndustList.do</a></td>
            <td>이인희</td>
            <td>전공분야 목록</td>
        </tr>

        <tr>
            <td>비밀번호변경</td>
            <td><a href="${pageContext.request.contextPath}/myPage/password/passwordModify.do">/myPage/password/passwordModify.do</a></td>
            <td>이인희</td>
            <td>비밀번호변경</td>
        </tr>
        <tr>
            <td>계좌정보변경</td>
            <td><a href="${pageContext.request.contextPath}/myPage/accountInfo/accountInfoModify.do">/myPage/accountInfo/accountInfoModify.do</a></td>
            <td>이인희</td>
            <td>계좌정보변경</td>
        </tr>
        <tr>
            <td>회원정보변경</td>
            <td><a href="${pageContext.request.contextPath}/myPage/userInfo/userInfoModify.do">/myPage/userInfo/userInfoModify.do</a></td>
            <td>이인희</td>
            <td>회원정보변경</td>
        </tr>
        <tr>
            <td>회원탈퇴</td>
            <td><a href="${pageContext.request.contextPath}/myPage/withdraw/userWithdraw.do">/myPage/withdraw/userWithdraw.do</a></td>
            <td>이인희</td>
            <td>회원탈퇴</td>
        </tr>
        <tr>
            <td>관심기업관리</td>
            <td><a href="${pageContext.request.contextPath}/myPage/interestCorp/interestCorpList.do">/myPage/interestCorp/interestCorpList.do</a></td>
            <td>이인희</td>
            <td>관심기업관리</td>
        </tr>

        <!-- ========================== 탐방일정 start ===================================== -->
        <tr>
            <td rowspan="2">탐방일정</td>
            <td>탐방일정</td>
            <td><a href="${pageContext.request.contextPath}/visitReserv/visitReserv/visitSchedule.do">/visitReserv/visitReserv/visitSchedule.do</a></td>
            <td>이인희</td>
            <td>탐방일정</td>
        </tr>
        <tr>
            <td>탐방일정목록</td>
            <td><a href="${pageContext.request.contextPath}/visitReserv/myVisitreserv/visitReservList.do">/visitReserv/myVisitreserv/visitReservList.do</a></td>
            <td>이인희</td>
            <td>탐방일정목록</td>
        </tr>
        <!-- ========================== 탐방일정 end     ===================================== -->
        <!-- ========================== 성과지급현황 start ===================================== -->
        <tr>
            <td rowspan="1">성과지급현황</td>
            <td>성과보수현황</td>
            <td><a href="${pageContext.request.contextPath}/myPage/userOutcomeHist/userOutcomeHistList.do">/myPage/userOutcomeHist/userOutcomeHistList.do</a></td>
            <td>이인희</td>
            <td>성과보수현황</td>
        </tr>
        <!-- ========================== 성과지급현황 end     ===================================== -->

        <!-- ========================== MyPage end     ===================================== -->

        <!-- ========================== 작성 end ===================================== -->
    </tbody>
</table>
<!-- ==========================간편결제 Front Index Pag 작성 start=====================================  -->



</section>
</body>
</html>