<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.0/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery range slider를 위해 필요한 라이브러리 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<!-- javascript date range picker를 위해 필요한 라이브러리 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<style type="text/css">
	.list-thumbnail {
		height: 150px;
		object-fit: cover;
	}
	
	.list-overlay {
		background-color: rgba(0, 0, 0, 0.3);
	}
	
	.list-overlay:hover {
		background-color: rgba(255, 255, 255, 0.15);
	}
</style>
<title>서울어때</title>
</head>
<body>
<!-- 
	요청 URL : localhost/acco/search?type= 또는 ?keyword=
	1. 해당 페이지를 요청한 방식에 따라 카드의 상세조건 옵션 다르게 보이게 하기 : 각 태그 클래스에 EL 삼항연산자 적용함
	* 요청 시 전달받는 Criteria를 통해 요청한 방식 판별, 숙소정보리스트와 요청한 방식에 따른 상세 옵션내용 출력(공용시설, 객실시설, 기타 태그)
	2. 초기화 버튼을 누르면 사용자가 변경한 옵션을 모두 초기화시키기
	3. 적용 버튼을 누르면 form에 저장된 input태그의 값들을 검색조건으로 모두 전달해 ajax로 숙소정보 요청URL보내고, 데이터 획득하기.
	4. 획득한 데이터를 출력하기. (처음 화면 로드될 때는 아무 조건 없이 조회할 것)
	5. 정렬 옵션 클릭 시에도 3~4번과 마찬가지로 처리하기
	6. 지도 버튼을 누르면 모달 창으로 지도 출력하기, 이 때 3번에서 획득한 데이터의 위도와 경도를 이용해 검색결과 지도에 표시하기.
 -->
