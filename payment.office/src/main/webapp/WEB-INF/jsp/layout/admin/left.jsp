<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type='text/javascript'>
function setVisibleLeftMenu(n){

    var containerNm = 'container';

    if(document.getElementById('container')==null){
        containerNm = 'ADM_container';
    }

    var divLeft = $('#' + containerNm + ' > div')[0];       //왼쪽 메뉴 공간 div

    if(n==0){
        $(divLeft).hide();
        $('#btnLeftMenuHide').hide();   //왼쪽메뉴 숨김버튼 숨기기
        $('#btnLeftMenuShow').show();   //왼쪽메뉴 보기버튼 보이게

        $('#contentsWrap').css('width', '100%');    //내용 100%

    }else{
        $(divLeft).show();
        $('#btnLeftMenuHide').show();
        $('#btnLeftMenuShow').hide();

        $('#contentsWrap').css('width', '83%');     //내용 83%(원복)
    }
}
//메뉴 접었다 폈다 함수.
function menuFoldIt(objId){
    var p = $("#"+objId).parent();
    if($(p).attr('class') == 'open_mn'){    //열려있는 상태이면
        $(p).children('ul').hide();
        $(p).attr('class', 'close_mn');
    }else if($(p).attr('class') != "current"){
        $(p).children('ul').show();
        $(p).attr('class', 'open_mn');
    }

}
</script>
<!-- 메뉴를 뿌려주고 부모키를 저장한다(2depth) -->
<c:set var = "parentSeq" value="${topMenuGrpStructSeq }"/>
<div id="IB_Snb">
    <c:forEach var = "data" items="${sessionScope['scopedTarget.loginSessionInfo'].menuGrpStructVoList}" varStatus="i">
        <c:if test = "${data.menuGrpStructSeq ne null and data.menuLocationCd eq reportLocation }">
	        <c:choose>
	            <c:when test="${topMenuGrpStructSeq eq data.menuGrpStructSeq }">
	                <p class="Snb_title">${data.screenDisplayMenuNm }</p>
	                <ul class="Snb_List">
	            </c:when>
	            <c:when test="${data.menuDepth eq 1 and data.topMenuGrpStructSeq eq topMenuGrpStructSeq }">
	                    <c:choose>
	                        <c:when test="${data.nodeYn eq 'N' }">
	                            <!-- <li class="current open_mn close_mn"> -->
	                            <c:choose>
	                               <c:when test="${leftMenuSeq eq data.menuGrpStructSeq}">
	                                    <li class = "current">
	                               </c:when>
	                               <c:otherwise>
	                                   <li class = "open_mn">
	                               </c:otherwise>
	                            </c:choose>
			                        <a href="#" onclick="menuFoldIt('leftMenu_${data.menuGrpStructSeq}')">${data.screenDisplayMenuNm }</a>
			                        <ul class="Snb_de_List" id = "leftMenu_${data.menuGrpStructSeq}"></ul>
			                    <li>
                                <c:if test="${leftMenuSeq ne data.menuGrpStructSeq}">
                                    <script type="text/javascript">
                                    menuFoldIt('leftMenu_${data.menuGrpStructSeq}');
                                    </script>
                                </c:if>
	                        </c:when>
	                        <c:otherwise>

                                   <c:choose>
                                       <c:when test="${currentUrl eq data.menuUrl}">
                                            <li class = "current">
                                       </c:when>
                                       <c:otherwise>
                                           <li class = "open_mn">
                                       </c:otherwise>
                                    </c:choose>

	                                <a href="javascript:goMenuUrl('${pageContext.request.contextPath}${data.menuUrl}','0','${data.menuGrpStructSeq}')">${data.screenDisplayMenuNm }</a>
	                            <li>
	                        </c:otherwise>
	                    </c:choose>

	            </c:when>
	            <c:when test="${data.menuDepth eq 2 }">
	                <script type="text/javascript">
	                    var stStr = "<li><a href='javascript:goMenuUrl(\"${pageContext.request.contextPath}${data.menuUrl}\",\"0\",\"${data.menuGrpStructSeq}\")'";

	                   /*  if("${leftMenuGrpStructSeq}" == "${data.menuGrpStructSeq}" || "${currentUrl}" == "${data.menuUrl}") {

	                    	stStr += 'class="current">${data.screenDisplayMenuNm}</a></li>';
	                    	$("#leftMenu_${data.parentMenuGrpStructSeq }").parent().removeClass("open_mn").addClass("current");
	                    	//$("#leftMenu_${data.parentMenuGrpStructSeq }").toggle();
	                    }
	                    else { */
	                    	stStr += ">${data.screenDisplayMenuNm}</li>";
	                    	//$("#leftMenu_${data.parentMenuGrpStructSeq }").parent().addClass("close_mn");
	                    /* } */

	                    $("#leftMenu_${data.parentMenuGrpStructSeq }").append(stStr);
	                </script>
	            </c:when>
	        </c:choose>
        </c:if>
    </c:forEach>
    </ul>

</div>



