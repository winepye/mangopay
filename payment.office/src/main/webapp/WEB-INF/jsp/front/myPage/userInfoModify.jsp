<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/userInfoModify_JS.jsp"%>
<!--
  * @Class Name  : userInfoModify.jsp
  * @Description : front > 회원정보변경
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.06.01	이인희      최초 생성
-->
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />
<section id="contents">
    <!--회원가입-->
    <form id="frm" name="frm" method="post">
        <!-- 저장및 검색을 위한 데이터 -->
        <input type="hidden" id="userInfoId" name="userInfoId" value="${userVo.userInfoId }">
        <input type="hidden" id="userMobileNum" name="userMobileNum" value="${userVo.userMobileNum }">
        <input type="hidden" id="userEmailAddr" name="userEmailAddr" value="${userVo.userEmailAddr }">
        <input type="hidden" id="searchIndustCategId" name="searchIndustCategId">
        <input type="hidden" id="searchCategDepth" name="searchCategDepth">
        <input type="hidden" id="searchIndustCategCd" name="searchIndustCategCd">

        <div class="member_editWrap">
            <!--기본정보입력-->
            <h3 class="h3_title_st mgt40">기본정보입력<span class="title_noti point_red">* 필수입력정보입니다.</span></h3>
            <div class="joinBoxst">
                <dl class="joinList">

					<dt>
                        <label>소속회사</label>
                    </dt>
                    <dd>
                        <p>
                            ${userVo.companyName }
                        </p>
                        <p class="good_noti"></p>
                    </dd>
                    <dt>
                        <label>아이디</label>
                    </dt>
                    <dd>
                        <p>
                            ${userVo.userId }
                        </p>
                        <p class="good_noti"></p>
                    </dd>
                  </dl>
                  <dl class="joinList">
                    <dt>
                        <label for="birthDay">이름<span class="point_red">*</span></label>
                    </dt>

                    <dd>
                        <p>
                            <input type="text" class="join_s_b w100pro" id="userName" name="userName" value="${userVo.userName }" style="ime-mode: active;" maxlength="20" title="이름 입력" />
                        </p>
                    </dd>
                    <c:set var = "userMobileNumBuf" value="${fn:split(userVo.userMobileNum,'-') }"></c:set>
                    <c:set var = "userMobileNum1" value="${userMobileNumBuf[0] }"></c:set>
                    <c:set var = "userMobileNum2" value="${userMobileNumBuf[1] }"></c:set>
                    <c:set var = "userMobileNum3" value="${userMobileNumBuf[2] }"></c:set>

                    <dt>
                        <label for="userMobileNum">휴대번호<span class="point_red">*</span></label>
                    </dt>
                    <dd>
                        <div class="addcombox userMobileNumModifyArea">
                            <select id="userMobileNum1" name="userMobileNum1" class="join_sel_b w_mobile">
                                <option <c:if test="${userMobileNum1 eq '010' }">selected="selected"</c:if>>010</option>
                                <option <c:if test="${userMobileNum1 eq '011' }">selected="selected"</c:if>>011</option>
                                <option <c:if test="${userMobileNum1 eq '016' }">selected="selected"</c:if>>016</option>
                                <option <c:if test="${userMobileNum1 eq '017' }">selected="selected"</c:if>>017</option>
                                <option <c:if test="${userMobileNum1 eq '018' }">selected="selected"</c:if>>018</option>
                                <option <c:if test="${userMobileNum1 eq '019' }">selected="selected"</c:if>>019</option>
                            </select>
                            <font style="float: left;">&nbsp;-</font>
                            <input type="text" class="join_s_b w_date" id="userMobileNum2" name="userMobileNum2"  value="${userMobileNum2 }"
                                     maxlength="4" title="휴대전화 가운데 입력" />
                            <font style="float: left;">&nbsp;-</font>
                            <input type="text" class="join_s_b w_date" id="userMobileNum3" name="userMobileNum3"  value="${userMobileNum3 }"
                                        maxlength="4" title="휴대전화 마지막 입력" />
                        </div>
                    </dd>
                    <c:set var = "emailBuf" value="${fn:split(userVo.userEmailAddr,'@')}" />
                    <dt>
                        <label for="userEmailAddr1">이메일<span class="point_red">*</span></label>
                    </dt>
                    <dd>
                        <input type="text" class="join_s_b w_checknum" id="userEmailAddr1" name="userEmailAddr1" style="ime-mode: disabled;" maxlength="20" value = "${emailBuf[0] }" />
                            <span>@</span>
                        <input type="text" class="join_s_b w_checknum" title="이메일입력" id="userEmailAddr2" name="userEmailAddr2" style="ime-mode: disabled;" maxlength="20" value = "${emailBuf[1] }"/>
                    </dd>
                </dl>

            </div>
            <!--//기본정보입력//-->

        </div>
        <!--//회원정보수정//-->
        <div class="bs_BtnBox_c">
            <button type="button" class="btn_white_B01" id = "btnCancel">취소</button>
            <button type="button" class="btn_blue_B01 mgl10" id = "btnModify">저장</button>
        </div>
        <!--//회원가입//-->
    </form>

</section>