<%@ include file="../common/nav.jsp" %>
<form id="form-search-accos">
	<div class="row bg-secondary" style="height:13vh;">
		<input type="hidden" name="currentLat" value="" />
		<input type="hidden" name="currentLong" value="" />
		<div class="px-3 pt-5 pb-3 mx-auto" style="min-width:992px; max-width:992px;">
			<c:choose>
				<c:when test="${not empty param.type }">
					<input type="hidden" name="types" value="${param.type }" />
					<h3 class="text-white ps-0 mb-3">${selectedTypeName }</h3>
				</c:when>
				<c:otherwise>
		 			<input type="hidden" name="keyword" value="${param.keyword }">
		 			<!-- keyword 검색값이 빈 문자열이거나 null이면 키워드를 출력하지 않는다. -->
		 			<c:if test='${param.keyword != "" and param.keyword != null }'>
						<h3 class="fs-bold text-center text-white">'${param.keyword }'</h3>
		 			</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="container my-3" style="min-width:992px; max-width:992px;">
			<div class="row p-3">
				<div class="col d-flex justify-content-start align-items-center my-auto px-0">
					<select class="form-select w-50 p-1" name="city">
						<option value="" data-city-lat="37.5666805" data-city-long="126.9784147" selected>서울 전체</option>
						<!-- 모든 지역정보를 받아와 반복문으로 출력 -->
						<c:forEach var="city" items="${cities }">
							<option value="${city.id }" data-city-lat="${city.latitude }" data-city-long="${city.longitude }">${city.name }</option>
						</c:forEach>
					</select>
				</div>
				<div class="col d-flex justify-content-end align-items-center my-auto">
					<small>
						현재 내 위치는 <strong id="home-current-location-address"></strong>
					</small>
					<i id="icon-refresh-location" class="bi bi-compass fs-4 text-primary ps-2" style="cursor: pointer;"></i>
				</div>
			</div>
			<div class="row">
				<div class="col-4">
					<div class="card p-1">
						<ul class="list-group list-group-flush">
							<li class="list-group-item py-3">
								<div class="fw-bold mt-3 mb-1 fs-5">날짜</div>
								<div class="text-small mt-1 mb-3 text-muted">최대 7박까지 조회 가능</div>
								<!-- TO DO : 현재보다 지난 날짜는 선택 못하게 하기 -->
								<input type="text" id="datepicker" class="form-control" value="" />
								<input type="hidden" name="startDate" value="" />
								<input type="hidden" name="endDate" value="" />
							</li>
							<li class="list-group-item py-3">
								<div class="fw-bold mb-3 fs-5">상세조건</div>
								<div class="btn-toolbar row g-2" role="toolbar" aria-label="Toolbar with button groups">
									<div class="col">
										<button type="button" id="btn-reset" class="btn btn-outline-primary w-100">초기화</button>
									</div>
									<div class="col">
										<button type="button" id="btn-apply" class="btn btn-secondary w-100">적용</button>
									</div>
								</div>
							</li>
							<li class=" list-group-item py-3 border-bottom-0 text-muted ${empty param.type ? 'd-none' : '' }">
								<div class="row d-flex justify-content-center">
									<div class="col-3 fw-bold text-muted my-auto">인원</div>
									<!-- 인원 수 표시 input 대신 span 태그 사용, 이벤트 script에서 설정하는 것으로 변경 예정 -->
									<div class="col-9 hstack gap-3">
										<button type="button" class="form-control btn btn-sm btn-light fs-4"
											onclick="this.parentNode.querySelector('input[type=number]').stepDown();">-</button>
										<input type="number" class="form-control form-control-lg fs-6 mx-auto" min="1" name="capacity" value="1" max="20" />
										<button type="button" class="form-control btn btn-sm btn-light fs-4"
											onclick="this.parentNode.querySelector('input[type=number]').stepUp();">+</button>
									</div>
								</div>
							</li>
							<li class="list-group-item py-3 border-bottom-0 text-muted">
								<div class="fw-bold mb-3">가격<small id="amount" class="text-secondary ms-3">1만원 이상</small></div>
								<input type="hidden" name="minPrice" value="10000" />
								<input type="hidden" name="maxPrice" value="300000" />
								<div id="slider-range"></div>
							</li>
							<li class="list-group-item py-3 border-bottom-0 text-muted ${empty param.type ? 'd-none' : '' }">
								<div class="fw-bold mb-3">공용 시설</div>
								<div class="row">
									<!-- 선택한 숙소 유형에 맞는 공용시설 옵션을 컨트롤러로부터 전달받아 반복문으로 출력한다. -->
									<c:forEach var="facility" items="${cofacilities }">
										<div class="col-6 mb-3">
											<input class="form-check-input" type="checkbox" name="commonFacilities" value="${facility.id }">
											<label class="form-check-label small">${facility.name }</label>
										</div>
									</c:forEach>
								</div>
							</li>
							<li class="list-group-item py-3 border-bottom-0 text-muted ${empty param.type ? 'd-none' : '' }">
								<div class="fw-bold mb-3">객실 시설</div>
								<div class="row">
									<!-- 모든 객실시설 옵션을 컨트롤러로부터 전달받아 반복문으로 출력한다. -->
									<c:forEach var="facility" items="${rofacilities }">
										<div class="col-6 mb-3">
											<input class="form-check-input" type="checkbox" name="roomFacilities" value="${facility.id }">
											<label class="form-check-label small">${facility.name }</label>
										</div>
									</c:forEach>
								</div>
							</li>
							<li class="list-group-item py-3 border-bottom-0 text-muted ${empty param.type ? 'd-none' : '' }">
								<div class="fw-bold mb-3">기타</div>
								<div class="row">
									<!-- 모든 부가사항 옵션을 컨트롤러로부터 전달받아 반복문으로 출력한다. -->
									<c:forEach var="tag" items="${tags }">
										<div class="col-6 mb-3">
											<input class="form-check-input" type="checkbox" name="tags" value="${tag }">
											<label class="form-check-label small">${tag }</label>
										</div>
									</c:forEach>
								</div>
							</li>
							<!-- 검색창으로 조회하는 경우 아래 옵션들이 카드에 표시된다. -->
							<li class="list-group-item py-3 border-bottom-0 text-muted ${not empty param.type ? 'd-none' : '' }">
								<div class="fw-bold mb-3">숙소 유형</div>
								<div class="row">
									<!-- 모든 숙소유형을 전달받아 반복문으로 출력 -->
									<c:forEach var="type" items="${types }">
										<div class="col-12 mb-3">
											<input class="form-check-input" type="checkbox" name="types" value="${type.id }">
											<label class="form-check-label">${type.name }</label>
										</div>
									</c:forEach>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<!-- 정렬기준, 지도버튼, 숙소 리스트 -->
				<div class="col-8">
					<!-- 정렬기준 radio button, 지도 modal button (버튼 스타일 식당 조회와 통일시킬 예정) -->
					<div class="d-flex flex-wrap mx-3 mb-3">
						<div id="btn-group-sort" class="btn-group flex-fill pe-2 my-auto" role="group" aria-label="Basic radio toggle button group">
							<input type="radio" class="btn-check" id="btnradio1" name="sort" value="rate" checked>
							<label class="btn btn-secondary" for="btnradio1">평점 순</label>
			
							<input type="radio" class="btn-check" id="btnradio2" name="sort" value="dist">
							<label class="btn btn-secondary" for="btnradio2">거리 순</label>
							
							<input type="radio" class="btn-check" id="btnradio3" name="sort" value="lowprice">
							<label class="btn btn-secondary" for="btnradio3">낮은 가격 순</label>
							
							<input type="radio" class="btn-check" id="btnradio4" name="sort" value="highprice">
						  	<label class="btn btn-secondary" for="btnradio4">높은 가격 순</label>
						</div>
						<button type="button" class="btn btn-light my-auto" id="btn-open-modal-map"><i class="bi bi-map"></i></button>
					</div>
					<!-- 검색결과 조회 리스트 -->
					<div id="accos-wrapper" class="row px-3 mx-auto">
						<!-- 숙소 검색결과가 script를 통해 출력됨-->
					</div>
				</div>
			</div>
	</div>
