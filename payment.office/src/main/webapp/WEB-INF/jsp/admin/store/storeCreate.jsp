<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/storeCreate_JS.jsp"%>

<!--
  * @Class Name  : storeCreatePage.jsp
  * @Description : 가맹점 작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">가맹점 등록</h3>
       	<table id="templateProject" class="tb_left_st2" summary="가맹점 등록">
           <caption>
               가맹점 등록
           </caption>
           <colgroup>
               <col width="20%" />
               <col width="30" />
               <col width="20%" />
               <col width="30%" />
           </colgroup>
           <tbody>
           		<tr>
           			<th scope="row"><label for="catId"><span class="redstar">*</span>CAT ID</label></th>
           			<td>
           				<input type="text" id="catId" name="catId" class="input_s_b w100pro" maxlength="100" placeholder="CAT ID를 입력하세요." numberOnly onkeyup="javascript:chkword(this, 10)"/>
           			</td>

           			<th scope="row"><label for="partnerInfoId"><span class="redstar">*</span>제휴사정보 ID</label></th>
           			<td>
           				<select name="partnerInfoId" id="partnerInfoId" class="sel_basic w100pro" title="제휴사 선택">
							<option value="0" selected="selected">선택</option>
							<c:forEach var="item" items="${partnerInfoIdList}">
								<option value="${item.partnerInfoId}">${item.partnerName}</option>
							</c:forEach>
						</select>
           			</td>
           		</tr>

           		<tr>
           			<th scope="row"><label for="storeName"><span class="redstar">*</span>가맹점명</label></th>
           			<td>
           				<input id="storeName" name="storeName" class="input_s_b w100pro" placeholder="가맹점명을 입력하세요." onkeyup="javascript:chkword(this, 30)" />
           			</td>

           			<th scope="row"><label for="bizType">업종</label></th>
           			<td>
           				<input id="bizType" name="bizType" class="input_s_b w100pro" placeholder="업종을 입력하세요." onkeyup="javascript:chkword(this, 30)" />
           			</td>
           		</tr>

           		<tr>
           			<th scope="row"><label for="deviceNum">기기번호</label></th>
           			<td>
           				<input type="text" id="deviceNum" name="deviceNum" class="input_s_b w100pro" placeholder="기기번호를 입력하세요." onkeyup="javascript:chkword(this, 30)" />
           			</td>
           			<th scope="row"><label for="bizRegNum1"><span class="redstar">*</span>사업자번호</label></th>
           			<td>
           				<input id="bizRegNum1" name="bizRegNum1" class="input_s_b w30pro" onkeyup="javascript:chkword(this, 3)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="bizRegNum2" name="bizRegNum2" class="input_s_b w20pro" onkeyup="javascript:chkword(this, 2)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="bizRegNum3" name="bizRegNum3" class="input_s_b w40pro" onkeyup="javascript:chkword(this, 5)" numberOnly/>
           				<!-- <input id="bizRegNum" name="bizRegNum" class="input_s_b w100pro" placeholder="사업자번호를 입력하세요." onkeyup="javascript:chkword(this, 10)"/> -->
           			</td>
           		</tr>
           		<!-- 부가세/봉사료율 -->
           		<tr>
           			<th scope="row"><label for="ceoName">부가세</label></th><!-- TAX_ON(과세), TAX_OFF(면세), TAX_PARALLEL(과세면세겸업) -->
           			<td class="itemList">
                         <customTagUi:code type="select" cdGrp="TAX_TYPE" cd="TAX_ON"  name="taxType" id="taxType" attr='class="sel_basic w30pro"' subjectText="과세형태"  />&nbsp;&nbsp;
                        <input id="taxRate" name="taxRate" class="input_s_b w30pro" onkeyup="javascript:chkword(this, 2)" value="10" numberOnly/>&nbsp;%
                    </td>
           			<th scope="row"><label for="serviceChargeYn">봉사료</label></th>
           			<td class="itemList">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="serviceChargeYn" id="serviceChargeYn" cd="N" />&nbsp;&nbsp;
                        <input id="serviceChargeRate" name="serviceChargeRate" class="input_s_b w30pro" onkeyup="javascript:chkword(this, 2)" value="0" numberOnly />%
                    </td>
           		</tr>

           		<tr>
           			<th scope="row"><label for="ceoName">대표자명</label></th>
           			<td>
           				<input id="ceoName" name="ceoName" class="input_s_b w100pro" placeholder="대표자명을 입력하세요." onkeyup="javascript:chkword(this, 30)"  />
           			</td>
           			<th scope="row"><label for="emailAddr">이메일</label></th>
           			<td>
           				<input id="emailAddr" name="emailAddr" class="input_s_b w100pro" placeholder="이메일을 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>
           		</tr>

           		<tr>
           			<th scope="row"><label for="mobileNum1">핸드폰</label></th>
           			<td>
           				<input id="mobileNum1" name="mobileNum1" class="input_s_b w30pro" onkeyup="chkword(this, 3)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="mobileNum2" name="mobileNum2" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="mobileNum3" name="mobileNum3" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<!-- <input id="mobileNum" name="mobileNum" class="input_s_b w100pro" placeholder="핸드폰 번호를 입력하세요." onkeyup="javascript:chkword(this, 20)" /> -->
           			</td>
           			<th scope="row"><label for="equipDate">설치일</label></th>
           			<td>
           				<input id="equipDate" name="equipDate" class="input_s_b w_date" maxlength="10"/>
           			</td>
           		</tr>

           		<tr>

           			<th scope="row"><label for="telNum1">전화번호</label></th>
           			<td>
           				<input id="telNum1" name="telNum1" class="input_s_b w30pro" onkeyup="chkword(this, 3)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="telNum2" name="telNum2" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="telNum3" name="telNum3" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<!-- <input id="telNum" name="telNum" class="input_s_b w100pro" placeholder="전화번호를 입력하세요." onkeyup="javascript:chkword(this, 20)"  /> -->
           			</td>
           			<th scope="row"><label for="storeZip">가맹점우편번호</label></th>
           			<td>
           				<input id="storeZip" name="storeZip" class="input_s_b w80pro" placeholder="가맹점우편번호를 입력하세요." readonly />
           				<button type="button" id="storeZipBtn" class="btn_white_B01">검색</button>
           			</td>
           		</tr>

           		<tr>
           			<th scope="row"><label for="storeAddr1">가맹점주소</label></th>
           			<td>
           				<input id="storeAddr1" name="storeAddr1" class="input_s_b w100pro" placeholder="가맹점주소를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>

           			<th scope="row"><label for="storeAddr2">가맹점주소(상세)</label></th>
           			<td>
           				<input id="storeAddr2" name="storeAddr2" class="input_s_b w100pro" placeholder="가맹점주소(상세)를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>
           		</tr>

           		<tr>
           			<th scope="row"><label for="companyInfoId"><span class="redstar">*</span>거래처 정보</label></th>
           			<td>
           				<select name="companyInfoId" id="companyInfoId" class="sel_basic w100pro" title="거래처 정보 선택">
							<option value="0" selected="selected">선택</option>
							<c:forEach var="item" items="${companyInfoIdList}">
								<option value="${item.companyInfoId}">${item.companyName}</option>
							</c:forEach>
						</select>
           			</td>
           			<th scope="row"><label for="useYn">사용여부</label></th>
					<td class="itemList">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="Y" prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
           		</tr>
           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoStoreListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnCreateStore" class="btn_gray_B01">저장</button>
        </div>
		<!-- 버튼 -->

	</form>

	<form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchStoreId" value='<c:out value="${storeCriteria.searchStoreId }" />'>
        <input type="hidden" name="searchStoreName" value='<c:out value="${storeCriteria.searchStoreName }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${storeCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${storeCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

        <input type="hidden" id="zipCdInputId" name="zipCdInputId" value='storeZip'>
        <input type="hidden" id="addrInputId" name="addrInputId" value='storeAddr1'>

    </form>
</section>