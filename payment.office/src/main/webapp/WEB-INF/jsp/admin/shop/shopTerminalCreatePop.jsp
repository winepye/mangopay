<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/commJS.jsp"%>
<%@ include file="/WEB-INF/jsp/common/daumPost.jsp"%>

<script type="text/javascript">
    $(document).ready(function(){

        // 숫자만 입력가능하도록 처리
        $("input:text[numberOnly]").on("keyup", function() {
            $(this).val($(this).val().replace(/[^0-9]/g,""));
        });

        $("#serviceZipBtn").click(function(){
            fn_searchZipCode();
        });

    });

    //창닫기
    function fn_closeWindow(){
        window.close();
    }

    // 매장단말기 등록저장
    function fn_createShopTerminal(){

        /* :::::::::::::::::: validation START ::::::::::::::::::::::::: */

        if(fn_validationCheck('가맹점상호', 'serviceStoreName')) return false;
        if(fn_validationCheck('매장단말번호', 'shopTerminalNum')) return false;
        if(fn_validationCheck('비말번호', 'password')) return false;
        if(fn_validationCheck('가맹점대표자', 'serviceCeoName')) return false;

        if(fn_validationCheck('사업자번호', 'serviceBizNum1')) return false;
        if(fn_validationCheck('사업자번호', 'serviceBizNum2')) return false;
        if(fn_validationCheck('사업자번호', 'serviceBizNum3')) return false;

        if(fn_validationCheck('가맹점연락처', 'serviceTelNum1')) return false;
        if(fn_validationCheck('가맹점연락처', 'serviceTelNum2')) return false;
        if(fn_validationCheck('가맹점연락처', 'serviceTelNum3')) return false;

        if(fn_validationCheck('서비스그룹코드', 'paymentGroup')) return false;
        if(fn_validationCheck('과세형태', 'taxDiv')) return false;
        if(fn_validationCheck('봉사료여부', 'svcAmtYn')) return false;
        if(fn_validationCheck('초기구동화면', 'initDriveScreen')) return false;
        if(fn_validationCheck('부가세율', 'taxRate')) return false;
        if(fn_validationCheck('봉사료율', 'svcChargeRate')) return false;


        /* :::::::::::::::::: validation END ::::::::::::::::::::::::: */

        var serviceTelNum;
        serviceTelNum = $("#serviceTelNum1").val()+"-"+$("#serviceTelNum2").val()+"-"+$("#serviceTelNum3").val();
        $("#serviceTelNum").val(serviceTelNum);

        var serviceBizNum;
        serviceBizNum = $("#serviceBizNum1").val()+"-"+$("#serviceBizNum2").val()+"-"+$("#serviceBizNum3").val();
        $("#serviceBizNum").val(serviceBizNum);

        if(confirm("<spring:message code='request.common.save'/>")) {
            $("#frm").attr("action",contextRoot + "/admin/shop/createShopTeminalAjax.do");
            commonAjaxSubmit("POST", $("#frm"), fn_doCreateCallback);
        }

    }

    //저장 콜백
    function fn_doCreateCallback(data){
        if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
            alert("정상적으로 저장되었습니다.");
            opener.location.reload();
            fn_closeWindow();
        }else{
            alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }
    }

    // daum 우편번호 검색 서비스 이용
    function fn_searchZipCode(){

        // /WEB-INF/jsp/common/daumPost.jsp 이용
        // 인자값 (우편번호ID, 기본주소ID, 상세주소ID)
        searchZipCode("serviceZip", "serviceAddr1", "serviceAddr2");
    }

</script>


