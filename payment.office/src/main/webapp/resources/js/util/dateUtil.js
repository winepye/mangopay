/**
 * dateUtil.js
 * 
 * 날짜 시간 관련
 */


/**
 * yyyymmdd 형태로 포매팅된 날짜 반환
 * 
 * @returns yyyymmdd 형태 날짜
 */
Date.prototype.yyyymmdd = function()			// new Date().yyyymmdd()	>> 8자리 문자열  ex) "20150609"
{
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();

    return yyyy + (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);
};
Date.prototype.yyyy_mm_dd = function()			// new Date().yyyy_mm_dd()	>> 10자리 문자열 	ex) "2015-06-09"
{
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();

    return yyyy + "/" + (mm[1] ? mm : '0'+mm[0]) + "/" + (dd[1] ? dd : '0'+dd[0]);
};





/**
 * 기준일 + n 일 
 * (예) 하루전날짜 addDate(-1), addDate(new Date(-1, "1/1/2002"))
 * 
 * @param n		: 숫자(일)
 * @param dt	: 기준일
 * @returns		: date (기준일+n)
 */
function addDate(n, dt){
	var base;
	
	if(dt == null)		//기준일(dt)이 없을때는 현재날짜로
		base = new Date();
	else
		base = dt;
	
	base.setDate(base.getDate() + n);
	
	return base;
}




/**
 * 경과 시(hour)
 * 
 * @param day1
 * @param day2
 * @returns {Number}
 */
function diffHour(day1, day2){
	
	var diff = day1.getTime() - day2.getTime();		//diff : millisecond
	
	return diff /(1000 * 60 * 60);		//시(hour)
}


/**
 * 두 날짜 차이 가져오기
 * 
 */
function getDiffDay(dayStr1, dayStr2){
    var day1 = new Date(dayStr1.split("/")[0], parseInt(dayStr1.split("/")[1])-1, dayStr1.split("/")[2]);
    var day2 = new Date(dayStr2.split("/")[0], parseInt(dayStr2.split("/")[1])-1, dayStr2.split("/")[2]);

    return (day2.getTime() - day1.getTime()) / 1000 / 60 / 60 / 24;
}


/**
 * 오늘과의 차이 가져오기
 * 
 */
function getDiffToday(dayStr){
    var today = new Date();
	today = new Date(today.getFullYear(), today.getMonth(), today.getDate());

    var day = new Date(dayStr.split("/")[0], parseInt(dayStr.split("/")[1])-1, dayStr.split("/")[2]);

    return (today.getTime() - day.getTime()) / 1000 / 60 / 60 / 24;
}

