<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="js/mposAppDetail_JS.jsp"%>
<!--
  * @Class Name  : mposAppDetail.jsp
  * @Description : MPOS 버전관리 상세
  * @Modification Information
  * @
  * @ 수정일             수정자      수정내용
  * @ 2018.12.27   	   이인희      최초 생성
-->
<section id="detail_contents">

    <form id="frm" name="frm" method="post">
        <!-- 탭별 페이징 구분을 위한 히든값 -->
        <input type="hidden" id="currentPageNo" name = "currentPageNo" value="1">

        <h3 class="h2_table_title">MPOS 버전 정보</h3>
        <table id="templateProject" class="tb_left_st2" summary="MPOS 버전 정보">
            <caption>MPOS 버전 정보</caption>
            <colgroup>
                <col width="20%" />
                <col width="30%" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">모바일타입</th>
                    <td><c:out value="${result.mobileTypeNm}" /></td>
                    <th scope="row">APP명</th>
                    <td><c:out value="${result.appName}" /></td>
                </tr>

                <tr>
                    <th scope="row">APP 업데이트방식</th>
                    <td><c:out value="${result.appUpdateMethodNm}" /></td>
                    <th scope="row">패키지명</th>
                    <td><c:out value="${result.packageName}" /></td>

                </tr>

                <tr>
                    <th scope="row">버전</th>
                    <td colspan="3">
                        <c:out value="${result.appVersion}" />
                    </td>
                </tr>
            </tbody>
        </table>
    </form>

    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchAppName" value='<c:out value="${search.searchAppName }" />'>
        <input type="hidden" name="searchType" value='<c:out value="${search.searchType }" />'>
        <input type="hidden" name="searchSdate" value='<c:out value="${search.searchSdate }" />'>
        <input type="hidden" name="searchEdate" value='<c:out value="${search.searchEdate }" />'>

        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${search.currentPageNo }" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${search.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

        <input type="hidden" value="${result.appVersionId}" name="appVersionId">

    </form>

    <div class="bs_BtnBox_c">
	    <button type="button" id="btnGoListPage" class="btn_white_B01">목록</button>
	    <button type="button" id="btnGoModifyPage" class="btn_gray_B01">수정</button>
	</div>
</section>