</form>
<%@ include file="../common/footer.jsp" %>

<!-- 지도 조회 모달 -->
<div id="modal-map" class="modal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<small class="modal-title text-center">내 위치 : <strong id="modal-current-location-address"></strong></small>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body d-flex justify-content-center">
				<!-- 지도 출력 :  -->
				<div id="map" style="width:1200px;height:600px;"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=258075821638bd633c20115d42be0584"></script>
<script type="text/javascript">
$(function () {
	
/*
 * 현재 위치 좌표 갱신하고, 숙소 검색 결과 갱신하기 : 최초 화면 출력시에 실행하고, 사용자가 내 위치 버튼 클릭 시에도 실행한다.
 */
	// 현재 위치 좌표를 저장하는 변수
	let currentLat = '';
	let currentLong = '';
	refreshLocation();
	
	// geolocation.getCurrentPosition은 비동기 통신으로 이루어지므로 반드시 이 통신이 완료되고 숙소 검색 요청을 보내야 한다.
	// 아래 함수를 실행하면 현재 위치 좌표를 새로 조회하고, 전역변수 currentLat, currentLong와 hidden 태그에 값이 저장된다.
	// 현재 위치 좌표를 새로 조회하지 못하면 서울 중심 좌표를 대신 저장한다.
	// 위 수행을 완료하면 숙소 검색 결과를 새로 요청해 화면에 출력한다.
	function refreshLocation() {
		// navigator.geolocation에서 지원하는 메소드를 사용해 사용자의 현재 위치 좌표값을 획득한다.
		// 받아온 좌표값은 hidden태그에 저장해서 숙소 검색 시 거리계산 조건에 사용할 수 있게 한다.
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				// 성공 시 콜백함수
				console.log(currentLat);
				console.log(currentLong);
		    	currentLat = position.coords.latitude;
		    	currentLong = position.coords.longitude;
				$(":hidden[name=currentLat]").val(currentLat);
				$(":hidden[name=currentLong]").val(currentLong);
				// 화면, 모달창에 현재 위치 주소를 출력한다.
				getLocationAddress();
				searchAccos();
	    	}, function(position) {
				// 실패 시 콜백함수
				// 현재 위치를 받을 수 없으면 서울 중심 좌표를 저장
				  	currentLat = 37.564214;
				  	currentLong = 127.0016985;
				$(":hidden[name=currentLat]").val(currentLat);
				$(":hidden[name=currentLong]").val(currentLong);
				// 화면, 모달창에 (정보없음)을 출력한다. (위치는 서울 중심으로 되어있지만 정보가 없음을 알려주기)
				    	$("#modal-current-location-address").text('(정보 없음)');
				 	  	$("#home-current-location-address").text('(정보 없음)');
				searchAccos();
			});
		}
	}
	
	// 현재 위치 좌표값으로 주소 정보를 조회해 모달 창 화면에 출력하는 함수
	function getLocationAddress() {
        $.getJSON('https://maps.googleapis.com/maps/api/geocode/json', 
      		  {sensor:false, 
      	       language:"ko",
      	       latlng: currentLat+","+currentLong, 
      	       key: "AIzaSyCLpyfe2_7Lvws3-UCb2qAtTouxy1xzCJo"})
      .done(function(data) {
      	let location = data.results[0];
      	let address = location.formatted_address.split(' ');
      	$("#modal-current-location-address").text(address[2]+' '+address[3]);
      	$("#home-current-location-address").text(address[2]+' '+address[3]);
      })
	}
	