<div id="pop_wrap">
    <!--팝업컨텐츠-->
    <div class="pop_container">

        <form id = "frm" name = "frm" method="post">

            <input type="hidden" name="shopInfoId" id="shopInfoId" value="${result.shopInfoId}" />

            <h3 class="h2_table_title" style="font-weight: bold">매장단말기 등록</h3>

            <table class="tb_left_st">
                <caption>매장단말기 등록</caption>
                <colgroup>
                    <col width="10%" /><col width="23%" />
                    <col width="10%" /><col width="23%" />
                    <col width="10%" /><col width="23%" />
                </colgroup>

                <tbody>
                    <tr>
                        <th scope="row"><label><span class="redstar">*</span>가맹점상호</label></th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="serviceStoreName" name="serviceStoreName"
                                   onkeyup="javascript:chkword(this, 30)"
                                    value="${result.shopTerminalBasicInfo.serviceStoreName}"/>
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>매장단말번호</label></th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="shopTerminalNum" name="shopTerminalNum"
                                   onkeyup="javascript:chkword(this, 5)"/>
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>비밀번호</label></th>
                        <td>
                            <input type="password" class="input_s_b w100pro" id="password" name="password" />
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label><span class="redstar">*</span>가맹점대표자</label></th>
                        <td>
                            <input type="text" class="input_s_b w100pro" id="serviceCeoName" name="serviceCeoName"
                                   value="${result.shopTerminalBasicInfo.serviceCeoName}"/>
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>사업자번호</label></th>

                        <c:set var = "bizBuf" value="${fn:split(result.shopTerminalBasicInfo.serviceBizNum,'-') }"></c:set>
                        <c:set var = "biz1" value="${bizBuf[0] }"></c:set>
                        <c:set var = "biz2" value="${bizBuf[1] }"></c:set>
                        <c:set var = "biz3" value="${bizBuf[2] }"></c:set>

                        <td style="white-space:nowrap;">
                            <input id="serviceBizNum1" name="serviceBizNum1" class="input_s_b w30pro"
                                   value="${biz1}" onkeyup="javascript:chkword(this, 3, 'serviceBizNum2')" numberOnly/>
                            <label class="w5pro">-</label>
                            <input id="serviceBizNum2" name="serviceBizNum2" class="input_s_b w20pro"
                                   value="${biz2}" onkeyup="javascript:chkword(this, 2, 'serviceBizNum3')" numberOnly/>
                            <label class="w5pro">-</label>
                            <input id="serviceBizNum3" name="serviceBizNum3" class="input_s_b w40pro"
                                   value="${biz3}" onkeyup="javascript:chkword(this, 5, 'serviceTelNum1')" numberOnly/>
                            <input type="hidden" name="serviceBizNum" id="serviceBizNum"
                                   value="${result.shopTerminalBasicInfo.serviceBizNum}">
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>가맹점연락처</label></th>

                        <c:set var = "telNumBuf" value="${fn:split(result.shopTerminalBasicInfo.serviceTelNum,'-') }"></c:set>
                        <c:set var = "telNum1" value="${telNumBuf[0] }"></c:set>
                        <c:set var = "telNum2" value="${telNumBuf[1] }"></c:set>
                        <c:set var = "telNum3" value="${telNumBuf[2] }"></c:set>
                        <td>
                            <input id="serviceTelNum1" name="serviceTelNum1" class="input_s_b w30pro"
                                   value="${telNum1}" onkeyup="chkword(this, 3, 'serviceTelNum2')" numberOnly/>
                            <label class="w5pro"> - </label>
                            <input id="serviceTelNum2" name="serviceTelNum2" class="input_s_b w30pro"
                                   value="${telNum2}" onkeyup="chkword(this, 4, 'serviceTelNum3')" numberOnly/>
                            <label class="w5pro"> - </label>
                            <input id="serviceTelNum3" name="serviceTelNum3" class="input_s_b w30pro"
                                   value="${telNum3}" onkeyup="chkword(this, 4, 'paymentGroup')" numberOnly/>
                            <input type="hidden" id="serviceTelNum" name="serviceTelNum"
                                   value="${result.shopTerminalBasicInfo.serviceTelNum}">
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label><span class="redstar">*</span>서비스그룹코드</label></th>
                        <td>
                            <customTagUi:code type="select" cdGrp="PAYMENT_GROUP" name="paymentGroup"
                                              id="paymentGroup"
                                              attr='class="sel_basic w100pro"' subjectText="선택"/>
                        </td>

                        <th scope="row"><label><span class="redstar">*</span>과세형태</label></th>
                        <td>
                            <select name="taxDiv" id="taxDiv"  class="sel_basic w100pro">
                                <option value="" selected="selected">선택</option>
                                <option value="TAX_ON">과세</option>
                                <option value="TAX_OFF">면세</option>
                                <option value="TAX_PARALLEL">과세 면세 겸업</option>
                            </select>
                        </td>

                        <th scope="row"><label><span class="redstar">*</span>봉사료여부</label></th>
                        <td>
                            <select name="svcAmtYn" id="svcAmtYn"  class="sel_basic w100pro">
                                <option value="" selected="selected">선택</option>
                                <option value="Y">예</option>
                                <option value="N">아니오</option>
                            </select>
                        </td>
                    </tr>

                    <tr>

                        <th scope="row"><label><span class="redstar">*</span>초기구동화면</label></th>
                        <td>
                            <customTagUi:code type="select" cdGrp="POS_CAT_DIV" name="initDriveScreen"
                                              id="initDriveScreen"
                                              attr='class="sel_basic w100pro"' subjectText="선택"/>
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>부가세율(%)</label></th>
                        <td>
                            <input type="text" class="input_s_b w100pro alignR" id="taxRate" name="taxRate" value="0" numberOnly/>
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>봉사료율(%)</label></th>
                        <td>
                            <input type="text" class="input_s_b w100pro alignR" id="svcChargeRate" name="svcChargeRate" value="0" numberOnly/>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row"><label><span class="redstar">*</span>가맹점우편번호</label></th>
                        <td>
                            <input id="serviceZip" name="serviceZip" class="input_s_b w80pro" readonly
                                   onclick="fn_searchZipCode()"
                                   value="${result.shopTerminalBasicInfo.serviceZip}"/>
                            <button type="button" id="serviceZipBtn" class="btn_white_B01">검색</button>
                        </td>
                        <th scope="row"><label><span class="redstar">*</span>가맹점주소</label></th>
                        <td>
                            <input id="serviceAddr1" name="serviceAddr1" class="input_s_b w100pro"
                                   onkeyup="javascript:chkword(this, 100)"
                                   value="${result.shopTerminalBasicInfo.serviceAddr1}"/>
                        </td>

                        <th scope="row"><label><span class="redstar">*</span>가맹점주소(상세)</label></th>
                        <td>
                            <input id="serviceAddr2" name="serviceAddr2" class="input_s_b w100pro"
                                   onkeyup="javascript:chkword(this, 100)"
                                   value="${result.shopTerminalBasicInfo.serviceAddr2}"/>
                        </td>
                    </tr>

                    <tr>
                        <th scope="row">바코드키인모드</th>
                        <td colspan="7">
                            <customTagUi:code type="radio" cdGrp="BARCODE_KEYIN_MODE"
                                              name="barcodeKeyinMode" id="barcodeKeyinMode" cd="BARCODE"
                                              prefix="<span class=radio_list>" postfix="</span>"/>
                        </td>
                    </tr>

                </tbody>
            </table>

            <style>
                .alignR {
                    text-align: right;
                }
            </style>

            <!-- 버튼 -->
            <div class="bs_BtnBox_c">
                <button type="button" id="btnCreate" class="btn_gray_B01" onclick="fn_createShopTerminal()">저장</button>
                <button type="button" id="btnClose" class="btn_gray_B01" onclick="fn_closeWindow()">닫기</button>
            </div>
            <!-- 버튼 -->

        </form>

    </div>
    <!--팝업컨텐츠-->
</div>