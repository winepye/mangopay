<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 검색을 위한 히든값 -->
<input type="hidden" id = "searchContentText" name = "searchContentText" value="${reportCriteria.searchContentText }">
<input type="hidden" id = "currentPageNo" name = "currentPageNo" value="${reportCriteria.currentPageNo }">
<!--//검색//-->
<p class="srch_Keyword">
    검색어 <strong>'${reportCriteria.searchContentText }'</strong> 에 대한 검색결과 입니다.
</p>
<!--탐방리포트결과-->
<div class="srch_Resultwrap">
    <h3 class="srch_title">
        <strong>탐방리포트</strong><em>(<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${searchReportVisitTotalCnt}" />건)</em>
    </h3>
    <div class="srch_repoWrap">
       <div id = "visitResultArea">
	       <c:forEach var = "data" items="${searchReportVisitList }">
	           <article class="srch_repoBox">
	            <div class="srch_repotitle">
	                <div class="rightBlock">
	                    <strong>${data.userId }</strong>
	                    <c:choose>
	                        <c:when test="${data.analDt != null }">
	                            (분석 <span><fmt:formatDate value="${data.analDt}" pattern="yyyy/MM/dd" /></span> | 등록 <span><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd" /></span>)
	                        </c:when>
	                        <c:otherwise>
	                            (등록 <span><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd" /></span>)
	                        </c:otherwise>
	                    </c:choose>
	                </div>

	                <h4 class="leftBlock titleArea">
	                   <c:if test="${data.reportDtlYn eq 'N' and sessionScope['scopedTarget.loginSessionInfo'].sessionUserLvlCd ne null}">
                                    <span class="icon_secret"
                                        style="float: left; margin-left: 10px; margin-top: 5px; margin-right: 0px;"><em>잠김</em></span>
                                </c:if>
	                   <a href="javascript:fn_goVisitReportDetailPage('<c:out value="${data.reportSeq}" />', '<c:out value="${data.reportDtlYn}" />')">
	                       <font style="float: left;">
                                ${data.title}
	                       </font>

	                       <c:if test="${data.newYn eq 'Y'}">
	                           <span class="new" style="float:left; line-height:20px; height:9px; width:9px; padding:3px 0 3px; display:block; vertical-align:middle;">
	                            <img src="${pageContext.request.contextPath}/resources/images/common/icon_new.gif" alt="New" style="vertical-align:middle; padding-left:6px; margin-bottom:3px;"/>
	                            </span>
	                        </c:if>
	                   </a>

	                </h4>
	            </div>
	            <div class="srch_con re_ellipsis multiline">
	                ${data.content }
	            </div>
	            <p class="srch_category">${data.industCategLvl1Nm }&gt; ${data.industCategLvl2Nm } &gt; ${data.industCategNm }</p>
	        </article>
	       </c:forEach>
           <button type="button" class="btn_more" id="btnVisitMore" onclick="fn_morePage('reportVisit')"><em>더보기 +</em></button>
	      <%--  <c:if test="${searchReportVisitTotalCnt>5 }">
	               <button type="button" class="btn_more" id="btnVisitMore" onclick="fn_morePage('reportVisit')"><em>더보기 +</em></button>
	       </c:if> --%>
	       <input type="hidden" id = "visitResultCurrentPageNo" value="${reportCriteria.currentPageNo }">
       </div>

<c:if test="${fn:length(searchReportVisitList)<=0 }">
          <div class="srch_nocon">검색결과가 없습니다.</div>
 </c:if>
 </div>
<!--//탐방리포트결과//-->

<!--일반리포트결과-->
<div class="srch_Resultwrap mgt50">
    <h3 class="srch_title">
        <strong>일반리포트</strong><em>(<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${searchReportGeneralTotalCnt}" />건)</em>
    </h3>
    <div class="srch_repoWrap">
       <div id = "generalResultArea">
	       <c:forEach var = "data" items="${searchReportGeneralList }">
	           <article class="srch_repoBox">
	            <div class="srch_repotitle">
	                <div class="rightBlock">
	                    <strong>${data.userId }</strong>
	                    <c:choose>
	                        <c:when test="${data.analDt != null }">
	                            (분석 <span><fmt:formatDate value="${data.analDt}" pattern="yyyy/MM/dd" /></span> | 등록 <span><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd" /></span>)
	                        </c:when>
	                        <c:otherwise>
	                            (등록 <span><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd" /></span>)
	                        </c:otherwise>
	                    </c:choose>
	                </div>
	               <h4 class="leftBlock titleArea">
                       <a href="javascript:fn_goGeneralReportDetailPage('<c:out value="${data.reportSeq}" />', '<c:out value="${data.reportDtlYn}" />')">
                        <c:if test="${data.reportDtlYn eq 'N' and sessionScope['scopedTarget.loginSessionInfo'].sessionUserLvlCd ne null}">
                                    <span class="icon_secret"
                                        style="float: left; margin-left: 10px; margin-top: 5px; margin-right: 0px;"><em>잠김</em></span>
                                </c:if>
	                       <font style="float: left;">
                                ${data.title}
                           </font>
	                       <c:if test="${data.newYn eq 'Y'}">
	                           <span class="new" style="float:left; line-height:20px; height:9px; width:9px; padding:3px 0 3px; display:block; vertical-align:middle;">
	                            <img src="${pageContext.request.contextPath}/resources/images/common/icon_new.gif" alt="New" style="vertical-align:middle; padding-left:6px; margin-bottom:3px;"/>
	                            </span>
	                        </c:if>
                       </a>
                    </h4>
	            </div>
	            <div class="srch_con re_ellipsis multiline">
	                ${data.content }
	            </div>
	            <p class="srch_category">${data.industCategLvl1Nm }&gt; ${data.industCategLvl2Nm } &gt; ${data.industCategNm }</p>
	           </article>
	       </c:forEach>
           <button type="button" class="btn_more"  id="btnGeneralMore" onclick="fn_morePage('reportGeneral')"><em>더보기 +</em></button>
	       <%-- <c:if test="${searchReportGeneralTotalCnt>5 }">
	               <button type="button" class="btn_more"  id="btnGeneralMore" onclick="fn_goMoreView('GENERAL')"><em>더보기 +</em></button>
	       </c:if> --%>
	       <input type="hidden" id = "generalResultCurrentPageNo" value="${reportCriteria.currentPageNo }">
       </div>
    <c:if test="${fn:length(searchReportGeneralList)<=0 }">
             <div class="srch_nocon">검색결과가 없습니다.</div>
    </c:if>
    <!--<button type="button" class="btn_more"><em>더보기</em></button>-->
</div>
<!--//일반리포트결과//-->