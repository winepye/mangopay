<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./js/smsSend_JS.jsp" %>

<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<form id = "frm" name = "frm" method="post">
    <section id="contents">
        <table class="board_regist_st01 mgt40">
            <caption>sms발송</caption>
            <colgroup>
                <col width="12.5%" />
                <col width="*" />
                <col width="12%" />
                <col width="35%" />
            </colgroup>
            <tr>
                <th scope="row">타입</th>
                <td colspan="3">
                    <input type="radio" id = "sendType" name = "sendType" value="3" checked="checked">단문
                    <input type="radio" id = "sendType" name = "sendType" value="5" >LMS(장문문자)
                    <input type="radio" id = "sendType" name = "sendType" value="6" >MMS(Image포함문자)
                </td>

            </tr>
            <tr>
                <th scope="row">보내는사람</th>
                <td>025865981</td>
                <th scope="row">받는사람</th>
                <td><input type="text" class="input_s_b w100pro" id="toNumber" name = "toNumber"/>숫자만입력</td>
            </tr>
            <tr>
                <th scope="row"><label for="IDNAME06">내용<span class="point_red">*</span></label></th>
                <td colspan="3" class="conEditor"><textarea class="regist_edit_st01" id="contents" name = "contents" placeholder="내용을 입력해주세요" title="리포트내용 입력"></textarea></td>
            </tr>
        </table>
        <!--//공지사항등록//-->
        <div class="bs_BtnBox_c">
            <button type="button" class="btn_blue_B01 mgl10" onclick="fn_sendSms()">SEND</button>
        </div>

    </section>
</form>