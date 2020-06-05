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
var paramJson2 = ${userVoListJson};
$(document).ready(function(){
    $("#${searchUserNameAttr }").keyup(function(){
        fn_searchUser();
    });
    $("#${searchUserNameAttr }").click(function(event){
        fn_searchUser();
    });
    $("body").click(function(){
        if($("#${searchUserNameAttr }:focus").size() == 0){
            $("#searchUserInfoSeqArea").hide();
        }
    });

    if($("#${searchUserNameAttr }").val()=="" && $("#${searchUserInfoIdSelectAttr }").val()!=""){
        $("#${searchUserNameAttr }").val($("#${searchUserInfoIdSelectAttr } option:selected").text());
    }
});

//검색어 keyup 이벤트
function fn_searchUser(){
    $("#${searchUserInfoIdSelectAttr }").val("");
    $("#searchUserInfoSeqArea").hide();
    var stStr = "";
    var inputUser = $("#${searchUserNameAttr }").val();

    if(inputUser == "") return;

    var searchJson = new Array();
    var cpnNm;
    $.each(paramJson2,function(key,value){
        var searchTxt = paramJson2[key].userName+"("+paramJson2[key].userId+")";
        if(searchTxt.indexOf(inputUser)>-1 ) searchJson.push(paramJson2[key]);

        if(inputUser == searchTxt){
            $("#${searchUserInfoIdSelectAttr }").val(paramJson2[key].userInfoId);
        }

    });
    //var regex = new RegExp(inputUser,'gi');
    if(searchJson.length>0){
        $.each(searchJson,function(key,value){
            searchTxt = searchJson[key].userName+"("+searchJson[key].userId+")";
            //var innerUserName = searchTxt.replace(regex, "<font  style='color: blue;'>"+inputUser+"</font>");
            var innerUserName = searchTxt.split(inputUser).join("<font  style='color: blue;'>"+inputUser+"</font>");
            stStr += "<div class='autocomplete-suggestion' id = 'userSelectedSeq_"+searchJson[key].userInfoId+"' onclick = \"fn_searchUserInfoSeq('userSelectedSeq_"+searchJson[key].userInfoId+"')\">";
            stStr += innerUserName+"</div>";
        });
        $("#searchUserInfoSeqArea").empty();
        $("#searchUserInfoSeqArea").append(stStr);
        $("#searchUserInfoSeqArea").show();
    }
}
//검색 셀렉트박스 선택시
function fn_searchUserInfoSeq(userInfoIdDiv){
    if(userInfoIdDiv!=""){
        var userInfoId = userInfoIdDiv.split("_")[1];
        $("#${searchUserInfoIdSelectAttr }").val(userInfoId);
        $("#${searchUserNameAttr }").val($("#"+userInfoIdDiv).text());
        $("#searchUserInfoSeqArea").hide();
    }
}
//소속회사 텍스트 박스에서 포커스가 떠날때 이름이 같은 회사가 있다면 선택한다.
function fn_userNameChk(){
    var userName = $("#${searchUserNameAttr }").val();
    $("#${searchUserInfoIdSelectAttr }").val("");
    $.each(paramJson2,function(key,value){
        if(userName == paramJson2[key].userId){
            $("#${searchUserInfoIdSelectAttr }").val(paramJson2[key].userInfoId);
            return false;
        }
    });
}
//회원
function fn_autoUserSelChange(value){
    $("#${searchUserInfoIdSelectAttr } option").each(function(){
        if($(this).val() == value){
            if($(this).text() != "선택하세요"){
                $("#${searchUserNameAttr }").val($(this).text());
            }
            else{
                $("#${searchUserNameAttr }").val('');
            }
            return false;
        }
    });
}
</script>

<!-- 커스텀 클래스가 있다면 셋팅 -->
<c:set var = "userNameClassName" value="input_s_b w240px"></c:set>
<c:set var = "userInfoSeqClassName" value="sel_basic mgl5"></c:set>

<c:if test="${searchUserNameClass ne null and searchUserNameClass ne '' }">
    <c:set var = "userNameClassName" value="${searchUserNameClass}"></c:set>
</c:if>
<c:if test="${searchUserInfoIdClass ne null and searchUserInfoIdClass ne '' }">
    <c:set var = "userInfoSeqClassName" value="${searchUserInfoIdClass}"></c:set>
</c:if>
<input type="text" class="${userNameClassName }" id="${searchUserNameAttr }" name="${searchUserNameAttr }" value="${searchUserName }" placeholder="회원명,아이디를 입력해 주세요."  autocomplete="off"/>

<select class="${userInfoSeqClassName }" title="회원선택" style="width: 194px" id="${searchUserInfoIdSelectAttr }" name="${searchUserInfoIdSelectAttr }" onchange="javascript:fn_autoUserSelChange(this.value);">
    <option value="">선택하세요</option>
    <c:forEach var="data" items="${userVoList}" varStatus="status">
        <option value="<c:out value='${data.userInfoId }' />" <c:if test="${searchUserInfoId ne null and data.userInfoId eq searchUserInfoId  }">selected="selected"</c:if>><c:out value='${data.userName }' />(<c:out value='${data.userId }' />)</option>
    </c:forEach>
</select>
<br>
<div class="autocomplete-suggestions" id="searchUserInfoSeqArea" style="position: absolute; max-height: 300px; z-index: 9999; width: 170px; display: none;"></div>