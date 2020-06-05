/* ==================================== 공통 기능 사용을 위한 전역변수 :S */
//공통코드 처리를 위한 전역변수
var codeurl= contextRoot + "/common/searchCode.do";
var codeTarget = "";

//화면 네비게이션 스트링
var navigationStr = "";
/* ==================================== 공통 기능 사용을 위한  전역변수 :E */

/* ====================================Custom Jquery Validation :S */
$.validator.addMethod("engnum", function(value) {  return   isEngNum(value) }); /* 영어, 숫자만 입력가능 */
$.validator.addMethod("isNum", function(value)  {   return  isNumber(value) }); /* 숫자만 입력가능 */
$.validator.addMethod("isNumComma", function(value)  {   return  isNumberComma(value) }); /* 숫자만 입력가능 */
/* ====================================Custom Jquery Validation :E */

/*=========================================== checkValidator overide :S*/
/* 같은 이름이 있어도 Validation되도록 변경 */
$.validator.prototype.checkForm = function() {
    this.prepareForm();
    for ( var i = 0, elements = (this.currentElements = this.elements()); elements[i]; i++ ) {
        if (this.findByName( elements[i].name ).length != undefined && this.findByName( elements[i].name ).length > 1) {
            for (var cnt = 0; cnt < this.findByName( elements[i].name ).length; cnt++) {
                this.check( this.findByName( elements[i].name )[cnt] );
            }
        } else {
            this.check( elements[i] );
        }
    }
    return this.valid();
};

/*=========================================== checkValidator overide :E*/
/*
//table에 체크박스를 모두 클릭한다. : thead에 All Click 체크박스가 있는경우.
function fn_allCheck(tableId){
	var allClick = true;
	if(!$("#"+tableId+" thead input[type='checkbox']").eq(0).prop("checked")){
		allClick = false;
	}
	$("#"+tableId+" tbody input[type='checkbox']").each(function(){
        if(!$(this).prop("disabled")){
		    $(this).prop("checked",allClick);
        }
	});
}
//thead에 All Click 체크박스가 있는경우  : tbody에서 thead 전체 선택/해제
function fn_eachCheck(tableId){
    var eachChk = true;
    $("#"+tableId+" tbody input[type='checkbox']").each(function(){
        if(!$(this).prop("disabled")){
    	    if(!$(this).prop("checked")) eachChk = false;
        }
    });
    $("#"+tableId+" thead input[type='checkbox']").prop("checked", eachChk);
}
*/
//ajax용 화면 보호기
function wrapWindowByMask(){
	//화면의 높이와 너비를 구한다.
	//var maskHeight = document.body.scrollHeight;
	var maskHeight = $("body").prop("scrollHeight");
	var maskWidth = $(window).width();

	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	$('#mask').css({'width':maskWidth,'height':maskHeight});

	//애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
	$('#mask').fadeIn(1000);
	$('#mask').fadeTo("slow",0.8);

	//윈도우 같은 거 띄운다.
	//$('.window').show();
}

//Daum Editor 에 데이터를 셋팅한다.
function setEditorContent(content){
	Editor.modify({
		 "content":$("#content").val()
		 });
}

//Daum Editor에 컨텐츠가 입력여부를 체크한다.
function isExistEditorContent(){
	var validator = new Trex.Validator();
	return validator.exists(Editor.getCanvas().getContent());
}

//Array Remove - By John Resig (MIT Licensed) - http://ejohn.org/blog/javascript-array-remove/
Array.prototype.remove = function(from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
    this.length = from < 0 ? this.length + from : from;
    return this.push.apply(this, rest);
};

