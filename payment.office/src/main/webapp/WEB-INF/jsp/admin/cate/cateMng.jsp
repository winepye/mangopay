<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/cateMng_JS.jsp"%>
<!--
  * @Description : 업종카테고리 화면
-->
<section id="detail_contents">
    <h2 class="h2_table_title mgt20">
		<span class="lspwide">업종카테고리(상)</span>
		<button type="button" id="btnNewCatePr" class="btn_grayline">신규</button>
	</h2>
    <div class="clearbothWrap2">
        <!-- 업종카테고리 영역 -->
	    <div class="flblock_20">
	        <div class="groupListbox3">
	            <p class="title">[ 업종카테고리(상) ]</p>
	            <!-- 목록  -->
	            <div id = "listArea">
	                <jsp:include page="./include/cateMng_INC.jsp"></jsp:include>
	            </div>
		      </div>
         </div>
		<div class="frblock">
            <!-- 업종카테고리(상) 상세 영역 -->
            <h3 class="h3_table_title">업종카테고리(상) 상세</h3>
			<div class="bs_BtnBox_r">
			    <button type="button" id="btnCreateCatePr" class="btn_gray_s01">저장</button>
            </div>

            <form id = "cateIndutyPrFrm" name = "cateIndutyPrFrm" method="post">
				<table id="reg_input_grid" class="tb_left_st2" summary="업종카테고리(상) 상세">
					<caption>업종카테고리(상) 상세</caption>
					<colgroup>
						<col width="120" />
						<col width="*" />
						<col width="120" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">업종카테고리(상)</th>
							<td>
								<input type="text" id="cateCdPr" name="cateCdPr" class="input_s_b w100pro" placeholder="업종카테고리(상) 코드를 입력하세요" />
							</td>
							<th scope="row">업종카테고리(상) 명</th>
							<td>
								<input type="text" id="cateNmPr" name="cateNmPr" class="input_s_b w100pro" placeholder="업종카테고리(상)명을 입력하세요" />
							</td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td class="itemList">
								<customTagUi:code type="select" cdGrp="YN_COMMON" cd = "${data==null?'Y':data.useYn }"
												  id="useYnPr" name="useYnPr" attr='class="sel_basic w100pro"'
												  prefix="<label>" postfix="</label>"/>
							</td>
							<th scope="row">비고</th>
							<td>
								<input type="text" id="cateDescPr" name="cateDescPr" class="input_s_b w100pro" placeholder="비고" />
							</td>
						</tr>
					</tbody>
				</table>
            </form>

            <!-- 업종카테고리(하) 목록 영역 -->
            <h3 class="h3_table_title mgt25">코드</h3>
            <div class="bs_BtnBox_r">
                 <button type="button"  id="btnAddRowCode"  class="btn_white_s01">추가</button>
                 <button type="button"  id="btnCreateCode"  class="btn_gray_s01">저장</button>
             </div>
             <!-- 목록 -->
             <div id = "listArea1" >
                 <jsp:include page="./include/cateMng_INC1.jsp"></jsp:include>
             </div>
		</div>
	</div>

	<form id = "searchFrm" name = "searchFrm" method="post">
        <input type="hidden" id="searchCateIndutyPr" name="searchCateIndutyPr" value="">
    </form>
</section>