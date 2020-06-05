<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<script type="text/javascript">
    $(document).ready(function(){

        $("#brandInfoId").prop('disabled', 'disabled');
        $("#companyInfoId").prop('disabled', 'disabled');

        /*if ($("#companyInfoId").val() == '') {
            $("#brandInfoId").val('');
            $("#brandInfoId").prop('disabled', 'disabled');
        }
        else {
            $("#brandInfoId").removeAttr("disabled");
            fn_changeBizTypeId();
        }*/

        // 숫자만 입력가능하도록 처리
        $("input:text[numberOnly]").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });

    });

    //창닫기
    function fn_closeWindow(){
        window.close();
    }

    // 매장 수정저장
    function fn_modifyShop(){

        var addMsg = "은(는) 필수 입력 항목입니다.";

        /* :::::::::::::::::: validation START ::::::::::::::::::::::::: */

        if($("#companyInfoId").val() == ''){
            alert("고객사"+addMsg);
            $("#companyInfoId").focus();
            return false;
        }

        if($("#brandInfoId").val() == ''){
            alert("브랜드"+addMsg);
            $("#brandInfoId").focus();
            return false;
        }

        if($("#shopName").val() == ''){
            alert("매장명"+addMsg);
            $("#shopName").focus();
            return false;
        }

        if($("#shopMngCode").val() == ''){
            alert("매장관리코드"+addMsg);
            $("#shopMngCode").focus();
            return false;
        }

        /* :::::::::::::::::: validation END ::::::::::::::::::::::::: */

        var shopTelNum;
        shopTelNum = $("#shopTelNum1").val()+"-"+$("#shopTelNum2").val()+"-"+$("#shopTelNum3").val();
        $("#shopTelNum").val(shopTelNum);


        if(confirm("<spring:message code='request.common.save'   />")) {
            $("#frm").attr("action",contextRoot + "/admin/shop/modifyShopAjax.do");
            commonAjaxSubmit("POST", $("#frm"), fn_doCreateCallback);
        }

    }


    //저장 콜백
    function fn_doCreateCallback(data){
        if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
            alert("정상적으로 저장되었습니다.");
            window.opener.fn_getChildData(data.shopInfo);
            fn_closeWindow();
        }else{
            alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }
    }

    // 업종(상위)정보변경 시 업종(하위) 정보 변경
    function fn_changeCompanyId(){

        $("#brandInfoId").empty();
        $('#brandInfoId').append("<option value=\"\" selected=\"selected\">선택</option>");

        if($("#companyInfoId").val() != ""){

            $('#brandInfoId').prop('disabled', false);

            <c:forEach var="item" items="${result.brandList}">
            var selectHtml;
            if('${item.parent}' == $("#companyInfoId").val()){
                var option = $("<option value=\"${item.id}\" >${item.name}</option>");
                $('#brandInfoId').append(option);
            }
            </c:forEach>

        }else{
            $("#brandInfoId").prop("disabled", "disabled");
        }

    }

    // 글자수 제한
    function chkword(obj, maxByte, focusName) {

        var strValue = obj.value;
        var strLen = strValue.length;

        var totalByte = 0;
        var len = 0;
        var oneChar = "";
        var str2 = "";

        for (var i = 0; i < strLen; i++) {
            oneChar = strValue.charAt(i);
            totalByte++;

            // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
            if (totalByte <= maxByte) {
                len = i + 1;
            }
        }

        if(focusName == null){
            // 넘어가는 글자는 자른다.
            if (totalByte > maxByte) {
                alert(maxByte + "자를 초과 입력 할 수 없습니다.");
                str2 = strValue.substr(0, len);
                obj.value = str2;
                chkword(obj, 4000);
            }
        }else{
            if (totalByte >= maxByte) {
                if(focusName != ''){
                    $("#"+focusName).focus();

                    str2 = strValue.substr(0, len);
                    obj.value = str2;
                    chkword(obj, 4000);
                }
            }
        }
    }

</script>


<div id="pop_wrap">
    <!--팝업컨텐츠-->
    <div class="pop_container">

        <form id = "frm" name = "frm" method="post">
            <h3 class="h2_table_title">매장정보 수정</h3>
            <table id="templateProject" class="tb_left_st2">

                <input type="hidden" id="shopInfoId" name="shopInfoId" value="${result.shopInfo.shopInfoId}">

                <caption>
                    매장정보 수정
                </caption>
                <colgroup>
                    <col width="20%" />
                    <col width="30" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">고객사</th>
                        <td>
                            <select name="companyInfoId" id="companyInfoId" class="sel_basic w100pro" onchange="fn_changeCompanyId()">
                                <option value="" selected="selected">선택</option>
                                <c:forEach var="item" items="${result.companyList}">
                                    <option value="${item.id}" <c:if test="${item.id eq result.shopInfo.companyInfoId}">selected="selected"</c:if> >${item.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <th scope="row">브랜드</th>
                        <td>
                            <select name="brandInfoId" id="brandInfoId" class="sel_basic w100pro">
                                <option value="" selected="selected">선택</option>
                                <c:forEach var="item" items="${result.brandList}">
                                    <option value="${item.id}" <c:if test="${item.id eq result.shopInfo.brandInfoId}">selected="selected"</c:if> >${item.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label><span class="redstar">*</span>매장명</label></th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="shopName" name="shopName"
                                   value="<c:out value="${result.shopInfo.shopName}" />"
                                   onkeyup="chkword(this, 30)">
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>매장관리코드</label></th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="shopMngCode" name="shopMngCode"
                                   value="<c:out value="${result.shopInfo.shopMngCode}" />"
                                   onkeyup="chkword(this, 30)">
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">매장전화번호</th>
                        <c:set var = "serviceTelNumBuf" value="${fn:split(result.shopInfo.shopTelNum,'-') }"></c:set>
                        <c:set var = "serviceTelNum1" value="${serviceTelNumBuf[0] }"></c:set>
                        <c:set var = "serviceTelNum2" value="${serviceTelNumBuf[1] }"></c:set>
                        <c:set var = "serviceTelNum3" value="${serviceTelNumBuf[2] }"></c:set>
                        <td>
                            <input type="hidden" id="shopTelNum" name="shopTelNum">
                            <input id="shopTelNum1" name="shopTelNum1" class="input_s_b w30pro"
                                   value="${serviceTelNum1}" onkeyup="chkword(this, 3,'shopTelNum2')" numberOnly/>
                            <label class="w5pro">-</label>
                            <input id="shopTelNum2" name="shopTelNum2" class="input_s_b w30pro"
                                   value="${serviceTelNum2}" onkeyup="chkword(this, 4,'shopTelNum3')" numberOnly/>
                            <label class="w5pro">-</label>
                            <input id="shopTelNum3" name="shopTelNum3" class="input_s_b w30pro"
                                   value="${serviceTelNum3}" onkeyup="chkword(this, 4)" numberOnly/>
                        </td>
                        <th scope="row">사용여부</th>
                        <td>
                            <customTagUi:code type="radio" cdGrp="YN_COMMON" name="useYn" id="useYn" cd="${result.shopInfo.useYn}" prefix="<span class=radio_list>" postfix="</span>"/>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- 버튼 -->
            <div class="bs_BtnBox_c">
                <button type="button" id="btnCreate" class="btn_gray_B01" onclick="fn_modifyShop()">저장</button>
                <button type="button" id="btnClose" class="btn_gray_B01" onclick="fn_closeWindow()">닫기</button>
            </div>
            <!-- 버튼 -->

        </form>

    </div>
    <!--팝업컨텐츠-->
</div>