//모달 오픈
//messageDivId: 모달창에 보여질 영역의 div
//title: 모달창에 제목
//width: 가로 px (default : 700px)
//heigth: 가로 px (default : 500px)
//draggableClass: 팝업을 드래그할수 있는영역
//theme: jquery 테마 적용 여부 (default : true)
function openModalPop(messageDivId , title , width , heigth , top ,left ,draggableClass, theme){
	var modalMessage = $("#"+messageDivId);

	var modalTheme = (theme=='' || theme == undefined)?true:theme;
	var modalWidth = (width=='' || width == undefined)?'700px':width;
	var modalHeigth = (heigth=='' || heigth == undefined)?'500px':heigth;
	var modalTop = (top=='' || top == undefined)?'20%':top;
	var modalLeft = (left=='' || left == undefined)?'35%':left;

	//var modalWidthNum = Number(modalWidth.split("px").join(""));
	//var modalHeigthNum = Number(modalHeigth.split("px").join(""));

	//var modalLeft = ( $(window).scrollLeft() + ($(window).width() - modalWidthNum) / 2 );
	//var modalTop = ( $(window).scrollTop() + ($(window).height() - modalHeigthNum) / 2 );
	var targetDraggableClass = (draggableClass=='' || draggableClass == undefined)?'pop_titleZone':draggableClass;

	$.blockUI({
		theme:     modalTheme,
		message: modalMessage
		//css 설정
	   ,css: {
		   width: modalWidth,
		   heigth: modalHeigth
		}
	  ,themedCSS: {
	        width:  modalWidth,
			heigth: modalHeigth,
	        top:    modalTop,
	        left:   modalLeft
	    },
	    title : title
	   ,bindEvents:false
		//모달창 외부 클릭시 닫기
	   ,onOverlayClick: $.unblockUI
	   ,draggable : true
	   ,overlayCSS:{backgroundColor:'',oapcity:0,cursor:'pointer'}

	});
	$("."+targetDraggableClass).css("padding-top","20px");
	$("."+targetDraggableClass).addClass("ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle ui-draggable-handle");

	if(title!=''){
		$("#"+messageDivId).attr("style","padding-left: 10px;padding-right: 10px;padding-bottom: 10px;padding-top: 10px;");
	}
}

//모달 메세지 팝업(전체창)
function alertMsg(msg){
	$.blockUI({
		message : msg + "<br><br><input type='button' value='닫기' onclick='removeMsg();' />",
		css : {
			border : '1px solid #CCCCCC'	//border style.
		}
	});
}

//모달 메세지 닫기(전체창)
function removeMsg(){
	$.unblockUI();
}
//화면 인쇄
function fn_printPage(){
    window.print();
}
//링크복사
function fn_copyUrlToClipboard() {
    //window.clipboardData.setData("Text", window.location.href);
    alert("복사되었습니다.");
  }
////////////////////////spin////////////////////
var opts_main = {
		  lines: 17, // The number of lines to draw
		  length: 20, // The length of each line
		  width: 10, // The line thickness
		  radius: 34, // The radius of the inner circle
		  corners: 1, // Corner roundness (0..1)
		  rotate: 0, // The rotation offset
		  direction: 1, // 1: clockwise, -1: counterclockwise
		  color: '#EBFBFF', // #rgb or #rrggbb or array of colors
		  speed: 1, // Rounds per second
		  trail: 60, // Afterglow percentage
		  shadow: false, // Whether to render a shadow
		  hwaccel: false, // Whether to use hardware acceleration
		  className: 'spinner' // The CSS class to assign to the spinner
		  //zIndex: 2e9, // The z-index (defaults to 2000000000)
		};
var spinner_main;
function progressView(){
	$('#progress').css('display','block');
	var target = document.getElementById('progress');
	spinner_main = new Spinner(opts_main).spin(target);
}

//검색영역 초기화
//radio박스는 개별 초기화
function searchAreaReset(areaId){
    $("#"+areaId+" input,#"+areaId+" select").each(function(i){
       if($(this).attr("type")!="button"&&$(this).attr("type")!="radio"&&$(this).attr("type")!="checkbox")
           $(this).val("");
    });
}
/////////////////////cookie//////////////////////////

/**
 * 쿠키 값추가
 */
