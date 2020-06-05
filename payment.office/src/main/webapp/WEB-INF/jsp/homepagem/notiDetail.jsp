<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%@ include file="./js/notiDetail_JS.jsp"%>

<section class="sub5" id="text">
	<img src="/homepagem/img/sub.jpg">
	<img src="/homepagem/img/sub05-1.jpg">
	<ul>
    	<li><a href="/m/notiList.do" class="select">공지사항</a></li>
        <li><a href="/m/createQna.do">상담의뢰</a></li>
        <li><a href="/m/questionList.do">자주묻는질문</a></li>
        <li><a href="/m/contact.do">Contact us</a></li>
    </ul>

    <div style="padding:10px;">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><img src="/homepage/img/board-line0.gif" width="1000" height="1"></td>
	        </tr>
	        <tr>
	          <td style="padding:10px"><font size="3"><b><font color="#000000"><c:out value="${notiBoardVo.title }" /></font></b></font></td>
	        </tr>
	        <tr>
	          <td style="padding:10px"><font size="2"><c:out value='${notiBoardVo.userName }' /> | <fmt:formatDate value="${notiBoardVo.createDate}" pattern="yyyy.MM.dd"/> | 조회수 : <c:out value="${notiBoardVo.viewCnt }" /></font></td>
	        </tr>
	        <tr>
	          <td style="padding:10px">
	          		<font size="2">
	         		<c:out value="${notiBoardVo.content }" escapeXml="false"/>
	         		</font>
	          </td>
	        </tr>
	        <tr>
	          <td style="padding:10px">
	          	<customTagUi:fileView atchFileGrpSeq="${notiBoardVo.atchFileGrpSeq }" fileTypeCd="ETC" />
	          </td>
	        </tr>

	        <tr>
	          <td><img src="/homepage/img/board-line0.gif" width="1000" height="1"></td>
	        </tr>
	        <tr>
	          <td height="80" align="center">
	            <table width="79" border="0" cellspacing="0" cellpadding="0">
	              <tr>
	                <td height="25" background="/homepage/img/b8.gif" align="center"><font color="#000000"><b><a href="/notiList.do"><font size="2">목록</font></a></b></font></td>
	              </tr>
	            </table>
	          </td>
	        </tr>
	      </table>
	  </div>

</section>





