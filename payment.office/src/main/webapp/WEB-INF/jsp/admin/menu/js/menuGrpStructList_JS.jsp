<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
//선택한 메뉴그룹의 이름
var selectedNm = "";

$(document).ready(function(){

	$("#searchMenuGrpSeqSelect").change(function(){
		fn_reloadTree();
	});
	fn_reloadTree();
});

//트리 영역 로드
function fn_reloadTree(){
	var selectedString = $("#searchMenuGrpSeqSelect").val();
	if(selectedString == "") {
		return;
	}
	var selectedBuf = selectedString.split("_");
    var selectedValue = selectedBuf[0];
    $("#searchMenuGrpSeq").val(selectedValue);

	$("#searchMenuGrpSeqSelect option").each(function(i){
		if($(this).val()==$("#searchMenuGrpSeqSelect").val()){
			selectedNm = $(this).text();
		}
	});
	$("#selectedNm").val(selectedNm);
	$("#searchMenuGrpStructSeq").val(0);
	$("#frm").attr("action" , contextRoot + "/admin/authMng/menuStruct/getMenuGrpStructListAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_reloadTreeCallback);
}

//트리영역 로드 콜백
function fn_reloadTreeCallback(data){
	$('#menuTreeArea').empty();
	$('#menuTreeArea').html(data);

	$("#menuRoot").text(selectedNm);
	$("#menuGrpTitle").text(selectedNm);
	$("#menuRoot").append($("<IMG style='padding-left:5px' SRC='${pageContext.request.contextPath}/resources/images/board/common/bg_snb_on_arrow.gif' id = 'selectNode'/>"));
	$("#searchMenuDepth").val("0");
	fn_nodeDetail();
}

//노드 컨트롤
function fn_nodeControll(action){
	var url = "";
	var isValid = true;

	switch(action){
	case 'copy':
		if($("#searchMenuDepth").val()=="2"||$("#searchMenuDepth").val()=="3"){
            alert("<spring:message code='noti.menu.noCopyLv0' />");  //Lv0 이하 메뉴는 복사할수 없습니다.
            return;
        }
		if($("#nodeCount").val()=="0"){
            alert("<spring:message code='noti.menu.noCopyTarget' />");  //복사 대상이 없습니다.
            return;
        }
		/* $("#nodeCopyTargetStructSeq").val($("#searchMenuGrpStructSeq").val()); */
		$("#menuCopyBtn").text("붙여넣기");
		$("#menuCopyBtn").attr("onclick","javascript:fn_nodeControll('paste')");

		if($("#searchMenuDepth").val()=="0"){
			$("#nodeCopyTargetStructSeq").val(0);
		}else if($("#searchMenuDepth").val()=="1"){
			$("#nodeCopyTargetStructSeq").val($("#searchMenuGrpStructSeq").val());
		}

		$("#nodeCopyTargetGrpSeq").val($("#searchMenuGrpSeq").val());
		$("#nodeCopyTargetLocation").val($("#searchMenuGrpSeqSelect").val().split("_")[1]);
		break;
	case 'paste':
		if($("#searchMenuGrpSeqSelect").val().split("_")[1]!=$("#nodeCopyTargetLocation").val()){
			alert("<spring:message code='noti.menu.noCopyDiffMenu' />");  //복사 대상과 메뉴 위치가 다릅니다.
			return;
		}
		if($("#menuStructSeq_"+$("#nodeCopyTargetStructSeq").val()).length>0){
			alert("<spring:message code='noti.menu.noCopyDup' />");  //이미 존재하는 메뉴입니다.
			return;
		}

		if($("#nodeCopyTargetGrpSeq").val()==$("#searchMenuGrpStructSeq").val()){
			isValid=false;
		}
		$("#nodeCopyTargetStructParentSeq").val($("#searchMenuGrpStructSeq").val());
		if($("#nodeCopyTargetStructSeq").val() == "") isValid = false;
		url = contextRoot + "/admin/authMng/menuStruct/createMenuStructByNodeCopyAjax.do";
		break;
	}
	if(isValid && url !=""){
		$("#frm").attr("action" , url);
		commonAjaxSubmit("POST", $("#frm"), fn_nodeControllCallback);
	}else if(url == ""){
		alert("<spring:message code='noti.menu.copyComplete' />");  //복사되었습니다.
	}else{
		alert("<spring:message code='noti.menu.noCopyTargetOrSameMenuGrp' />");
		//복사 대상이 없거나 동일한 그룹메뉴입니다.
	}
}
//노드 컨텐츠박스 액션 이후 콜백 (리로드)
function fn_nodeControllCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		fn_reloadTree();
		$("#menuCopyBtn").val("메뉴복사");
        $("#menuCopyBtn").attr("onclick","javascript:fn_nodeControll('copy')");
	}else if(data.result == "<c:out value='${Constants.RESULT_REJECT }' />"){
		alert("<spring:message code='noti.menu.noCopyNoUseMenu' />");
		//복사대상메뉴중 사용하지 않는 메뉴가 있습니다. 메뉴그룹메뉴에서 사용여부를 확인해 주시기 바랍니다.
		fn_menuGrpMenuSelect();
	}else if(data.result == "<c:out value='${Constants.RESULT_NO_EXIST }' />"){
        alert("<spring:message code='noti.menu.noCopyTargetMenu' />");  //복사대상메뉴가 없습니다.
        fn_menuGrpMenuSelect();
    }else if(data.result == "<c:out value='${Constants.RESULT_FAIL }' />"){
		fn_menuGrpMenuSelect();
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}
//메뉴그룹 구조 삭제
function fn_deleteMenuStruct(){
	var url = contextRoot + "/admin/authMng/menuStruct/deleteMenuStructAjax.do";
	if(confirm("<spring:message code='request.common.delete' />")){  //삭제하시겠습니까?
		$("#frm").attr("action" , url);
	    commonAjaxSubmit("POST", $("#frm"), fn_deleteMenuStructCallback);
	}
}
//메뉴그룹 구조 삭제 콜백 (리로드)
function fn_deleteMenuStructCallback(data){
    if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
        fn_reloadTree();
    }else{
        fn_menuGrpMenuSelect();
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}
//우측 노드 디테일 화면을 보여준다.(노드클릭)
function fn_nodeDetail2(obj){
	//$("#selectNode").remove();
	if(obj.id == "menuRoot"){
		$(".select").removeClass("select");
		obj.className = obj.className+" select";
	    var dataBuf = obj.id;
        var data = dataBuf.split("_");
		$("#searchMenuGrpStructSeq").val(0);
		$("#menuGrpStructSeq").val(data[1]);
		$("#searchMenuDepth").val(0);
		$("#searchTopMenuGrpStructSeq").val(0);
	}else{
		$(".select").removeClass("select");
		obj.className = obj.className+" select";
		var dataBuf = obj.id;
	    var data = dataBuf.split("_");
	    $("#searchMenuGrpStructSeq").val(data[1]);
	    $("#menuGrpStructSeq").val(data[1]);
	    $("#searchTopMenuGrpStructSeq").val(data[4]);
	    $("#searchMenuDepth").val(parseInt(data[2])+1);
	    $("#searchBusinessTypeCd").val(dataBuf.split("|")[1]);
	    //$("#searchMenuGrpStructSeq").val(data[1]);
	}
	fn_nodeDetail();
}

