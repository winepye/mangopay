<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/dormantAccount_JS.jsp"%>
<!--
  * @Class Name  : dormantAccount.jsp
  * @Description : 휴면계정 재이용 신청 화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.08.08    이인희      최초 생성
-->
    <form id = "frm" name = "frm" method="post">
    <!--휴면계정 재이용 신청-->
        <div class="revivalWrap">
            <h2 class="join_title"><span class="title">휴면계정 재이용 신청</span></h2>
            <!--휴면계정 알림박스-->
            <div class="revival_stateBox">
                <div class="revival_con">
                    <c:choose>
                        <c:when test="${not empty userCriteria.searchUserId} }">
                            <p><span class="userid"><c:out value="${userCriteria.searchUserId}"/></span>님은 1년이상 로그인하지 않은 관계로 <strong>휴면계정상태입니다.</strong></p>
                        </c:when>
                        <c:otherwise>
                            <p>1년이상 로그인하지 않은 회원은 <strong>휴면계정으로 관리됩니다.</strong></p>
                        </c:otherwise>
                    </c:choose>
                    <p><strong>정상회원으로 전환은 <span class="pointline">본인인증을 통해 가능합니다.</span></strong></p>
                </div>
                <dl class="revival_noti">
                    <dt>휴면계정이란?</dt>
                    <dd>사용자에게 안정된 메일공간을 제공하고자 시행되는 정책으로 최근 1년간 비로그인 계정에 대해 메일계정해지</dd>
                </dl>
            </div>
            <!--//휴면계정 알림박스//-->

    <div id = "listArea">
        <jsp:include page="./include/dormantAccount_INC.jsp"></jsp:include>
    </div>



</div>
<!--//휴면계정 재이용 신청//-->

    <!-- 검색이나 화면이동을 위한 데이터 -->
    <input type="hidden" id = "searchFindType" name = "searchFindType" value="dormantAccount">
    <input type="hidden" id = "searchChkeckType" name = "searchChkeckType"  value="${userCriteria.searchChkeckType}">
    <input type="hidden" id = "searchTelNo" name = "searchTelNo">
    </form>
