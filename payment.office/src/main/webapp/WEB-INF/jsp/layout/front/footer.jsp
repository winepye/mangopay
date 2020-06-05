<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script>
$(document).ready(function () {
    $('.select-label').click(function () {
        $('.dropdown').toggleClass('active');
    });
    $('.dropdown-list li').click(function () {
        $('.select-label').text($(this).text());
        $('.dropdown').removeClass('active');
    });
});
</script>

<footer id="footerArea">
	<!--footer menu-->
	<div class="bottomMenuArea">
    	<div class="bottomMenuBox">
    	   <div class="Customer">
                <ul class="bottom_customer">
                    <li>고객상담 1670-1772</li>
                    <li><span class="daytxt">평일 09:00 - 18:00 (토, 일, 공휴일 제외)</span></li>
                    <li><span class="daytxt">팩스 : 0504-160-1896</span></li>
                </ul>
            </div>
    	    <!-- <div class="familyMenu">
                <div class="dropdown">
                    <span class="select-label">Family Site</span>
                    <input type="hidden" name="cd-dropdown">
                    <ul class="dropdown-list">
                        <li><a href="http://www.naver.com/" target="_blank" title="새창이동">네이버</a></li>
                    </ul>
                </div>
            </div> -->
            <%-- <div class="hompageMenu">
               	 <ul class="bottom_mn_list">
                    <li><a href="#this" class="">회사소개</a></li>
                    <li><a href="#this" class="">제휴광고문의</a></li>
                    <li>
                        <a href="${pageContext.request.contextPath}/info/siteInfo/siterule.do" class="">
                        <c:choose>
                                <c:when test="${pageUrl ne '/info/siteInfo/siterule.do' }">
                                     약관
                                </c:when>
                                <c:otherwise>
                                <strong> 약관</strong>
                                </c:otherwise>
                            </c:choose>

                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/info/siteInfo/privacy.do" class="">
                            <c:choose>
                                <c:when test="${pageUrl ne '/info/siteInfo/privacy.do' }">
                                    개인정보취급방침
                                </c:when>
                                <c:otherwise>
                                <strong>개인정보취급방침</strong>
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </li>
                    <li><a href="#this" class="">이메일무단 수집거부</a></li>
                    <li><a href="#this" class="">책임한계 및 법적고지</a></li>
	            </ul>
            </div> --%>
            <!-- <div class="familyMenu"> 추후에 스크립트 적용 예정
                <p class="title"><span class="hide">Family Site</span></p>
                <select name="" id="" class="">
                	<option value="">운영사이트 바로가기</option>
                    <option value=""></option>
                    <option value=""></option>
                </select>
            </div>  -->
        </div>
    </div>
    <!--// footer menu //-->

    <!--copyright-->
    <%-- <div class="copyrightArea">
        <div class="copyrightBox">
            <div class="addZone">
                <ul>
                    <li><address>인천시 연수구 갯벌로20 미추홀타워 본관 11층</address></li>
                    <li>사업자등록번호 : 111-22-33333</li>
                    <li>개인정보책임자 : 조성민</li>
                    <li>팩스 : 1670-1772</li>
                    <li><span class="email"><a href="mailto:louis@mpsolutions.kr">이메일 문의</span></a></li>
                </ul>
            </div>
            <div class="contact">
                <ul>
                    <li>COPYRIGHT (C) <strong>MP Solutions.</strong> ALL RIGHTS RESERVED.</li>
                </ul>
                <ul>
                    <li><strong>MP솔루션스 고겍센터</strong></li>
                    <li>관리자메일 : louis@mpsolutions.kr</li>
                    <li>대표전화 : 1670-1772 (09:00~18:00 토, 일, 공휴일 제외)</li>
                    <li>팩스 : 0504-160-1896</li>
                </ul>
                <copyright><img src="${pageContext.request.contextPath}/resources/images/common/footer_copyright_01.gif" alt="Copyright ⓒ MP Solutions. All right reserved." /></copyright>
            </div>
        </div>
    </div> --%>
    <!--// copyright //-->
</footer>