function addCookie(name, value, url, expiredays){
    var todayDate = new Date();
    if(Number(expiredays)>0){
        todayDate.setDate( eval(todayDate.getDate() + expiredays) );
    }else if(Number(expiredays) == 0){
        todayDate = null;
    }else{
        todayDate.setDate( todayDate.getDate() + 30);
    }
    document.cookie = name + "=" + escape( value ) +
        (todayDate!=null ? "; expires=" + todayDate.toGMTString() : "") +
        (url!=null ? "; path="+url : " " );
}

/**
 * 쿠키 값 얻기
 */
function getCookie(name){
    var Found = false;
    var start, end;
    var i = 0;
    while(i <= document.cookie.length){
        start = i;
        end = start + name.length;
        if(document.cookie.substring(start, end) == name){
            Found = true;
            break;
        }
        i++;
    }

    if(Found == true){
        start = end + 1;
        end = document.cookie.indexOf(";", start);
        if(end < start){
            end = document.cookie.length;
        }
        return document.cookie.substring(start, end);
    }else{
        return "";
    }
}

/**
 * 쿠키 값추가2
 */
function setCookie(cookieName, value, exdays){
 var exdate = new Date();
 exdate.setDate(exdate.getDate() + exdays);
 var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
 document.cookie = cookieName + "=" + cookieValue + ";path=/";
}

/**
 * 쿠키 삭제
 */
function deleteCookie(cookieName){
 var expireDate = new Date();
 expireDate.setDate(expireDate.getDate() - 1);
 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + ";path=/";
}

/*************************************************************************************************
설명   :브라우저명, 버전
**************************************************************************************************/
var browserDetect = {
    init: function () {
        this.browser = this.searchString(this.dataBrowser) || "Other";
        this.version = this.searchVersion(navigator.userAgent) || this.searchVersion(navigator.appVersion) || "Unknown";

        return this;
    },
    searchString: function (data) {
        for (var i = 0; i < data.length; i++) {
            var dataString = data[i].string;
            this.versionSearchString = data[i].subString;

            if (dataString.indexOf(data[i].subString) !== -1) {
                return data[i].identity;
            }
        }
    },
    searchVersion: function (dataString) {
        var index = dataString.indexOf(this.versionSearchString);
        if (index === -1) {
            return;
        }

        var rv = dataString.indexOf("rv:");
        if (this.versionSearchString === "Trident" && rv !== -1) {
            return parseFloat(dataString.substring(rv + 3));
        } else {
            return parseFloat(dataString.substring(index + this.versionSearchString.length + 1));
        }
    },

    dataBrowser: [
        {string: navigator.userAgent, subString: "OPR", identity: "Opera"},
        {string: navigator.userAgent, subString: "MSIE", identity: "Explorer"},
        {string: navigator.userAgent, subString: "Trident", identity: "Explorer"},
        {string: navigator.userAgent, subString: "Firefox", identity: "Firefox"},
        {string: navigator.userAgent, subString: "Chrome", identity: "Chrome"},
        {string: navigator.userAgent, subString: "Safari", identity: "Safari"}
    ]

};
var browserInfo = browserDetect.init();
/*************************************************************************************************
설명 : IE9인지 체크.
**************************************************************************************************/
function _gfn_isiE9() {
    return browserInfo.browser == "Explorer" && parseInt(browserInfo.version) <10;
}
/*************************************************************************************************
설명 : IE8인지 체크.
**************************************************************************************************/
function _gfn_isiE8() {
    return browserInfo.browser == "Explorer" && parseInt(browserInfo.version) <9;
}

/////////////////////popup//////////////////////////
function openPopupByCookie(name, value, url, title, popWidth, popHeight){
    if(getCookie(name) != value) {
        openPopup(url, title, popWidth, popHeight);
    }
    else{
        //alert("쿠키에서 팝업안뜨도록 제어 됨");
    }
}

