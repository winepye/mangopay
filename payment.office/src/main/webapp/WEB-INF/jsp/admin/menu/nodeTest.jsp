<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<%-- <%@ include file="./js/codeMng_JS.jsp"%> --%>
<!--
  * @Class Name  : menuList.jsp
  * @Description : 메뉴관리화면
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2018.10.14	이인희      최초 생성
-->
<body class="nosidebar">
<section id="detail_contents">

	<div id='demo1' class='demo'>
		<ul>
			<li id='phtml_1'><a href='#'>부모 노드 1</a>
				<ul>
					<li id='phtml_2'><a href='#'>자식 노드 1</a></li>
					<li id='phtml_3'><a href='#'>자식 노드 2</a></li>
					<li id='phtml_4'><a href='#'>자식 노드 3</a></li>
				</ul>
			</li>
			<li id='phtml_5'><a href='#'>부모 노드 2</a>
				<ul>
					<li id='phtml_6'><a href='#'>자식 노드 1</a></li>
					<li id='phtml_7'><a href='#'>자식 노드 2</a></li>
					<li id='phtml_8'><a href='#'>자식 노드 3</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<script type="text/javascript">
	var obj2;
		$(function() {
			$("#toggle_node").click(function() {
				$("#demo1").jstree("toggle_node", "#phtml_1");
			});
			$("#demo1")
				.jstree({
					"themes" : {
						"theme" : [ "classic" ]
					}, // 트리 테마
					"ui" : {
						"initially_select" : [ "phtml_2" ]
					},
					"core" : {
						"initially_open" : [ "phtml_1" ],
						"html_titles" : [ "true" ]
					},
					"contextmenu" : {
					      "items" : {
					          "create" : {
					              "separator_before" : false,
					              "separator_after"  : true,
					              "label"            : "만들기3",
					              "action"           : function (obj) { alert(obj);
					              										obj2 = obj;
					              										}
					          },
					          "rename" : {
					              "separator_before" : false,
					              "separator_after"  : true,
					              "label"            : "이름변경",
					              "action"           : function (obj) { this.create(obj); }
					          },
					          "remove" : {
					              "separator_before" : false,
					              "separator_after"  : true,
					              "label"            : "삭제",
					              "action"           : function (obj) { this.create(obj); }
					          },
					          "ccp" : {
					              "separator_before" : false,
					              "separator_after"  : true,
					              "label"            : "편집",
					              "action"           : function (obj) { this.create(obj); }
					          },
					          "user_define" : {
					             "separator_before" : false,
					              "separator_after"  : true,
					              "label"            : "사용자정의",
					              "action"           : function (obj) { this.create(obj); }
					          },
					      }
					},
					"dnd" : {
					       "drop_finish" : function () {
					            alert("DROP");
					        },
					        "drag_check" : function (data) {
					            alert("CHECK");
					            if(data.r.attr("id") == "phtml_1") {
					                return false;
					            }
					            return {
					               after : false,
					               before : false,
					               inside : true
					            };
					        },
					        "drag_finish" : function (data) {
					            alert("DRAG OK");
					        }
					},
					"plugins" : [ "themes", "html_data" ,"ui", "crrm", "contextmenu","dnd" ]
				});

			$("#demo1")
				.bind("select_node.jstree", function (event, data) {
					$("#log1").html('선택된 노드 id: ' + data.rslt.obj.attr("id"));
      			});

			$("#demo1")
				.bind("open_node.jstree", function(event, data) {
					$("#log1").html("oepn operation: " + event.type);
				});

			$("#demo1")
				.bind("close_node.jstree", function(event, data) {
					$("#log1").html(data.rslt.obj.attr("id") + " close operation: " + event.type);
				});

		});
	</script>

	<div id="log1">log</div>
</section>
</body>