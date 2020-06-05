function mEmGET(arrayKey, arrayValue, Value) { 
    count = arrayKey.length; 
    for(i=0;i<count;i++) { 
        if(arrayKey[i]==Value) { 
            return arrayValue[i]; 
            break; 
        } 
    } 
} 

// ie ativeX 출력 변경 함수 
function mEmbed() { 
var emtype; 
    var key = new Array(); 
    var value = new Array(); 
	// error_check=0; 
    for(i=0;i<mEmbed.arguments.length;i++) { 
        data = mEmbed.arguments[i].split('='); 
        key[i] = data[0]; 
        value[i] = data[1]; 
    } 

    contents = ''; 
	srcdata = mEmGET(key,value,'src').toLowerCase(); 

    classid = mEmGET(key,value,'classid'); 
    codebase = mEmGET(key,value,'codebase'); 
    
	if(/\.(swf)$/.test(srcdata)) { //flash 
        classid = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'; 
        codebase = 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.c-ab#version=6,0,29,0'; 
		emtype="flash"; 
    } else if(/\.(wmv|wma|asf|avi|wav|asx|mpeg|mp3|midi|aiff|au|wpl|wm|wmx|wmd|wmz)$/.test(srcdata)){//media 
        classid = 'CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95'; 
        codebase = 'http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'; 
		emtype="media"; 
	} 

    if(classid && codebase) { 
        contents += '<object'; 
        if(classid) { 
            contents += ' classid="' + classid + '"'; 
        } 
        if(codebase) { 
            contents += ' codebase="' + codebase + '"'; 
        } 
        count = key.length; 
        for(i=0;i<count;i++) { 
            if(value[i]!='') { 
                if(key[i]!='src') { 
                    contents += ' ' + key[i] + '="' + value[i] + '"'; 
                } 
            } 
        } 
        contents += '>'; 
        for(i=0;i<count;i++) { 
            if(value[i]!='') { 
                if(emtype=='flash' && key[i]=='src') { 
                    contents += '<param name="movie" value="' + value[i] + '" />'; 
                } else  if(emtype=='media' && key[i]=='src') { 
                    contents += '<param name="filename" value="' + value[i] + '" />'; 
                } else { 
                    contents += '<param name="' + key[i] + '" value="' + value[i] + '" />'; 
                } 
            } 
        } 
    } 
	contents += '<param name=wmode value=transparent>';
    contents += '<embed'; 
    for(i=0;i<count;i++) { 
        if(value[i]!='') { 
            contents += ' ' + key[i] + '="' + value[i] + '"'; 
        } 
    } 
    contents += '>'; 
    contents += '</embed>'; 
    if(classid && codebase) { 
        contents += '</object>'; 
    } 
    document.write(contents); 
//return contents; 
} 