function openPopup(url, title, popWidth, popHeight){
    var winWidth    = document.body.clientWidth;   // 현재창의 너비
    var winHeight   = document.body.clientHeight;	// 현재창의 높이
    var winX        = window.screenX; //현재창의 x좌표
    var winY        = window.screenY; //현재창의 y좌표
    //var winX = window.screenX || window.screenLeft || 0;    // 현재창의 x좌표
    //var winY = window.screenY || window.screenTop  || 0;    // 현재창의 y좌표

    var popX = winX + (winWidth - popWidth)/2;
    var popY = winY + (winHeight - popHeight)/2;
    /*
    var popX = Math.ceil((window.screen.width - popWidth)/2);
    var popY = Math.ceil((window.screen.height - popHeight)/2);
    */
    window.open(contextRoot + "/sample/commonPopupChild.do",title,'width='+popWidth+',height='+popHeight+',top='+popY+',left='+popX+'');
}


/**
 * jQuery 메시지 관련 유틸 함수
 */
(function($) {

	$.Util = {

			isAlphabet : function (numUnicode) {
			   if ( 65 <= numUnicode && numUnicode <= 90 ) return true;            // 대문자
			   if ( 97 <= numUnicode && numUnicode <= 122 ) return true;           // 소문자
			   return false;
			},
			isNumber : function (numUnicode) {
			   if ( 48 <= numUnicode && numUnicode <= 57 ) return true;
			   return false;
			},
			isSpecialCharacter : function (numUnicode) {
				   if ( numUnicode == 45 || numUnicode == 46 || numUnicode == 95 ) return true;
				   return false;
			},
			/*
			 * 영문과 숫자 그리고 -, _만 허용한다.
			 */
			validCheckId : function (name) {
				var length = name.length;
				for (var i = 0; i < length; i++) {
					var numUnicode = name.charCodeAt(i);
					if (this.isAlphabet(numUnicode)
							|| this.isNumber(numUnicode)
							|| this.isSpecialCharacter(numUnicode)){
					} else {
						return false;
					}
				}
				return true;
			},


			/*
			 * 입력된 문자열의 좌우측 공백을 제거한 문자열을 리턴
			 */
			trim : function(str) {
				return str.replace(/(^\s*)|(\s*$)/g, "");
			},

			/*
			 * 숫자 체크 함수
			 */
			checkNum : function(str) {
				var regExp = /^[0-9]+$/;
				if('' == str){
					return true;
				}else{
					return regExp.test(str);
				}
			},
			/*
			 * 이메일 체크 함수
			 */
			checkEmail : function(str) {
				var regExp =  /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
				if('' == str){
					return true;
				}else{
					return regExp.test(str);
				}
			},

			/*
			 * 핸드폰 번호 체크 함수
			 */
			checkPhone : function(str) {
				var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
				if('' == str){
					return true;
				}else{
					return regExp.test(str);
				}
			},

			/*
			 * 핸드폰 번호 체크 함수
			 */
			checkPhone2 : function(str) {
				var regExp = /^\d{3}\d{3,4}\d{4}$/;
				if('' == str){
					return true;
				}else{
					return regExp.test(str);
				}
			},

			/*
			 * ID 또는 비밀번호 번호 체크 함수
			 */
			checkPassWord : function(str) {
				var regExp = /^[a-z0-9_]{4,20}$/;
				if('' == str){
					return true;
				}else{
					return regExp.test(str);
				}
			},

			/*
			 * 문자열에 dot(.) 제거하는 함수
			 */
			removeComma : function(str) {
				var pattern = /\s*.\s*/;
				if('' == str){
					return true;
				}else{
				    if(pattern.test(str)) {
				        return this.replace(/\./g, "");
				    }

				    return this;
				}

				return this;
			},
			/*
			 * Form Clear 함수
			 */
			clearForm : function(formName) {
				$(eval(formName)).each(function(){
					this.reset();
				});
			}
	};

})(jQuery);

