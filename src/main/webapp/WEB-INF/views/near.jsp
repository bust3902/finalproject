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

/*navbar 숨김 기능을 위한 css 설정 추가*/
	nav!important {
		position: fixed;
		top: -header.height;
		width: 100%;
		transition: top 0.5s;
	}

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
		<div class="col-3 d-flex flex-column px-0">
			<div class="p-3 bg-light">
	  			<form id="form-search" class="d-flex justify-content-center p-3 my-auto" action="javascript:changeCurrentPage(1);" autocomplete="off">
					<input class="form-control me-2 type="text" id="search" name="keyword" value="${param.keyword }" placeholder="통합검색" style="max-width:600px;height:auto">
					<input type="hidden" name="type" value="">
					<input type="hidden" name="currentLat" value="${param.currentLat}">
					<input type="hidden" name="currentLong" value="${param.currentLong}">
					<input type="hidden" name="userNo" value="${LOGIN_USER.no }">
					<button class="btn btn-outline-primary" type="submit"><i class="bi bi-search"></i></button>
				</form>
				<ul class="nav nav-pills d-flex justify-content-evenly" id="tab-types"  role="tablist">
					<li class="nav-item">
						<button class="nav-link active" type="button" role="tab" data-bs-toggle="tab" aria-selected="true" data-type="">전체</button>
					</li>
					<li class="nav-item">
						<button class="nav-link" type="button" role="tab" data-bs-toggle="tab" aria-selected="true" data-type="A">숙소</button>
					</li>
					<li class="nav-item">
						<button class="nav-link" type="button" role="tab" data-bs-toggle="tab" aria-selected="true" data-type="R">맛집</button>
					</li>
					<li class="nav-item">
						<button class="nav-link" type="button" role="tab" data-bs-toggle="tab" aria-selected="true" data-type="M">MY</button>
					</li>
				</ul>
			</div>
			<div id="places-wrapper" class="p-3">
				<!-- 검색결과가 이곳에 출력된다. -->
			</div>
			<div id="pagination-wrapper" class="d-flex justify-content-center">
				<ul id="ul-item-wrapper" class="pagination" class="mx-auto">
					<!-- 페이징 번호 버튼이 이곳에 출력된다. -->
				</ul>
			</div>
		</div>
		<!-- 지도 -->
		<div class="col-9 px-0">
			<div id="map" class="vh-100">
				<div class="position-absolute" style="z-index: 1000;">
					<div class="position-relative start-0 top-0 p-3 d-flex">
						<!-- 현재 위치 가져오기 -->
						<button id="refreshlocation-btn" type="button" class="btn btn-danger me-1">
							<i class="bi bi-compass" style="cursor: pointer;"></i>
						</button>
						<!-- 지도 중심 가져오기 -->
						<button id="mapcenter-btn" type="button" class="btn btn-danger">지도위치로 검색</button>
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
 * 현재 위치 좌표 갱신하고, 숙소 검색 결과 갱신하기 : 최초 화면 출력시에 실행하고, 사용자가 내 위치 버튼 클릭 시에도 실행한다.
 */
	// 지도 정의하기
	let container = document.getElementById('map');
	// mapcenter 값 설정
	let options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng("37.5666805", "126.9784147"), //지도의 중심좌표
			level: 8 //지도의 레벨(확대, 축소 정도)
	};
	// 지도 생성, 윈도우로 보내기(지도 객체를 사용하는 search함수를 외부에서 정의하기 위함)
	window.map = new kakao.maps.Map(container, options);
	map.relayout();

	// 현재 위치 좌표를 저장하고 마커를 생성
	myLocationMarker = new kakao.maps.Marker({
	    position: new kakao.maps.LatLng($(":hidden[name=currentLat]").val(), $(":hidden[name=currentLong]").val()),
	    image: myLocaMarkerImage
	});
	myLocationMarker.setMap(map);
	
	if("${param.currentLat}" != "" && "${param.currentLong}" != "") {
		// URL에서 특정 좌표를 전달받은 경우, 내위치와 지도 중심을 그 좌표로 하고 지도 레벨을 확대시킨다.
		setMyLocationByLatLng("${param.currentLat}", "${param.currentLong}");
		map.setLevel(5);
	} else if ("${param.keyword }" != "") {
		// URL에서 특정 좌표 없이 요청파라미터로 keyword값을 전달받은 경우, 내위치와 지도중심을 서울중심으로 한다.
		setMyLocationByLatLng("37.5666805", "126.9784147");
	} else {
		// 어느 경우에도 속하지 않으면 내위치 획득하고 중심 설정하는 함수 실행
		refreshLocation();
	}

	// 화면 첫 출력시 페이지버튼과 전체 검색결과를 띄운다
	changeCurrentPage(1);
});

