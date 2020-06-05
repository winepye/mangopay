﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery/jquery.bxslider.min.js"></script>
<%@ include file="./js/main_JS.jsp"%>

<div class="main_visual_wrap">
    <div class="main_visual">
        <ul class="bxslider">
            <li>
                <div class="main_cutBox1">
                    <h2 class="cut_m_title">Smart Payment</h2>
                        <p class="cut_s_title">간편결제를 통한 고객편의성 제공</p>
                        <p class="cut_txt">간편결제를 통해 고객의 카드 결제가 훨씬 쉬워집니다.<br>고객 편의성 증진!<br></p>
                </div>
                <div class="main_imgBox1">
                </div>
            </li>
            <li>
                <div class="main_cutBox2">
                    <h2 class="cut_m_title">Payment Revolution</h2>
                        <p class="cut_s_title">가맹점 카드 수수료 인하</p>
                        <p class="cut_txt">가맹점 카드 수수료 인하효과 발생<br>가맹점의 최저 수수료를 보장해 드립니다.<br></p>
                </div>
                <div class="main_imgBox2">
                </div>
            </li>
            <!-- <li>
                <div class="main_cutBox3">
                    <h2 class="cut_m_title">Business Analysis Report </h2>
                        <p class="cut_s_title">간편결제 시스템 확립</p>
                        <p class="cut_txt">이해 당사자가 아닌 전문가들이 제 3자 입장에서<br>산업별 시장분석, 업종평균재무, 전망 등을 분석한 보고서<br></p>
                </div>
                <div class="main_imgBox3">
                </div>
            </li>
            <li>
                <div class="main_cutBox4">
                    <h2 class="cut_m_title">Gateway to Success</h2>
                        <p class="cut_s_title">카드수수료 인하 </p>
                        <p class="cut_txt">학벌 NO! 경력 NO! 오로지 나의 실력만으로 평가!<br>본인의 실력과 리포트만으로 평가받는 시스템<br></p>
                </div>
                <div class="main_imgBox4">
                </div>
            </li> -->
        </ul>
    </div>
</div>
<!--// 메인비쥬얼 //-->
<form id="frm" name="frm" method="post" style="margin-bottom: 50px;">
    <!-- 리포트 상세페이지 이동시 필요한 파라미터 -->
    <input type="hidden" id = "searchReportKindCd" name = "searchReportKindCd">
    <!--로그인박스-->
    <div class="loginBax_wrap">
        <div class="loginBax">
        <c:choose>
            <c:when test="${!sessionScope['scopedTarget.loginSessionInfo'].isLogin}">
                <!--로그인전-->
            <div class="login">
                <div class="m_loginZone">
                    <div class="inputZone">
                        <p><input type="text"  id="searchUserId" name="searchUserId" title="아이디입력" placeholder="아이디입력" onkeypress="if(event.keyCode==13) fn_doLogin();"/></p>
                        <p><input type="password" id="searchUserPwd" name="searchUserPwd" title="비번입력" placeholder="비밀번호입력" onkeypress="if(event.keyCode==13) fn_doLogin();"/></p>
                    </div>
                    <button type="button" id="btnLogIn" class="btn_login">로그인</button>
                </div>
                <div class="m_login_p">
                    <span class="inpChk idChkbox"  type="checkbox" id="chk">아이디저장</span>
                    <span class="idChkbox" style="cursor: pointer;">아이디 저장</span>
                </div>
            </div>
            <!--//로그인전//-->
            </c:when>
            <c:otherwise>
            <!--로그인후-->
                <div class="logout">
                    <c:set var="userLvlCd" value="${sessionScope['scopedTarget.loginSessionInfo'].sessionUserLvlCd eq 'M1'?'admin':fn:toLowerCase(sessionScope['scopedTarget.loginSessionInfo'].sessionUserLvlCd)}"></c:set>
                    <div class="m_loginZone">
                        <div class="m_loginBox_after">

                            <p class="m_name"><a href="javascript:fn_morePage('myPageMain')">${sessionScope['scopedTarget.loginSessionInfo'].sessionUserName}</a>님</p>
                            <ul class="m_list">
                                <li>소속회사 :
                                    ${sessionScope['scopedTarget.loginSessionInfo'].sessionCompanyName}
                                </li>
                                <li>회원유형 :
                                    <customTagUi:code type="text" cdGrp="USER_TYPE_CD" name="" cd="${sessionScope['scopedTarget.loginSessionInfo'].sessionUserTypeCd}" />
                                </li>
                            </ul>
                            <p class="m_btn"><button type="button" class="btn_member" onclick="fn_morePage('myInfoModify')">회원정보수정</button>
                                            <button type="button" class="btn_logout"  onclick="fn_doLogout()">로그아웃</button></p>
                        </div>
                    </div>
                </div>
                <!--//로그인후//-->
            </c:otherwise>
        </c:choose>
            <!-- Link Menu -->
            <dl class="icon_shortcut">
                <dt>바로가기</dt>
                <dd class="link01"><a href="javascript:fn_morePage('paymentList')">승인이력</a></dd>
                <dd class="link02"><a href="javascript:fn_morePage('notiList')">공지사항</a></dd>
                <!-- <dd class="link03"><a href="javascript:alert('준비중입니다.')">간편결제<br>이용안내</a></dd>
                <dd class="link04"><a href="javascript:alert('준비중입니다.')">가맹점정책<br>안내</a></dd> -->
            </dl>
            <!-- //Link Menu -->
        </div>
    </div>


