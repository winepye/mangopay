<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
function minibox1(a) {
	var popupX = (window.screen.width / 2) - (200 / 2);
	// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음

	var popupY= (window.screen.height / 2) - (300 / 2);
	// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음

  window.open(a, '', 'width=684, height=960, scrollbars=no, noresized marginwidth=0, marginheight=0, menubar=0, resizable=0, left='+ popupX + ', top='+ popupY);
}
</script>
<script language="JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
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
//

</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="MM_preloadImages('/homepage/img/top-menu01-1.gif','/homepage/img/top-menu02-1.gif','/homepage/img/top-menu03-1.gif','/homepage/img/top-menu04-1.gif','/homepage/img/top-menu05-1.gif','/homepage/img/top-menu06-1.gif','/homepage/img/top-menu07-1.gif','img/m-jijum02-1.gif','img/m-jijum03-1.gif','img/m-jijum04-1.gif','img/m-jijum05-1.gif','img/m-jijum06-1.gif','/homepage/img/top=menu02-1.gif','/homepage/img/top=menu03-1.gif','/homepage/img/top=menu04-1.gif','/homepage/img/top=menu05-1.gif','/homepage/img/top=menu01-1.gif')">
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
          <td width="15%" bgcolor="#FFCC00"><font size="3" color="#717171"><b><a href="/subpage04.do"><font color="#FFFFFF">Device</font></a></b></font></td>
          <td width="15%"><font size="3" color="#717171"><b><a href="/notiList.do">고객센터</a></b></font></td>
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
        <tr>
          <td><img src="/homepage/img/sub5-1.jpg" width="1000" height="1388"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><a href="javascript:minibox1('/homepage/pro01.html')"><img src="/homepage/img/pro01.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro02.html')"><img src="/homepage/img/pro02.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro03.html')"><img src="/homepage/img/pro03.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro04.html')"><img src="/homepage/img/pro04.jpg" width="250" height="250" border="0"></a></td>
        </tr>
        <tr>
          <td><a href="javascript:minibox1('/homepage/pro05.html')"><img src="/homepage/img/pro05.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro06.html')"><img src="/homepage/img/pro06.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro07.html')"><img src="/homepage/img/pro07.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro08.html')"><img src="/homepage/img/pro08.jpg" width="250" height="250" border="0"></a></td>
        </tr>
        <tr>
          <td><a href="javascript:minibox1('/homepage/pro09.html')"><img src="/homepage/img/pro09.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro10.html')"><img src="/homepage/img/pro10.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro11.html')"><img src="/homepage/img/pro11.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro12.html')"><img src="/homepage/img/pro12.jpg" width="250" height="250" border="0"></a></td>
        </tr>
        <tr>
          <td><a href="javascript:minibox1('/homepage/pro13.html')"><img src="/homepage/img/pro13.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro14.html')"><img src="/homepage/img/pro14.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro15.html')"><img src="/homepage/img/pro15.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro16.html')"><img src="/homepage/img/pro16.jpg" width="250" height="250" border="0"></a></td>
        </tr>
        <tr>
          <td><a href="javascript:minibox1('/homepage/pro17.html')"><img src="/homepage/img/pro17.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro18.html')"><img src="/homepage/img/pro18.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro19.html')"><img src="/homepage/img/pro19.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro20.html')"><img src="/homepage/img/pro20.jpg" width="250" height="250" border="0"></a></td>
        </tr>
        <tr>
          <td><a href="javascript:minibox1('/homepage/pro21.html')"><img src="/homepage/img/pro21.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro22.html')"><img src="/homepage/img/pro22.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro23.html')"><img src="/homepage/img/pro23.jpg" width="250" height="250" border="0"></a></td>
          <td><a href="javascript:minibox1('/homepage/pro24.html')"><img src="/homepage/img/pro24.jpg" width="250" height="250" border="0"></a></td>
        </tr>
      </table>
      <br>
      <br>
      <br>
      <br>
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
