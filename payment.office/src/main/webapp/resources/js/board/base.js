document.write("<script src='js/risu/login.js'></script>");
document.write("<script src='js/risu/my.js'></script>");
document.write("<script src='js/risu/admin.js'></script>");
document.write("<script src='js/risu/deal.js'></script>");
document.write("<script src='js/risu/html5.js'></script>");
document.write("<script src='js/risu/jquery.min.js'></script>");
document.write("<script src='js/risu/jquery.form.min.js'></script>");
document.write("<script src='js/auto/jquery.autocomplete.js'></script>");
document.write("<script src='js/auto/jquery.mockjax.js'></script>");
document.write("<script src='js/intro.js'></script>");
document.write("<script src='js/ajax.js'></script>");
document.write("<script src='js/util.js'></script>");
document.write("<script src='js/board.js'></script>");

var ParameterValAry = new Array();
var ParameterNmAry = new Array();

// 페이지 이동
function MovePage(URL, Target) {
	var Con = '';
	Con += '<form id="movePage" name="movePage" method="post">';
	if(URL == 'MnAList2.do') {
		Con += '<input type="hidden" id="Deal_Type" name="Deal_Type" value="B"/>';
		URL = 'MnAList.do';
	}
	if(URL == 'Login.do') {
		Con += '<input type="hidden" id="User_In_Ip" name="User_In_Ip" value="'+$("#User_In_Ip").val()+'"/>';
	}
	if(URL == 'AdminDeal.do') {
		Con += '<input type="hidden" id="Grp_Seq" name="Grp_Seq" value="1"/>';
		URL = 'AdminMain.do';
	}
	Con += '</form>';
	$('body').append(Con);
	if(Target == '') $("#movePage").attr('target', '_self').attr('action', URL).submit();
	else $("#movePage").attr('target', Target).attr('action', URL).submit();
	$("#movePage").remove();
}

// 페이지 이동2
function Go_Jump(URL, Target, ParamValAry, ParamNmAry) {
	var Con = '';
	Con += '<form id="movePage" name="movePage" method="post">';
	for(var oOo = 0; oOo < ParamNmAry.length; oOo++) {
		Con += '<input type="hidden" id="'+ ParamNmAry[oOo] +'" name="'+ ParamNmAry[oOo] +'"/>';
	}
	Con += '</form>';
	$('body').empty();
	$('body').append(Con);
	
	for(var oOo = 0; oOo < ParamNmAry.length; oOo++) {
		for(var OoO = 0; OoO < ParamValAry.length; OoO++) {
			$('#'+ParamNmAry[oOo]).val(ParamValAry[OoO][ParamNmAry[oOo]]);
//			alert($('#'+ParamNmAry[oOo])+"==="+ParamNmAry[oOo]+"==="+ParamValAry[OoO][ParamNmAry[oOo]]+"==="+ParamValAry[OoO]["Deal_Type"]);
		}
	}
	$("#movePage").attr('target', Target).attr('action', URL).submit();
	$("#movePage").remove();
}

// 서브메뉴 활성화
function OnSubMenu(ObjNm, ObjType, ClassNm, seq) {
	if(ObjType == 'id') Obj = $('#'+ObjNm).children('ul').children('li');
	else if(ObjType == 'class') Obj = $('.'+ObjNm).children('ul').children('li');
	
	for(var oOo = 0; oOo < Obj.length; oOo++) {
		Obj.eq(oOo).removeClass();
	}
	
	if(ObjType == 'id') Obj.eq(seq).attr('class', ClassNm);
	else if(ObjType == 'class') Obj.eq(seq).attr('class', ClassNm);
	
	if(Obj.eq(seq).children('ul') != undefined) Obj.eq(seq).children('ul').show();
}

// 서브 하위메뉴 활성화
function OnSecSubMenu(ObjNm, ObjType, ClassNm, seq) {
	if(ObjType == 'id') Obj = $('#'+ObjNm);
	else if(ObjType == 'class') Obj = $('.'+ObjNm);
	
	for(var oOo = 0; oOo < Obj.children('li').length; oOo++) {
		Obj.children('li').eq(oOo).removeClass();
	}
	
	if(ObjType == 'id') Obj.children('li').eq(seq).attr('class', ClassNm);
	else if(ObjType == 'class') Obj.children('li').eq(seq).attr('class', ClassNm);
}

// 탭메뉴 활성화
function OnTabMenu(parentseq, seq) {
	var TabMenu;
	for(var oOo = 0; oOo < $('.tabZone').eq(parentseq).children('ul').children('li').length; oOo++) {
		TabMenu = $('.tabZone').eq(parentseq).children('ul').children('li').eq(oOo);
		TabMenu.attr('class', '');
	}
	TabMenu = $('.tabZone').eq(parentseq).children('ul').children('li').eq(seq);
	TabMenu.attr('class', 'on');
}