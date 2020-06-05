/**
 * trim
 */
String.prototype.trim = function(){
	    return this.replace(/(^\s*)|(\s*$)/gi, "");
};


/**
 * isEmpty
 */
//String.prototype.isEmpty = function(){
//
//	if(this==null) return true;
//
//	var str = this.trim();
//	if(str.length == 0){
//		return true;
//	}else{
//		return false;
//	}
//};




/**
 * 공백문자 이거나 null 체크
 */
function isEmpty(param){

	if(param==null || param == undefined) return true;
	if(typeof param == "number") return false;

	var str = param.trim();
	if(str.length == 0){
		return true;
	}else{
		return false;
	}
}


/**
 * 숫자열을 3자리마다 "," 표 찍기
 */
function formatMoney(strNumber,mode){

	if(mode == undefined) mode = "INSERT";

	if(typeof strNumber == 'number'){
		strNumber = strNumber.toString();				//숫자타입이면 문자로 변환
	}else if(strNumber == null){
		strNumber = '';
	}

    var nLength=strNumber.length;
    var i=0;
    var strResult='';
    if(mode=='INSERT'){
        var j=0;
        for(i=nLength-1;i>=0;i--){
            j++;
            strResult=strNumber.substring(i,i+1)+strResult;
            if(j%3==0 && i>0){
                strResult=','+strResult;
            }
        }
    }else if( mode=='DELETE'){
        for(i=nLength-1;i>=0;i--){
            if(strNumber.substring(i,i+1)!=','){
                strResult=strNumber.substring(i,i+1)+strResult;
            }
        }
    }
    return strResult;
}

/**
 * 알파벳으로만 되어 있는 문자열인지
 */
function isAlpha(xStr){
    return xStr.match(/[^a-z]/gi);
}


/**
 * 문자열에 한글문자가 하나라도 있는지 검사
 */
function strInKrChar(value){
    for (var idx = 0; idx < value.length; idx++) {
        str2 = value.charAt(idx);
        if (( str2 >= 'ㄱ' && str2 <= '힣' )){
            return true;
        }
    }
    return false;
}

/**
 * 문자열이 영문대소 와 숫자 로만 구성됬는지 패턴검사
 */
function strInNumNEn(value){
    if(value==null || value.length < 1) return true;
    var temp = value;
    while(temp.indexOf("\\")>-1){
        temp = temp.substr(temp.indexOf("\\")+1);
    }
    temp = temp.replace("[","");
    temp = temp.replace("]","");
    var format = "[^\._A-Za-z0-9]{1,}";

    if(temp.search(format) != -1){
        return true;
    }else{
        return false;
    }
}

/**
 * 정규식으로 문자열이 숫자로만 구성됬는지 패턴검사
 */
function strInNum(value){
    var format = "^[0-9]";

    if (value.search(format) != -1) {
        return true;
    }
    return false;
}

/**
 * 정규식으로 문자열이 이메일로 유효한지 패턴검사
 */
/*function isEmail(value){
    var format = "^([-.0-9a-zA-Z]+)@([-.0-9a-zA-Z]+).([a-zA-Z]+)$";
    if (value.search(format) != -1) {
        return true;
    }
    return false;
}
*/
/**
 * 정규식으로 문자열이 이메일로 유효한지 패턴검사2
 */
function isEmail(obj){
    var reg = /^[0-9a-zA-Z_]([_\.]?[0-9a-zA-Z_])*@([0-9a-zA-Z_]+)(\.[0-9a-zA-Z_]+){1,2}$/;

    if(reg.test(obj.val()) == false) {
        //obj.focus();
        return false;
    }else{
        return true;
    }
}


/**
 * 정규식으로 문자열이 일반전화번호로 유효한지 패턴검사
 */
function isPhoneNumber(value){
    var format = "^[0-9]\{2,3\}-[0-9]\{3,4\}-[0-9]\{4\}$";

    if (value.search(format) != -1) {
        return true;
    }
    return false;
}

/**
 * 정규식으로 문자열이 헨드폰번호로 유효한지 패턴검사
 */
function isMobileNumber(value){
    var format = "^[0-9]\{3\}[0-9]\{3,4\}[0-9]\{4\}$";
    if (value.search(format) != -1) {
        return true;
    }
    return false;
}

/**
 * 전화번호형식으로 ex)025556666 >> 02-555-6666
 */
function toPhoneFormat(pStr){
	return pStr.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, '$1-$2-$3');
}

/**
 * 전화번호&핸드폰 체크
 */
function fn_isPhonNumer(){
    var result = (/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-[0-9]{3,4}-[0-9]{4}$/).test(pStr);
    if(reg.test(obj.val()) == false) {
        obj.focus();
        alert(content);
        return false;
    }else{
        return true;
    }
}
/**
 * 숫자만 허용
 */
function isNumber(pStr){
	var result = (/[^0-9]/g).test(pStr);
	return !result;
}
/**
 * 숫자,-  허용
 */
function isNumberMinus(pStr){
    var result = (/[^0-9\-]/g).test(pStr);
    return !result;
}

/**
 * 숫자,콤마  허용
 */
function isNumberComma(pStr){
    var result = (/[^0-9\,]/g).test(pStr);
    return !result;
}

/**
 * 영문,숫자만 허용
 */
function isEngNum(pStr) {
	var result = (/[^a-zA-Z0-9\s]/).test(pStr);
	return !result;
}

/**
 * 영문,숫자, 특수문자(-)만 허용
 */
/*function isEngNumMinus(pStr) {
	var result = (/[^a-zA-Z0-9|-\s]/).test(pStr);
	return !result;
}*/

/**
 * 영문,숫자, 특수문자(_)만 허용
 */
function isEngNumUnderbar(pStr) {
    var result = (/^[a-zA-Z0-9|_]*$/).test(pStr);
    return !result;
}

/**
* 8~20자리 영문,숫자,특수문자 중 2가지 조합 패스워드
*/
function isPasswordFormat(pStr) {
   var result = (/(^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])|(?=.*[!@#$%^&+=])).*$/).test(pStr);
   return !result;
}

function isNameFormat(pStr) {
    var result = (/^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/).test(pStr);
    return !result;
}

/**
 * 숫자앞에 원하는 길이만큼 '0' 채우기
 *
 * @param no	: 숫자
 * @param len	: 전체길이
 * @returns 숫자앞에 '0' 채운 문자열
 */
function fillzero(no, len) {
	no= '000000000000000'+no;
	return no.substring(no.length-len);
}

/**
 * 비밀번호 안전성 체크
 */
function ischeckPassword(pStr){
    var check = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,20}$/;

    if(pStr.length < 8 || pStr.length > 20) return false;

    return check.test(pStr);
}