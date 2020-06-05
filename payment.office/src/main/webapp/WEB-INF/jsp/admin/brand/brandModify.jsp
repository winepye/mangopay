<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/brandModify_JS.jsp"%>
<!--
  * @Class Name  : brandCreatePage.jsp
  * @Description : 브랜드 작성화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.11.21	    이인희      최초 생성
-->
<section id="detail_contents">
	<form id = "frm" name = "frm" method="post">
		<h3 class="h2_table_title">브랜드 수정</h3>
       	<table id="templateProject" class="tb_left_st2" summary="브랜드 수정">

       		<input type="hidden"  id="brandInfoId" name="brandInfoId" value="${result.brandInfoId}"/>
            <!-- 검색폼 -->
            <input type="hidden" name="searchCompanyName" value='<c:out value="${brandCriteria.searchCompanyName }" />'>
            <input type="hidden" name="searchBrandName" value='<c:out value="${brandCriteria.searchBrandName }" />'>
            <input type="hidden" name="searchBizType" value='<c:out value="${brandCriteria.searchBizType }" />'>
            <input type="hidden" name="searchState" value='<c:out value="${brandCriteria.searchState }" />'>
            <input type="hidden" name="searchType" value='<c:out value="${brandCriteria.searchType }" />'>
            <input type="hidden" name="searchSdate" value='<c:out value="${brandCriteria.searchSdate }" />'>
            <input type="hidden" name="searchEdate" value='<c:out value="${brandCriteria.searchEdate }" />'>

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
               <th scope="row"><label for="companyInfoId"><span class="redstar">*</span>브랜드 명</label></th>
               <td colspan="3">
                   <select name="companyInfoId" id="companyInfoId" class="sel_basic w50pro" title="브랜드 선택">
                       <option value="" selected="selected">선택</option>
                       <c:forEach var="item" items="${companyList}">
                           <option value="${item.data}" <c:if test="${item.data eq result.companyInfoId}">selected="selected"</c:if> >${item.label}</option>
                       </c:forEach>
                   </select>
               </td>
           </tr>

           <tr>
               <th scope="row"><label for="brandName"><span class="redstar">*</span>브랜드 명</label></th>
               <td colspan="3">
                   <input type="text" id="brandName" name="brandName" class="input_s_b w100pro" value="${result.brandName}" />
               </td>
           </tr>

           <tr>
               <%-- FIXME: 2018-12-18 엄종(상) 수정 --%>
               <th scope="row">
                   <label for="bizTypeParent"><span class="redstar">*</span>업종(상위)</label>
               </th>
               <td>
                   <select name="bizTypeParent" id="bizTypeParent" class="sel_basic w100pro" title="거래처정보 선택"
                           onchange="fn_changeBizTypeId()">
                       <option value="0" selected="selected">선택하세요.</option>
                       <c:forEach var="item" items="${bizTypeParentList}">
                           <option value="${item.data}" <c:if test="${item.data eq result.bizTypeParent}">selected="selected"</c:if> >${item.label}</option>
                       </c:forEach>
                   </select>
               </td>
               <th scope="row">
                   <label for="bizType"><span class="redstar">*</span>업종(하위)</label>
               </th>
               <td>
                   <select name="bizType" id="bizType" class="sel_basic w100pro" title="가맹점 선택">
                       <option value="0" selected="selected">선택하세요.</option>
                       <c:forEach var="item" items="${bizTypeList}">
                           <option value="${item.data}" <c:if test="${item.data eq result.bizType}">selected="selected"</c:if> >${item.label}</option>
                       </c:forEach>
                   </select>
               </td>
           </tr>

           <tr>
               <th scope="row">매장구분</th>
               <td colspan="3">
                        <span class=radio_list>
                            <label for="shopPayType1"><input type="radio" id="shopPayType1" name="shopPayType"
                                                             value="AFTER" <c:if test="${result.shopPayType eq 'AFTER'}">checked</c:if> > 선불</label>
                        </span>
                   <span class=radio_list>
                            <label for="shopPayType2"><input type="radio" id="shopPayType2" name="shopPayType"
                                                             value="BEFORE" <c:if test="${result.shopPayType eq 'BEFORE'}">checked</c:if> > 후불</label>
                        </span>
               </td>
           </tr>

           <tr>
               <th scope="row"><label for="telNum1">대표번호</label></th>
               <c:set var = "telNumBuf" value="${fn:split(result.telNum,'-') }"></c:set>
               <c:set var = "telNum1" value="${telNumBuf[0] }"></c:set>
               <c:set var = "telNum2" value="${telNumBuf[1] }"></c:set>
               <c:set var = "telNum3" value="${telNumBuf[2] }"></c:set>
               <td>
                   <input type="txt" id="telNum1" name="telNum1" value="${telNum1}" class="input_s_b w30pro" onkeyup="chkword(this, 3, 'telNum2')" numberOnly/>
                   <label class="w5pro"> - </label>
                   <input type="txt" id="telNum2" name="telNum2" value="${telNum2}" class="input_s_b w30pro" onkeyup="chkword(this, 4, 'telNum3')" numberOnly/>
                   <label class="w5pro"> - </label>
                   <input type="txt" id="telNum3" name="telNum3" value="${telNum3}" class="input_s_b w30pro" onkeyup="chkword(this, 4)" numberOnly/>
                   <input type="hidden" id="telNum" name="telNum">
               </td>
               <th scope="row">담당자</th>
               <td><input type="text" id="personCharge" name="personCharge" value="${result.personCharge}" class="input_s_b w100pro" /></td>
           </tr>

           		<tr>
           			<th scope="row">
						<label for="useYn">사용여부</label>
					</th>
					<td colspan="3" class="itemList">
                         <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="${result.useYn}" prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
           		</tr>

           </tbody>
       </table>

		<!-- 버튼 -->
		<div class="bs_BtnBox_c">
            <button type="button" id="btnGoBrandListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnGoBrandPreviousPage" class="btn_white_B01" onclick="javascript:history.back();">취소</button>
            <button type="button" id="btnModifyBrand" class="btn_gray_B01">수정완료</button>
        </div>
		<!-- 버튼 -->

	</form>

	<form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchCompanyName" value='<c:out value="${brandCriteria.searchCompanyName }" />'>
        <input type="hidden" name="searchBrandName" value='<c:out value="${brandCriteria.searchBrandName }" />'>
        <input type="hidden" name="searchBizType" value='<c:out value="${brandCriteria.searchBizType }" />'>
        <input type="hidden" name="searchState" value='<c:out value="${brandCriteria.searchState }" />'>
        <input type="hidden" name="searchType" value='<c:out value="${brandCriteria.searchType }" />'>
        <input type="hidden" name="searchSdate" value='<c:out value="${brandCriteria.searchSdate }" />'>
        <input type="hidden" name="searchEdate" value='<c:out value="${brandCriteria.searchEdate }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${brandCriteria.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${brandCriteria.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
    </form>

</section>