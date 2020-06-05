<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<ul>
	<c:forEach var = "data" items="${result.listCateIndutyGroup }">
	   <li role="CODE"  id="<c:out value='${data.cateCd }' />" onclick="javascript:fn_getCateIndutyPrDetail('<c:out value='${data.cateCd }' />');"><c:out value="${data.cateNm }" /></li>
	</c:forEach>
</ul>