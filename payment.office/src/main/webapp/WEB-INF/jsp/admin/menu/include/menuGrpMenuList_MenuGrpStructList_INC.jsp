<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<c:set var = "nodeCount" value="0" />
<h2 class="h2_table_title2 mgt20"><a href="javascript:fn_nodeDetail2(this);" id="menuGrpTitle"></a></h2>
    <div class="clearbothWrap2">
        <div class="flblock_20">
	        <div class="groupListbox2">
	            <ul>
	                <li>
	                    <a href="#this" onclick="fn_nodeDetail2(this);" id="menuRoot" class="select"></a>
	                    <ul></ul>
	                </li>

	                <c:forEach var="data" items="${menuGrpStructVoList }" varStatus="i">
	                   <c:choose>
	                    <c:when test="${data.parentMenuGrpStructSeq eq 0}">
	                        <c:set var = "nodeCount" value="${nodeCount+1 }" />
	                        <script type="text/javascript">
	                        $("#nodeCount").val("${nodeCount}");
	                        var stStr = '<li>';
	                        stStr     += '<a id="menuStructSeq_${data.menuGrpStructSeq }_${data.menuDepth}_${data.parentMenuGrpStructSeq}_${data.topMenuGrpStructSeq}_|${data.businessTypeCd}" href="#this" onclick="fn_nodeDetail2(this)">';
	                        stStr     += 'Lv${data.menuDepth} : ${data.screenDisplayMenuNm }';
	                        stStr     += '</a><ul></ul>';
	                        stStr     += '</li>';

	                        $("a[id = 'menuRoot']").parent().after(stStr);

	                        </script>
	                    </c:when>
	                    <c:otherwise>
	                            <c:set var = "nodeCount" value="${nodeCount+1 }" />
	                            <script type="text/javascript">
	                            //var tabStr = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	                            var $targetTr = $("a[id *= 'menuStructSeq_${data.parentMenuGrpStructSeq}']");
	                            var stStr = "<li>"
	                            stStr       += "<a id='menuStructSeq_${data.menuGrpStructSeq }_${data.menuDepth}_${data.parentMenuGrpStructSeq}_${data.topMenuGrpStructSeq}_|${data.businessTypeCd}' href='#this' onclick='fn_nodeDetail2(this)'>";

	                            var menuDepth = "${data.menuDepth}";
	                            /* stStr       +=tabStr; */
	                            stStr       +="Lv${data.menuDepth} : ${data.screenDisplayMenuNm }</a><ul></ul>";
	                            stStr   += "</li>";


	                            $("a[id *= 'menuStructSeq_${data.parentMenuGrpStructSeq}']").parent().find("ul").eq(0).prepend(stStr);
	                            $("#nodeCount").val("${nodeCount}");
	                            </script>
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	            </ul>
	        </div>
    </div>
 <div id="menuStructDetailArea"></div>