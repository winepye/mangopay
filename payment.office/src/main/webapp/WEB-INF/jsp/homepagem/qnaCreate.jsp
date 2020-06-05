<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/qnaCreate_JS.jsp"%>
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<form id = "frm" name = "frm" method="post">
<section class="sub5" id="con">
	<img src="/homepagem/img/sub.jpg">
	<img src="/homepagem/img/sub05-1.jpg">
	<ul>
    	<li><a href="/m/notiList.do">공지사항</a></li>
        <li><a href="/m/createQna.do" class="select">상담의뢰</a></li>
        <li><a href="/m/questionList.do">자주묻는질문</a></li>
        <li><a href="/m/contact.do">Contact us</a></li>
    </ul>

    <p>당사에서 제공하는 VAN 서비스 및 결제 단말기, Mango Pay에 관심이 있거나 문의사항이 있으신 분은 대표전화 <b>1670-1772</b>로 전화주시거나 하단 상담 의뢰 양식 작성후 남겨주시면 연락드리겠습니다.</p>
    <table id="mail">
    	<tr>
        	<th>이름(업체명)</th>
            <td><input type="text" id="title" name="title"></td>
        </tr>
        <tr>
        	<th>연락처</th>
            <td><input type="text" id = "userMobileNum" name = "userMobileNum"></td>
        </tr>
        <tr>
        	<th>이메일주소</th>
            <td><input type="text" id = "userEmailAddr" name = "userEmailAddr"></td>
        </tr>
        <tr>
        	<th>문의내용</th>
            <td><textarea id = "content" name = "content"></textarea></td>
        </tr>
    </table>

    <p class="title">개인정보수집 및 이용에 관한 동의사항</p>
    <span>정보수집 &middot; 이용동의<br>
    MP솔루션스는 가맹점 가입 및 1:1 문의시 고객상담, 서비스 이용에 따른 민원사항 처리, 분쟁조정을 위한 기록보존을 위해 아래와 같은 정보를 수집합니다.</span>
	<table id="info">
    	<tr>
        	<th>수집목적</th>
            <th>수집항목</th>
            <th>수집근거</th>
        </tr>
        <tr>
        	<td>가맹점식별</td>
            <td>이름</td>
            <td rowspan="4">정보통신망 이용촉진 및 정보보호 등에 관한 법률 제22조</td>
        </tr>
        <tr>
        	<td>고객상담 및 민원처리</td>
            <td>전화번호</td>
        </tr>
        <tr>
        	<td>서비스 변경사항 및 고지사항 전달</td>
            <td>이메일</td>
        </tr>
        <tr>
        	<td>마케팅 및 광고</td>
            <td>IP주소, 단말기 정보, 쿠키</td>
        </tr>
    </table>
    <p>보유기간 : 요금정산, 요금과 오납 등 분쟁 대비를 위해 해지 후 6개월까지 보관(요금 미/과납이 있을 경우와 요금 관련 분쟁이 계속될 경우에는 해결 시 까지 보유)<br>
* 귀하는 MP솔루션스의 가맹점 홈페이지 서비스 이용에 필요한 최소한의 개인정보 수집 &middot; 이용에 동의하지 않을 수 있으나 동의를 거부할 경우 서비스 이용이 불가합니다.</p>
	<p>
		<input type="radio" id="agree" name="agree" value="Y"> 동의합니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="radio" id="agree" name="agree" value="N"> 동의하지 않습니다.<br>
		<input type="button"  onClick="javascript:fn_doCreateQna();" value="확인"/>
	</p>

</span>

</section>
</form>