<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!--
  * @Class Name  : notiList.jsp
  * @Description : 공지사항리스트화면
  * @Modification Information
  * @
  * @ 수정일        		수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<section id="detail_contents">

	<customTagUi:code type="select" cdGrp="BOARD_TYPE_CD" name="boardType" cd="NOTI" attr='class="select_b"' subjectText="선택"/>
	<BR>
	<customTagUi:code type="checkbox" cdGrp="BOARD_TYPE_CD" name="boardType" cd="NOTI,FAQ" prefix="<span class=radio_list>" postfix="</span>"/>
	<BR>
	<customTagUi:code type="radio" cdGrp="BOARD_TYPE_CD" name="boardType1" cd="NOTI" prefix="<span class=radio_list>" postfix="</span>"/>
	<BR>
	<customTagUi:code type="text" cdGrp="QNA_STATUS_CD" name="boardType2" cd="RECP" />
	
</section>