/*
 * 모달 창에 카카오 openAPI로 지도 가져오기
 */
	// 모달 창에 지도 정의하기
	let container = document.getElementById('map');
	// mapcenter 값 설정
	let options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng("37.5666805", "126.9784147"), //지도의 중심좌표
			level: 7 //지도의 레벨(확대, 축소 정도)
	};
	// 지도 생성
	let map = new kakao.maps.Map(container, options);
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

	// 지도 버튼에 모달 이벤트 연결하기
	let modalMap = new bootstrap.Modal($("#modal-map"));
	$("#btn-open-modal-map").click(function () {
		modalMap.show();
		// 카카오맵이 보이지 않다가 보이게 되므로, 카카오맵 api 메소드 중 레이아웃과 중심을 재설정 해주는 메소드를 실행해야 지도 화면과 중심이 깨지지 않는다.
		map.relayout(); 
		changeMapCenter(map);
		myLocationMarker.setPosition(new kakao.maps.LatLng(currentLat, currentLong));
	});

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
	input태그에서 daterangepicker 통해 숙박일정 선택하기
	TO DO : 가능하면 확인 버튼 위치 등 수정 또는 다른 라이브러리 사용?
*/
	// 화면 로드 시 날짜 및 기간 초기화
	// * 로컬스토리지에 기존에 조회한 날짜가 저장되어 있으면 그 값을, 없으면 오늘/내일 날짜를 가져온다.
	// * 이 변수의 값이 hidden태그, 로컬스토리지, daterangepicker 에서 관리된다.
	let startDayString = getDateValues().start
	let endDayString = getDateValues().end;
	let duration = 1;
	// daterangepicker 생성 설정
    $('#datepicker').daterangepicker({
    	// 직접 커스텀한 문자열을 input태그의 value에 넣기 위해 autoUpdate 해제
    	"autoUpdateInput": false,
    	// 최대 7박까지 예약 가능
		"maxSpan": {
		    "days": 7
		},
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "minDate": moment().format('YYYY-MM-DD'), // 오늘 이전의 날짜는 조회 불가능하다.
        "startDate": startDayString,
        "endDate": endDayString,
        "drops": "down"
    }, function (start, end, label) {
    	// 생성 시, 날짜를 변경한 뒤 적용시키면 실행되는 함수
    	// 화면에 출력할 시작일, 종료일, 기간에 대한 문자열을 값을 변경하고, 변경된 날짜를 hidden태그, localStorage에도 저장한다.
        startDayString = start.format('YYYY-MM-DD');
        endDayString = end.format('YYYY-MM-DD');
        duration = end.diff(start,'days');
        setDateValues(startDayString, endDayString);
    });

	// html이 출력될 때 datepicker의 input태그의 value 저장
	$('#datepicker').val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박');
	// html이 출력될 때에도 날짜 정보를 hidden 태그와 localStorage에 저장
	setDateValues(startDayString, endDayString);
	
	// 날짜 변경 여부와 무관하게 적용을 누르면 발생하는 이벤트에 함수 등록
	// * input태그의 value 설정 (생성 설정의 날짜변경 이벤트와 다름)
    $('#datepicker').on('apply.daterangepicker', function(ev, picker) {
    	setDateValues(startDayString, endDayString);
    	$(this).val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박')
    	// 검색 조건이 바뀌었으므로 숙소 검색 함수를 실행한다.
        searchAccos();
    });
    
    // 날짜 정보를 hidden 태그와 localStorage에 저장하는 함수
	// * hidden태그 저장 : 검색조건으로 날짜포맷의 값을 전달하기 위함
    // * localStorage 저장 : 이 페이지를 다시 요청하거나 상세조회 페이지를 요청해도 설정한 날짜가 유지되도록 한다.
    function setDateValues(start, end) {
        $(":hidden[name=startDate]").val(start);
        $(":hidden[name=endDate]").val(end);
        localStorage.setItem("startDate", start);
        localStorage.setItem("endDate", end);
    }
    
    // 초기화할 날짜 정보를 가져오는 함수.
    // localStorage에 값이 있으면 그 값을, 없으면 현재 날짜, 현재 날짜 + 1을 가져온다.
    function getDateValues() {
    	let startvalue = localStorage.getItem("startDate");
    	let endvalue = localStorage.getItem("endDate")
    	let selectedDate = {
   			start : ((typeof startvalue == "undefined" || startvalue == null || startvalue == "") ? moment().format('YYYY-MM-DD') : startvalue),
   			end : ((typeof endvalue == "undefined" || endvalue == null || endvalue == "") ? moment().add(+1, 'd').format('YYYY-MM-DD') : endvalue)
    	};
    	return selectedDate;
    }
    
