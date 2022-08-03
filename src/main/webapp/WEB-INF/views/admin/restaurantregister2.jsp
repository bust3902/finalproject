<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<h1 class="fs-3 text-white p-2">음식점 등록</h1>
	</div>
</div>
<div class="container mt-5" style="min-width:992px; max-width:992px;">
	<div class="row mb-3 px-3">
	
		<div class="col-3">
			<!-- 사이드바 -->
			<aside>
				<jsp:include page="../common/adminsidebar.jsp" />
			</aside>
		</div>
		
		<div class="col-9 border bg-white">
				
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div>
			                <form onsubmit="searchPlaces(); return false;">
			                    키워드 : <input type="text" value="이태원 맛집" id="keyword" size="15"> 
			                    <button type="submit">검색하기</button> 
			                </form>
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
    
				<div class="row">
					위치, 주소
					<div id="map" style="width:100%;height:40vh;"></div>
				</div>
				
			<form id="form-restaurant" class="col p-3" method="post" action="insert">
		
				<!-- DB에서 태그 꺼내와서 c:forEach로 출력 -->
				<div class="mb-5">
					<label class="form-label">태그</label>
					<div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="tags" value="">
							<label class="form-check-label" >태그</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="tags" value="">
							<label class="form-check-label" >태그</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="tags" value="">
							<label class="form-check-label" >태그</label>
						</div>
					</div>
				</div>
				
				<!-- 메뉴 입력 폼 -->
				<div class="mb-5">
					<label class="form-label">메뉴</label>
					<input class="form-control mb-2" type="text" id="menu-name">
					<label class="form-label">금액</label>
					<input class="form-control mb-2" type="text" id="menu-price">
					<div class="text-end">
						<button type="button" class="btn btn-secondary btn-sm" id="btn-add-menu">추가</button>
					</div>
					<div class="mb-3 mt-2">
						<div id="menu-box"></div>
					</div>
				</div>

				
				<!-- 
					주소 입력 폼
					지도에서 위치선택(위도,경도)
				 -->
				<!-- <div class="mb-5">
					<label class="form-label">주소</label>
					<input class="form-control mb-2" type="text" name="location">
					<div class="text-end">
						<button type="button" class="btn btn-secondary btn-sm" id="btn-add-address">입력</button>
					</div>
				</div> -->
				
				<!-- submit -->
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5">등록</button>
				</div>		
				
			</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e9adb3077789558d707162df08956e7&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 1 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

// 인포윈도우 전역변수 선언
var infowindow;

//키워드로 장소를 검색합니다
searchPlaces();

//키워드 검색을 요청하는 함수입니다
function searchPlaces() {

var keyword = document.getElementById('keyword').value;

	if (!keyword.replace(/^\s+|\s+$/g, '')) {
	    alert('키워드를 입력해주세요!');
	    return false;
	}
	
	// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	ps.keywordSearch( keyword, placesSearchCB);
	
	//지도 중심좌표를 얻어옵니다 
	var latlng = map.getCenter();

	console.log(latlng);
}

//키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	    // LatLngBounds 객체에 좌표를 추가합니다
	    var bounds = new kakao.maps.LatLngBounds();
	
	    for (var i=0; i<data.length; i++) {
	        displayMarker(data[i]);    
	        bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	    }       
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
}

//지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
 
	// 마커를 생성하고 지도에 표시합니다
	var marker = new kakao.maps.Marker({
		map: map,
		position: new kakao.maps.LatLng(place.y, place.x),
		clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
	});

	//마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
	var iwContent = '<div style="padding:5px;">선택되었습니다.</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

	// 인포윈도우를 생성합니다
		infowindow = new kakao.maps.InfoWindow({
		content : iwContent,
		removable : iwRemoveable
	});

	// 마커에 클릭이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'click', function() {
		infowindow.close();
		// 마커 위에 인포윈도우를 표시합니다
		infowindow.open(map, marker);
		var location = marker.getPosition();
		console.log(location);
	});
}

// 메뉴 추가 버튼
$("#btn-add-menu").click(function() {
	let $div = $("#menu-box");
	let $inputName = $("#menu-name");
	let $inputPrice = $("#menu-price");

	let menuLength = $(":input[name=menus]").length;
	if (menuLength >= 10) {
		alert("최대 10개까지만 가능합니다.");
		$input.val("");
		return;
	}
	
	let menuName = $inputName.val();
	let menuPrice = $inputPrice.val();
	if (menuName != "") {
		let spanContent = '<span>메뉴명 :'+menuName+' 금액 : '+menuPrice+'</span><br>';
		let hiddenContent = '<input type="hidden" name="menus" value="'+menuName+'금액 : '+menuPrice+'" />'
		
		$div.before(spanContent);
		$div.append(hiddenContent);
		
		$inputName.val("");
		$inputPrice.val("");
	}		
});
</script>
</body>
</html>