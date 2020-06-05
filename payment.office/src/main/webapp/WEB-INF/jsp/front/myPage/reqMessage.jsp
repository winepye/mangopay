<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/reqMessage_JS.jsp"%>
<!--
  * @Class Name  : reqMessage.jsp
  * @Description : front > My Page > 메세지충전
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2020.05.31	psj      최초 생성
-->
<customTagUi:jspTitleTag pageUrl="${pageUrl }" />

<section id="contents">
<form id = "frm" name = "frm" method="post">
	<ul class="dot_list_st04 mgt10">
		<li><strong>가맹점명 : </strong>${sessionScope['scopedTarget.loginSessionInfo'].sessionUserName}</li>
		<li><strong>잔여금액 : </strong>13,000원<br>(충전하신 금액는 사용달에 상관없이 사용 가능하며 미사용시 환불되지 않습니다.)</li>
		<li><label class="txt"><input type="checkbox" id = "isSearchInResult"><span><strong style="margin-left: 3px;">결재내역 카카오톡 수신 하기 </strong></span></label><br>(선택시 : 사용자 결제가 완료되면 결제내역이 카카오톡으로 전송되며 건당 20원씩 과금됩니다.)</li>
	</ul>

    <table class="board_regist_st01 mgt40" summary="메세지충전 (충전금액, 충전방법, 결재요청 모바일번호)">
        <caption>메세지충전</caption>
        <colgroup>
            <col width="12%" />
            <col width="12%" />
            <col width="12%" />
            <col width="12%" />
            <col width="16%" />
            <col width="*" />
            <col width="10%" />
        </colgroup>
        <tr>
            <th scope="row"><label for="requestAmount">충전금액</label></th>
            <td>
            	<customTagUi:code type="select" cdGrp="REQ_MESSAGE_AMOUNT_CD" name="requestAmount" id="requestAmount" attr='class="join_sel_b"' subjectText="선택하세요"/>
            </td>
            <th scope="row"><label for="requestMessageType">충전방법</label></th>
            <td>
                <customTagUi:code type="select" cdGrp="REQUEST_MESSAGE_TYPE" name="requestMessageType" id="requestMessageType" attr='class="join_sel_b"'/>
            </td>
            <th scope="row"><label for="requestPhone">결제요청 모바일번호</label></th>
            <td>
                <input type="text" id="requestPhone" name="requestPhone" class="input_s_b w100pro"
                	   placeholder="(-) 제외한 모바일번호를 입력해주세요"
                	   value="${fn:replace(sessionScope['scopedTarget.loginSessionInfo'].sessionUserMobileNo,'-','')}"/>
            </td>
            <td><button type="button" class="btn_blue_B02" id="btnReqMessage">충전요청</button></td>
        </tr>
    </table>

    <div class="idpass_noticeBox">
        <ul class="dot_list_st02">
            <li>충전방법 : 청구서발송을 선택하시면 결제요청 모바일번호로 결제요청 메시지가 발송됩니다.</li>
            <li>충전방법 : 무통장 입금을 선택하신경우 충전하기 버튼을 클릭 후 아래 통장으로 입금 확인 후 충전이 됩니다.</li>
            <li>무통장입금 : 국민은앵, MP솔루션스, 5678-7534-98876</li>
        </ul>
    </div>
</form>
</section>