////////////////// 지도 관련
// 검색결과 마커로 사용할 이미지 객체를 만든다.
let placeMarkerImage =  new kakao.maps.MarkerImage('/resources/images/markericons/geo-alt-fill.svg', new kakao.maps.Size(42,42));
// 현재 지도에 표시된 검색결과 마커를 관리하기 위한 배열을 정의한다.
let placeMarkers = [];
// 내 위치좌표값, 마커객체를 관리하는 변수를 정의
let currentLat = '';
let currentLong = '';
let myLocationMarker = '';
// 내 위치 마커 이미지 만들기
let myLocaMarkerImage =  new kakao.maps.MarkerImage('/resources/images/markericons/house-door-fill.svg', new kakao.maps.Size(42,42));

////// 내 위치 관련
// 아래 함수를 실행하면 현재 위치 좌표를 새로 조회하고, 전역변수 currentLat, currentLong와 hidden 태그에 값이 저장된다.
// 현재 위치 좌표를 새로 조회하지 못하면 서울 중심 좌표를 대신 저장한다.
function refreshLocation() {
	// navigator.geolocation에서 지원하는 메소드를 사용해 사용자의 현재 위치 좌표값을 획득한다.
	// 받아온 좌표값은 hidden태그에 저장해서 검색 시 거리계산 조건에 사용할 수 있게 한다.
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			// 성공 시 콜백함수
	    	currentLat = position.coords.latitude;
	    	currentLong = position.coords.longitude;
			// 검색결과, 내위치마커, 지도 중심 갱신
			setMyLocationByLatLng(currentLat, currentLong);
    	}, function(position) {
			// 실패 시 콜백함수
			// 현재 위치를 받을 수 없으면 서울 중심 좌표를 저장
			currentLat = 37.564214;
			currentLong = 127.0016985;
			// 검색결과, 내위치마커, 지도 중심 갱신
			setMyLocationByLatLng(currentLat, currentLong);
		});
	}
	
}

// 현재 지도 중심을 특정 좌표값으로 바꿔주는 함수
function setMyLocationByLatLng(currentLat, currentLong) {
	$(":hidden[name=currentLat]").val(currentLat);
	$(":hidden[name=currentLong]").val(currentLong);
	myLocationMarker.setPosition(new kakao.maps.LatLng(currentLat, currentLong));
	map.setCenter(new kakao.maps.LatLng(currentLat, currentLong));
	changeCurrentPage(1);
}

// 현재 지도 중심을 내 위치(검색 기준으로 바꾸는 함수)
function setMyLocationByMap() {
	let latlng = map.getCenter();
	let currentLat = latlng.getLat();
	let currentLong = latlng.getLng();
	$(":hidden[name=currentLat]").val(currentLat);
	$(":hidden[name=currentLong]").val(currentLong);
	myLocationMarker.setPosition(new kakao.maps.LatLng(currentLat, currentLong));
	map.setCenter(new kakao.maps.LatLng(currentLat, currentLong));
	changeCurrentPage(1);
}

////// 검색결과 관련
// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수.
//* 인자값이 null이면 마커를 삭제하고, 지도 객체이면 그 지도에 마커를 표시한다.
function setMarker(map) {
	for (let i = 0; i < placeMarkers.length; i++) {
		placeMarkers[i].setMap(map);
	}
}

/*
 * 검색창에 입력한 키워드에 따른 검색결과를 ajax로 획득하여 화면, 지도에 출력하는 함수
 */
