<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.co.smartdatacorp.core.bean.session.LoginSessionInfo"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<title>망고페이</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta property="og:image" content="http://www.mangopay.co.kr/resources/images/logo/mangopay_logo2.png">
<meta property="og:image:secure_url" content="https://www.mangopay.co.kr/resources/images/logo/mangopay_logo2.png" />

<style>
.abcwrap { width:950px; margin:0 auto 40px; }
.abc { width:100%; border-collapse:collapse; border-spacing:0; font-size:12px; color:#000; }
.abc thead th { background:#dadada; border:#bbb solid 1px; padding:6px 6px; font-weight:bold; }
.abc tbody th { background:#ededed; border:#cfcfcf solid 1px; text-align:left;  padding:4px 6px; }
.abc tbody td { border:#cfcfcf solid 1px; padding:4px 6px; }
.txt_center { text-align:center; }
</style>
<script type="text/javascript">

var filter = "win16|win32|win64|mac|macintel";
if ( navigator.platform ) {
	if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
		//alert('mobile 접속');
		location.href = "/m/index.do";
	} else {
		//alert('pc 접속');
		location.href = "/index.do";
	}
}

</script>

</html>