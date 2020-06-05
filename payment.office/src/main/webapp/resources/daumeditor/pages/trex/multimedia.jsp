<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>멀티미디어 삽입</title>
<script src="../../js/popup.js" type="text/javascript" charset="utf-8"></script>
<link rel="stylesheet" href="../../css/popup.css" type="text/css"  charset="utf-8"/>
<style type="text/css">
	input,textarea { border:1px solid #000000;vertical-align:middle;font-size:12px;}

	/* swf wrapper, set width/height */
	.wrapper { width:458px; }
	.code { width:458px; }

	.hidden { display:none;}
	.show { display:auto;}
	.desc{ margin: 15px 27px 5px 25px;padding:10px 8px;text-align:left;font-weight:bold;}
	.desc span{ color:#496ce5; }
	.field { margin:0 auto 10px; background:#ffffff url(../../images/icon/editor/tvpot/body_bg.gif?rev=1.0.1);width:420px;height:239px;}
	.field li{ list-style-type:none;}
	.field .codesubmenu { padding-top:20px;width:350px; margin:0 auto; }
	.codeMenu { margin:0px auto;}
	.codeMenu li { display:inline;margin-right:20px; }
	.inputmenu { margin-top:20px;padding-left:30px; color:#333;font-size:11px;font-family:"ëì",dotum}
	.inputmenu input, .inputmenu textarea{ width:308px; }
	#codeUrl { margin-top:10px;}

	.inputmenu .unselected{color:#bbbbbb}
	.inputmenu .unselected input, .inputmenu .unselected textarea{border:1px solid #bbbbbb;}

	.point {
		font-weight:normal;
		color:#a7b9ec;
	}
</style>
<script type="text/javascript">
// <![CDATA[

	function initEmbeder() {
		var _opener = PopupUtil.getOpener();
		if(!_opener) {
			alert('ìëª»ë ê²½ë¡ë¡ ì ê·¼íì¨ìµëë¤.');
			return;
		}

		var _embeder = getEmbeder('media');
		window.execEmbed = _embeder.embedHandler;

		autoResizeHeight($tx("wrapper"));
	}

	// ì½ë ì½ì ìë£ í
	function done() {
		var _data = {};
		var types = document.getElementsByName("codeType");
		if (types[0].checked) {
			_data.url = document.getElementsByName("url")[0].value.trim();
		} else if (types[1].checked) {
			_data.code = document.getElementsByName("source")[0].value.trim();
		}
		if (typeof(execEmbed) == 'undefined') { //Virtual Function
	        return;
	    }
		executeAfterDataCheck(_data, function(){
			execEmbed(_data);
			closeWindow();
	    });
	}

	function executeAfterDataCheck(data, successHandler) {
		if (data.url || data.code) {
			successHandler();
		} else {
			alert("ì²¨ë¶í  ë©í°ë¯¸ëì´ ì£¼ìë¥¼ ë°ë¥´ê² ìë ¥í´ì£¼ì¸ì.");
		}
	}

	function selectType(id){
		var textArea = document.getElementsByName("source")[0];
		var input = document.getElementsByName("url")[0];
		if ( id == 'codeUrl' ){
			$tx.addClassName($tx('codeSource'), "unselected")
			$tx.removeClassName($tx('codeUrl'), "unselected")
			textArea.value = "";
			textArea.disabled = true;
			input.disabled=false;
			input.focus();
		}else{
			$tx.addClassName($tx('codeUrl'), "unselected")
			$tx.removeClassName($tx('codeSource'), "unselected")
			textArea.disabled = false;
			input.value = "";
			input.disabled=true;
			textArea.focus();
		}
		autoResizeHeight($tx("wrapper"));
	}

// ]]>
</script>
</head>
<body onload="initEmbeder()">
<div id="wrapper" class="wrapper">
<div class="header">
	<h1>외부컨텐츠 삽입</h1>
</div>
<div class="body">
	<div id="code" class="code">
		<p class="desc">아래 멀티미디어 등의 삽입 방식을 선택한 후, 주소를 입력하세요.</p>
		<ul class="field">
			<li class="codesubmenu">
				<ol class="codeMenu">
					<li><input type="radio" id="type_url" value="url" name="codeType" onclick="selectType('codeUrl');" style="border:none"  checked="checked" /> <label for="type_url">멀티미디어 링크</label></li>
					<li><input type="radio" id="type_source" value="source" name="codeType" onclick="selectType('codeSource');" style="border:none" /> <label for="type_source">html(embed,object 소스입력)</label></li>
				</ol>
			</li>
			<li class="inputmenu">
				<ol>
					<li id="codeUrl" style="height:30px;"><label>멀티미디어 링크 </label><input type="text" name="url" /></li>
					<li id="codeSource" class="unselected"><label> html(embed,object 소스입력) </label><textarea rows="7" name="source" disabled="true"></textarea></li>
				</ol>
			</li>
		</ul>
	</div>
</div>
<div class="footer">
	<p><a href="#" onclick="closeWindow();" title="취소" class="close">취소</a></p>
	<ul>
		<li class="submit"><a href="#" onclick="done();" title="ë±ë¡" class="btnlink">등록</a> </li>
	</ul>
</div>
</div>
</body>
</html>