function search(currentPage) {
	let queryString = $("#form-search").serialize() + "&currentPage=" + currentPage;
	// MY 버튼을 눌러서 이 함수를 실행했을 경우와, 다른 버튼을 눌렀을 경우 요청하는 URL이 다르다.
	let url = '';
	if ($("button[data-type='M']").hasClass("active")) {
		url = "/places/mylike";
	} else {
		url = "/places";
	}
	
	$.getJSON(url, queryString).done(function(places) {
		let content = '';
		let $wrapper = $("#places-wrapper").empty();
		if (places.length === 0) {
			content += '<div class="p-3 text-center my-auto">조회 결과가 없습니다.</div>';
			$wrapper.append(content);
		} else {
			// 기존에 지도에 표시된 마커를 모두 삭제하고, 배열을 비운다.
			setMarker(null);
			placeMarkers = [];
			$.each(places, function(index, place) {
				content = '';
				let detailURL = '';
				if (place.type === "A") {
					detailURL = "/acco/detail?id=" + place.id;
				} else if (place.type === "R") {
					detailURL = "/restaurant/detail?no=" + place.id;
				} else {
					alert("다시 시도해주세요.")
					return;
				}
				
				console.log(place.name, place.reviewRateIcon);
				content += '	<div class="row p-3 border-bottom">';
				content += '		<p class="mb-1">';
				content += '			<span id="place-name-' + place.id + '" class="fw-light text-muted" style="cursor: pointer;">' + place.name + '</span>';
				content += '			<small class="border-end mx-3"></small>';
				content += '			<small>' + (place.type == "A" ? '숙소' : '맛집' ) + '</small>';
				content += '			<i id="icon-heart-' + place.id + '" data-place-id="' + place.id +'" data-place-type="' + place.type +'" class="icon-heart bi ' + (place.liked ? 'bi-heart-fill' : 'bi-heart') + ' fs-5 text-primary float-end"></i>';
				content += '		</p>';
				content += '		<p class="text-warning small">';
				content += '			<span class="badge bg-warning">' + place.reviewRate.toFixed(1) + '</span>';
				content += '			<i class="bi ' + place.reviewRateIcon.star1 + '"></i>';
				content += '			<i class="bi ' + place.reviewRateIcon.star2 + '"></i>';
				content += '			<i class="bi ' + place.reviewRateIcon.star3 + '"></i>';
				content += '			<i class="bi ' + place.reviewRateIcon.star4 + '"></i>';
				content += '			<i class="bi ' + place.reviewRateIcon.star5 + '"></i>';
				content += '			<span class="border-end mx-1"></span>';
				content += '			<span class="text-muted">리뷰 ' + place.reviewCount +'건</span>';
				content += '			<span class="border-end mx-1"></span>';
				content += '			<span id="like-count-' + place.id +'" class="text-muted"> 찜 ' + place.likeCount +'명</span>';
				content += '			<span class="badge bg-danger float-end">' + place.distance +'km</span>';
				content += '		</p>';
				content += '		<p class="small mb-1">';
				content += '			<span>' + place.address +'</span>';
				content += '		</p>';
				content += '		<a class="small text-decoration-none text-secondary float-end" href="' + detailURL + '">상세보기</a>';
				content += '	</div>';
				$wrapper.append(content);
				
				let markerPosition = new kakao.maps.LatLng(place.latitude, place.longitude);
				let marker = new kakao.maps.Marker({
				    position: markerPosition,
				    image: placeMarkerImage
				});
				
				// 마커에 click 이벤트를 등록
 				kakao.maps.event.addListener(marker, 'click', function() {
 					// 상세조회 페이지로 이동
 					location.href= detailURL;
 				});
				// 마커에 mouseover, mouseout 이벤트를 등록
				// * mouseover 시 보여줄 커스텀오버레이를 생성 (숙소 정보 요약)
				let overlaycontent = '';
				overlaycontent += `<div class="position-relative">
										<div class="position-absolute" style="top: -130px; left: -95px;">
											<button type="button" class="btn btn-dark position-relative" style="background-color: rgba( 0, 0, 0, 0.5 );">
												<div>`;
				overlaycontent += place.name + '<br/>';
				overlaycontent += '<small>평점 : </small><span class="badge bg-warning">' + place.reviewRate.toFixed(1) + '</span><br/>';
				overlaycontent += '<small>내 위치까지 거리 : <strong>' + place.distance + 'km</strong></small>';
				overlaycontent += `				</div>
											<svg width="1em" height="1em" viewBox="0 0 16 16" class="position-absolute top-100 start-50 translate-middle mt-1 opacity-50" fill="#212529" xmlns="http://www.w3.org/2000/svg"><path d="M7.247 11.14L2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/></svg>
										</button>
									</div>
								</div>`;
				let overlay = new kakao.maps.CustomOverlay({
					content: overlaycontent,
					position: markerPosition
				});
				kakao.maps.event.addListener(marker, 'mouseover', function() {
					overlay.setMap(map);
				});
				kakao.maps.event.addListener(marker, 'mouseout', function() {
					overlay.setMap(null);
				});
				// 장소 이름을 클릭하면 해당 장소의 커스텀오버레이를 보여주는 이벤트핸들러 등록
				 $("#place-name-" + place.id).click(function() {
					 overlay.setMap(map);
				 });
				
				// 배열에 마커 객체를 저장
				placeMarkers.push(marker);
				
			});
			// 배열에 담긴 마커를 지도에 모두 표시한다.
			setMarker(map);
		}
	})
}

//////////////////지도 외 엘리먼트 관련
/**
 * 현재 페이지에 대한 pagination 객체를 db로부터 조회해 페이지 버튼 엘리먼트를 생성하는 함수
 * 검색날짜를 변경해서, 객실 데이터 행 수가 변경될 때 실행한다.
 */