//우측 노드 디테일 화면을 보여준다.
function fn_nodeDetail(){
	$("#frm").attr("action" , contextRoot + "/admin/authMng/menuStruct/getMenuGrpStructAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_nodeDetailCallback);
}
//노드의 디테일을 보여준다.
function fn_nodeDetailCallback(data){
	$("#menuStructDetailArea").empty();
	$("#menuStructDetailArea").append(data);
	fn_menuGrpMenuSelect();
}


//메뉴그룹 메뉴 리스트 조회
function fn_menuGrpMenuSelect(){
	if($("#searchMenuGrpSeq").val()=="") return;

	$("#frm").attr("action" , contextRoot + "/admin/authMng/menuStruct/getMenuGrpMenuListForStructAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_menuGrpMenuSelectCallback);
}

//메뉴그룹 메뉴리스트  콜백
function fn_menuGrpMenuSelectCallback(data){
	$("#menuGrpMenuListArea").empty();
	$("#menuGrpMenuListArea").html(data);

	 if($("#searchMenuDepth").val() == "3"){
		$("input[name = 'useMenuSeqList']").each(function(){
			$(this).hide();
			//fn_menuGrpStructMenuValidate();
		});

		//fn_menuGrpStructMenuValidate();
		//fn_chkAllClick();
   	}
	 /*else{
   		$("input[name = 'useMenuSeqList']").hide();
   		$("input[name *= '_chkBox']").hide();
   	} */

}
//메뉴 체크박스 벨리데이션
function fn_menuGrpStructMenuValidate(){
	if($("input[name = 'useMenuSeqList']:checked").length>1){
        var businessTypeBuf1 = $("input[name = 'useMenuSeqList']:checked").eq(0).val();
        var businessType1 = businessTypeBuf1.split("|")[1];

        var businessTypeBuf2 = $("input[name = 'useMenuSeqList']:checked").eq(1).val();
        var businessType2 = businessTypeBuf2.split("|")[1];
        if(businessType1 == businessType2){
            if($("#searchMenuDepth").val() == "0"){
               alert("<spring:message code='noti.menu.nodeNoSameBusinessType' />");  //첫번째 노드는 같은 업무유형으로 구성할수 없습니다.
               $("input[name = 'useMenuSeqList']").prop("checked",false);
               return;
            }

            if(businessType1!=$("#searchBusinessTypeCd").val()){
                alert(businessType1+","+$("#searchBusinessTypeCd").val()+"<spring:message code='noti.menu.nodeSameBusinessType' />");
                // : 마지막 노드는 부모노드와 업무유형이 같아야 합니다. 다시 확인해 주십시오.
                $("input[name = 'useMenuSeqList']").prop("checked",false);
                $("input[name *= '_chkBox']").prop("checked",false);
                return;
            }
            $("input[name = 'useMenuSeqList']").each(function(i){
                if($(this).val().indexOf(businessType1)==-1){
                    $(this).hide();
                    $("input[name*='_chkBox']").hide();
                    $("#"+businessType1+"_chkBox").show();
                }
            })
        }else{

            $("input[name = 'useMenuSeqList']:checked").each(function(){
                var businessType = $(this).val().split("|")[1];
                $("input[name *= 'useMenuSeqList']:not(checked").each(function(){
                    if($(this).val().indexOf(businessType)!=-1&&!$(this).prop("checked"))
                        $(this).hide();
                })
            })

            $("input[name*='_chkBox']").hide();
        }
    }else{
        $("input[type = 'checkbox']").show();
    }
}
//메뉴 구분별 접었다 펴기
function fn_toggleMenu(businessTypeCd){
	var toggleClass = $("#"+businessTypeCd+"_sort").attr("class");
	var innerToggleClass = toggleClass=='sort_lowtohigh'?'sort_hightolow':'sort_lowtohigh'
	$("#"+businessTypeCd+"_sort").removeClass();
	$("#"+businessTypeCd+"_sort").addClass(innerToggleClass);
	$("."+businessTypeCd+"_tr").toggle();
}

//비지니스타입별 allchk
function fn_businessTypeAllChk(businessType){
	if($("#"+businessType+"_chkBox").prop("checked")){
		$("."+businessType+"_tr").each(function(i){
			$(this).find("input[type='checkbox']").prop("checked",true);
		});
	}else{
		$("."+businessType+"_tr").each(function(i){
			$(this).find("input[type='checkbox']").prop("checked",false);
		});
	}

	if($("input[name = 'useMenuSeqList']:checked").length>1){
        var businessTypeBuf1 = $("input[name = 'useMenuSeqList']:checked").eq(0).val();
        var businessType1 = businessTypeBuf1.split("|")[1];

        var businessTypeBuf2 = $("input[name = 'useMenuSeqList']:checked").eq(1).val();
        var businessType2 = businessTypeBuf2.split("|")[1];
        if(businessType1 == businessType2){
        	if(businessType1!=$("#searchBusinessTypeCd").val()){
                alert(businessType1+","+$("#searchBusinessTypeCd").val()+"<spring:message code='noti.menu.nodeSameBusinessType' />");
                // : 마지막 노드는 부모노드와 업무유형이 같아야 합니다. 다시 확인해 주십시오.
                $("input[name = 'useMenuSeqList']").prop("checked",false);
                $("input[name *= '_chkBox']").prop("checked",false);
                return;
            }
        }
    }
}

//메뉴그룹메뉴 하위메뉴저장
function fn_doSaveMenuList(){
	if(confirm("<spring:message code='request.common.save' />")){  //저장하시겠습니까?
		$("input[name = 'useMenuSeqList']").prop("disabled",false);
		$("#frm").attr("action",contextRoot + "/admin/authMng/menuStruct/processMenuStructAjax.do");
		commonAjaxSubmit("POST", $("#frm"), fn_doSaveCallback);
	}
}
//메뉴그룹메뉴 하위메뉴저장 콜백
function fn_doSaveCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
		alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		$("#frm").find("input[name='deleteMenuSeqList']").remove();
		fn_reloadTree();
	}else{
		fn_menuGrpMenuSelect();
		alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
	}
}

