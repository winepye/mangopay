<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/userModify_JS.jsp"%>
<!--
  * @Class Name  : storeCreatePage.jsp
  * @Description : 사용자 수정화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">사용자 수정</h3>
       	<table id="templateProject" class="tb_left_st2" summary="사용자 수정">

       		<input type="hidden" name="searchUserInfoId" value='<c:out value="${userCriteria.searchUserInfoId}" />'>
       		<input type="hidden" name="userInfoId" value='<c:out value="${userCriteria.searchUserInfoId}" />'>
       		<input type="hidden" name="searchUserId" value='<c:out value="${userCriteria.searchUserId}" />'>
	        <input type="hidden" name="searchUserName" value='<c:out value="${userCriteria.searchUserName}" />'>
	        <input type="hidden" name="searchUserTypeCd" value='<c:out value="${userCriteria.searchUserTypeCd}" />'>
	        <input type="hidden" name="searchStoreName" value='<c:out value="${userCriteria.searchStoreName}" />'>
	        <input type="hidden" name="searchCompanyName" value='<c:out value="${userCriteria.searchCompanyName}" />'>
	        <input type="hidden" name="searchUseYn" value='<c:out value="${userCriteria.searchUseYn}" />'>

           <caption>
               사용자 수정
           </caption>
           <colgroup>
               <col width="20%" />
               <col width="30" />
               <col width="20%" />
               <col width="30%" />
           </colgroup>
           <tbody>
           		<tr>
           			<th scope="row"><span class="redstar">*</span>사용자명</th>
           			<td>
           				<input id="userName" name="userName" class="input_s_b w100pro" value="${result.userName}" placeholder="사용자명을 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>
           			<th scope="row">사용자 ID</th>
           			<td><c:out value="${result.userId}" /></td>
           		</tr>
           		<tr>
           			<th scope="row">
           				<label for="userPassword">비밀번호</label>
           				<!-- <input type="button" onclick="javascript:fn_changePassword()" style="cursor:pointer;"> -->
           			</th>
           			<td>
           				<input type="password" id="userPassword" name="userPassword" class="input_s_b w100pro" placeholder="비밀번호을 입력하세요." onkeyup="javascript:chkword(this, 255)" />
           			</td>
					<th scope="row"><label for="userPassword2">비밀번호 확인</label></th>
           			<td>
           				<input type="password" id="userPassword2" name="userPassword2" class="input_s_b w100pro" placeholder="비밀번호을 입력하세요." onkeyup="javascript:chkword(this, 255)" />
           			</td>
           		</tr>

           		<tr>
           			<th scope="row">
           				<label for="userEmailAddr">이메일</label>
           			</th>
           			<td>
           				<input id="userEmailAddr" name="userEmailAddr" class="input_s_b w100pro" value="${result.userEmailAddr}" placeholder="이메일을 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>

           			<th scope="row">
           				<label for="userMobileNum1">핸드폰</label>
           			</th>
           			<c:set var = "userMobileNumBuf" value="${fn:split(result.userMobileNum,'-') }"></c:set>
                    <c:set var = "userMobileNum1" value="${userMobileNumBuf[0] }"></c:set>
                    <c:set var = "userMobileNum2" value="${userMobileNumBuf[1] }"></c:set>
                    <c:set var = "userMobileNum3" value="${userMobileNumBuf[2] }"></c:set>
           			<td>
           				<input id="userMobileNum1" name="userMobileNum1" class="input_s_b w30pro" value="${userMobileNum1}" onkeyup="chkword(this, 3)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="userMobileNum2" name="userMobileNum2" class="input_s_b w30pro" value="${userMobileNum2}" onkeyup="chkword(this, 4)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="userMobileNum3" name="userMobileNum3" class="input_s_b w30pro" value="${userMobileNum3}" onkeyup="chkword(this, 4)" numberOnly/>
           				<input type="hidden" id="userMobileNum" name="userMobileNum"/>
           			</td>
           		</tr>

           		<tr>
           			<th scope="row">
           				<label for="companyInfoId">거래처정보</label>
           			</th>
           			<td>
           				<select name="companyInfoId" id="companyInfoId" class="sel_basic w100pro" title="거래처 정보 선택" onchange="javascript:fn_changeCompanyId()">
							<option value="0" selected="selected">선택</option>
							<c:forEach var="item" items="${companyInfoIdList}">
								<option value="${item.companyInfoId}" <c:if test="${item.companyInfoId eq result.companyInfoId}">selected="selected"</c:if>>${item.companyName}</option>
							</c:forEach>
						</select>
           			</td>
           			<th scope="row">
           				<label for="storeCode">가맹점</label>
           			</th>
           			<td>
           				<select name="storeCode" id="storeCode" class="sel_basic w100pro" title="가맹점 선택">
							<option value="0" selected="selected">선택하세요.</option>
							<c:forEach var="item" items="${storeInfoIdList}">
								<option value="${item.storeCode}" <c:if test="${item.storeCode eq result.storeCode}">selected="selected"</c:if>>${item.storeName}-${item.bizRegNum}</option>
							</c:forEach>
						</select>
           			</td>
           		</tr>

           		<tr>
           			<th scope="row">
						<label for="useYn">회원구분</label>
					</th>
					<td class="itemList">
                         <customTagUi:code type="select" cdGrp="USER_TYPE_CD" cd="${result.userTypeCd}" name="userTypeCd" id="userTypeCd" attr='class="sel_basic w100pro"' subjectText="선택"/>
                    </td>
           			<th scope="row">
						<label for="useYn">사용여부</label>
					</th>
					<td class="itemList">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="${result.useYn}" prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
           		</tr>
           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoUserListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnGoUserPreviousPage" class="btn_white_B01" onclick="javascript:history.back();">취소</button>
            <button type="button" id="btnModifyUser" class="btn_gray_B01">저장</button>
        </div>
		<!-- 버튼 -->

	</form>

	<form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchUserId" value='<c:out value="${userCriteria.searchUserId}" />'>
        <input type="hidden" name="searchUserName" value='<c:out value="${userCriteria.searchUserName}" />'>
        <input type="hidden" name="searchUserTypeCd" value='<c:out value="${userCriteria.searchUserTypeCd}" />'>
        <input type="hidden" name="searchStoreName" value='<c:out value="${userCriteria.searchStoreName}" />'>
        <input type="hidden" name="searchCompanyName" value='<c:out value="${userCriteria.searchCompanyName}" />'>
        <input type="hidden" name="searchUseYn" value='<c:out value="${userCriteria.searchUseYn}" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${userCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${userCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
    </form>

</section>