//숫자만 입력가능
//$(document).ready(function(){ 제일 첨음에
//onlyNumber($("#sortOrd")); 와 같이 입력
function onlyNumber(o){
	  o.css('imeMode','disabled').keypress(function(event) {
	       if(event.which && (event.which < 48 || event.which > 57) ) {
	           event.preventDefault();
	       }
	    }).keyup(function(){
	        if( $(this).val() != null && $(this).val() != '' ) {
	            $(this).val( $(this).val().replace(/[^0-9]/g, '') );
	        }
	    });
}

//숫자만 입력가능
//<input type="text" onkeydown="return onlyNumber2(event)">
function onlyNumber2(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
    {
        return;
    }
    else
    {
        return false;
    }
}

//알파벳, 숫자인지 체크
function checkAlpahNumber(val) {
	var valLen = val.length;

	var isAlphabet = false;
	var isNumber   = false;
	var isSpcChar  = false;

	if(valLen > 0) {
		for(var i=0 ; i<valLen ; i++) {
			if((65 <= val.charAt(i).charCodeAt() && val.charAt(i).charCodeAt() <= 90) || (97 <= val.charAt(i).charCodeAt() && val.charAt(i).charCodeAt() <= 122)) {
				if("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf(val.charAt(i)) > -1){
					//alert("알파벳");
					isAlphabet= true;
				}
			} else if(48 <= val.charAt(i).charCodeAt() && val.charAt(i).charCodeAt() <= 57) {
				//alert("숫자");
				isNumber= true;
			} else if((33 <= val.charAt(i).charCodeAt() && val.charAt(i).charCodeAt() <= 47) || (58 <= val.charAt(i).charCodeAt() && val.charAt(i).charCodeAt() <= 64) || (91 <= val.charAt(i).charCodeAt() && val.charAt(i).charCodeAt() <= 96) || (123 <= val.charAt(i).charCodeAt() && val.charAt(i).charCodeAt() <= 125)) {
				//alert("특수문자");
				isSpcChar= true;
			}

			if(!isAlphabet && !isNumber && isSpcChar){
				break;
			}

			isAlphabet = false;
			isNumber   = false;
			isSpcChar  = false;
		}
	}

	return isAlphabet || isNumber || !isSpcChar;
}

//금액부분에 ,를 찍어준다.
function getMoney4Double(i){
	s = i.split(".");
	c = 0;
	result;
	for(i=s[0].length; i>=0; i--){
		result.prepend(s[0].substring(i,i));
		c++;
		if(c == 3){
			c=0;
			result.prepend(",");

		}
	}

	return result;
}

//년만 표시하는 selectBox
function getYearSelectBox(formId,type){
	if(type =="current") {
		var startYear = "2016";
		var currentYear = new Date().getFullYear();
		var nextYear = startYear;

	    for (var i = startYear; i <= currentYear; i++ ) {
	    	$( formId ).append(
	        $("<option></option>")
	             .attr("value", i)
	             .text(i)
	        );
	    }
	    if(type =="current") $( formId ).val(currentYear);
	}else{
		var currentYear = new Date().getFullYear();
		var nextYear = currentYear-5;

		$( formId ).append(
	         $("<option></option>")
	             .attr("value", "")
	             .text("전체")
	     );
	    for (var i = -5; i <= 5; i++ ) {
	    	$( formId ).append(
	        $("<option></option>")
	             .attr("value", nextYear)
	             .text(nextYear)
	        );
	        nextYear++;
	    }
	}


}

