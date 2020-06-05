<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주소로 장소 표시하기</title>
    <style>
        .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
        .wrap * {padding: 0;margin: 0;}
        .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
        .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
        .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
        .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
        .info .close:hover {cursor: pointer;}
        .info .body {position: relative;overflow: hidden;}
        .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
        .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
        .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
        .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
        .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
        .info .link {color: #5085BB;}
    </style>
</head>
<body>
<div id="daumMap" style="width:500px;height:500px;"></div>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=ddf7f036a7bbceabd8505a907e9d1d82&libraries=services"></script>

<script>
    <!-- 선택한 Marker -->
    var selectImageSrc = "http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
    var selectImageSize = new daum.maps.Size(24, 35);
    var selectMarkerImage = new daum.maps.MarkerImage(selectImageSrc, selectImageSize);

    /* 마커이미지1 */
    var imageSrc1 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLjr8cJpI5mLVWa7Fz-3ysxAn4oUarapyc77Iy22DCmhYXbfSr";
    var imageSize1 = new daum.maps.Size(24, 35);
    var markerImage1 = new daum.maps.MarkerImage(imageSrc1, imageSize1);

    /* 마커이미지2 */
    var imageSrc2 = "https://thumb9.shutterstock.com/thumb_large/1737244/365128766/stock-vector-green-map-pointer-icon-marker-gps-location-flag-symbol-365128766.jpg";
    var imageSize2 = new daum.maps.Size(24, 35);
    var markerImage2 = new daum.maps.MarkerImage(imageSrc2, imageSize2);

    // 지도를 표시할 div
    var mapContainer = document.getElementById('daumMap'),
        mapOption = {
            center: new daum.maps.LatLng(33.450704, 126.570689), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new daum.maps.Map(mapContainer, mapOption);

    // 지도 타입 변경 컨트롤을 생성한다
    var mapTypeControl = new daum.maps.MapTypeControl();

    // 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
    map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

    // 지도에 확대 축소 컨트롤을 생성한다
    var zoomControl = new daum.maps.ZoomControl();

    // 지도의 우측에 확대 축소 컨트롤을 추가한다
    map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

    //지도에 값 셋팅
    var corpInfoVoListJson = ${corpInfoVoListJson};
    $.each(corpInfoVoListJson,function(key,value){
        var marker = new daum.maps.Marker({
            map: map, // 마커를 표시할 지도
            position: new daum.maps.LatLng(value.latitude, value.longitude), // 마커를 표시할 위치
            title : value.cpnNm, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
            //image : markerImage, // 마커 이미지
        });

        setMarker(marker,value);

        value.marker = marker;
    });

//선택된 마커를 찾기위한 변수
var selectedCorpSeq = "";
//선택된 마커의 기존 이미지
var selectedMarkerImage;

function setMarker(marker,value){

    var content = '<div class="wrap">' +
    '    <div class="info">' +
    '        <div class="title">' +
    '            '+value.cpnNm +'('+value.cpnId+')'+
    '            <div class="close" onclick="closeOverlay('+value.corpInfoSeq+')" title="닫기"></div>' +
    '        </div>' +
    '        <div class="body">' +
    '            <div class="desc">' +
    '                <div class="ellipsis">'+value.addr+'</div>' +
    '                <div>'+value.tel+'</div>' +
    '            </div>' +
    '        </div>' +
    '    </div>' +
    '</div>';
    // 마커 위에 표시할 인포윈도우를 생성한다
    var overlay = new daum.maps.CustomOverlay({
        content: content,
        map: map,
        position: marker.getPosition()
    });
    overlay.setMap(null);

    //마커 이미지를 판단한다. (임의로 나눈다.)
    if(parseInt(value.corpInfoSeq)<500){

    }else if (parseInt(value.corpInfoSeq)>500 && parseInt(value.corpInfoSeq)>1000){

    }else{

    }


    // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
    daum.maps.event.addListener(marker, 'click', function() {
        overlay.setMap(map);
        selectedMarkerImage = marker.getImage();
        // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
        marker.setImage(selectMarkerImage);
    });
    // 마커를 초기화 한다.
    daum.maps.event.addListener(marker, 'reset', function() {
        marker.setImage(selectedMarkerImage);
        overlay.setMap(null);
    });
}
//커스텀 오버레이를 닫기 위해 호출되는 함수입니다
function closeOverlay(corpInfoSeq) {
    var targetMarker = corpInfoVoListJson[corpInfoSeq].marker;
    // 마커 객체에 사용자 이벤트를 등록한다
    daum.maps.event.trigger(targetMarker, 'reset','');
}

</script>
</body>
</html>
