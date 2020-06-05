<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/mainList_JS.jsp"%>
<!--
  * @Class Name  : mainList.jsp
  * @Description : admin > main 목록 조회
  * @Modification Information
  * @
  * @ 수정일                       수정자      수정내용
  * @ 2016.05.26    이인희      최초 생성
-->
<form id = "frm" name = "frm" method="post" style="padding: 15px 15px 0px 15px;text-align: left;">
<section class="admin_main">
    <!--관리자정보-->
    <article>
        <h3 class="h3_adtitle_arrow">관리자정보</h3>
        <table class="tb_basic_st" summary="관리자정보">
            <caption>관리자정보</caption>
            <colgroup>
                <col width="25%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">이름 (아이디)</th>
                    <td>${sessionScope['scopedTarget.loginSessionInfo'].sessionUserName} <span class="txt_userid">(${sessionScope['scopedTarget.loginSessionInfo'].sessionUserId})</span></td>
                </tr>
                <tr>
                    <th scope="row">연락처</th>
                    <td class="txt_phonenum">${result.userVo.userMobileNum }</td>
                </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td class="txt_eamil">${result.userVo.userEmailAddr }</td>
                </tr>
                <tr>
                    <th scope="row">권한</th>
                    <td><customTagUi:code type="text" cdGrp="USER_TYPE_CD" name="" cd="${sessionScope['scopedTarget.loginSessionInfo'].sessionUserTypeCd}" /></td>
                </tr>
            </tbody>
        </table>
    </article>
    <!--//관리자정보//-->

    <!-- 가맹점별승인내역 -->
    <article>
        <h3 class="h3_adtitle_arrow"><span>가맹점별승인내역</span></h3>
        <table class="tb_basic_st2" summary="승인내역">
            <caption>가맹점별승인내역</caption>
            <colgroup>
                <col span="3" width="33.3%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">월</th>
                    <th scope="col">금액</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach var = "data" items="${result.summaryInfo4 }" varStatus="i">
	                <tr>
	                    <td style="cursor: default;"><strong>${data.storeName}</strong></td>
	                    <td style="cursor: default;"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.approvalAmount}" /></strong>원</td>
	                </tr>
	             </c:forEach>
            </tbody>
        </table>
        <button type="button" class="btn_more_adm" onclick="fn_goPage('generalReport')"><em>더보기</em></button>
    </article>
    <!--//가맹점별승인내역//-->

    <!--가맹점현황-->
    <%-- <article>
        <h3 class="h3_adtitle_arrow">가맹점현황</h3>
        <table class="tb_basic_st" summary="미처리 내역">
            <caption>미처리 내역</caption>
            <colgroup>
                <col width="25%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">전체가맹점</th>
                    <td class="txt_num"><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.summaryInfo.withdrwReqUserCnt}" />100</td>
                </tr>
                <tr>
                    <th scope="row">전일가입</th>
                    <td class="txt_num"><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.summaryInfo.yesterdayJoinUserCnt}" />4</td>
                </tr>
                <tr>
                    <th scope="row">오늘가입</th>
                    <td class="txt_num"><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.summaryInfo.todayJoinUserCnt}" />3</td>
                </tr>
            </tbody>
        </table>
        <button type="button" class="btn_more_adm" onclick="fn_goPage('USERDETAIL')"><em>더보기</em></button>
    </article> --%>
    <!--//가맹점현황//-->
 </section>
 <section class="admin_main">

    <!-- 승인내역 -->
    <article>
        <h3 class="h3_adtitle_arrow"><span>승인내역</span></h3>
        <table class="tb_basic_st2" summary="승인내역">
            <caption>금일결제내역</caption>
            <colgroup>
                <col span="3" width="33.3%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">금일승인건수</th>
                    <th scope="col">금일승인금액</th>
                    <th scope="col">전체승인금액</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="cursor: default;"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.summaryInfo.todayAppvCnt}" /></strong>건</td>
                    <td style="cursor: default;"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.summaryInfo.todayAppvAmount}" /></strong>원</td>
                    <td style="cursor: default;"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${result.summaryInfo.totalAppvAmount}" /></strong>원</td>
                </tr>
            </tbody>
        </table>
        <button type="button" class="btn_more_adm" onclick="fn_goPage('generalReport')"><em>더보기</em></button>
    </article>
    <!--//승인내역//-->

    <!-- 월별승인내역 -->
    <article>
        <h3 class="h3_adtitle_arrow"><span>월별승인내역</span></h3>
        <table class="tb_basic_st2" summary="승인내역">
            <caption>월별승인내역</caption>
            <colgroup>
                <col span="3" width="33.3%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">월</th>
                    <th scope="col">건수</th>
                    <th scope="col">금액</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach var = "data" items="${result.summaryInfo2 }" varStatus="i">
	                <tr>
	                    <td style="cursor: default;"><strong>${data.transAt}</strong></td>
	                    <td style="cursor: default;"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.approvalCnt}" /></strong>건</td>
	                    <td style="cursor: default;"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.approvalAmount}" /></strong>원</td>
	                </tr>
	             </c:forEach>
            </tbody>
        </table>
        <button type="button" class="btn_more_adm" onclick="fn_goPage('generalReport')"><em>더보기</em></button>
    </article>
    <!--//월별승인내역//-->

    <!-- 일별승인내역 -->
    <article>
        <h3 class="h3_adtitle_arrow"><span>일별승인내역</span></h3>
        <table class="tb_basic_st2" summary="승인내역">
            <caption>일별승인내역</caption>
            <colgroup>
                <col span="3" width="33.3%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">월</th>
                    <th scope="col">금액</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach var = "data" items="${result.summaryInfo3 }" varStatus="i">
	                <tr>
	                    <td style="cursor: default;"><strong>${data.transAt}</strong></td>
	                    <td style="cursor: default;"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.approvalAmount}" /></strong>원</td>
	                </tr>
	             </c:forEach>
            </tbody>
        </table>
        <button type="button" class="btn_more_adm" onclick="fn_goPage('generalReport')"><em>더보기</em></button>
    </article>
    <!--//일별승인내역//-->


</section>



<!-- 검색이나 화면이동을 위한 데이터 :S -->
<input type="hidden" id = "searchVisitType" name = "searchVisitType">
<input type="hidden" id = "searchAprvCd" name = "searchAprvCd">
<input type="hidden" id = "searchUserStatusCd" name = "searchUserStatusCd">
<input type="hidden" id = "searchFromDtS" name = "searchFromDtS">
<input type="hidden" id = "searchToDtS" name = "searchToDtS">
<input type="hidden" id = "searchFromDtmS" name = "searchFromDtmS">
<input type="hidden" id = "searchToDtmS" name = "searchToDtmS">
<input type="hidden" id="searchQnaStatusCd" name = "searchQnaStatusCd">
<input type="hidden" id="searchAprvCdType" name = "searchAprvCdType">
<input type="hidden" id="searchRemitStatusCd" name = "searchRemitStatusCd">
<input type="hidden" id="searchCnclYn" name = "searchCnclYn">
<!-- 검색이나 화면이동을 위한 데이터 :E -->
</form>

