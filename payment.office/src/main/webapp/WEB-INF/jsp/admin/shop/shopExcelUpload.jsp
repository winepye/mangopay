<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>

<script type="text/javascript">

    // 파일 확장자 체크
    function checkFileType(filePath) {

        var fileFormat = filePath.split(".");

        if (fileFormat.indexOf("xlsx") > -1) {
            return true;
        } else if (fileFormat.indexOf("xls") > -1) {
            return true;
        } else {
            return false;
        }
    }

    // 엑셀업로드를 위한 엑셀템플릿 다운로드
    function tempDown(){

        var path = "<%=request.getSession().getServletContext().getRealPath("/")%>";

        console.log("====> " + path);
        //window.location.href = contextRoot +"/admin/shop/templateDown.do";
        window.location.href = "/tempExcel/tempDown.jsp?file=sample2.xls";
    }

    // 엑셀 일괄 업로드
    function check() {

        var file = $("#excelFile").val();
        if (file == "" || file == null) {
            alert("파일을 선택해주세요.");
            return false;
        } else if (!checkFileType(file)) {
            alert("엑셀 파일만 업로드 가능합니다.");
            return false;
        }

        if (confirm("업로드 하시겠습니까?")) {
            var options = {
                success : function(data) {
                    alert("모든 데이터가 업로드 되었습니다.");

                    $("#listArea").empty();
                    $("#listArea").html(data);
                },
                type : "POST"
            };
            $("#excelUploadForm").ajaxSubmit(options);
        }
    }

</script>

<!--
* @Description : 매장일괄등록
-->
<section id="detail_contents">

    <form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post"
          action= "/admin/shop/shopExcelUploadAjax.do">

        <div class="adm_searchBox">
            <table class="adm_tb_search">
                <caption>엑셀업로드</caption>
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">엑셀업로드</th>
                    <td colspan="2">
                        <dl class="vm_name">
                            <dd><input id="excelFile" type="file" name="excelFile" /></dd>
                        </dl>
                    </td>
                    <td>
                        <button type="button" class="btn_white_B01" onclick="tempDown()" >엑셀템플릿 다운로드</button>
                        <%--<a href="/tempExcel/tempDown.jsp?file=sample2.xls"> 파일 다운</a>--%>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>

        <!-- 버튼 -->
        <div class="bs_BtnBox_c">
            <button type="button" id="addExcelImpoartBtn" class="btn_gray_B01" onclick="check()">일괄등록 저장</button>
        </div>
        <!-- 버튼 -->

        <!--/ 가맹점 정렬목록 /-->
        <div id = "listArea" style="padding-top: 30px">
            <jsp:include page="./include/shopExcelUpload_INC.jsp"></jsp:include>
        </div>

    </form>

</section>
