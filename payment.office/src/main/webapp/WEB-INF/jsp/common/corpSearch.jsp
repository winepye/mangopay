<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp"%>
<!-- 기업 검색 css -->
<style>
.autocomplete-suggestions {border: 1px solid #999;background: #FFF;cursor: default;overflow: auto;}
.autocomplete-suggestion {white-space: nowrap;overflow: hidden;padding: 2px 5px;}
.autocomplete-suggestion:hover {background:#f5f7f8;}
</style>
<script type="text/javascript">
//소속회사 검색을 위한 전역변수
var paramJson = ${corpInfoVoListJson};
//검색조건 유지를 위한 변수
var searchCorpNmText = "";
var selectedDivId = "";
var index = -1;
var position  = 0;
$(document).ready(function(){

    $("#${corpNmText }").blur(function(){
        fn_corpNameChk();
    });
    $("#${corpNmText }").click(function(event){
        fn_searchCorp();
    });
    $("body").click(function(){
        if($("#${corpNmText }:focus").size() == 0){
            $("#searchCorpInfoSeqArea").hide();
            searchCorpNmText = "";
            selectedDivId = "";
            index = -1;
            position  = 23;
        }
    });

    if($("#${corpNmText }").val()=="" && $("#${corpInfoSeqSelect }").val()!=""){
        $("#${corpNmText }").val($("#${corpInfoSeqSelect } option:selected").text());
    }

    $("#${corpNmText }").keyup(function(event){
    	if(event.keyCode > 47||event.keyCode < 13){
    		searchCorpNmText = "";
            selectedDivId = "";
            index = -1;
            position  = 23;
    	    fn_searchCorp();
    	}
    })
    $("#${corpNmText }").keydown(function(event){
    	$("#searchCorpInfoSeqArea").find("div").css("background","#FFF");
    	if(event.keyCode == 40){
    	    if($("#searchCorpInfoSeqArea").css("display")!="none"&&$("#searchCorpInfoSeqArea").find("div").length>index){
    	    	if($("#searchCorpInfoSeqArea").find("div").length-1 == index){
    	    		$("#searchCorpInfoSeqArea").find("div").eq(index).css("background","#f5f7f8");
    	    		selectedDivId = $("#searchCorpInfoSeqArea").find("div").eq(index).attr("id");
    	    		return;
    	    	}
    	    	index++;
    	    	if(index == 0) searchCorpNmText = $(this).val();
    	    	$("#${corpNmText }").val($("#searchCorpInfoSeqArea").find("div").eq(index).text());
    	    	$("#searchCorpInfoSeqArea").find("div").eq(index).css("background","#f5f7f8");
    	    	selectedDivId = $("#searchCorpInfoSeqArea").find("div").eq(index).attr("id");
    	    	position=position+23;
    	    	if(index>12){
    	    		  $('#searchCorpInfoSeqArea').animate({scrollTop : position-46+"px"}, 0);
    	    	}

    	    }
    	}else if(event.keyCode == 38){
    		if($("#searchCorpInfoSeqArea").css("display")!="none"&&-1<index){
                $("#searchCorpInfoSeqArea").find("div").eq(index).css("background","#f5f7f8");
                $("#${corpNmText }").val($("#searchCorpInfoSeqArea").find("div").eq(index).text());
                selectedDivId = $("#searchCorpInfoSeqArea").find("div").eq(index).attr("id");
                position=position-23;
                if(position>=0){
                      $('#searchCorpInfoSeqArea').animate({scrollTop : position-46+"px"}, 0);

                }
                index--;

            }else if(index == -1){
            	$("#${corpNmText }").val(searchCorpNmText);
            }
    	}else if(event.keyCode == 13){
            if($("#searchCorpInfoSeqArea").css("display")!="none"&&index!=-1){
            	fn_searchCorpInfoSeq(selectedDivId);
                event.preventDefault();
            }
        }
    });
});

//검색어 keyup 이벤트
function fn_searchCorp(){
    $("#${corpInfoSeqSelect }").val("");
    $("#searchCorpInfoSeqArea").hide();
    var stStr = "";
    var inputCorp = $("#${corpNmText }").val();

    if(inputCorp == "") return;

    var searchJson = new Array();
    var cpnNm;
    $.each(paramJson,function(key,value){
        cpnNm = paramJson[key].cpnNm
        if(cpnNm.indexOf(inputCorp)>-1 ) searchJson.push(paramJson[key]);

        if(inputCorp == cpnNm){
            $("#${corpInfoSeqSelect }").val(paramJson[key].corpInfoSeq);
        }

    });
    //var regex = new RegExp(inputCorp,'gi');
    if(searchJson.length>0){
        $.each(searchJson,function(key,value){
            //var innerCpnNm = searchJson[key].cpnNm.replace(regex, "<font  style='color: blue;'>"+inputCorp+"</font>");
            var innerCpnNm = searchJson[key].cpnNm.split(inputCorp).join("<font  style='color: blue;'>"+inputCorp+"</font>");
            stStr += "<div class='autocomplete-suggestion' id = 'corpSelectedSeq_"+searchJson[key].corpInfoSeq+"' onclick = \"fn_searchCorpInfoSeq('corpSelectedSeq_"+searchJson[key].corpInfoSeq+"')\">";
            stStr += innerCpnNm+"</div>";
        });
        $("#searchCorpInfoSeqArea").empty();
        $("#searchCorpInfoSeqArea").append(stStr);
        $("#searchCorpInfoSeqArea").show();
    }
}
//검색 셀렉트박스 선택시
function fn_searchCorpInfoSeq(corpInfoSeqDiv){
	searchCorpNmText = "";
    selectedDivId = "";
    index = -1;
    position  = 23;

    if($("#${corpInfoSeqSelect }").val()!=""){

        $("#searchCorpInfoSeqArea").hide();
        return;
    }
    if(corpInfoSeqDiv!=""){
        var corpInfoSeq = corpInfoSeqDiv.split("_")[1];
        $("#${corpInfoSeqSelect }").val(corpInfoSeq).change();
        $("#${corpNmText }").val($("#"+corpInfoSeqDiv).text());
        $("#searchCorpInfoSeqArea").hide();
    }
}
//소속회사 텍스트 박스에서 포커스가 떠날때 이름이 같은 회사가 있다면 선택한다.
function fn_corpNameChk(){
	if($("#${corpInfoSeqSelect }").val()!="") return;
    var cpnNm = $("#${corpNmText }").val();
    $("#${corpInfoSeqSelect }").val("")
    $.each(paramJson,function(key,value){
        if(cpnNm == paramJson[key].cpnNm){
            $("#${corpInfoSeqSelect }").val(paramJson[key].corpInfoSeq);
            return false;
        }
    });
}
//기업선택
function fn_autoComSelChange(value){
    if(value == ""){
        $("#${corpNmText }").val('');
        return;
    }
    $("#${corpInfoSeqSelect } option").each(function(){
        if($(this).val() == value){
            if($(this).text() != "선택하세요"){
                $("#${corpNmText }").val($(this).text());
            }
            else{
                $("#${corpNmText }").val('');
            }
            return false;
        }
    });
}
</script>

<!-- 커스텀 클래스가 있다면 셋팅 -->
<c:set var = "corpNmClassName" value="join_s_b w_favcom"></c:set>
<c:set var = "corpInfoSeqClassName" value="join_sel_b"></c:set>

<c:if test="${corpNmClass ne null and corpNmClass ne '' }">
    <c:set var = "corpNmClassName" value="${corpNmClass}"></c:set>
</c:if>
<c:if test="${corpInfoSeqClass ne null and corpInfoSeqClass ne '' }">
    <c:set var = "corpInfoSeqClassName" value="${corpInfoSeqClass}"></c:set>
</c:if>
<input type="text" class="${corpNmClassName }" id="${corpNmText }" name="${corpNmText }" value="${corpNm }" placeholder="기업명을 입력해 주세요." autocomplete="off"/>

<select class="${corpInfoSeqClassName }" title="기업선택" style="width: 194px" id="${corpInfoSeqSelect }" name="${corpInfoSeqSelect }" onchange="javascript:fn_autoComSelChange(this.value);">
    <option value="">${firstSel == null? '선택하세요':firstSel }</option>
    <c:forEach var="data" items="${corpInfoVoList}" varStatus="status">
        <option value="<c:out value='${data.corpInfoSeq }' />" <c:if test="${corpInfoSeq ne null and data.corpInfoSeq eq corpInfoSeq  }">selected="selected"</c:if>><c:out value='${data.cpnNm }' /></option>
    </c:forEach>
</select>
<br>
<div class="autocomplete-suggestions" id="searchCorpInfoSeqArea" style="position: absolute; max-height: 300px; z-index: 9999; width: 170px; display: none;"></div>