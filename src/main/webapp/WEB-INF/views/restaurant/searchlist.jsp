<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<title>서울 맛어때</title>
</head>
<body>
<div class="container my-3" style="min-width:992px; max-width:992px;">
<form id="form-search-restaurant" >
	<div class="position-relative">
		<form id="form-search" class="d-flex" role="search" action="searchlist">
	        <input class="form-control me-sm-2" type="text" name="keyword" value="${param.keyword }" id="search" placeholder="지역,음식을 검색하세요">
	        <button class="btn btn-secondary my-2 my-sm-0" type="button" onclick="searchRestaurants();">
	        	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				</svg>
			</button>
			<div id="box-keywords" class="position-absolute w-100 d-none" style="top:44px; left:0; z-index: 1000;">
				<ul class="list-group" id="fix-grop-keywords">
					<li class="list-group-item list-group-flush border">
						<a href="" class="border-bottom" >내주변 검색</a>
							<hr style="display: block;">
						<div class="d-flex justify-content-between">
							<span>최근검색어</span>
							<button id="delete-all-keyword" type="button" class="float-end btn text-danger border-0 btn-sm">모두 지우기</button>
						</div>
					</li>
				</ul>
				<ul class="list-group" id="list-group-keywords">
		  			<li class="list-group-item list-group-flush border">
						<a href="" class="border-bottom">내주변 검색</a>
							<hr style="display: block;">
						<div class="d-flex justify-content-between">
							<span>최근검색어</span>
							<button type="button" class="float-end btn text-danger border-0 btn-sm">모두 지우기</button>
						</div>
					</li>
					<li class="list-group-item list-group-flush ">
						<div class="d-flex justify-content-between">
							<button type="button" class="float-end btn text-dark border-0 btn-sm">
								<i class="bi bi-clock"></i>
								<span class="ms-4">맛있는 맛집</span>
							</button>
							<button type="button" class="float-end btn text-danger border-0 btn-sm"><i class="bi bi-trash"></i></button>
						</div>
					</li>
				</ul>
			</div>
	</div>
	<div class="row px-3 pt-5 pb-3">
	</div>
	<div class="row">
		<div class="col-4">
			<div class="card p-1">
				<ul class="list-group list-group-flush">
					<li class="list-group-item py-3">
						<div class="fw-bold mb-3">카테고리</div>
						<!-- 음식 카테고리만큼 내용이 출력되게 하기 -->
						<div class="row p-3">
							<c:forEach var="category" items="${categories }">
								<div class="form-check">
							        <input class="form-check-input" type="radio" name="categorys" onchange="searchRestaurants()" value="${category.id }">
							        <label class="form-check-label" for="optionsRadios1">
							          ${category.name }
							        </label>
						      	</div>
							</c:forEach>
						</div>
					</li>
					<li class="list-group-item py-3">
						<div class="fw-bold mb-3">음식점 태그</div>
						<!-- 음식 태그만큼 내용이 출력되게 하기 -->
						<c:forEach var="tag" items="${tags }">
							 <div class="form-check">
							     <input class="form-check-input" type="checkbox" name="tags" value="${tag }" onchange="searchRestaurants()">
							     <label class="form-check-label" for="flexCheckDefault">${tag }</label>
						     </div>
						</c:forEach>
					</li>
					<li class="list-group-item py-3">
						<div class="row p-3">
							<select class="form-select w-80" name="city" onchange="searchRestaurants()">
								<option value="" data-city-lat="37.5666805" data-city-long="126.9784147" selected>서울 전체</option>
								<!-- 모든 지역정보를 받아와 반복문으로 출력 -->
								<c:forEach var="city" items="${cities }">
									<option value="${city.id }" data-city-lat="${city.latitude }" data-city-long="${city.longitude }">${city.name }</option>
								</c:forEach>
							</select>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="col-8">
			<div class="d-flex flex-wrap mx-3 mb-3">
				<div id="btn-group-sort" class="btn-group flex-fill pe-2" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" id="btnradio11" name="sort" value="point" checked onchange="searchRestaurants()">
					<label class="btn btn-secondary" for="btnradio11">평점 순</label>
	
					<input type="radio" class="btn-check" id="btnradio22" name="sort" value="count"  onchange="searchRestaurants()">
					<label class="btn btn-secondary" for="btnradio22">리뷰 많은 순</label>
					
					<input type="radio" class="btn-check" id="btnradio33" name="sort" value="like"  onchange="searchRestaurants()">
					<label class="btn btn-secondary" for="btnradio33">좋아요 많은 순</label>
					
					<input type="radio" class="btn-check" id="btnradio44" name="sort" value="dist"  onchange="searchRestaurants()">
				  	<label class="btn btn-secondary" for="btnradio44">거리 순</label>
				</div>
			</div>
			<div class="row mb-3">
				<h3>내주변 맛집<button class="btn btn-outline-secondary btn-lg border-0 float-end"><i class="bi bi-share"></i></button></h3>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				  <input type="radio" class="btn-check" name="distance" id="btnradio1" autocomplete="off" checked=""  onchange="searchRestaurants()">
				  <label class="btn btn-outline-secondary" for="btnradio1">500m</label>
				
				  <input type="radio" class="btn-check" name="distance" id="btnradio2" autocomplete="off" onchange="searchRestaurants()">
				  <label class="btn btn-outline-secondary" for="btnradio2">1km</label>
				
				  <input type="radio" class="btn-check" name="distance" id="btnradio3" autocomplete="off" onchange="searchRestaurants()">
				  <label class="btn btn-outline-secondary" for="btnradio3">2km</label>
				
				  <input type="radio" class="btn-check" name="distance" id="btnradio4" autocomplete="off" onchange="searchRestaurants()">
				  <label class="btn btn-outline-secondary" for="btnradio4">3km</label>
				</div>
			</div>
				<div>
					<div class="row mb-3" id="map" style="width:100%;height:350px;"></div>
				</div>
			<!-- 검색 결과 조회 리스트 -->
			<div class="row mx-auto">
				<table class="table">
					<colgroup>
						<col width="30%">
						<col width="*">
						<col width="20%">
					</colgroup>
					<tbody id="tbody-rests">
						<!-- 음식 검색결과가 script를 통해 출력됨-->
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<input type="hidden" name="minLat">
	<input type="hidden" name="maxLat">
	<input type="hidden" name="minLon">
	<input type="hidden" name="maxLon">
