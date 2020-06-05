<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.abcwrap { width:950px; margin:0 auto 40px;}
.abc { width:100%; border-collapse:collapse; border-spacing:0; font-size:12px; color:#000;}
.abc thead th { background:#dadada; border:#bbb solid 1px; padding:6px 6px; font-weight:bold; }
.abc tbody th { background:#ededed; border:#cfcfcf solid 1px; text-align:left;  padding:4px 6px; }
.abc tbody td { border:#cfcfcf solid 1px; padding:4px 6px; }
.txt_center { text-align:center; }
</style>
</head>
<section class="abcwrap">
<P><P><P>
로그인 ID : ${sessionScope['scopedTarget.loginSessionInfo'].sessionUserId}<P>
로그인 사용자명  : ${sessionScope['scopedTarget.loginSessionInfo'].sessionUserName}<P>
</section>

<!-- ==========================간편결제 Admin Index Pag 작성 start=====================================  -->
<h4 style="color: white;"><a href="${pageContext.request.contextPath}/main/frontIndex.do">프론트이동</a></h4>
<h3 style="color: white;">간편결제 Admin Index Page</h3>
<table border="1" id = "indexTable" class="abc">
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

        <!-- ========================== 게시판>FAQ start ===================================== -->
        <tr>
            <td rowspan="3">게시판 </td>
            <td>FAQ리스트</td>
            <td><a href="${pageContext.request.contextPath}/admin/board/faq/faqList.do">/admin/board/faq/faqList.do</a></td>
            <td>이인희</td>
            <td>게시판>FAQ리스트 화면</td>
        </tr>
        <!-- ========================== 게시판>FAQ end ===================================== -->
        <!-- ========================== 게시판>공지사항 start ===================================== -->
        <tr>
            <td>공지사항리스트</td>
            <td><a href="${pageContext.request.contextPath}/admin/board/noti/notiList.do">/admin/board/noti/notiList.do</a></td>
            <td>이인희</td>
            <td>게시판>공지사항리스트 화면</td>
        </tr>
        <!-- ========================== 게시판>공지사항 end ===================================== -->
        <!-- ========================== 게시판>1:1문의 start ===================================== -->
        <tr>

            <td>1:1문의리스트</td>
            <td><a href="${pageContext.request.contextPath}/admin/board/qna/qnaList.do">/admin/board/qna/qnaList.do</a></td>
            <td>이인희</td>
            <td>게시판>1:1문의리스트 화면</td>
        </tr>
        <!-- ========================== 게시판>1:1문의 end ===================================== -->
        <!-- ========================== 코드관리 start ===================================== -->
        <tr>
            <td rowspan="4">시스템 </td>
            <td>코드관리</td>
            <td><a href="${pageContext.request.contextPath}/admin/baseMng/code/codeMng.do">/admin/baseMng/code/codeMng.do</a></td>
            <td>이인희</td>
            <td>코드관리</td>
        </tr>
        <!-- ========================== 코드관리 end ===================================== -->

        <!-- ========================== 메뉴관리 start ===================================== -->
        <tr>
            <td>메뉴관리(1번화면)</td>
            <td><a href="${pageContext.request.contextPath}/admin/authMng/menu/menuList.do">/admin/authMng/menu/menuList.do</a></td>
            <td>이인희</td>
            <td>메뉴관리</td>
        </tr>
        <tr>
            <td>메뉴그룹 메뉴 관리(2번화면)</td>
            <td><a href="${pageContext.request.contextPath}/admin/authMng/menu/menuGrpMenuList.do">/admin/authMng/menu/menuGrpMenuList.do</a></td>
            <td>이인희</td>
            <td>메뉴그룹 메뉴 관리</td>
        </tr>

        <tr>
            <td>메뉴그룹 구조 관리(3번화면)</td>
            <td><a href="${pageContext.request.contextPath}/admin/authMng/menu/menuGrpStructList.do">/admin/authMng/menu/menuGrpStructList.do</a></td>
            <td>이인희</td>
            <td>메뉴그룹 구조 관리</td>
        </tr>
        <!-- ========================== 메뉴관리 end ===================================== -->
        <!-- ========================== 로그인 start ===================================== -->
        <tr>
            <td>로그인 </td>
            <td>로그인</td>
            <td><a href="${pageContext.request.contextPath}/admin/login/login.do">/admin/login/login.do</a></td>
            <td>이인희</td>
            <td>Hidden에 searchRedirectUrl로 로그인 후 이동할 곳을 저장하고 있음</td>
        </tr>
        <!-- ========================== 로그인 end ===================================== -->
        <!-- ========================== 회원목록 start ===================================== -->
        <tr>
            <td>회원목록</td>
            <td>회원목록</td>
            <td><a href="${pageContext.request.contextPath}/admin/user/user/userList.do">/admin/user/userList.do</a></td>
            <td>이인희</td>
            <td>회원목록</td>
        </tr>
        <!-- ========================== 회원목록 end ===================================== -->
        <!-- ========================== 일반 리포트 start ===================================== -->
        <tr>
            <td rowspan="2">리포트</td>
            <td>일반 리포트</td>
            <td><a href="${pageContext.request.contextPath}/admin/service/payment/getPaymentList.do">/admin/service/payment/getPaymentList.do</a></td>
            <td>이인희</td>
            <td>리포트 일반</td>
        </tr>
        <!-- ========================== 일반 리포트 end ===================================== -->
        <!-- ========================== 탐방 리포트 start ===================================== -->
        <tr>
            <td>탐방 리포트</td>
            <td><a href="${pageContext.request.contextPath}/admin/report/visit/visitReportList.do">/admin/report/visit/visitReportList.do</a></td>
            <td>이인희</td>
            <td>탐방 파트너</td>
        </tr>
        <!-- ========================== 탐방 리포트  end ===================================== -->
        <!-- ========================== 일반 리포트 start ===================================== -->
        <tr>
            <td>탐방일정</td>
            <td>탐방일정목록</td>
            <td><a href="${pageContext.request.contextPath}/admin/visitReserv/visitReserv/visitReservList.do">/admin/visitReserv/visitReserv/visitReservList.do</a></td>
            <td>이인희</td>
            <td>탐방일정목록</td>
        </tr>
        <!-- ========================== 일반 리포트 end ===================================== -->

        <!-- ========================== 관리자 메인 목록 조회 start ===================================== -->
        <tr>
            <td>관리자 메인</td>
            <td>관리자 메인</td>
            <td><a href="${pageContext.request.contextPath}/admin/main/adminMainList.do">/admin/main/adminMainList.do</a></td>
            <td>이인희</td>
            <td>관리자 메인</td>
        </tr>
        <!-- ========================== 관리자 메인 목록 조회 end ===================================== -->
        <!-- ========================== 탐방요청 목록 조회 start ===================================== -->
        <tr>
            <td>탐방요청 목록</td>
            <td>탐방요청 목록</td>
            <td><a href="${pageContext.request.contextPath}/admin/corp/corpAnalReq/corpAnalReqList.do">/admin/corp/corpAnalReq/corpAnalReqList.do</a></td>
            <td>이인희</td>
            <td>탐방요청 목록</td>
        </tr>
        <!-- ========================== 기업분석요청 목록 조회 end ===================================== -->
        <!-- ========================== 성과보수 목록 start ===================================== -->
        <tr>
            <td>성과보수 목록</td>
            <td>성과보수 목록</td>
            <td><a href="${pageContext.request.contextPath}/admin/outcome/userOutcomeHist/userOutcomeHistList.do">/admin/outcome/userOutcomeHist/userOutcomeHistList.do</a></td>
            <td>이인희</td>
            <td>성과보수 목록</td>
        </tr>
        <!-- ========================== 성과보수 목록 end ===================================== -->
        <!-- ========================== 성과금 미지급 목록 start ===================================== -->
        <tr>
            <td>성과금 미지급 목록</td>
            <td>성과금 미지급 목록</td>
            <td><a href="${pageContext.request.contextPath}/admin/outcome/userOutcomeHist/noRemitUserOutcomeSummaryList.do">/admin/outcome/userOutcomeHist/noRemitUserOutcomeSummaryList.do</a></td>
            <td>이인희</td>
            <td>성과금 미지급 목록</td>
        </tr>
        <!-- ========================== 성과금 미지급 목록 end ===================================== -->
        <!-- ========================== 송금이력 목록 start ===================================== -->
        <tr>
            <td>송금이력 목록</td>
            <td>송금이력 목록</td>
            <td><a href="${pageContext.request.contextPath}/admin/outcome/userRemitHist/userRemitHistList.do">/admin/outcome/userRemitHist/userRemitHistList.do</a></td>
            <td>이인희</td>
            <td>송금이력 목록</td>
        </tr>
        <!-- ========================== 송금이력 목록 end ===================================== -->
        <!-- ========================== 기준값마스터 목록 start ===================================== -->
        <tr>
            <td>기준값마스터 목록</td>
            <td>기준값마스터 목록</td>
            <td><a href="${pageContext.request.contextPath}/admin/baseMng/baseValueMstr/baseValueMstrList.do">/admin/baseMng/baseValueMstr/baseValueMstrList.do</a></td>
            <td>이인희</td>
            <td>기준값마스터 목록</td>
        </tr>
        <!-- ========================== 기준값마스터 목록 end ===================================== -->

        <!-- ========================== 작성 end ===================================== -->
    </tbody>
</table>
<!-- ==========================간편결제 Admin Index Pag 작성 end=====================================  -->