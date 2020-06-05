<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/userCreate_JS.jsp"%>
<!--
  * @Class Name  : userCreatePage.jsp
  * @Description : 사용자 등록 화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">사용자 등록</h3>
       	<table id="templateProject" class="tb_left_st2" summary="사용자 등록">
           <caption>
               사용자 등록
           </caption>
           <colgroup>
               <col width="20%" />
               <col width="30" />
               <col width="20%" />
               <col width="30%" />
           </colgroup>
           <tbody>
           		<tr>
           			<th scope="row">
           				<label for="userName"><span class="redstar">*</span>사용자명</label>
           			</th>
           			<td>
           				<input type="text" id="userName" name="userName" class="input_s_b w100pro" placeholder="사용자명을 입력하세요." onkeyup="javascript:chkword(this, 100)" style="ime-mode:active;"/>
           			</td>
           			<th scope="row">
           				<label for="userId"><span class="redstar">*</span>사용자 ID</label>
           			</th>
           			<td>
           				<input type="text" id="userId" name="userId" class="input_s_b w100pro" placeholder="사용자 ID를 입력하세요." onkeyup="javascript:chkword(this, 30)" style="ime-mode:inactive;"/>
           			</td>
           		</tr>

           		<tr>
           			<th scope="row">
           				<label for="userPassword"><span class="redstar">*</span>비밀번호</label>
           			</th>
           			<td>
           				<input type="password" id="userPassword" name="userPassword" class="input_s_b w100pro" placeholder="비밀번호을 입력하세요." onkeyup="javascript:chkword(this, 255)"/>
           			</td>
           			<th scope="row">
           				<label for="userPassword2"><span class="redstar">*</span>비밀번호 확인</label>
           			</th>
           			<td>
           				<input type="password" id="userPassword2" name="userPassword2" class="input_s_b w100pro" placeholder="비밀번호을 입력하세요." onkeyup="javascript:chkword(this, 255)"/>
           			</td>
           		</tr>

           		<tr>
           			<th scope="row">
           				<label for="userEmailAddr">이메일</label>
           			</th>
           			<td>
           				<input id="userEmailAddr" name="userEmailAddr" class="input_s_b w100pro" placeholder="이메일을 입력하세요." onkeyup="javascript:chkword(this, 100)"  />
           			</td>

           			<th scope="row">
           				<label for="userMobileNum1">핸드폰</label>
           			</th>
           			<td>
           				<input id="userMobileNum1" name="userMobileNum1" class="input_s_b w30pro" onkeyup="chkword(this, 3)" numberOnly />
           				<label class="w5pro">-</label>
           				<input id="userMobileNum2" name="userMobileNum2" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly />
           				<label class="w5pro">-</label>
           				<input id="userMobileNum3" name="userMobileNum3" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly />
           				<input type="hidden" id="userMobileNum" name="userMobileNum" />
           			</td>
           		</tr>

           		<tr>
           			<th scope="row">
           				<label for="companyInfoId"><span class="redstar">*</span>거래처정보</label>
           			</th>
           			<td>
           				<select name="companyInfoId" id="companyInfoId" class="sel_basic w100pro" title="거래처정보 선택" onchange="javascript:fn_changeCompanyId()">
							<option value="0" selected="selected">선택하세요.</option>
							<c:forEach var="item" items="${companyInfoIdList}">
								<option value="${item.companyInfoId}">${item.companyName}</option>
							</c:forEach>
						</select>
           			</td>
           			<th scope="row">
           				<label for="storeCode"><span class="redstar">*</span>가맹점</label>
           			</th>
           			<td>
           				<select name="storeCode" id="storeCode" class="sel_basic w100pro" title="가맹점 선택">
							<option value="0" selected="selected">선택하세요2.</option>
							<c:forEach var="item" items="${storeInfoIdList}">
								<option value="${item.storeCode}">${item.storeName}-${item.bizRegNum}</option>
							</c:forEach>
						</select>
           			</td>
           		</tr>



           		<tr>
           			<th scope="row">
						<label for="useYn"><span class="redstar">*</span>회원구분</label>
					</th>
					<td class="itemList">
                         <customTagUi:code type="select" cdGrp="USER_TYPE_CD" cd="" name="userTypeCd" id="userTypeCd" attr='class="sel_basic w100pro"' subjectText="선택하세요."/>
                    </td>
           			<th scope="row">
						<label for="useYn">사용여부</label>
					</th>
					<td class="itemList">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="Y" />
                    </td>
           		</tr>


           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoUserListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnCreateUser" class="btn_gray_B01">저장</button>
        </div>
		<!-- 버튼 -->

	</form>

	<form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchUserId" value='<c:out value="${userCriteria.searchUserId }" />'>
        <input type="hidden" name="searchUserName" value='<c:out value="${userCriteria.searchUserName }" />'>
        <input type="hidden" name="searchUserTypeCd" value='<c:out value="${userCriteria.searchUserTypeCd}" />'>
        <input type="hidden" name="searchStoreName" value='<c:out value="${userCriteria.searchStoreName}" />'>
        <input type="hidden" name="searchCompanyName" value='<c:out value="${userCriteria.searchCompanyName}" />'>
        <input type="hidden" name="searchUseYn" value='<c:out value="${userCriteria.searchUseYn}" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${userCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${userCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
    </form>

	<form id="frmStore" name="frmStore" method="post">
        <input type="hidden" id="companyId" name="companyId" >
    </form>
</section>