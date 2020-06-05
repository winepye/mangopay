//공통 파일 업로드를 위한 url
var fileUploadUrl = contextRoot + "/common/file/uploadAjax.do";
//공통 파일 업로드 타겟 파일 엘리먼트
var uploadTarget;
//공통 파일 업로드 타겟 파일 엘리먼트
var fileTypeTarget;
//공통 파일  타겟 파일 엘리먼트
var atchFileSeqTarget;
//공통 파일 업로드 타겟 파일 엘리먼트
var uploadList = new Array();
/**
 * 파일용량을 반환한다.
 */
function getFileSize(fileName) {
    var obj = document.getElementsByName(fileName)[0];
    var size = 0;
    if(_gfn_isiE9()) {
        return size;
    }

    if(obj && obj.files.length > 0) {
        size = obj.files[0].size;
    }

    return size;
}
//공통 파일 삭제
function deleteAtchFile(atchFileSeq,viewMode){
	if(confirm("해당 파일을 삭제하시겠습니까?")){
	    atchFileSeqTarget = atchFileSeq;
	    var url = contextRoot + "/common/file/deleteAjax.do";
	    var paramObj = {"atchFileSeq":atchFileSeq,"viewMode":viewMode};
	    commonAjax("POST", url, paramObj, deleteAtchFileCallback);
	}
}
//공통파일 삭제 콜백
function deleteAtchFileCallback(data){
    alert("삭제되었습니다.");
    var deleteAfterUploadList = new Array();
    for(var i = 0 ; i <uploadList.length;i++){
    	if(uploadList[i] == atchFileSeqTarget){
        	continue;
        }else{
        	deleteAfterUploadList.push(uploadList[i]);
        }
    }
    uploadList=deleteAfterUploadList;
    $("#fileDetail_" + atchFileSeqTarget).remove();

}
//공통 파일 업로드
function fileUploadCallback(data){
    //uploadTarget
    //fileTypeTarget
	$("#fileArea_"+fileTypeTarget).prepend($("#topFrm").find("input[type='file']").clone());
	var viewMode = $("#topFrm").find("#viewMode").val();
	$("#topFrm").attr("enctype", "");
	$("#topFrm").empty();

	if(data.msg!=null && data.msg != "" && data.msg != undefined){
		alert(data.msg);
		return;
	}
    uploadList.push(data.result.atchFileSeq);

    setFileViewArea(data.result.atchFileSeq,data.result.fileOrgnNm,fileTypeTarget,data.result.volume,viewMode);
}
//공통 파일 업로드후 영역에 추가
function setFileViewArea(atchFileSeq,fileOrgnNm,fileTypeCd,volume,viewMode){

	if($("#fileView_"+fileTypeCd).find("li").length==0){
		$("#fileView_"+fileTypeCd).empty();
	}
	var volumeKb = volume*0.000977;
    var stStr = "";
    stStr    += "<li id = 'fileDetail_"+atchFileSeq+"'><a href = 'javascript:downloadFile("+atchFileSeq+")'>"
    			+fileOrgnNm+"<span>"+volumeKb.toFixed(2)+"KB</span></a>";
    stStr    += "<a class='fileDelete' href='#this' onclick='javascript:deleteAtchFile("+atchFileSeq+",\""+viewMode+"\")'><em>삭제</em></a></li>";
    stStr    += ""
    $("#fileView_"+fileTypeCd).append(stStr);
}

//파일 다운로드
function downloadFile(atchFileSeq){
    var url = contextRoot + "/common/file/downloadFile.do";
    //alert(atchFileSeq+"번파일 다운로드");
    // url과 data를 입력받음
    if( url && atchFileSeq ){
        var inputs = '';
        //inputs+='<input type="hidden" name="atchFileSeq" value="'+ atchFileSeq +'" />';
        url += "?atchFileSeq=" + atchFileSeq;
        var downPop = window.open(url);
        // request를 보낸다.
        //jQuery('<form action="'+ url +'" method="post" target="downloadPop">'+inputs+'</form>')
        //.appendTo('body').submit().remove();

        //downPop.close();
    };
}