<!--메인컨텐츠-->
<div id="main_container">
    <div class="reportNoti">
    <input type="hidden" id="searchReportSeq" name="searchReportSeq"> <input type="hidden"  id="searchBoardSeq" name="searchBoardSeq">
    <div class="m_contents">
        <!--왼쪽전체-->
        <div class="m_left_block">

            <!--2.사이트현황요약-->
            <c:if test="${sessionScope['scopedTarget.loginSessionInfo'].isLogin == true}">
	            <div class="stateZoneBox">
	                <div class="site_stateZone">
	                    <ul class="reportBox">
	                        <li>
	                            <p>금일 승인건수</p>
	                            <p class="number"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${summaryInfoMap.todayAppvCnt}" /></strong> 건</p>
	                        </li>
	                    </ul>
	                    <ul class="cashBox"> <!-- memberBox -->
	                        <li>
	                            <p>금일 승인금액</p>
	                            <p class="number"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${summaryInfoMap.todayAppvAmount}" /></strong> 원</p>
	                        </li>
	                    </ul>
	                    <ul class="cashBox">
	                        <li>
	                            <p>전체 승인금액</p>
	                            <p class="number"><strong><fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${summaryInfoMap.totalAppvAmount}" /></strong> 원</p>
	                        </li>
	                    </ul>
	                </div>
	            </div>
	        </c:if>
            <!--//2.사이트현황요약//-->
            <script type="text/javascript">
                var maxCnt = 0;
                var summaryInfoArray = new Object();
            </script>

            <!--4.공지+고객센터-->
            <!--4.공지사항-->
            <div id="notice_new" class="notice_list">
                <h3><a href="javascript:fn_morePage('notiList')" style="color:white;">공지사항</a></h3>
                <div class="notiBox">
                    <ul class="news_list" id = "notiListUl">
                        <c:forEach var="data" items="${notiVoList }">
                            <li>
                               <a href="javascript:fn_goNotiDetailPage(${data.boardSeq })">
                                   <span>
                                        <c:choose>
                                            <c:when test="${fn:length(data.title)>30 }">
                                               ${fn:substring(data.title,0,20) }...
                                            </c:when>
                                            <c:otherwise>
                                               ${data.title }
                                            </c:otherwise>
                                        </c:choose>

                                    </span>
                                     <c:if test="${data.newYn eq 'Y'}">
                                        <span class="new">
                                           <img src="${pageContext.request.contextPath}/resources/images/common/icon_new.gif" alt="New" style="display: inline;margin-top: 20px;"/>
                                        </span>
                                    </c:if>
                                 </a>

                                 <span class="date"><fmt:formatDate value="${data.createDate}" pattern="yyyy/MM/dd" /></span>
                            </li>
                        </c:forEach>
                    </ul>
                    <p id="btn_notice" class="btn_notice">
                        <a href="#" id="notiPrev" class="btn_up">위로</a>
                        <a href="#" id='notiNext'  class="btn_down">아래로</a>
                    </p>
                </div>
            </div>
            <!--//4.공지사항//-->

            </div>
            <!--//퀵메뉴//-->
        </div>
        <!--//오른쪽전체//-->
    </div>

</div>
</form>


<!--// 메인컨텐츠 //-->
