<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./js/emailSend_JS.jsp" %>

<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<form id = "frm" name = "frm" method="post">
    <section id="contents">
        <table class="board_regist_st01 mgt40">
            <caption>이메일발송</caption>
            <colgroup>
                <col width="12.5%" />
                <col width="*" />
                <col width="12%" />
                <col width="35%" />
            </colgroup>
            <tr>
                <th scope="row">제목</th>
                <td colspan="3">
                    <input type="text" class="input_s_b w100pro" id="title" name = "title"/>
                </td>

            </tr>
            <tr>
                <th scope="row">받는사람계정(보내는사람은 프로퍼티에서 계정관리)</th>
                <td><input type="text" class="input_s_b w100pro" id="emailAccount" name = "emailAccount" /></td>
                <th scope="row">이름</th>
                <td><input type="text" class="input_s_b w100pro" id="name" name = "name"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="IDNAME06">내용<span class="point_red">*</span></label></th>
                <td colspan="3" class="conEditor"><textarea class="regist_edit_st01" id="contents" name = "contents" placeholder="내용을 입력해주세요" title="리포트내용 입력"></textarea></td>
            </tr>
        </table>
        <!--//공지사항등록//-->
        <div class="bs_BtnBox_c">
            <button type="button" class="btn_blue_B01 mgl10" onclick="fn_sendEmail()">SEND</button>
        </div>

    </section>
</form>