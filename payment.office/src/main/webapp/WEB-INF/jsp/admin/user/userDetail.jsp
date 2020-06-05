<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/userDetail_JS.jsp"%>
<!--
  * @Class Name  : userDetail.jsp
  * @Description : 회원상세
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->



<section id="detail_contents">
	<c:set var="isAuthConstNow" value="N" />
    <form id="frm" name="frm" method="post">
        <!-- 탭별 페이징 구분을 위한 히든값 -->
        <input type="hidden" id="searchTabType">
        <input type="hidden" id="searchPopType">
        <input type="hidden" id="currentPageNo" name = "currentPageNo" value="1">
        <input type="hidden" id="searchYear" name="searchYear" />

        <!-- ibUser정보 -->
        <input type="hidden" name = "ibUserName" id = "ibUserName" value="${result.userAddInfoVo.ibUserName }">
        <input type="hidden" name = "ibUserId" id = "ibUserId" value="${result.userAddInfoVo.ibUserId }">

        <h3 class="h2_table_title">회원기본정보</h3>
        <table id="templateProject" class="tb_left_st2" summary="사용자정보">
            <caption>사용자정보</caption>
            <colgroup>
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">사용자명</th>
                    <td><c:out value="${result.userVo.userName}" /></td>
                    <th scope="row">사용자ID</th>
                    <td class="txt_num"><c:out value="${result.userVo.userId }" /></td>
                </tr>
                <tr>
                    <th scope="row">거래처정보</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.companyName }" /></span></td>
                    <th scope="row">가맹점명</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.storeName }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">CAT ID</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.catId }" /></span></td>
                    <th scope="row">가맹점코드</th>
                    <td><span class="txt_num"><c:out value="${result.userVo.storeCode}" /></span></td>
                </tr>
                <tr>
                    <th scope="row">사업자번호</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.bizRegNum }" /></span></td>
                    <th scope="row">업종</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.bizType }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">대표자명</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.ceoName }" /></span></td>
                    <th scope="row">핸드폰</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.userMobileNum }" /></span></td>

                </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.userEmailAddr }" /></span></td>
                    <th scope="row">사용여부</th>
                    <td><span class="txt_eng"><c:out value="${result.userVo.useYn }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">가맹점 키값</th>
                    <td colspan="3"><span class="txt_eng"><c:out value="${result.userVo.compApikey }" /></span></td>
                </tr>
                <tr>
                    <th scope="row">주소</th>
                    <td colspan="3">
                        <c:choose>
                            <c:when test="${result.userVo.storeAddr1 eq null || result.userVo.storeAddr1 eq ''}">-</c:when>
                            <c:otherwise>
                                <span class="txt_num">(<c:out value="${result.userVo.storeZip}" />)</span>
                                 <c:out value="${result.userVo.storeAddr1}" /> <c:out value="${result.userVo.storeAddr2}" />
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </tbody>
        </table>

		<div style="width:100%; padding-top: 20px;">
			<label>※ 모바일 정보</label>
		</div>
		<div style="width:100%; overflow:auto;">
			<table id="userMobileTable" class="tb_left_st2" summary="사용자 모바일 목록">
				<caption>사용자 모바일 목록</caption>
			    <colgroup>
			        <col width="100"> <!--Mobile Type-->
			        <col width="130"> <!--Mobile UUID-->
			        <col width="100"> <!--APP Ver-->
			        <col width="150"> <!--Package-->
			        <col width="*"> <!-- Token -->
			    </colgroup>
				<thead>
					<tr>
						<th scope="col">Mobile Type</th>
						<th scope="col">Mobile UUID</th>
						<th scope="col">APP Ver</th>
						<th scope="col">Package</th>
						<th scope="col">FCM Push Token</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="data" items="${result.userMobileList}" varStatus="status">
						<tr>
							<td style="text-align: center;"><c:out value='${data.mobileType }' /></td>
							<td style="text-align: center;"><c:out value='${data.mobileUuid }' /></td>
							<td style="text-align: center;"><c:out value='${data.appVersion }' /></td>
							<td style="text-align: center;word-break:break-all"><c:out value='${data.packageName }' /></td>
							<td style="word-break:break-all"><c:out value='${data.pushToken }' /></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(result.userMobileList) <= 0 }">
						<tr>
							<td class="nodata" colspan="5">조회된 모바일정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>




        <div id="btnAuthCreatePop">
            <span class="ui-helper-hidden-accessible"><input type="text"/></span><!-- 자동 focus 막기 -->
            <table id="templateProject" class="tb_left_st2" summary="회원권한제한">
                <caption>회원권한제한 등록</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="*%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><label for="inputStartDt">기간</label></th>
                        <td class="vtwrap">시작일 : <input type="text" class="input_s_b w_date" id="inputStartDt" name="inputStartDt"> 종료일 : <input type="text"  class="input_s_b w_date" id="inputEndDt" name="inputEndDt">
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="regRsn">등록사유</label></th>
                        <td><input type="text" id="regRsn" name="regRsn" class="input_s_b w100pro" maxlength="100" placeholder="등록사유를 입력하세요."></td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="menuGrpSeq">메뉴그룹</label></th>
                        <td>
                        <select id="menuGrpSeq" name="menuGrpSeq" class="sel_basic">
                                <option value="">선택</option>
                                <c:forEach var="menuGrpSeqSelect" items="${result.menuGrpVoList }">
                                    <c:if test="${menuGrpSeqSelect.menuGrpAuthTypeCd ne 'REPRESENT'}">
                                        <option value="${menuGrpSeqSelect.menuGrpSeq }" <c:if test = "${menuGrpSeqSelect.menuGrpSeq eq data.menuGrpSeq}">selected = "selected"</c:if>>${menuGrpSeqSelect.menuGrpNm }</option>
                                    </c:if>
                                </c:forEach>
                        </select>
                        </td>
                    </tr>
                </tbody>
            </table>
             <!-- 버튼 -->
            <div class="bs_BtnBox_c">
                <button type="button" id="btnAuthConstClose" class="btn_white_B01">닫기</button>
                <button type="button" id="btnAuthConstProc" class="btn_gray_B01">권한저장</button>
            </div>
        </div>
        <div id="btnAuthCancelPop" style="display: none;">
            <table id="templateProject" class="tb_left_st2" summary="회원권한제한">
                <caption>회원권한제한 취소</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="*%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">취소사유</th>
                        <td><textarea class="textarea_basic" placeholder="취소사유를 입력하세요." title="권한적용 취소사유 입력" name="cnclRsn" id="cnclRsn" rows="3" cols="70"></textarea>
                        <br>

                        </td>
                    </tr>

                </tbody>
            </table>
            <!-- 버튼 영역 -->
            <div class="bs_BtnBox_c">
                <button type="button" id="btnAuthConstCancelClose" class="btn_white_B01">닫기</button>
                <button type="button" id="btnAuthConstCancel" class="btn_gray_B01">권한취소</button>
            </div>
        </div>
        <!-- 권한 변경때 frm폼을 쓰기위해서 복사...............................PSJ -->
        <input type="hidden" name="userInfoId" value='<c:out value="${userCriteria.searchUserInfoId }" />'>
        <input type="hidden" name="searchUserInfoId" value='<c:out value="${userCriteria.searchUserInfoId }" />'>


        <input type="hidden" name="updateBefLvlCd" value='<c:out value="${result.userAddInfoVo.userLvlCd}" />'>
        <input type="hidden" name="userAuthConstSeq" id="userAuthConstSeq">
    </form>
    <form id="moveFrm" name="moveFrm" method="post">
        <!-- 검색조건 유지를 위한 파라미터 :S -->
        <!-- 검색폼 -->
        <input type="hidden" name="searchUserId" value='<c:out value="${userCriteria.searchUserId}" />'>
        <input type="hidden" name="searchUserName" value='<c:out value="${userCriteria.searchUserName}" />'>
        <input type="hidden" name="searchUserTypeCd" value='<c:out value="${userCriteria.searchUserTypeCd}" />'>
        <input type="hidden" name="searchStoreName" value='<c:out value="${userCriteria.searchStoreName}" />'>
        <input type="hidden" name="searchCompanyName" value='<c:out value="${userCriteria.searchCompanyName}" />'>
        <input type="hidden" name="searchUseYn" value='<c:out value="${userCriteria.searchUseYn}" />'>




        <input type="hidden" name="searchUserLvlCd" value='<c:out value="${userCriteria.searchUserLvlCd}" />'>
        <input type="hidden" name="searchUserStatusCd" value='<c:out value="${userCriteria.searchUserStatusCd}" />'>
        <input type="hidden" name="searchFromDtS" value='<fmt:formatDate value="${userCriteria.searchFromDt}" pattern="yyyy/MM/dd"/>'>
        <input type="hidden" name="searchToDtS" value='<fmt:formatDate value="${userCriteria.searchToDt}" pattern="yyyy/MM/dd"/>'>
        <!-- 상세 -->
        <input type="hidden" name="searchUserInfoId" value='<c:out value="${userCriteria.searchUserInfoId}" />'>
        <!-- 페이징 -->
        <input type="hidden" name="currentPageNo" value='<c:out value="${userCriteria.currentPageNo}" />'>
        <input type="hidden" id="sortOrder" name="sortOrder" value='<c:out value="${userCriteria.sortOrder}" />'>
        <!-- 검색조건 유지를 위한 파라미터 :E -->
    </form>



    <div class="bs_BtnBox_c">
	    <button type="button" id="btnGoUserListPage" class="btn_white_B02">목록</button>
	    <button type="button" id="btnGoUserModifyPage" class="btn_gray_B01">수정</button>
	</div>
</section>

