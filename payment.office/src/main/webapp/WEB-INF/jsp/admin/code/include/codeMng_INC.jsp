<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<ul>
	<c:forEach var = "data" items="${result.codeGroupVoList }">
	   <li role="CODE"  id="<c:out value='${data.cdGrp }' />" onclick="javascript:fn_getCodeGroupDetail('<c:out value='${data.cdGrp }' />');"><c:out value="${data.cdGrpNm }" /></li>
	</c:forEach>
</ul>