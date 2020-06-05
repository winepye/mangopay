<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
    <tiles:insertAttribute name="header"/>
</head>
<body>
<div id="wrap">
	<div id='topMenu'><tiles:insertAttribute name="top"/></div>
	<div id="ADM_container">
         <div id="contentsWrap">
             <div class="adm_contents">
                <tiles:insertAttribute name="content"/>
             </div>

	   <div class='footer'><tiles:insertAttribute name="footer"/></div>
	   </div>
    </div>
</div>



</body>
</html>