/*
	jQuery UI를 이용한 금액 슬라이더 생성하기  
*/  
	$("#slider-range").slider({
		range : true,
		min : 1,
		max : 30,
		values : [1, 30],
		slide : function(event, ui) {
			// 슬라이더 값이 바뀔 때마다 텍스트 내용을 변경하고, hidden태그의 값도 변경한다.
			$("#amount").text(ui.values[0] + "만원 ~ " + ui.values[1] + "만원");
			$("input[name='minPrice']").val(ui.values[0]*10000);
			$("input[name='maxPrice']").val(ui.values[1]*10000);
		}
	});
	// 처음에는 1만원 이상으로 표시한다. (hidden태그 기본 최소/최대값도 1~30으로 저장되어있음)
	$("#amount").text($("#slider-range").slider("values", 0) + "만원 이상");

	
/*
 * ajax로 검색 조건에 따른 숙소정보 조회하기
 */
 	// 현재 지도에 표시된 마커를 관리하기 위한 배열을 정의한다.
 	let accoMarkers = [];
 	// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수.
 	// * 인자값이 null이면 마커를 삭제하고, 지도 객체이면 그 지도에 마커를 표시한다.
 	function setMarker(map) {
 		for (let i = 0; i < accoMarkers.length; i++) {
 			accoMarkers[i].setMap(map);
 		}
 	}
 	
 	// 마커에서 사용할 이미지 객체를 만든다.
 	let accoMarkerImage =  new kakao.maps.MarkerImage('/resources/images/markericons/geo-alt-fill.svg', new kakao.maps.Size(45,45));
 	function searchAccos() {
		let queryString = $("#form-search-accos").serialize();
		// 기존에 화면에 출력된 숙소정보 컨텐츠를 모두 지운다.
		let $div = $("#accos-wrapper").empty();
		// 기존에 지도에 표시된 마커를 모두 삭제하고, 배열을 비운다.
		setMarker(null);
		accoMarkers = [];
		
		// ajax로 검색조건에 따른 숙소정보를 요청해 응답데이터로 받는다.
		$.getJSON("/accommodations", queryString).done(function(accos) {
			if (accos.length === 0) {
				let content = `
					<p class="my-5 text-center">조회된 결과가 없습니다.</p>
				`;
				$div.append(content);
			} else {
				$.each(accos, function(index, acco) {
					// 숙소 정보 html컨텐츠 생성
					let content = '';
					content += '<div id="card-acco-' + acco.id +'" class="card text-bg-light p-0 rounded-0">';
					content += '	<img src="/resources/images/acco/thumbnail/' + acco.thumbnailImageName +'" class="list-thumbnail card-img img-fluid rounded-0" alt="accommodation thumbnail">';
					content += '	<div class="list-overlay card-img-overlay p-3 rounded-0 text-light d-flex justify-content-between">';
					content += '		<div class="my-auto">';
					content += '		<h5 class="fw-semibold">' + acco.name + '</h5>';
					content += '			<p class="text-warning">';
					content += '				<span class="badge bg-warning">' + acco.reviewRate.toFixed(1) + '</span><strong class="ms-2">' + acco.reviewRateKeyword +' (' + acco.reviewCount  +')</strong>';
					content += '			</p>';
					content += '			<small>' + acco.district + '</small>';
					content += '		</div>';
					content += '		<p class="text-end fs-4 fw-semibold mt-auto">' + acco.minPrice.toLocaleString() + '<span class="fs-5"> 원 ~</span></p>';
					content += '	</div>';
					content += '</div>';
					
					// 숙소 정보 html컨텐츠를 tbody에 추가
					$div.append(content);
					$("#card-acco-"+acco.id).click(function() {
						location.href = "acco/detail?id=" + acco.id;
					});
					
					// 지도에 표시할 마커 객체 생성
					let markerPosition = new kakao.maps.LatLng(acco.latitude, acco.longitude);
					let marker = new kakao.maps.Marker({
					    position: markerPosition,
					    image: accoMarkerImage
					});
					
					// 마커에 click 이벤트를 등록
	 				kakao.maps.event.addListener(marker, 'click', function() {
	 					// 상세조회 페이지로 이동
	 					location.href= "acco/detail?id=" + acco.id;
	 				});
					
					// 마커에 mouseover, mouseout 이벤트를 등록
					// * mouseover 시 보여줄 커스텀오버레이를 생성 (숙소 정보 요약)
					let overlaycontent = '';
					overlaycontent += `<div class="position-relative">
											<div class="position-absolute" style="top: -130px; left: -95px;">
												<button type="button" class="btn btn-dark position-relative" style="background-color: rgba( 0, 0, 0, 0.5 );">
													<div>`;
					overlaycontent += acco.name + '<br/>';
					overlaycontent += '<small>평점 : </small><span class="badge bg-warning">' + acco.reviewRate.toFixed(1) + '</span><br/>';
					overlaycontent += '<small>내 위치까지 거리 : <strong>' + acco.currentDistance + 'km</strong></small>';
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
					
					// 배열에 마커 객체를 저장
					accoMarkers.push(marker);
				});
				// 배열에 새로 담긴 마커 객체를 모두 지도에 표시한다.
				setMarker(map);
			}
		});
	}
	
