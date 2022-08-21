<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.0/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">

	#footer {
		margin: 0px!important;
	}

</style>
<title>서울어때</title>
</head>
<body>
<%@ include file="common/nav.jsp" %>
<div class="w-100 m-0">
	<div class="row w-100 m-0">
		<!-- 검색창, 결과 조회 -->
		<div class="col-3 px-0">
			<div class="p-3 bg-light">
	  			<form id="form-search" class="d-flex justify-content-center p-3 my-auto" action="/search" autocomplete="off">
					<input class="form-control me-2" type="text" id="search" name="keyword" placeholder="통합검색" style="max-width:600px;height:auto">
					<button class="btn btn-outline-primary" type="submit"><i class="bi bi-search"></i></button>
				</form>
				<ul class="nav nav-pills d-flex justify-content-evenly" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="all-tab" data-bs-toggle="tab"
							data-bs-target="#all-tab-pane" type="button" role="tab"
							aria-controls="all-tab-pane" aria-selected="true">전체</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="accommodation-tab" data-bs-toggle="tab"
							data-bs-target="#accommodation-tab-pane" type="button" role="tab"
							aria-controls="accommodation-tab-pane" aria-selected="true">숙소</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="restaurant-tab" data-bs-toggle="tab"
							data-bs-target="#restaurant-tab-pane" type="button" role="tab"
							aria-controls="restaurant-tab-pane" aria-selected="true">맛집</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="like-tab" data-bs-toggle="tab"
							data-bs-target="#like-tab-pane" type="button" role="tab"
							aria-controls="like-tab-pane" aria-selected="true">MY</button>
					</li>
				</ul>
			</div>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade show active" id="all-tab-pane" role="tabpanel" aria-labelledby="all-tab" tabindex="0">
					<div class="p-3">
						<div class="row p-3 border-bottom">
							<p class="mb-1">
								<span class="fw-light">장소 이름<small class="border-end mx-3"></small></span><small>식당</small>
								<i class="bi bi-heart fs-5 text-primary float-end"></i>
							</p>
							<p class="text-warning small">
								<span class="badge bg-warning">4.5</span>
								<i class="bi bi-star-fill"></i>
								<i class="bi bi-star-fill"></i>
								<i class="bi bi-star-fill"></i>
								<i class="bi bi-star-fill"></i>
								<i class="bi bi-star-fill"></i>
								<span class="border-end mx-1"></span>
								<span class="text-muted">리뷰 5건</span>
								<span class="border-end mx-1"></span>
								<span class="text-muted"> 찜 50명</span>
							</p>
							<p class="small mb-1">
								주소
							</p>
						</div>
					</div>
				</div>
				<div class="tab-pane fade" id="accommodation-tab-pane" role="tabpanel" aria-labelledby="accommodation-tab" tabindex="0">
					test accommodation
				</div>
				<div class="tab-pane fade" id="restaurant-tab-pane" role="tabpanel" aria-labelledby="restaurant-tab" tabindex="0">
					test restaurant
				</div>
				<div class="tab-pane fade" id="like-tab-pane" role="tabpanel" aria-labelledby="like-tab" tabindex="0">
					test mylike
				</div>
			</div>
		</div>
		<!-- 지도 -->
		<div class="col-9 px-0">
			<div id="map" class="vh-100">
				<div class="position-absolute" style="z-index: 1000;">
					<div class="position-relative start-0 top-0 p-3 d-flex">
						<button type="button" class="btn btn-danger me-1">
							<i class="bi bi-compass" style="cursor: pointer;"></i>
						</button>
						<button type="button" class="btn btn-danger">현재 위치로 검색</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="common/footer.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=258075821638bd633c20115d42be0584"></script>
<script type="text/javascript">
$(function(){
	/*
	 * 카카오 openAPI로 지도 가져오기
	 */
		// 지도 정의하기
		let container = document.getElementById('map');
		// mapcenter 값 설정
		let options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng("37.5666805", "126.9784147"), //지도의 중심좌표
				level: 7 //지도의 레벨(확대, 축소 정도)
		};
		// 지도 생성
		let map = new kakao.maps.Map(container, options);
		// 지도 중심을 설정하는 dom엘리먼트를 커스텀오버레이로 추가
// 		let element = `<i id="icon-refresh-location" class="bi bi-compass fs-4 text-primary ps-2" style="cursor: pointer;"></i>
// 						<button type="button">현재 위치로 검색</button>`;
// 		let elementOverlay = new kakao.maps.CustomOverlay({
// 			position: absolute,
// 			content: element
// 		});				
		
		// 현재 선택한 지역에 따른 지도의 중심좌표와 확대 레벨 재설정
// 		changeMapCenter(map);
		// 내 위치 마커 생성하기
		// 내 위치 마커 이미지 만들기
		let myLocaMarkerImage =  new kakao.maps.MarkerImage('/resources/images/markericons/house-door-fill.svg', new kakao.maps.Size(45,45));
		let myLocationMarker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng("37.5666805", "126.9784147"),
		    image: myLocaMarkerImage
		});
		// 내 위치 마커 지도에 표시하기
		myLocationMarker.setMap(map);
	
	/*
	 * 선택한 지역에 따라 지도의 중심좌표 변경하기
	 */
		function changeMapCenter(map) {
		// 지도의 중심 좌표는 지역 선택에 따라 달라진다.
		let cityLat = $("select[name=city] :selected").attr("data-city-lat");
		let cityLong = $("select[name=city] :selected").attr("data-city-long");
		map.setCenter(new kakao.maps.LatLng(cityLat, cityLong));
		// 전체 조회 / 지역 조회에 따라 확대 레벨이 달라진다. '서울전체' 항목은 value 값이 ""이다.
		if ($("select[name=city] :selected").val() == "") {
			map.setLevel(8);
		} else {
			map.setLevel(7);
		}
	}
});
</script>
</body>
</html>