</form>	
</div>

<!-- 현재 위치를 확인할 수 있는 버튼입니다. -->
<div class="position-absolute" style="top:60px; left:1200px;" >
	<button id="locationButton" class="float-end border-0"><i class="bi bi-geo"></i>현재위치 확인</button>
	<p id="demo"></p>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=49a6f0504323df1e2fbc06bfac690d78"></script>
<script type="text/javascript">

let currentLat = '';
let currentLong = '';

$("#locationButton").click(function() {
	let x = document.getElementById("demo");
	// 위도와 경도 값을 가져오는 코드입니다.
	if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(function(position) {
	    	let latitude = position.coords.latitude;
	        let longitude = position.coords.longitude;
	        //alert(latitude + ", " + longitude);
	        
	        // 구글 map api를 이용해서 위도 경도 값을 통해 해당하는 주소값 가져오기
	        $.getJSON('https://maps.googleapis.com/maps/api/geocode/json', 
	        		  {sensor:false, 
	        	       language:"ko",
	        	       latlng: latitude+","+longitude, 
	        	       key: "AIzaSyCLpyfe2_7Lvws3-UCb2qAtTouxy1xzCJo"})
	        .done(function(data) {
	        	console.log(data);
	        	let location = data.results[0];
	        	//let address = location.formatted_address.replace("대한민국 ", " ");
	        	let address2 = location.formatted_address.split(' ');
	        	//alert(address2[2]+' '+address2[3]);
	        	//alert(address);
	        	$("#locationButton").text(address2[2]+' '+address2[3]);
	        })
	    });
	  } else { 
		// 현재 위치를 받을 수 없으면 서울 중심 위경도를 저장
	    	currentLat = 37.564214;
	    	currentLong = 127.0016985;
			$(":hidden[name=currentLat]").val(currentLat);
			$(":hidden[name=currentLong]").val(currentLong);
	  }
});
	let $boxKeywords = $("#box-keywords");
	
	$("#search").click(function() {
	
		// 최근 검색어 토굴을 이용. 체크박스를
		$boxKeywords.toggleClass("d-none");
	
		refreshKeywordList() 
	});
	
	// 최근 검색어를 저장하는 기능
	$("#form-search").submit(function() {
		let keyword = $(":input[name=keyword]").val();
		let text = localStorage.getItem("keywords") || '[]';
		let array = JSON.parse(text);
		
		if (keyword != "") {
			// 여기서 변수명 입력 조심하기
			array.unshift(keyword);
			text = JSON.stringify(array);
			localStorage.setItem("keywords", text);
			
			return ture;
		} else {
			alert("검색어를 입력하세요");
			return false;
		}
		
	});
	
	// 최근 검색어 전체 삭제하는 기능
	$("#delete-all-keyword").click(function() {
		localStorage.setItem("keywords",[]);
		
		refreshKeywordList();
	});
	
	// 최근 검색어를 최신화 하는 기능()
	function refreshKeywordList() {
		let text = localStorage.getItem("keywords") || '[]';
		let array = JSON.parse(text);
		
		// empty를 사용해서 기존의 검색했던 최근 검색어를 지웁니다.
		let $listGroup = $("#list-group-keywords").empty();
		
		$.each(array, function(index, keyword) {
			let content = '';
			content += '<li class="list-group-item list-group-flush ">'
			content += '	<div class="d-flex justify-content-between">'
			content += '		<button type="button" class="float-end btn text-dark border-0 btn-sm">'
			content += '			<i class="bi bi-clock"></i>'
			content += '			<span class="ms-4" onclick="searchKeyword(\''+keyword+'\')">'+keyword+'</span>'
			content += '		</button>'
			content += '		<button type="button" class="float-end btn text-danger border-0 btn-sm" onclick="deleteKeyword('+index+')"><i class="bi bi-trash"></i></button>'
			content += '	</div>'
			content += '</li>'
			// let content = '<li class="list-group-item list-group-flush border"> <i class="bi bi-clock"> '+keyword+' <button>X</button> </li>';
			$listGroup.append(content);
		})
	}
	
	// 최근 검색어를 하나씩 삭제하는 기능
	function deleteKeyword(index) {
		let text = localStorage.getItem("keywords") || '[]';
		let array = JSON.parse(text);
		
		array.splice(index, 1);
		text = JSON.stringify(array);
		localStorage.setItem("keywords", text);
		
		refreshKeywordList();
		// alert(index);
	};
	
	// 최근 검색어 클릭시 검색되게 하는 기능
	// index를 주고 받지 말고 쉽게 keyword를 주고 받기
	function searchKeyword(keyword) {
		//alert(keyword);
		
		location.href="searchlist?keyword=" + keyword;
	};
	
	// 카카오 맵 api를 이용한 지도 구현
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};
	
	//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	let map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 현재 선택한 지역에 따른 지도의 중심좌표와 확대 레벨 재설정
	changeMapCenter(map);
	// 내 위치 마커 생성하기
	// 내 위치 마커 이미지 만들기
	let myLocaMarkerImage =  new kakao.maps.MarkerImage('/resources/images/markericons/house-door-fill.svg', new kakao.maps.Size(45,45));
	let myLocationMarker = new kakao.maps.Marker({
	    position: new kakao.maps.LatLng(currentLat, currentLong),
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
	
	
	/*
		ajax로 검색 조건에 따른 음식점 정보 조회하기
	*/
	// 현재 지도에 표시된 마커를 관리하기 위한 배열을 정의하기
	let restaurantMakers = [];
	// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수
	// * 인자값이 null이면 마커를 삭제하고, 지도 객체면 그 지도에 마커를 표시한다.
	function setMarker(map) {
		for(let i = 0; i < restaurantMakers.length; i++) {
			restaurantMakers[i].setMap(map);
		}
	}
	// 마커에서 사용할 이미지 객체를 만들기
	let restMarkerImage =  new kakao.maps.MarkerImage('/resources/images/markericons/geo-alt-fill.svg', new kakao.maps.Size(45,45));
	
	function searchRestaurants() {
		let queryString = $("#form-search-restaurant").serialize();
		
		
		
		let $tbody = $("#tbody-rests").empty();
		// 기존 지도에 표시된 마커를 모두 삭제하고 배열을 비운다.
		setMarker(null);
		restaurantMakers = [];
		
		// ajax로 검색조건에 따른 숙소정보를 요청해 응답 데이터로 받는다.
		$.getJSON("/restaurants", queryString).done(function(rests) {
			if (rests.length === 0) {
				let content = `
					<tr>
						<td colspan="3" class="text-center">
							<p class="py-5">조회된 결과가 없습니다.</p>
						</td>
					</tr>
				`;
				$tbody.append(content);
			} else {
				$.each(rests, function(index, rest) {
					// 음식점 정보 html컨텐츠 생성
					let content = '';
					content += '<div id="card-rest-' + rest.no +'" class="card text-bg-light p-0 rounded-0">';
					// content += '	<img src="/resources/images/acco/thumbnail/' + acco.thumbnailImageName +'" class="list-thumbnail card-img img-fluid rounded-0" alt="accommodation thumbnail">';
					content += '	<div class="p-3 rounded-0">';
					content += '		<div class="my-auto">';
					content += '		<h5 class="fw-semibold">' + rest.name + '</h5>';
					content += '			<p class="text-warning">';
					content += '				<span class="badge bg-warning">' + rest.reviewPoint.toFixed(1) + '</span><strong class="ms-2"> (' + rest.reviewCount  +')</strong>';
					content += '			</p>';
					content += '			<small>' + rest.district + '</small>';
					content += '			<small>' + rest.tel + '</small>';
					content += '			<small>' + rest.cityId + '</small>';
					content += '		<p class="text-end fs-4 fw-semibold mt-auto">' + rest.tel + '<span class="fs-5"></span></p>';
					content += '		</div>';
					content += '	</div>';
					content += '</div>';
					
					
					$tbody.append(content);
					$("#card-rest-"+rest.no).click(function() {
						location.href = "detail?no=" + rest.no;
					});
					
					let markerPosition = new kakao.maps.LatLng(rest.latitude, rest.longitude);
					let marker = new kakao.maps.Marker({
						map: map,
					    position: markerPosition,
					    image: restMarkerImage
					});
					
					// 마커에 click 이벤트를 등록
					kakao.maps.event.addListener(marker, 'click', function() {
						// 상세조회 페이지로 이동
						location.href="restaurant/detail?no=" + rest.no;
					});
					//restaurantMakers.push(marker);
				});
				//setMarker(map);
			}
		});
	}
	
	// 지도가 이동, 확대, 축소로 인해 지도영역이 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'bounds_changed', function() {             
	    
	    // 지도 영역정보를 얻어옵니다 
	    var bounds = map.getBounds();
	    
	    // 영역정보의 남서쪽 정보를 얻어옵니다 
	    var swLatlng = bounds.getSouthWest();
	    
	    // 영역정보의 북동쪽 정보를 얻어옵니다 
	    var neLatlng = bounds.getNorthEast();
	    
	    var message = '<p>영역좌표는 남서쪽 위도, 경도는  ' + swLatlng.toString() + '이고 <br>'; 
	    message += '북동쪽 위도, 경도는  ' + neLatlng.toString() + '입니다 </p>'; 
	    
	    var resultDiv = document.getElementById('result');   
	    resultDiv.innerHTML = message;
	    
	});
	
</script>
</body>
</html>