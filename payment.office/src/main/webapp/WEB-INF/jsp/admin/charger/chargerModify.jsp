<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/daumEditorHeader.jsp"%>
<%@ include file="./js/chargerModify_JS.jsp"%>
<!--
  * @Class Name  : chargerCreatePage.jsp
  * @Description : 담당자작성화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<input type="hidden" name = chargerInfoId value='<c:out value="${result.chargerInfoId }" />'>
		<h3 class="h2_table_title">담당자 수정</h3>
       	<table id="templateProject" class="tb_left_st2" summary="담당자 등록, 제목, 공지유형, 내용, 노출여부">
           <caption>
               담당자 수정
           </caption>
           <colgroup>
               <col width="15%" />
               <col width="35%" />
               <col width="15%" />
               <col width="35%" />
           </colgroup>
           <tbody>
               <tr>
                   <th scope="row">
                   		<label for="title"><span class="redstar">*</span>담당자유형</label>
                   </th>
                   <td colspan="3">
                   		<customTagUi:code type="select" cdGrp="CHARGER_TYPE" cd="${result.chargerType}" name="chargerType" id="chargerType"
                   		attr='class="sel_basic w200px"' subjectText="선택" />
                   </td>
               </tr>
               <tr>
                   <th scope="row">
                   		<label for="title">서비스제공자</label>
                   </th>
                   <td>
                   		<customTagUi:code type="select" cdGrp="SERVICE_PROVIDER" cd="${result.serviceProvider}"  name="serviceProvider" id="serviceProvider" attr='class="sel_basic w200px"' subjectText="선택"/>
                   </td>
                   <th scope="row">
                   		<label for="categCd">고객사</th>
                   <td>
                       <select name="companyInfoId" id="companyInfoId" class="sel_basic w100pro" title="거래처정보 선택" onchange="javascript:fn_changeCompanyId()">
							<option value="0" selected="selected">선택</option>
							<c:forEach var="item" items="${companyInfoList}">
								<option value="${item.companyInfoId}" <c:if test="${item.companyInfoId eq result.companyInfoId}">selected="selected"</c:if>>${item.companyName}</option>
							</c:forEach>
						</select>
                   </td>
               </tr>
               <tr>
                   <th scope="row">
                   		<label for="title">브랜드</label>
                   </th>
                   <td>
                   		<select name="brandInfoId" id="brandInfoId" class="sel_basic w100pro" title="거래처정보 선택" onchange="javascript:fn_changeBrandId()">
							<option value="0" selected="selected">선택</option>
						</select>
                   </td>
                   <th scope="row">
                   		<label for="categCd">매장</th>
                   <td>
                        <select name="shopInfoId" id="shopInfoId" class="sel_basic w100pro" title="거래처정보 선택" >
							<option value="0" selected="selected">선택</option>
						</select>
                   </td>
               </tr>
               <tr>
           			<th scope="row"><label for="chargerName"><span class="redstar">*</span>담당자명</label></th>
           			<td>
           				<input id="chargerName" name="chargerName" value="${result.chargerName }" class="input_s_b w100pro" placeholder="담당자명을 입력하세요." onkeyup="javascript:chkword(this, 30)" />
           			</td>

           			<th scope="row"><label for="mobileNum1"><span class="redstar">*</span>모바일번호</label></th>
           			<c:set var = "mobileNumBuf" value="${fn:split(result.mobileNum,'-') }"></c:set>
                    <c:set var = "mobileNum1" value="${mobileNumBuf[0] }"></c:set>
                    <c:set var = "mobileNum2" value="${mobileNumBuf[1] }"></c:set>
                    <c:set var = "mobileNum3" value="${mobileNumBuf[2] }"></c:set>
           			<td>
           				<input id="mobileNum1" name="mobileNum1" value="${mobileNum1}" class="input_s_b w30pro" onkeyup="chkword(this, 3)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="mobileNum2" name="mobileNum2" value="${mobileNum2}" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="mobileNum3" name="mobileNum3" value="${mobileNum3}" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<input type="hidden" id="mobileNum" name="mobileNum" />
           			</td>
           		</tr>
           		<tr>
           		    <th scope="row"><label for="emailAddr">이메일</label></th>
           			<td>
           				<input id="emailAddr" name="emailAddr" value="${result.emailAddr}"  class="input_s_b w100pro" placeholder="이메일을 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>
           			<th scope="row"><label for="companyTelNum1">회사전화번호</label></th>
           			<c:set var = "companyTelNumBuf" value="${fn:split(result.companyTelNum,'-') }"></c:set>
                    <c:set var = "companyTelNum1" value="${companyTelNumBuf[0] }"></c:set>
                    <c:set var = "companyTelNum2" value="${companyTelNumBuf[1] }"></c:set>
                    <c:set var = "companyTelNum3" value="${companyTelNumBuf[2] }"></c:set>
           			<td>
           				<input id="companyTelNum1" name="companyTelNum1" value="${companyTelNum1 }" class="input_s_b w30pro" onkeyup="chkword(this, 3)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="companyTelNum2" name="companyTelNum2" value="${companyTelNum2 }" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<label class="w5pro">-</label>
           				<input id="companyTelNum3" name="companyTelNum3" value="${companyTelNum3 }" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
           				<input type="hidden" id="companyTelNum" name="companyTelNum" />
           			</td>
           		</tr>
           		<tr>
           			<th scope="row"><label for="departmentName">부서</label></th>
           			<td>
           				<input id="departmentName" name="departmentName" value="${result.departmentName}"  class="input_s_b w100pro" placeholder="부서를 입력하세요." onkeyup="javascript:chkword(this, 30)" />
           			</td>

           			<th scope="row"><label for="officialPosition">직위</label></th>
           			<td>
           				<input id="officialPosition" name="officialPosition" value="${result.officialPosition}"  class="input_s_b w100pro" placeholder="직위를 입력하세요." onkeyup="javascript:chkword(this, 30)" />
           			</td>
           		</tr>
           		<tr>
           			<th scope="row"><label for="companyZip">우편번호</label></th>
           			<td colspan="3">
           				<input id="companyZip" name="companyZip" value="${result.companyZip}" class="input_s_b w80pro" placeholder="우편번호를 입력하세요." readonly />
           				<button type="button" id="zipBtn" class="btn_white_B01">검색</button>
           			</td>
           		</tr>

           		<tr>
           			<th scope="row"><label for="companyAddr1">기본주소</label></th>
           			<td>
           				<input id="companyAddr1" name="companyAddr1" value="${result.companyAddr1}" class="input_s_b w100pro" placeholder="기본주소를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>

           			<th scope="row"><label for="companyAddr2">상세주소</label></th>
           			<td>
           				<input id="companyAddr2" name="companyAddr2" value="${result.companyAddr2}" class="input_s_b w100pro" placeholder="상세주소를 입력하세요." onkeyup="javascript:chkword(this, 100)" />
           			</td>
           		</tr>
           		<tr>
           			<th scope="row"><label for="useYn"><span class="redstar">*</span>사용여부</label></th>
					<td class="itemList" colspan="3">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="${result.useYn}"  prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
           		</tr>

           </tbody>
       </table>

        <!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <button type="button" id="btnGoChargerListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnModifyCharger" class="btn_gray_B01">저장</button>
        </div>
        <!-- 버튼 -->
	</form>
	<form id = "moveFrm" name = "moveFrm" method = "post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <%-- <input type="hidden" name = "searchContentType" value='<c:out value="${chargerCriteria.searchContentType }" />'>
        <input type="hidden" name = "searchContentText" value='<c:out value="${chargerCriteria.searchContentText }" />'>
        <input type="hidden" name = "searchBoardSeq" value='<c:out value="${chargerCriteria.searchBoardSeq }" />'>
        <input type="hidden" name = "searchOpenYn" value='<c:out value="${chargerCriteria.searchOpenYn }" />'>
        <input type="hidden" name = "searchFromDtS" value="<fmt:formatDate value="${chargerCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>">
        <input type="hidden" name = "searchToDtS" value="<fmt:formatDate value="${chargerCriteria.searchToDt}" pattern="yyyy/MM/dd"/>"> --%>
        <!-- 페이징 -->
        <input type="hidden" name = "currentPageNo" value='<c:out value="${chargerCriteria.currentPageNo }" />'>
        <input type="hidden" name = "recordCountPerPage" value='<c:out value="${chargerCriteria.recordCountPerPage }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
	</form>
</section>