//월만 표시하는 달력
function monthPickerWrap(formId, type){
	//관리자화면에서 호출시
	if(type == 'admin'){
		$( formId ).MonthPicker({
			Button: false ,
			//MaxMonth: -1 ,
			MonthFormat: 'yy/mm', // Short month name, Full year.
		}).attr('readonly','readonly');
		$( formId ).after('<img class="ui-monthpicker-trigger" src="/resources/images/common/btn_calendar.gif" style="cursor: pointer; margin-left: 5px; margin-top: 5px;">');
		$(".ui-monthpicker-trigger").click(function(){
			$(this).prev().focus();
		})
	}else{
		$( formId ).MonthPicker({
			Button: false ,
			MaxMonth: -1 ,
			MonthFormat: 'yy/mm', // Short month name, Full year.
		}).attr('readonly','readonly');
		$( formId ).after('<img class="ui-monthpicker-trigger" src="/resources/images/common/btn_calendar.gif" style="cursor: pointer; margin-left: 5px; margin-top: 5px;float:left;">');
		$(".ui-monthpicker-trigger").click(function(){
			$(this).prev().focus();
		})
	}
}

//달력
function datePickerWrap(formId , type , targetId){

	$( formId ).datepicker({

		showOn: "both",
		dateFormat:"yy/mm/dd",
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		buttonImage: contextRoot + "/resources/images/common/btn_calendar.gif",
		buttonImageOnly: true,
		changeMonth: true,
		currentText: '오늘',
		changeYear: true
	}).attr('readonly','readonly');

	if(type == 'start' || type == 'end'){
	    switch(type){
	    case 'start':
	        $(formId).datepicker("option", "maxDate", $(targetId).val());
	        $(formId).datepicker("option", "onClose", function ( selectedDate ) {
	            $(targetId).datepicker( "option", "minDate", selectedDate );
	            $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px', 'margin-top':'5px'});
	         });
	        break;
	    case 'end':
	        $(formId).datepicker("option", "minDate", $(targetId).val());
	        $(formId).datepicker("option", "onClose", function ( selectedDate ) {
	            $(targetId).datepicker( "option", "maxDate", selectedDate );
	            $('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px', 'margin-top':'5px'});
	         });
	    }
	}

	if(type == 'before' || type == 'after'){
	    switch(type){
	    case 'before':
	        $(formId).datepicker("option", "maxDate", new Date().yyyy_mm_dd());
	        break;
	    case 'after':
	        $(formId).datepicker("option", "minDate", new Date().yyyy_mm_dd());
	    }
    }

	$('img.ui-datepicker-trigger').css({'cursor':'pointer', 'margin-left':'5px', 'margin-top':'5px'});
}

/** 텍스트area에 byte를 제한한다. */
function getCntnBytes(areaId , maxByte , alertMsg){
    var obj = $('#'+areaId);
    var text = $(obj).val();
    var leng = text.length;
    var isByteChk = true;
    lMaxByte=maxByte;
    while(getTextLength(text) >maxByte){
        leng --;
        text = text.substring(0,leng);
        //$('#'+areaId).val(text);
        isByteChk=false;
    }
    if(!isByteChk){
        alert(alertMsg);
        $('#'+areaId).val(text);
    }
    //$('#'+areaId+"Bytes").text(fn_getTextLength(text));
}
var lMaxByte;
/** byte 체크. */
function getTextLength(str){
    lMaxLen = 0;

    var len = 0;
    for(var i=0;i<str.length;i++){
        var c = escape(str.charAt(i));
        if(c.length==1) len++;
        else if(c.indexOf("%u")!=-1) len+=2;
        else if(c.indexOf("%")!=-1) len+= 2;
        if(lMaxByte >= len){
            lMaxLen++;
        }
    }
    return len;
}

//날짜형식이 맞는지 체크
//6자리면 앞에 19를 붙임
function isValidDate(param) {
	try {

        if(param.length == 6){
            param = "19" + param;
        }
		param = param.replace(/-/g, '');

		// 자리수가 맞지않을때
		if (isNaN(param) || param.length != 8) {
			return false;
		}

		var year = Number(param.substring(0, 4));
		var month = Number(param.substring(4, 6));
		var day = Number(param.substring(6, 8));

		if (month < 1 || month > 12) {
			return false;
		}

		var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var maxDay = maxDaysInMonth[month - 1];

		// 윤년 체크
		if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
			maxDay = 29;
		}

		if (day <= 0 || day > maxDay) {
			return false;
		}
		return true;

	} catch (err) {
		return false;
	}
	;
}