//디스플레이 명을 바꾼다
function fn_modifyScreenNm(){
	$("#menuGrpStructSeq").val($("#searchMenuGrpStructSeq").val());
	$("#frm").attr("action",contextRoot + "/admin/authMng/menuStruct/modifyMenuStructScreenNmAjax.do");
	commonAjaxSubmit("POST", $("#frm"), fn_modifyScreenNmCallback);
}
function fn_modifyScreenNmCallback(data){
	if(data.result == "<c:out value='${Constants.RESULT_SUCCESS }' />"){
        alert("<spring:message code='success.common.save' />");  //정상적으로 저장되었습니다.
		fn_reloadTree();
    }else{
        fn_menuGrpMenuSelect();
        alert("<spring:message code='fail.common.save' />");  //저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.
    }
}
//온로드 후에 비지느스타입별 all체크되어있는지 확인
function fn_chkAllClick(){
	if($("input[name*='_chkBox']:checked").length>0){
	    $("input[name='useMenuSeqList']").prop("checked",false);
	    $("input[name='useMenuSeqList']").hide();

	    var $chkBox = $("input[name*='_chkBox']:checked");
	    var chkItemTrName = $chkBox.attr("name").substring(0,$(this).attr("name").lastIndexOf("_"));
	    var isAllchk = true;
	    $("."+chkItemTrName+"_tr").each(function(i){
            if(!$(this).find("input[name='useMenuSeqList']").prop("checked")){
                isAllchk = false;
            }
        });
	    if(isAllchk){
            $(this).prop("checked",true);
            $(this).show();
        }
	}

	if($("input[name = 'useMenuSeqList']:checked").length>1){
        var businessTypeBuf1 = $("input[name = 'useMenuSeqList']:checked").eq(0).val();
        var businessType1 = businessTypeBuf1.split("|")[1];

        var businessTypeBuf2 = $("input[name = 'useMenuSeqList']:checked").eq(1).val();
        var businessType2 = businessTypeBuf2.split("|")[1];
        if(businessType1 == businessType2){
        	if(businessType1!=$("#searchBusinessTypeCd").val()){
                alert(businessType1+","+$("#searchBusinessTypeCd").val()+"<spring:message code='noti.menu.nodeSameBusinessType' />");
                // : 마지막 노드는 부모노드와 업무유형이 같아야 합니다. 다시 확인해 주십시오.
                $("input[name *= '_chkBox']").prop("checked",false);
                $("input[name = 'useMenuSeqList']").prop("checked",false);
                return;
            }
        }
	}
}

</script>