//pdfViewer를 호출한다.
function pdfViewerOpen(atchFileSeq,viewTitle){

	var viewerFrm = $("<form id = 'viewerFrm'></form>");


	//$("#topFrm input[name='atchFileSeq']").remove();
	var $atchFileSeq = $("<input></input>").attr("name","atchFileSeq").attr("type","hidden").val(atchFileSeq);
	var $viewTitle = $("<input></input>").attr("name","viewTitle").attr("type","hidden").val(viewTitle);
	var $isIE8 = $("<input></input>").attr("name","isIE8").attr("type","hidden").val(_gfn_isiE8());

	viewerFrm.append($atchFileSeq);
	viewerFrm.append($viewTitle);
	viewerFrm.append($isIE8);


	viewerFrm.attr("method","post");
	$("body").append(viewerFrm);

	var wX = 900;
    var wY = 860;

    if(_gfn_isiE8()){
    	wX = 900;
    	wY = 200;
	}

    window.open("",'viewerPop','width='+wX+'px,height='+wY+'px,resizable=yes,scrollbars = yes');
    $("#viewerFrm").attr("action",contextRoot + "/viewer/reportViewer.do").attr("target","viewerPop").submit();
    $("#viewerFrm").remove();
}

//Imgae 바로보기
function imgViewerOpen(atchFileSeq,viewTitle){
	var viewerFrm = $("<form id = 'viewerFrm'></form>");


	//$("#topFrm input[name='atchFileSeq']").remove();
	var $atchFileSeq = $("<input></input>").attr("name","atchFileSeq").attr("type","hidden").val(atchFileSeq);
	var $viewTitle = $("<input></input>").attr("name","viewTitle").attr("type","hidden").val(viewTitle);

	viewerFrm.append($atchFileSeq);
	viewerFrm.append($viewTitle);

	viewerFrm.attr("method","post");
	$("body").append(viewerFrm);

	var wX = 500;
    var wY = 300;

    window.open("",'imageViewerPop','width='+wX+'px,height='+wY+'px,resizable=yes,scrollbars = yes');
    $("#viewerFrm").attr("action",contextRoot + "/viewer/imageViewer.do").attr("target","imageViewerPop").submit();
    $("#viewerFrm").remove();
}
var popTop = 100;
var popLeft = 100;
//공통팝업 바로보기
function commonPopupOpen(searchPopupSeq,width,height){
	var viewerFrm = $("<form id = 'viewerFrm'></form>");

	//$("#topFrm input[name='atchFileSeq']").remove();
	//var $viewTitle = $("<input></input>").attr("name","viewTitle").attr("type","hidden").val(viewTitle);
	//var $viewContent = $("<input></input>").attr("name","viewContent").attr("type","hidden").val(viewContent);
	var $searchPopupSeq = $("<input></input>").attr("name","searchPopupSeq").attr("type","hidden").val(searchPopupSeq);

	//viewerFrm.append($viewTitle);
	//viewerFrm.append($viewContent);
	viewerFrm.append($searchPopupSeq);

	viewerFrm.attr("method","post");
	$("body").append(viewerFrm);

	var wX = width;
    var wY = height;

    popTop = parseInt(popTop)+30;
    popLeft = parseInt(popLeft)+30;


    //window.open("",searchPopupSeq,'width='+wX+'px,height='+wY+'px,resizable=yes,scrollbars = yes,top='+popTop+', left='+popLeft);
    window.open("",searchPopupSeq,'width='+wX+'px,height='+wY+'px,resizable=yes,scrollbars = yes');
    $("#viewerFrm").attr("action",contextRoot + "/viewer/commonPopup.do").attr("target",searchPopupSeq).submit();
    $("#viewerFrm").remove();
}
//pdf viewer 다운로드 페이지로 이동한다
function fn_openViewerDownloadPage(){
	window.open('http://www.korea.adobe.com/products/acrobat/readstep2.html', '_blank');
}