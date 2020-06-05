<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<script type="text/javascript" defer="defer">
    $(document).ready(function(){

        datePickerWrap("#searchSdate");
        datePickerWrap("#searchEdate");
        fn_setDate(0, "day");

        fn_check(); // 날짜 셋팅 이후로

    });

    /*
      inNum : n일 or n월
      type : day, month
    */
    function fn_setDate(inNum, type){

        var now = new Date();

        var searchStartDt = now.yyyy_mm_dd();

        if(type == "month"){
            now.setMonth(now.getMonth()-inNum);
            now.setDate(now.getDate() +1);
        }else if(type == "day"){
            now.setDate(now.getDate() - inNum);
        }

        var seachEndDt = now.yyyy_mm_dd();

        $("#searchSdate").val(seachEndDt);
        $("#searchEdate").val(searchStartDt);

    }

    function fn_check(){
        //var ss = $("#tempSdate").val();
        //var ee = $("#tempEdate").val();

        console.log("====> tempSdate :: " + $("#tempSdate").val());
        console.log("====> tempEdate :: " + $("#tempEdate").val());

        $("#searchSdate").val($("#tempSdate").val());
        $("#searchEdate").val($("#tempEdate").val());

    }


</script>