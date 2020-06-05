<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/companyCreate_JS.jsp"%>
<!--
  * @Class Name  : companyCreatePage.jsp
  * @Description : 고객사등록 작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.11.19	    이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">고객사 등록</h3>
       	<table id="templateProject" class="tb_left_st2" summary="고객사 등록">
           <caption>
               고객사 등록
           </caption>
           <colgroup>
               <col width="20%" />
               <col width="30" />
               <col width="20%" />
               <col width="30%" />
           </colgroup>
           <tbody>
                <tr>
                    <th scope="row"><label for="btCorp"><span class="redstar">*</span>사업자 구분</label></th>
                    <td colspan="3" class="itemList">
                        <span class=radio_list>
                            <label for="btCorp"><input type="radio" id="btCorp" name="businessType"
                                                       value="corporate" checked> 법인</label>
                        </span>
                        <span class=radio_list>
                            <label for="btPer"><input type="radio" id="btPer" name="businessType"
                                                      value="personal"> 개인</label>
                        </span>
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="bizRegNum1"><span class="redstar">*</span>사업자번호</label></th>
                    <td style="white-space:nowrap;">
                        <input id="bizRegNum1" name="bizRegNum1" class="input_s_b w30pro"
                               onkeyup="javascript:chkword(this, 3, 'bizRegNum2')" numberOnly/>
                        <label class="w5pro">-</label>
                        <input id="bizRegNum2" name="bizRegNum2" class="input_s_b w20pro"
                               onkeyup="javascript:chkword(this, 2, 'bizRegNum3')" numberOnly/>
                        <label class="w5pro">-</label>
                        <input id="bizRegNum3" name="bizRegNum3" class="input_s_b w40pro"
                               onkeyup="javascript:chkword(this, 5)" numberOnly/>
                        <input type="hidden" name="bizRegNum" id="bizRegNum">

                        <%--<button type="button" class="btn_gray_B01" onclick="checkDuple()">중복확인</button>--%>

                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="corpNum1">법인 등록번호</label></th>
                    <td>
                        <input id="corpNum1" name="corpNum1" class="input_s_b w60pro"
                               onkeyup="javascript:chkword(this, 6, 'corpNum2')" numberOnly/>
                        <label class="w5pro">-</label>
                        <input id="corpNum2" name="corpNum2" class="input_s_b w40pro"
                               onkeyup="javascript:chkword(this, 7)" numberOnly/>
                        <input type="hidden" id="corpNum" name="corpNum">
                    </td>

                    <th scope="row"><label for="ceoName"><span class="redstar">*</span>대표자명</label></th>
                    <td>
                        <input id="ceoName" name="ceoName" class="input_s_b w100pro"
                               placeholder="대표자명을 입력하세요." onkeyup="javascript:chkword(this, 30)"/>
                    </td>
                </tr>


                <tr>
                    <th scope="row"><label for="companyName"><span class="redstar">*</span>회사명</label></th>
                    <td colspan="3">
                        <input id="companyName" name="companyName" class="input_s_b w50pro"
                               placeholder="거래처명을 입력하세요." onkeyup="javascript:chkword(this, 30)"  />
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="companyZip">사업장우편번호</label></th>
                    <td colspan="3">
                        <input id="companyZip" name="companyZip" class="input_s_b w80pro" readonly
                               onclick="fn_searchZipCode()" />
                        <button type="button" id="storeZipBtn" class="btn_white_B01">검색</button>
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="companyAddr1">사업장주소</label></th>
                    <td>
                        <input id="companyAddr1" name="companyAddr1" class="input_s_b w100pro"
                               placeholder="사업장주소를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
                    </td>

                    <th scope="row"><label for="companyAddr2">사업주소(상세)</label></th>
                    <td>
                        <input id="companyAddr2" name="companyAddr2" class="input_s_b w100pro"
                               placeholder="사업장 상세주소를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="bizCond">업태</label></th>
                    <td>
                        <input id="bizCond" name="bizCond" class="input_s_b w100pro" placeholder="업태를 입력하세요."
                               onkeyup="javascript:chkword(this, 30)" />
                    </td>

                    <th scope="row"><label for="bizType">종목</label></th>
                    <td>
                        <input id="bizType" name="bizType" class="input_s_b w100pro"
                               placeholder="종목을 입력하세요." onkeyup="javascript:chkword(this, 100)" />
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="telNum1">대표번호</label></th>
                    <td colspan="3">
                        <input id="telNum1" name="telNum1" class="input_s_b w10pro" onkeyup="chkword(this, 3, 'telNum2')" numberOnly/>
                        <label class="w5pro"> - </label>
                        <input id="telNum2" name="telNum2" class="input_s_b w10pro" onkeyup="chkword(this, 4, 'telNum3')" numberOnly/>
                        <label class="w5pro"> - </label>
                        <input id="telNum3" name="telNum3" class="input_s_b w10pro" onkeyup="chkword(this, 4)" numberOnly/>
                        <input type="hidden" id="telNum" name="telNum">
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="paymentType"><span class="redstar">*</span>결제타입</label></th>
                    <td>
                        <select name="paymentType" id="paymentType" class="sel_basic w100pro" title="결제타입">
                            <option value="" selected="selected">선택</option>
                            <option value="EASY_PAY">간편결제</option>
                            <option value="MPOS_PAY">mPos</option>
                            <option value="ALL">mPos+간편결제</option>
                        </select>
                    </td>
                    <th scope="row"><label for="partnerInfoId"><span class="redstar">*</span>제휴사정보ID</label></th>
                    <td>
                        <select name="partnerInfoId" id="partnerInfoId" class="sel_basic w100pro" title="제휴사 선택">
                            <option value="" selected="selected">선택</option>
                            <c:forEach var="item" items="${partnerInfoIdList}">
                                <option value="${item.partnerInfoId}">${item.partnerName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

           		<%--
           		<tr>
           			<th scope="row"><label for="partnerInfoId"><span class="redstar">*</span>제휴사정보 ID</label></th>
           			<td colspan="3">
           				<select name="partnerInfoId" id="partnerInfoId" class="sel_basic w100pro" title="제휴사 선택">
							<option value="0" selected="selected">선택</option>
							<c:forEach var="item" items="${partnerInfoIdList}">
								<option value="${item.partnerInfoId}">${item.partnerName}</option>
							</c:forEach>
						</select>
           			</td>
           		</tr>
           		<tr>
           			<th scope="row"><label for="useYn"><span class="redstar">*</span>사용여부</label></th>
					<td colspan="3" class="itemList">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="Y"
                                           prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
           		</tr>
           		--%>
           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoCompanyListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnCreateCompany" class="btn_gray_B01">저장</button>
        </div>
		<!-- 버튼 -->

	</form>

	<form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchCompanyId" value='<c:out value="${companyCriteria.searchCompanyId }" />'>
        <input type="hidden" name="searchCompanyName" value='<c:out value="${companyCriteria.searchCompanyName }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${companyCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${companyCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
    </form>
</section>