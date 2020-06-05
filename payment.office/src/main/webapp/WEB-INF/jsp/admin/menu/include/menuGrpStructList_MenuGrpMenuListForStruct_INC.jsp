<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : menuGrpMenuList_INC.jsp
  * @Description : 메뉴그룹메뉴
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.03    이인희      최초 생성
-->
<!-- 그리드 핸들링을 위한 변수 :S -->
<c:set var="businessTypeBuf" value=""></c:set>
<c:set var="businessTypeRowCount" value="0"></c:set>

<!-- 그리드 핸들링을 위한 변수 :E -->
<h3 class="h3_table_title mgt25"><span>메뉴</span><span class="f12 fnormal mgl15 point_red">* 선택 불가능한 메뉴는 이미 사용중인 메뉴입니다. </span></h3>
<div class="bs_BtnBox_r">
    <button type="button" class="btn_gray_s01" onclick="fn_doSaveMenuList()">저장</button>
</div>
<table id="SGridTarget" class="tb_basic_st" summary="메뉴명, 메뉴설명, 메뉴위치, 메뉴유형코드, URL, 대표메뉴여부">
    <caption>메뉴그룹메뉴</caption>
    <colgroup>
        <col width="150px" />
        <col width="100px" />
        <col width="200px" />
        <col width="100px" />
        <col width="100px" />
        <col width="250px" />
        <col width="100px" />
    </colgroup>
    <thead>
        <tr>
            <th scope="col">구분</th>
            <th scope="col">메뉴명</th>
            <th scope="col">메뉴설명</th>
            <th scope="col">메뉴위치</th>
            <th scope="col">메뉴유형</th>
            <th scope="col">URL</th>
            <th scope="col">선택</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="data" items="${menuVo }">
            <tr class="${data.businessTypeCd }_tr">
                <c:choose>
                    <c:when test="${businessTypeBuf != data.businessTypeCd}">
                        <td  class="txt_left">
                            <customTagUi:code type="text" cdGrp="BUSINESS_TYPE_CD" name="" cd="${data.businessTypeCd }" /><%-- <a href="javascript:fn_toggleMenu('${data.businessTypeCd }')" id="${data.businessTypeCd }_sort" class="sort_lowtohigh">&nbsp;<em>오름차순</em></a> --%>
                            <!-- </td><td></td><td></td><td></td><td></td><td></td><td></td> --> <!-- <td> -->
                            <%-- <input type="checkbox" id='${data.businessTypeCd }_chkBox' name='${data.businessTypeCd }_chkBox' onclick="fn_businessTypeAllChk('${data.businessTypeCd }')" /><span class="blind">전체선택</span> --%>
                        </td>
                        <!-- </tr> -->
                        <script type="text/javascript">
                            $("#${businessTypeBuf}").parent().find("td").eq(0).attr("rowspan", "${businessTypeRowCount}");
                        </script>
                        <c:set var="businessTypeBuf" value="${data.businessTypeCd }"></c:set>
                        <c:set var="businessTypeRowCount" value="0"></c:set>
                    </c:when>
                    <c:otherwise>
                        <td></td>
                        <c:set var="businessTypeRowCount" value="${businessTypeRowCount+1 }"></c:set>
                    </c:otherwise>
                </c:choose>
                <!-- <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;┗</td> -->
                <td class="txt_left">${data.menuNm }</td>
                <td class="txt_left">${data.menuDesc }</td>
                <td class="txt_eng"><customTagUi:code type="text" cdGrp="MENU_LOCATION_CD" name="" cd="${data.menuLocationCd }" /></td>
                <td><customTagUi:code type="text" cdGrp="MENU_TYPE_CD" name="" cd="${data.menuTypeCd }" /></td>
                <td class="txt_awrap">${data.menuUrl }</td>
                <td><input type="checkbox" name="useMenuSeqList" value="<c:out value='${data.menuSeq }'/>_<c:out value='${data.menuNm }'/>_|<c:out value='${data.businessTypeCd }'/>"
                                <c:forEach var = "child" items="${childList }">
                                    <c:if test = "${child eq  data.menuSeq}">
                                        checked="checked"
                                    </c:if>
                                </c:forEach>> <span class="blind">선택</span></td>
            </tr>

        </c:forEach>
        <c:forEach var = "data" items="${unableList }">
            <script type="text/javascript">
            $("input[name='useMenuSeqList']").each(function(){
            	if($(this).val().indexOf("${data}")==0){
            		$(this).attr("disabled","disabled");
            	}
            })
            </script>
        </c:forEach>
        <c:if test="${fn:length(menuVo) <= 0 }">
        <tr>
            <td class="nodata" colspan="7">조회된 데이터가 없습니다.</td>
        </tr>
        </c:if>
    </tbody>
</table>