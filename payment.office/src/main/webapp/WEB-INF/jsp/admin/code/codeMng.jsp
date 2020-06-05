<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/codeMng_JS.jsp"%>
<!--
  * @Class Name  : codeMng.jsp
  * @Description : 코드관리화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">
    <h2 class="h2_table_title mgt20"><span class="lspwide">코드그룹</span> <button type="button" id="btnNewCodeGroup" class="btn_grayline">신규</button></h2>
    <div class="clearbothWrap2">
        <!-- 코드그룹 영역 -->
	    <div class="flblock_20">
	        <div class="groupListbox3">
	            <p class="title">[코드그룹]</p>
	            <!-- 목록  -->
	            <div id = "listArea">
	                <jsp:include page="./include/codeMng_INC.jsp"></jsp:include>
	            </div>
		      </div>
         </div>
		<div id="codeDetailArea" class="frblock">
            <!-- 코드그룹 상세 영역 -->
            <h3 class="h3_table_title">코드그룹상세</h3>
			<div id="codeGroupDetailArea" class="bs_BtnBox_r">
			    <button type="button" id="btnCreateCodeGroup" class="btn_gray_s01">저장</button>
            </div>
            <form id = "codeGroupFrm" name = "codeGroupFrm" method="post">
            <table id="reg_input_grid" class="tb_left_st2" summary="코드그룹상세">
	            <caption>코드그룹상세</caption>
	            <colgroup>
	                <col width="80" /> <!--코드그룹-->
	                <col width="*" /> <!--*-->
	                <col width="95" /> <!--코드그룹명-->
	                <col width="*" /> <!--*-->
	                <col width="110" /> <!--상위코드그룹-->
	                <col width="*" /> <!--*-->
	            </colgroup>
	            <tbody>
	                <tr>
	                    <th scope="row"><label for="cdGrp">코드그룹</label></th>
	                    <td><input type="text" id="cdGrp" name="cdGrp" class="input_s_b w100pro" placeholder="코드그룹을 입력하세요" /></td>
	                    <th scope="row"><label for="cdGrpNm">코드그룹명</label></th>
	                    <td><input type="text" id="cdGrpNm" name="cdGrpNm" class="input_s_b w100pro" placeholder="코드그룹명을 입력하세요" /></td>
	                    <th scope="row"><label for="parentCdGrp">상위코드그룹</label></th>
	                    <td><input type="text" id="parentCdGrp" name="parentCdGrp" class="input_s_b w100pro" placeholder="상위코드그룹을 입력하세요" /></td>
	                </tr>
	                <tr>
	                    <th scope="row"><label for="remark">비고</label></th>
	                    <td colspan="3"><input type="text" id="remark" name="remark" class="input_s_b w100pro" placeholder="비고" /></td>
	                    <th scope="row"><label for="useYn">사용여부</label></th>
	                    <td class="itemList"><customTagUi:code type="select" cdGrp="YN_COMMON" cd = "${data==null?'Y':data.useYn }" id="useYn" name="useYn" attr='class="sel_basic w100pro"' prefix="<label>" postfix="</label>"/></td>
	                </tr>
	            </tbody>
            </table>
            </form>
            <!-- 코드목록 영역 -->
            <h3 class="h3_table_title mgt25">코드</h3>
            <div class="bs_BtnBox_r">
                 <button type="button"  id="btnAddRowCode"  class="btn_white_s01">추가</button>
                 <button type="button"  id="btnCreateCode"  class="btn_gray_s01">저장</button>
             </div>
             <!-- 목록 -->
             <div id = "listArea1" >
                 <jsp:include page="./include/codeMng_INC1.jsp"></jsp:include>
             </div>
		</div>
	</div>

	<form id = "searchFrm" name = "searchFrm" method="post">
        <input type="hidden" id="searchCdGrp" name="searchCdGrp" value="">
    </form>
</section>