<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/commonTag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/commJS.jsp"%>
<script type="text/javascript" defer="defer">
    $(document).ready(function(){

        datePickerWrap("#searchSdate");
        datePickerWrap("#searchEdate");
        fn_setDate(0, "day");

        fn_check(); // 날짜 셋팅 이후로

        // 검색영역 접기/열기
        $("#btnClose").click(function(){
            fn_searchAreaToggle();
        });

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

    //검색영역초기화
    function fn_doInit(){
      
      // 고객사명
      $("#searchCompanyName").val('');
      
      // 브랜드명
      $("#searchBrandName").val('');
      
      // 매장명
      $("#searchShopName").val('');
      
      // 사업자번호
      $("#searchBizNum").val('');
      
      // CAT-ID
      $("#searchCatId").val('');
      
      // 결제수단
      $("input[name=searchPaymentMethod]:checkbox").each(function(){
        $(this).prop("checked", false);
      });
      
      // 서비스제공자
      $("input[name=searchSrvProvider]:checkbox").each(function(){
        $(this).prop("checked", false);
      });
      
      // 기간
      fn_setDate(0, "day");

    }

    //검색 ,페이지 이동
    function fn_doSearch(pageNo){

        $("input[name=searchPaymentMethod]:checked").each(function(){
            console.log(": "+$(this).val());
        });

        $("#frm").attr("action" , contextRoot + "/admin/service/mpos/getMposSrvListAjax.do");
        $("#currentPageNo").val(pageNo);
        commonAjaxSubmit("POST", $("#frm"), fn_searchCallback);
    }

    // 검색,페이지 이동 콜백
    function fn_searchCallback(data){
      $("#listArea").empty();
      $("#listArea").html(data);

      $("#searchTotalCount").text($("#listTotalCount").val());
    }

    // 검색영역 접기/열기
    function fn_searchAreaToggle(){

        if($("#btnClose").text() == "검색영역 접기"){
            $("#btnClose").text("검색영역 열기")
        }else{
            $("#btnClose").text("검색영역 접기")
        }
        // 접기/열기 토글
        $("#searchArea").toggle();
    }

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

    //20개씩, 40개씩, 60개씩 보기
    function fn_listChange(val){
      $("#recordCountPerPage").val(val);
      fn_doSearch("1");
    }

    //정렬순서
    function fn_doSort(type){

        if(type == 1){
            var targetClass = $("#sort_column_prefix0").attr("class");

            if(targetClass == "sort_hightolow"){
                $("#sort_column_prefix0").removeClass("sort_hightolow");
                $("#sort_column_prefix0").addClass("sort_lowtohigh");

                $("#sortOrder").val("A.PAYMENT_HIST_ID ASC");
            }else if(targetClass == "sort_lowtohigh"){
                $("#sort_column_prefix0").removeClass("sort_lowtohigh");
                $("#sort_column_prefix0").addClass("sort_hightolow");

                $("#sortOrder").val("A.PAYMENT_HIST_ID DESC");
            }
        }else if(type == 2){

        }

        fn_doSearch(1);
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

    // 상세 팝업 (POPUP)
	function fn_openDetailPop(paymentHistId, histCnt){

      console.log("===> " + paymentHistId);
      console.log("===> " + histCnt);

      var url2 = "www.naver.com";
      var url = contextRoot + "/admin/service/mpos/mposSrvDetailPop.do?paymentHistId=" + paymentHistId;

      var height = 500;

      if(histCnt != "1"){
          height = 800;
      }


      console.log("===> " + url2);
      console.log("===> " +contextRoot);
      fn_popUp('mposPayDetailPop', 800, height, url );

    }



</script>