<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/notiList_JS.jsp"%>

<html>
<head>
<title>MP솔루션스</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/homepage/css/css.css?ver=1.1" type="text/css">
<script language='javascript' src='/homepage/js/mEmbed.js'></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(/homepage/img/d-bg.jpg);
	background-repeat: no-repeat;
	background-position: center;
	background-position: top;
}
-->
</style>
<script language="JavaScript">
<!--



<!--

//-->

//탭(다중) 메인제품

  function showStore(show){
				if(show == "1"){
					store1.style.display = '';
					store2.style.display = 'none';
					store3.style.display = 'none';
					store4.style.display = 'none';
					store5.style.display = 'none';
					store6.style.display = 'none';

				}else if(show == "2"){
					store1.style.display = 'none';
					store2.style.display = '';
					store3.style.display = 'none';
					store4.style.display = 'none';
					store5.style.display = 'none';
					store6.style.display = 'none';

				}else if(show == "3"){
					store1.style.display = 'none';
					store2.style.display = 'none';
					store3.style.display = '';
					store4.style.display = 'none';
					store5.style.display = 'none';
					store6.style.display = 'none';

				}else if(show == "4"){
					store1.style.display = 'none';
					store2.style.display = 'none';
					store3.style.display = 'none';
					store4.style.display = '';
					store5.style.display = 'none';
					store6.style.display = 'none';

				}else if(show == "5"){
					store1.style.display = 'none';
					store2.style.display = 'none';
					store3.style.display = 'none';
					store4.style.display = 'none';
					store5.style.display = '';
					store6.style.display = 'none';

				}else if(show == "6"){
					store1.style.display = 'none';
					store2.style.display = 'none';
					store3.style.display = 'none';
					store4.style.display = 'none';
					store5.style.display = 'none';
					store6.style.display = '';
				}
			}
////-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="MM_preloadImages('/homepage//homepage/img/top-menu01-1.gif','/homepage//homepage/img/top-menu02-1.gif','/homepage//homepage/img/top-menu03-1.gif','/homepage//homepage/img/top-menu04-1.gif','/homepage//homepage/img/top-menu05-1.gif','/homepage//homepage/img/top-menu06-1.gif','/homepage//homepage/img/top-menu07-1.gif','/homepage/img/m-jijum02-1.gif','/homepage/img/m-jijum03-1.gif','/homepage/img/m-jijum04-1.gif','/homepage/img/m-jijum05-1.gif','/homepage/img/m-jijum06-1.gif','/homepage//homepage/img/top=menu02-1.gif','/homepage//homepage/img/top=menu03-1.gif','/homepage//homepage/img/top=menu04-1.gif','/homepage//homepage/img/top=menu05-1.gif','/homepage//homepage/img/top=menu01-1.gif')">
<table width="1000" border="0" cellspacing="0" cellpadding="0" align="center" height="90%">
  <tr>
    <td valign="top">
      <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><a href="/index.do"><img src="/homepage/img/mp-logo.gif" width="156" height="112" border="0"></a></td>
          <td align="right" valign="bottom"><img src="/homepage/img/mp-01.gif" width="258" height="39">
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="40">
        <tr align="center">
          <td width="15%"><font size="3" color="#717171"><b><a href="/subpage01.do">사업영역</a></b></font></td>
          <td width="15%"><font size="3" color="#717171"><b><a href="/subpage02.do">Mango Pay</a></b></font></td>
          <td width="15%"><font size="3" color="#717171"><b><a href="/subpage03.do">VAN</a></b></font></td>
          <td width="15%"><font size="3" color="#717171"><b><a href="/subpage04.do">Device</a></b></font></td>
          <td width="15%" bgcolor="#FFCC00"><font size="3" color="#717171"><b><a href="/notiList.do"><font color="#FFFFFF">고객센터</font></a></b></font></td>
          <td width="15%"><font size="3" color="#717171"><b><a href="/main/main.do">가맹점페이지</a></b></font></td>
          <td width="15%"><font size="3" color="#717171"><b><a href="http://naver.me/xlOqz5gg">회원가입</a></b></font></td>
        </tr>
      </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="/homepage/img/sub.jpg" width="1000" height="228"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="/homepage/img/sub04-1.gif" width="1000" height="83"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="49">&nbsp;</td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr align="center">
          <td width="250" height="44" background="/homepage/img/bg-menu01-1.gif" style="padding:3 0 0 0"><b><a href="/notiList.do"><font size="3">공지사항</font></a></b></td>
          <td width="250" height="44" background="/homepage/img/bg-menu01.gif" style="padding:3 0 0 0"><b><a href="/createQna.do"><font size="3">상담의뢰</font></a></b></td>
          <td width="250" height="44" background="/homepage/img/bg-menu01.gif" style="padding:3 0 0 0"><b><a href="/questionList.do"><font size="3">자주묻는질문</font></a></b></td>
          <td width="250" height="44" background="/homepage/img/bg-menu01.gif" style="padding:3 0 0 0"><b><a href="/contact.do"><font size="3">Contact Us</font></a></b></td>
        </tr>
      </table>
<form id = "frm" name = "frm" method="post">
	<!-- 공지사항 목록 -->
     <div id = "includeArea">
		<jsp:include page="./include/notiList_INC.jsp"></jsp:include>
	</div>
	<!-- 페이징을 위한 데이터 -->
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${boardCriteria.recordCountPerPage }">
	<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${boardCriteria.currentPageNo }">
	<!-- 상세 페이지 이동을 위한 테이더-->
	<input type="hidden" id = "searchBoardSeq" name = "searchBoardSeq">

</form>

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="80">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" background="/homepage/img/bg01.jpg">
      <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="36" style="padding:0 10 0 0"><a href="/notiList.do"><font color="#FFFFFF">공지사항</font></a></td>
                <td height="36" style="padding:0 10 0 10"><a href="/createQna.do"><font color="#FFFFFF">상담의뢰</font></a></td>
                <td height="36" style="padding:0 10 0 10"><a href="/questionList.do"><font color="#FFFFFF">자주묻는질문</font></a></td>
                <td height="36" style="padding:0 10 0 10"><a href="/contact.do"><font color="#FFFFFF">Contact Us</font></a></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="204" valign="top" width="609">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr height="30">
                <td><font size="3">상호 : <strong>(주)엠피솔루션스</strong></font></td>
              </tr>
              <tr>
                <td><font size="2">주소 : (우)21985  인천광역시 연수구 송도문화로 119(글로벌캠퍼스), B1006호 오픈이노베이션<br>
                  사업자등록번호 : 246-81-01545 대표전화 : 1670-1772 사이트관리자 : 이인희, 대표자 : 조성민</font><br>
                  <a href="/personal.do" target="_blank">개인정보처리방침 | 제3자정보이용동의</a><br>
                  Copyright(C)2019 MP Solutions, All rights reserved.</td>
              </tr>
            </table>
          </td>
          <td height="204" valign="top" width="391">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="/homepage/img/copy2.jpg" width="123" height="66"></td>
              </tr>
              <tr>
                <td>
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="/homepage/img/copy3.jpg" width="136" height="36"></td>
                      <td><img src="/homepage/img/copy4.jpg" width="131" height="36"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