/*
 * 엘리먼트에 대한 사용자 상호작용 이벤트 등록
 */
	// 날짜를 변경했을 때 숙소 재검색 후 화면 갱신 : daterangepicker 생성 코드에서 설정함
	// 상세조건 적용 버튼을 눌렀을 때 숙소 재검색 후 화면 갱신
	//		TO DO: 적용 버튼의 필요 유무? 다른 거 눌러도 다 현 상태로 폼 제출되는데
	$("#btn-apply").click(function() {
		searchAccos();
	});
	// 정렬 버튼을 눌렀을 때 숙소 재검색 후 화면 갱신
	// 		TO DO : 적용 버튼 누르지 않은 내용은 반영 안 시킬 수 있나?
	$("input[name=sort]").click(function() {
		searchAccos();
	});
	// 지역을 변경했을 때 숙소 재검색 후 화면 갱신, 지도 center 변경
	$("select[name=city]").change(function() {
		searchAccos();
		changeMapCenter(map);
	});
	// 초기화 버튼을 눌렀을 때 상세조건을 모두 초기화
	$("#btn-reset").click(function() {
		// 인원
		$("input[name=capacity]").val("1");
		// 가격
		$("#slider-range").slider("option", "values", [1,30]);
		$(":hidden[name=minPrice]").val(10000);
		$(":hidden[name=maxPrice]").val(300000);
		$("#amount").text("1만원 이상");
		// 공용시설
		$(":checkbox[name=commonFacilities]").prop("checked", false);
		// 객실시설
		$(":checkbox[name=roomFacilities]").prop("checked", false);
		// 기타
		$(":checkbox[name=tags]").prop("checked", false);
	});
	// 나침반 아이콘을 눌렀을 때 내 위치 정보를 다시 조회하고, 검색결과도 갱신
	$("#icon-refresh-location").click(function(){
		refreshLocation();
	});
	
});
</script>
</body>
</html>