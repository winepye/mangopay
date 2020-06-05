<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<section id="detail_contents">
    <form id = "frm" name = "frm" method="post">
        <h3 class="h2_table_title">MPOS 버전 수정</h3>
        <table id="templateProject" class="tb_left_st2" summary="MPOS 버전 수정">

            <caption>
                MPOS 버전 수정
            </caption>
            <colgroup>
                <col width="20%" />
                <col width="30" />
                <col width="20%" />
                <col width="30%" />
            </colgroup>
            <tbody>

                <tr>
                    <th scope="row"><label for="mobileType"><span class="redstar">*</span>모바일타입</label></th>
                    <td>
                        <customTagUi:code type="radio" cdGrp="MOBILE_TYPE" name="mobileType" id="mobileType"
                                          cd="ANDROID"
                                          prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
                    <th scope="row"><label for="appName"><span class="redstar">*</span>APP명</label></th>
                    <td>
                        <input type="text" class="input_s_b w100pro" name="appName" id="appName" onkeyup="chkword(this, 100)">
                    </td>

                </tr>

                <tr>
                    <th scope="row"><label for="appUpdateMethod"><span class="redstar">*</span>APP 업데이트방식</label></th>
                    <td>
                        <customTagUi:code type="radio" cdGrp="APP_UPDATE_METHOD" name="appUpdateMethod" id="appUpdateMethod" cd="ALARM"
                                          prefix="<span class=radio_list>" postfix="</span>"/>
                    </td>
                    <th scope="row"><label for="appVersion"><span class="redstar">*</span>버전</label></th>
                    <td>
                        <input type="text" class="input_s_b w100pro" id="appVersion" name="appVersion" onkeyup="chkword(this, 20)" >
                    </td>
                </tr>

                <tr>
                    <th scope="row"><label for="packageName"><span class="redstar">*</span>패키지명</label></th>
                    <td>
                        <input type="text" class="input_s_b w100pro" id="packageName" name="packageName" onkeyup="chkword(this, 255)">
                    </td>
                    <th scope="row"><label for="updateLink"><span class="redstar">*</span>업데이트링크</label></th>
                    <td>
                        <input type="text" class="input_s_b w100pro" id="updateLink" name="updateLink" onkeyup="chkword(this, 255)">
                    </td>
                </tr>

            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <button type="button" id="btnGoListPage" class="btn_white_B01">목록</button>
            <button type="button" id="btnCreate" class="btn_gray_B01">저장</button>
        </div>
        <!-- 버튼 -->

        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchAppName" value='<c:out value="${search.searchAppName }" />'>
        <input type="hidden" name="searchType" value='<c:out value="${search.searchType }" />'>
        <input type="hidden" name="searchSdate" value='<c:out value="${search.searchSdate }" />'>
        <input type="hidden" name="searchEdate" value='<c:out value="${search.searchEdate }" />'>


        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${search.currentPageNo }" />'>
        <input type="hidden" name="sortOrder" value='<c:out value="${search.sortOrder }" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->

        <input type="hidden" id="appVersionId" name="appVersionId" value="${result.appVersionId}">

    </form>

</section>

<%@ include file="js/mposAppCreate_JS.jsp"%>