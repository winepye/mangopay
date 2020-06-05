<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<!--
  * @Class Name  : generalReportList_JS.jsp
  * @Description : admin > generalReportList_JS
  * @Modification Information
  * @
  * @ 수정일        수정자      수정내용
  * @ 2016.05.09	이인희      최초 생성
-->
<script type="text/javascript" defer="defer">
    $(document).ready(function(){

        datePickerWrap("#searchFromDt");
        datePickerWrap("#searchToDt");

      //검색버튼
		$("#btnSearch").click(function() {
			fn_doSearch(1);
		});

        //
        $('#searchApproveYn').click(function () {
			fn_doSearch(1);
         });

        //
        $('#searchCancelYn').click(function () {
			fn_doSearch(1);
         });

        //초기화버튼
        $("#btnInit").click(function(){
            fn_doInit();
        });
    });


    //승인취소
    function cancelApprove(txId){
    	if(!confirm("해당 항목을 승인취소 하시겠습니까?")) return;
    	var url = "/common/approve/cancel/cancelApproveAjax.do";

    	var param = {
    			txId : txId
    	};

    	var callback = function(data){
    		if(data.resultCode == "0000"){
        		alert("정상적으로 승인취소되었습니다.");
        		fn_doSearch($("#currentPageNo").val());
        	}else{
        		alert("승인취소가 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        		fn_doSearch($("#currentPageNo").val());
        	}
    	}
    	commonAjaxParam("POST", url, param, callback);
    }

    ////////////////////////////////////////////////////////
    /// 기존소스
    ///////////////////////////////////////////////////////////
    //검색영역초기화
    function fn_doInit(){
        $("#searchDateType").val('analDt');
        fn_setDate('${Constants.SEARCH_DEFAULT_PER_MONTH }');
        $("#searchUserName").val("");
        $("#searchUserId").val("");
        $("#searchTitle").val("");
    }

    //검색 ,페이지 이동
    function fn_doSearch(pageNo){
        $("#frm").attr("action" , contextRoot + "/admin/service/payment/getPaymentListAjax.do");
        $("#currentPageNo").val(pageNo);
        commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
    }

    // 20개씩, 40개씩, 60개씩 보기
    function fn_listChange(val){
        $("#recordCountPerPage").val(val);
        fn_doSearch("1");
    }

    // 정렬
    function fn_doSort(val) {

        var toggleClass = $("#sort_column_prefix"+val).attr("class");
        var innerToggleClass = toggleClass == 'sort_hightolow' ? 'sort_lowtohigh' : 'sort_hightolow';

        $("#sort_column_prefix0").removeClass();
        $("#sort_column_prefix0").addClass("sort_normal");
        $("#sort_column_prefix1").removeClass();
        $("#sort_column_prefix1").addClass("sort_normal");
        $("#sort_column_prefix2").removeClass();
        $("#sort_column_prefix2").addClass("sort_normal");
        $("#sort_column_prefix3").removeClass();
        $("#sort_column_prefix3").addClass("sort_normal");

        $("#sort_column_prefix"+val).removeClass();
        $("#sort_column_prefix"+val).addClass(innerToggleClass);

        $("#sortKind").val(innerToggleClass);
        $("#sortList").val(val);

        fn_doSearch("1");
    }

    // 검색,페이지 이동 콜백
    function fn_searchCallback(data){
        $("#listArea").empty();
        $("#listArea").html(data);

        $("#listTotalCnt").text($("#listTotalCntHidden").val());
    }

    //기간 셋팅
    function fn_setDate(inMonth){

        var now = new Date();

        var searchStartDt = now.yyyy_mm_dd();
        now.setMonth(now.getMonth()-inMonth);

        var seachEndDt = now.yyyy_mm_dd();

        $("#searchFromDt").val(seachEndDt);
        $("#searchToDt").val(searchStartDt);
    }

    //탭 목록 클릭
    function fn_setIndustCategCd(industCategCd){
        $("#searchIndustCategCd").val(industCategCd);
        $("#tabUl li").each(function(i){
            $(this).removeClass();
            if($(this).attr("id") == "tabLi_"+industCategCd) $(this).addClass("on");
        });
        fn_doSearch("1");
    }

    function fn_goDetailPage(reportSeq){
        $("#searchReportSeq").val(reportSeq);
        $("#frm").attr("action",contextRoot + "/admin/report/general/generalReportDetail.do");
        $("#frm").submit();
    }

  //상세팝업
	function fn_openDetailPage(txId){
		var windowW = 800;  // 창의 가로 길이
        var windowH = 500;  // 창의 세로 길이
        var left = Math.ceil((window.screen.width - windowW)/2);
        var top = Math.ceil((window.screen.height - windowH)/2);

		var url = contextRoot + "/admin/service/payment/getPaymentDetailPop.do?txId=" + txId;
		window.open(url,"PaymentDetailPop","scrollbars=yes,toolbar=yes,resizable=yes, top="+top+", left="+left+", height="+windowH+", width="+windowW);

	}
</script>