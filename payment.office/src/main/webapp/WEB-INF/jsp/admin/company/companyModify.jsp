<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/companyModify_JS.jsp"%>
<!--
  * @Class Name  : companyCreatePage.jsp
  * @Description : 고객사 작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.11.21	    이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">고객사 수정</h3>
       	<table id="templateProject" class="tb_left_st2" summary="고객사 수정">

       		<input type="hidden"  id="companyInfoId" name="companyInfoId" value="${result.company.companyInfoId}"/>
       		<input type="hidden"  id="searchCompanyId" name="searchCompanyId" value='<c:out value="${companyCriteria.searchCompanyId }" />'>
        	<input type="hidden"  id="searchCompanyName" name="searchCompanyName" value='<c:out value="${companyCriteria.searchCompanyName }" />'>

           <caption>
               거래처 수정
           </caption>
           <colgroup>
               <col width="20%" />
               <col width="30" />
               <col width="20%" />
               <col width="30%" />
           </colgroup>
           <tbody>
           		<tr>
                    <th scope="row">사업자 구분</th>
                    <td colspan="3">
                            <c:if test="${result.company.businessType == 'corporate'}">
                                법인
                            </c:if>
                            <c:if test="${result.company.businessType == 'personal'}">
                                개인
                            </c:if>
                    </td>
           		</tr>

                <tr>
                    <th scope="row">사업자번호</th>
                    <c:set var = "bizRegNumBuf" value="${fn:split(result.company.bizRegNum,'-') }"></c:set>
                    <c:set var = "bizRegNum1" value="${bizRegNumBuf[0] }"></c:set>
                    <c:set var = "bizRegNum2" value="${bizRegNumBuf[1] }"></c:set>
                    <c:set var = "bizRegNum3" value="${bizRegNumBuf[2] }"></c:set>
                    <td style="white-space:nowrap;" colspan="3">
                        ${bizRegNum1} - ${bizRegNum2} - ${bizRegNum3}
                    </td>
                </tr>

                <tr>
                    <th scope="row">
                        <c:if test="${result.company.businessType == 'corporate'}">
                            법인 등록번호
                        </c:if>
                        <c:if test="${result.company.businessType == 'personal'}">
                            생년월일
                        </c:if>
                    </th>
                    <c:set var = "corpNumBuf" value="${fn:split(result.company.corpNum,'-') }"></c:set>
                    <c:set var = "corpNum1" value="${corpNumBuf[0] }"></c:set>
                    <c:set var = "corpNum2" value="${corpNumBuf[1] }"></c:set>
                    <td colspan="3">
                        ${corpNum1} - ${corpNum2}
                    </td>

                </tr>

                <tr>
                    <th scope="row"><label for="companyName"><span class="redstar">*</span>회사명</label></th>
                    <td>
                        <input id="companyName" name="companyName" class="input_s_b w100pro" value="${result.company.companyName}"
                               placeholder="거래처명을 입력하세요." onkeyup="javascript:chkword(this, 30)"  />
                    </td>
                    <th scope="row"><label for="ceoName"><span class="redstar">*</span>대표자명</label></th>
                    <td>
                        <input id="ceoName" name="ceoName" class="input_s_b w100pro" value="${result.company.ceoName}"
                               placeholder="대표자명을 입력하세요." onkeyup="javascript:chkword(this, 30)"/>
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="companyZip">사업장우편번호</label></th>
                    <td colspan="3">
                        <input id="companyZip" name="companyZip" class="input_s_b w80pro" readonly
                               onclick="fn_searchZipCode()" value="${result.company.companyZip}" />
                        <button type="button" id="storeZipBtn" class="btn_white_B01">검색</button>
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="companyAddr1">사업장주소</label></th>
                    <td>
                        <input id="companyAddr1" name="companyAddr1" class="input_s_b w100pro" value="${result.company.companyAddr1}"
                               placeholder="사업장주소를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
                    </td>

                    <th scope="row"><label for="companyAddr2"><span class="redstar">*</span>사업주소(상세)</label></th>
                    <td>
                        <input id="companyAddr2" name="companyAddr2" class="input_s_b w100pro" value="${result.company.companyAddr2}"
                               placeholder="사업장 상세주소를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="bizCond">업태</label></th>
                    <td>
                        <input id="bizCond" name="bizCond" class="input_s_b w100pro" placeholder="업태를 입력하세요."
                               onkeyup="javascript:chkword(this, 30)" value="${result.company.bizCond}" />
                    </td>

                    <th scope="row"><label for="bizType">종목</label></th>
                    <td>
                        <input id="bizType" name="bizType" class="input_s_b w100pro" value="${result.company.bizType}"
                               placeholder="종목을 입력하세요." onkeyup="javascript:chkword(this, 100)" />
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="telNum1">대표번호</label></th>
                    <c:set var = "telNumBuf" value="${fn:split(result.company.telNum,'-') }"></c:set>
                    <c:set var = "telNum1" value="${telNumBuf[0] }"></c:set>
                    <c:set var = "telNum2" value="${telNumBuf[1] }"></c:set>
                    <c:set var = "telNum3" value="${telNumBuf[2] }"></c:set>
                    <td colspan="3">
                        <input id="telNum1" name="telNum1" class="input_s_b w10pro" onkeyup="chkword(this, 3, 'telNum2')"
                               value="${telNum1}" numberOnly/>
                        <label class="w5pro"> - </label>
                        <input id="telNum2" name="telNum2" class="input_s_b w10pro" onkeyup="chkword(this, 4, 'telNum3')"
                               value="${telNum2}" numberOnly/>
                        <label class="w5pro"> - </label>
                        <input id="telNum3" name="telNum3" class="input_s_b w10pro" onkeyup="chkword(this, 4)"
                               value="${telNum3}" numberOnly/>
                        <input type="hidden" id="telNum" name="telNum">
                    </td>
                </tr>

                <tr>
                    <th scope="row">홈페이지</th>
                    <td colspan="3">
                        <input type="text" class="input_s_b w100pro" id="homepageUrl" name="homepageUrl" onkeyup="chkword(this, 200)"
                            <c:choose>
                                <c:when test="${result.company.homepageUrl eq null or result.company.homepageUrl eq '' }">value="http://"</c:when>
                                <c:otherwise>value="${result.company.homepageUrl}"</c:otherwise>
                            </c:choose> >
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="paymentType"><span class="redstar">*</span>결제타입</label></th>
                    <td>
                        <select name="paymentType" id="paymentType" class="sel_basic w100pro" title="결제타입">
                            <option value="" <c:if test="${'' eq result.company.paymentType}">selected="selected"</c:if>>선택</option>
                            <option value="EASY_PAY" <c:if test="${'EASY_PAY' eq result.company.paymentType}">selected="selected"</c:if>>간편결제</option>
                            <option value="MPOS_PAY" <c:if test="${'MPOS_PAY' eq result.company.paymentType}">selected="selected"</c:if>>mPos</option>
                            <option value="ALL" <c:if test="${'ALL' eq result.company.paymentType}">selected="selected"</c:if>>mPos+간편결제</option>
                        </select>
                    </td>
                    <th scope="row">
                        <label for="partnerInfoId"><span class="redstar">*</span>제휴사정보 ID</label>
                    </th>
                    <td>
                        <select name="partnerInfoId" id="partnerInfoId" class="sel_basic w100pro" title="제휴사 선택">
                            <option value="" selected="selected">선택</option>
                            <c:forEach var="item" items="${partnerInfoIdList}">
                                <option value="${item.partnerInfoId}" <c:if test="${item.partnerInfoId eq result.company.partnerInfoId}">selected="selected"</c:if>>${item.partnerName}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

           		<tr>
           			<th scope="row">
						<label for="useYn">사용여부</label>
					</th>
					<td colspan="3" class="itemList">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="${result.company.useYn}" prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
           		</tr>

           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoCompanyListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnGoCompanyPreviousPage" class="btn_white_B01" onclick="javascript:history.back();">취소</button>
            <button type="button" id="btnModifyCompany" class="btn_gray_B01">수정완료</button>
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