//Id, Pwd 유혀성 검사
function isValidPasswd(str) {
	//길이 체크
	if(str.length < 8){
		return false;
	}
	if(str.length > 20){
		return false;
	}

	var Set_Num = "0123456789";
	var Set_Alpha1 = "abcdefghijklmnopqrstuvwxyz";
	var Set_Alpha2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//	var Set_Other = "`~!@#$%^&*()-_=+\\|]}[{'\";:/?.>,<";
	var Set_Other = "`~!@#$%^&*()-_=+|]}[{'\";:/?.>,<";		//모바일 이슈로 인하여 \제외
	var str1 = str;
	var varDigit = 0;
	var varAlpha = 0;
	var varSpecial = 0;
	for(var i=0; i < str1.length; i++) {
		if(Set_Num.indexOf(str1.charAt(i)) > -1){
			varDigit = 1;
		}else if(Set_Alpha1.indexOf(str1.charAt(i)) > -1){
			varAlpha = 1;
		}else if(Set_Alpha2.indexOf(str1.charAt(i)) > -1){
			varAlpha = 1;
		}else if(Set_Other.indexOf(str1.charAt(i)) > -1){
			varSpecial = 1;
		}else{
			if(" " == str1.charAt(i)){
				return false;
			}else{
				return false;
			}
		}
	}
	if((varDigit + varAlpha + varSpecial) < 2){
		return false;
	}

	return true;
}

function isValidId(str) {
	//길이 체크
	if(str.length < 6){
		return false;
	}
	if(str.length > 20){
		return false;
	}

	var Set_Num = "0123456789";
	var Set_Alpha1 = "abcdefghijklmnopqrstuvwxyz";
	var Set_Alpha2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//	var Set_Other = "`~!@#$%^&*()-_=+\\|]}[{'\";:/?.>,<";
	var Set_Other = "_";		//모바일 이슈로 인하여 \제외
	var str1 = str;
	var varDigit = 0;
	var varAlpha = 0;
	var varSpecial = 0;
	for(var i=0; i < str1.length; i++) {
		if(Set_Num.indexOf(str1.charAt(i)) > -1){
			varDigit = 1;
		}else if(Set_Alpha1.indexOf(str1.charAt(i)) > -1){
			varAlpha = 1;
		}else if(Set_Alpha2.indexOf(str1.charAt(i)) > -1){
			varAlpha = 1;
		}else if(Set_Other.indexOf(str1.charAt(i)) > -1){
			varSpecial = 1;
		}else{
			if(" " == str1.charAt(i)){
				return false;
			}else{
				return false;
			}
		}
	}
	/*if(varAlpha > 0){
		return true;
	}
	if((varDigit + varSpecial) < 2){
		return false;
	}*/

	return true;
}

//이름 유효성 검사
function isValidName(str) {
	 if(!/^[가-힝a-zA-Z]{2,}$/.test(str))
         return false;
	 else return true;
}

//시작일, 종료일 크기 비교
function isCompareFromToDate(fromObj, toObj, objName){
    var fromObjVal = $(fromObj).val();
    var toObjVal   = $(toObj).val();

    if(fromObjVal != "" && toObjVal != ""){
        if(fromObjVal > toObjVal){
        	if(objName != undefined ){alert(objName+" 시작일이 종료일보다 이후일 수 없습니다.");}
        	else{alert("시작일이 종료일보다 이후일 수 없습니다.");}
            $(fromObj).focus();
            return false;
        }
    }

    return true;
}

/**
 * CheckBox 전체 체크
 * 전체 ID가 개별 항목의 Name과 같아야 한다
 * @param obj
 */
function fn_allCheck(obj){
    var isAllChecked = $(obj).is(":checked");
    $("input[name="+obj.id+"]:checkbox").each(function(i){
        $(this).prop("checked", isAllChecked);
    });
}

