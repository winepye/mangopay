/**
 * Event가 발생한 Html 객체의 window 새로 위치 얻기
 */
function getRealOffsetTop(o) {
    return o ? o.offsetTop + getRealOffsetTop(o.offsetParent) : 0;
}

/**
 * Event가 발생한 Html 객체의 window 가로 위치 얻기
 */
function getRealOffsetLeft(o) {
    return o ? o.offsetLeft + getRealOffsetLeft(o.offsetParent) : 0;
}

//페이지 로딩 이미지 표시
function showLoadingImage(top,left,width,height) {
  if(top) $(".loadingWrap").css("margin-top",top);
  if(left) $(".loadingWrap").css("margin-left",left);
  if(width) $(".loadingWrap").css("width",width);
  if(height) $(".loadingWrap").css("height",height);

  $(".loadingWrap").show();
}

//페이지 로딩 이미지 감추기
function hideLoadingImage() {
    //preload.style.visibility = "hidden";
	 $(".loadingWrap").hide();
}

/************************************************
2014-12-15
개발자들이 공통적으로 쓸 util js라 생각되시면 devUtil 안에 넣어주세요.(개발자들이 직접/추가나 수정 가능)
*************************************************/

var devUtil= {
        /*************************************************************************************************
        설명   : escape 특수문자 변경(& < > ' ")
        입력값 : vals - 변경할 내용
        **************************************************************************************************/
        fn_escapeReplace : function(vals){
            return vals.replace(/&/g,"&amp").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/'/g,"&#39;").replace(/\"/g,"&quot;");
        },
        /*************************************************************************************************
        설명   : key 입력 제어 (key이벤트 발생시)
        입력값 : e - event (필수값)
                 type - digits(0~9),digits2(0~9,), number(0~9-,.), date(0~9-), alphaNumeric(a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ)
        **************************************************************************************************/
        fn_keyControl : function(e, type) {
            var keyCode = ( window.event ) ? window.event.keyCode : e.which;
            var ctrl = ( window.event ) ? window.event.ctrlKey : e.ctrlKey;
            var shift = ( window.event ) ? window.event.shiftKey : e.shiftKey;
            var bKey = true;

            if (type == "digits") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "digits2") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidDecimalSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "number") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "date") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidDateSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "alphaNumeric") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidHangulKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            }else if (type == "alphaNumeric2") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "alphaDotNumeric") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidDotSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "password") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "email") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidEmailKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidDotSymbolKey(keyCode, ctrl, shift) || devUtil.fn_isValidDateSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "nospace") {
                if(devUtil.fn_isValidSpaceKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            }

            if (bKey == false) {
                if (window.event){
                    window.event.returnValue = false;
                } else {
                    e.preventDefault();
                    e.stopPropagation();
                }
            }
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidFunctionKey: function (keyCode, ctrl, shift) {
            var isValid = false;
            if(ctrl && keyCode == 67) { //ctrl + c
                isValid = true;
            } else if(ctrl && keyCode == 86) { //ctrl + v
                isValid = true;
            } else if(keyCode == 8 || keyCode == 9 || keyCode == 46) {//backspace, tab, delete
                isValid = true;
            } else if(keyCode == 37 || keyCode == 39) {//left, right
                isValid = true;
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidNumberKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(shift == false && 48 <= keyCode && keyCode <= 57) { //0~9
                isValid = true;
            } else if(shift == false && 96 <= keyCode && keyCode <= 105) { //키패드 0~9
                isValid = true;
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidNumberSymbolKey: function (keyCode, ctrl, shift) {
            var isValid = false;
            if(browserDetect.browser == "Opera") {
                if(keyCode == 78 || keyCode == 46) {// .
                    isValid = true;
                } else if(keyCode == 45) {// -
                    isValid = true;
                } else if(keyCode == 44) {// ,
                    isValid = true;
                }
            } else {
                if(keyCode == 110 || keyCode == 190) {// .
                    isValid = true;
                } else if(keyCode == 189 || keyCode == 109) {// -
                    isValid = true;
                } else if(keyCode == 188) {// ,
                    isValid = true;
                }
            }

            return isValid;
        },
        fn_isValidDecimalSymbolKey: function (keyCode, ctrl, shift) {
            var isValid = false;
            if(browserDetect.browser == "Opera") {
                if(keyCode == 45) {// -
                    isValid = true;
                } else if(keyCode == 44) {// ,
                    isValid = true;
                }
            } else {
                if(keyCode == 189 || keyCode == 109) {// -
                    isValid = true;
                } else if(keyCode == 188) {// ,
                    isValid = true;
                }
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidDateSymbolKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(browserDetect.browser == "Opera") {
                if(keyCode == 45) {// -
                    isValid = true;
                }
            } else {
                if(keyCode == 189 || keyCode == 109) {// -
                    isValid = true;
                }
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidEnglishKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(65 <= keyCode && keyCode <= 90) {// 알파벳
                isValid = true;
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidHangulKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(browserDetect.browser == "Opera") {
                if( 197 == keyCode) {// 한글
                    isValid = true;
                }
            } else if(browserDetect.browser == "Firefox") {
                if( 0 == keyCode) {// 한글
                    isValid = true;
                }
            } else {
                if( 229 == keyCode) {// 한글
                    isValid = true;
                }
            }

            return isValid;
        },
        /*************************************************************************************************
        설명   : 숫자 천단위 콤마 추가
        입력값 : num - 변환할문자
        예)    : devUtil.fn_getNumberFormat('100000');
        **************************************************************************************************/
        fn_getNumberFormat : function(num) {
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
};

