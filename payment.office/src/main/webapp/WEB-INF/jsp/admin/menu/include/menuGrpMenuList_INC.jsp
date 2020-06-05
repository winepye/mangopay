<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : menuGrpMenuList_INC.jsp
  * @Description : 메뉴그룹메뉴
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.03	이인희      최초 생성
-->
<h2 class="h2_table_title mgt30"><span class="lspwide">메뉴그룹메뉴</span></h2>
<div class="clearbothWrap">
<!-- 그리드 핸들링을 위한 변수 :S -->
<c:set var = "businessTypeBuf" value=""></c:set>
<c:set var = "businessTypeRowCount" value="0"></c:set>
<div class="flblock_20">
    <div class="groupListbox">
        <input type="hidden"  name="searchBusinessTypeCdGrp" id = "searchBusinessTypeCdGrp" value="${menuCriteria.searchBusinessTypeCdGrp }"/>
        <p class="title">[업무유형선택]</p>
        <ul>
             <c:forEach var = "data" items="${searchBusinessTypeCdList }">
                <li class="menuBusinessLi" id="authMenu_${data.businessTypeCd }" onClick="fn_menuGrpMenuSelect('${data.businessTypeCd }');">
                    <customTagUi:code type="text" cdGrp="BUSINESS_TYPE_CD" name="businessTypeCd" cd="${data.businessTypeCd }" />
                </li>
		       <%--  <option value="${data.businessTypeCd }"<c:if test="${menuCriteria.searchBusinessTypeCdGrp eq data.businessTypeCd }"> selected="selected"</c:if>>
		            <customTagUi:code type="text" cdGrp="BUSINESS_TYPE_CD" name="businessTypeCd" cd="${data.businessTypeCd }" />
		        </option> --%>
		    </c:forEach>
        </ul>
    </div>
</div>
<%-- <select id = "searchBusinessTypeCdGrp" name = "searchBusinessTypeCdGrp" size="100" style="width: 20%; overflow: scroll; float: left;" onchange="fn_menuGrpMenuSelect()">
    <option value="">업무유형 선택</option>
    <c:forEach var = "data" items="${searchBusinessTypeCdList }">
        <option value="${data.businessTypeCd }"<c:if test="${menuCriteria.searchBusinessTypeCdGrp eq data.businessTypeCd }"> selected="selected"</c:if>>
            <customTagUi:code type="text" cdGrp="BUSINESS_TYPE_CD" name="businessTypeCd" cd="${data.businessTypeCd }" />
        </option>
    </c:forEach>
</select> --%>
<div class="frblock">
<!-- 그리드 핸들링을 위한 변수 :E -->
<table id="menuTable" class="tb_basic_st" summary="메뉴명, 메뉴설명, 메뉴위치, 메뉴유형코드, URL, 대표메뉴여부">
	<caption>메뉴그룹메뉴</caption>
	<colgroup>
        <col width="">
        <col width="">
        <col width="">
        <col width="">
        <col width="">
        <col width="80">
        <col width="50">
    </colgroup>
	<thead>
		 <tr>
			<th scope="col">구분(전체선택)</th>
			<th scope="col">메뉴명</th>
			<th scope="col">메뉴설명</th>
			<th scope="col">메뉴유형코드</th>
			<th scope="col">URL</th>
			<th scope="col">대표<br>메뉴</th>
			<th scope="col">선택<input type="checkbox" id="deleteBoardSeq" name='allChk' onclick="fn_menuTableAllChk();" /></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var = "data" items="${menuVo }">
			<tr class = "<c:out value='${data.businessTypeCd }'/>_tr" ">
			<c:choose>
				<c:when test="${businessTypeBuf != data.businessTypeCd}">
						<td class="text-left vt vtwrap">
							<input type="checkbox" id='<c:out value='${data.businessTypeCd }'/>_chkBox' name='<c:out value='${data.businessTypeCd }'/>_chkBox' onclick="fn_businessTypeAllChk('${data.businessTypeCd }')"/><span class="blind">전체선택</span>
	                        <customTagUi:code type="text" cdGrp="BUSINESS_TYPE_CD" name="businessTypeCd" cd="${data.businessTypeCd }" />
						</td>

					<script type="text/javascript">
						$("#${businessTypeBuf}").parent().find("td").eq(0).attr("rowspan","${businessTypeRowCount}");
					</script>
					<c:set var = "businessTypeBuf" value="${data.businessTypeCd }"></c:set>
					<c:set var = "businessTypeRowCount" value="0"></c:set>
				</c:when>
				<c:otherwise>
					<td></td>
					<c:set var = "businessTypeRowCount" value="${businessTypeRowCount+1 }"></c:set>
				</c:otherwise>
			</c:choose>
						<td class="txt_left"><a href="javascript:fn_openDetailPop('${data.menuSeq }');">${data.menuNm }</a></td>
						<td class="txt_left">${data.menuDesc }</td>
						<td class="txt_eng">${data.menuTypeCd }</td>
						<td class="txt_left">${data.menuUrl }</td>
						<td class="txt_eng">${data.representMenuYn eq 'Y' ? '예' : '아니오' }</td>
						<td>
						    <input type="hidden" name = "grpMenuListUseYn" value="${data.grpMenuListUseYn }">
			           		<input type="checkbox" name = "useMenuSeqList" value="<c:out value='${data.menuSeq }'/>" <c:if test="${data.useYn eq 'Y' }">checked="checked"</c:if>
			           		    onclick="fn_useMenuSeqChkClick($(this))"
			           		>
			          		<span class="blind">선택</span>
			             </td>
					</tr>

		</c:forEach>
		<c:if test="${fn:length(menuVo) <= 0 }">
        <tr>
            <td class="nodata" colspan="8">조회된 데이터가 없습니다.</td>
        </tr>
        </c:if>
	</tbody>
</table>
</div>

</div>

<!-- 버튼 -->
<div class="bs_BtnBox_c">
    <button type="button" id="btnCreate" onclick="fn_doSaveMenuList()" class="btn_blue_B02">저장</button>
</div>
<!-- 버튼 -->