function refreshPaginationButton(currentPage) {
	let queryString = $("#form-search").serialize() + "&currentPage=" + currentPage;
	if ($("button[data-type='M']").hasClass("active")) {
		queryString += "&option=mylike";
	} else {
		queryString += "&option=places";
	}
	$.getJSON("/places/pagination", queryString).done(function(pagination) {
		let $wrapper = $("#ul-item-wrapper").empty();
		let content = '';
		content += '<li class="page-item" data-page-num="' + (currentPage - 1)  +'">';
		content += '	<a class="page-link ' + (pagination.currentPage <= 1 ? "disabled" : "") + '" aria-label="Previous">';
		content += '		<span aria-hidden="true">&laquo;</span>';
		content += '	</a>';
		content += '</li>';
		for (let num = pagination.beginPage; num <= pagination.endPage; num ++) {
			content += '<li class="page-item ' + (pagination.currentPage == num ? "active" : "") + '" data-page-num="' + num + '">';
			content += '	<a class="page-link" href="javascript:changeCurrentPage(' + num +');">' + num +'</a>';
			content += '</li>';
		}
		content += '<li class="page-item" data-page-num="' + (currentPage + 1)  +'">';
		content += '	<a class="page-link ' + (pagination.currentPage >= pagination.totalPages ? "disabled" : "") + '" aria-label="Next">';
		content += '    <span aria-hidden="true">&raquo;</span>';
		content += '  </a>';
		content += '</li>';
		
		$wrapper.append(content);
		
		// 페이지 버튼에 changeCurrentPage(currentPage) 함수 연결
		$wrapper.find(".page-item").click(function() {
			changeCurrentPage($(this).attr("data-page-num"));
		})
	});
}

function changeCurrentPage(num) {
	$("#pagination-wrapper .page-item").removeClass("active");
	$('li[data-page-num="' + num +'"]').addClass("active");
	// num을 currentPage로 하는 객실 정보 또는 찜목록 출력
	search(num);
	// 페이지 버튼 상태 갱신
	refreshPaginationButton(num);
}

/*
 * 엘리먼트에 대한 사용자 상호작용 이벤트 등록
 */
$("#refreshlocation-btn").click(function() {
	refreshLocation();
});
$("#mapcenter-btn").click(function() {
	setMyLocationByMap();
});
$("#tab-types button").click(function() {
	let type = $(this).attr("data-type");
	 if (type === "M") {
		 if ("${LOGIN_USER }" === "") {
			 alert("내 찜목록은 로그인이 필요한 기능입니다.");
			 location.reload();
			 return;
		 }
	 } else {
		// MY버튼을 클릭하지 않았을 때에만 hidden태그에 값을 저장
		$(":hidden[name=type]").val(type);
	 }
	changeCurrentPage(1);
});
// 마이페이지를 선택한 상태에서 검색 시 전체검색으로 탭 변경
$("#form-search").submit(function(){
	let $mypageBtn = $("button[data-type='M']");
	if ($($mypageBtn).hasClass("active")) {
		$mypageBtn.removeClass("active");
		$("button[data-type='']").addClass("active");
		$(":hidden[name=type]").val("");
		changeCurrentPage(1);
	}
});
// 하트아이콘 눌렀을 때 찜하기 기능 구현
$(document).on("click", ".icon-heart", function(){ toggleLike(event); });

// 찜하기 토글, DB 반영
function toggleLike(event) {
	let id = event.target.getAttribute("data-place-id");
	let type = event.target.getAttribute("data-place-type");
	let $icon = $(event.target);
	// 로그인 여부 체크
	if ("${LOGIN_USER }" == "") {
		alert("찜하기는 로그인이 필요한 기능입니다.");
		return false;
	}
	
	// 하트를 누른 장소의 유형에 따라 ajax 요청url이 달라진다.
	let url = '';
	let queryString = '';
	if (type == "A") {
		url = "/changelike/acco";
		queryString = "accoId=" + id;
	} else if (type == "R") {
		url = "/changelike/restaurant";
		queryString = "restaurantNo=" + id;
	}
	
	// 숙소아이디 전달해서 ajax로 like 저장 요청
	$.getJSON(url, queryString).done(function(result) {
		if (result === true) {
			console.log("test");
			// 아이콘 표현 토글 처리
			$icon.toggleClass("bi-heart-fill");
			$icon.toggleClass("bi-heart");
			// 찜한 사람 수를 반영하기 위해 페이지갱신
			let currentPage = $("#ul-item-wrapper .active").find("a").text();
			changeCurrentPage(currentPage);
		} else {
			console.log('fail');
			alert("오류가 발생했습니다. 다시 시도해주세요.");
		}
	});
	
}

window.onscroll = function() {
	if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
		document.querySelector("nav").style.top = '0';
	} else {
		document.querySelector("nav").style.top = '-200px';
	}
}
</script>
</body>
</html>