/**
 * CheckBox 개별 체크
 * 전체 ID가 개별 항목의 Name과 같아야 한다
 * @param obj
 */
function fn_eachCheck(obj){
    var codes = $('input:checkbox[name="'+obj.name+'"]');
    for(var i=0 ;i<codes.length; i++){
        if (!codes[i].checked){
            $("#"+obj.name).prop("checked", false);
            return;
        }
    }
    $("#"+obj.name).prop("checked", true);
}
/**
 * 숫자 천단위 콤마 추가
 * num - 변환할문자
 * @param num
 */
function fn_getNumberFormat(num) {
    /*if(this.fn_isUndefined(num) == ""){
        return "0";
    }*/

    var val = num.toString().replace(/,/g,"");
    var reg = /(^[+-]?\d+)(\d{3})/;
    while(reg.test(val)){
        val = val.replace(reg, "$1"+","+"$2");
    }
    return val;
}
/**
 * InputBox 금액 형식으로만 입력받는다. (keydown,blur숫자 , 콤마 )
 * @param elementId
 */
function fn_numberFormat(elementId , round){
	  $("#"+elementId).on("keydown",  function(event){
		  devUtil.fn_keyControl(event, "number");
	    }).on("keyup",  function(event){
	        var keyCode = ( window.event ) ? window.event.keyCode : event.which;
	        if ($(this).val() != "" && !(keyCode == 37 || keyCode == 39)) {
	        	$(this).val(devUtil.fn_getNumberFormat($(this).val()));
	        }
	        if(round != undefined && round != ''){

	        	var val = $(this).val();
	        	var arr = val.split("\.");
	        	if (arr.length > 1 && arr[1] !="") {
	                if(arr[1].length>round){
	                	val = "";
	                	alert("소수점 "+round + " 자리까지 입력 가능합니다.");
	                	val = arr[0]+"."+arr[1].substring(0,round);
	                	$(this).val(val);
	                }
	            }
	        }
	    }).on("blur", function(event){
	        if ($(this).val() != "") {
	            var chkNumber = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test($(this).val());
	            if (chkNumber == true) {
	            	 $(this).val(devUtil.fn_getNumberFormat($(this).val()));
	            } else {
	                alert("올바른 숫자 형식으로 입력하세요.");
	                $(this).val("");
	                $(this).focus();
	            }
	        }
	    });
}
/**
 * InputBox 금액 형식으로만 입력받는다. (keydown,blur숫자 , 콤마 )
 * @param elementId
 */
function fn_numberFormatForNumberClass(){
	  var round = 2;
	  if($(".number").length>0){
		  $(".number").each(function(){
			  $(this).val(devUtil.fn_getNumberFormat($(this).val()));
		  })

	  }
	  $(".number").on("keydown",  function(event){
		  devUtil.fn_keyControl(event, "number");
	    }).on("keyup",  function(event){
	        var keyCode = ( window.event ) ? window.event.keyCode : event.which;
	        if ($(this).val() != "" && !(keyCode == 37 || keyCode == 39)) {
	        	$(this).val(devUtil.fn_getNumberFormat($(this).val()));
	        }
	        if(round != undefined && round != ''){

	        	var val = $(this).val();
	        	var arr = val.split("\.");
	        	if (arr.length > 1 && arr[1] !="") {
	                if(arr[1].length>round){
	                	val = "";
	                	alert("소수점 "+round + " 자리까지 입력 가능합니다.");
	                	val = arr[0]+"."+arr[1].substring(0,round);
	                	$(this).val(val);
	                }
	            }
	        }
	    }).on("blur", function(event){
	        if ($(this).val() != "") {
	            var chkNumber = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test($(this).val());
	            if (chkNumber == true) {
	            	 $(this).val(devUtil.fn_getNumberFormat($(this).val()));
	            } else {
	                alert("올바른 숫자 형식으로 입력하세요.");
	                $(this).val("");
	                $(this).focus();
	            }
	        }
	    });
}