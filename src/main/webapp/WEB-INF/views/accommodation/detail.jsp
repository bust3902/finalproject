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
<!-- javascript date range picker를 위해 필요한 라이브러리 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<!-- swiper css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
<style type="text/css">
	.profile-image-wrapper {
		width: 70px;
		height: 70px;
		overflow: hidden;
		position: relative;
		background: rgba(0, 0, 0, 0.5);
	}
	
	.profile-image-wrapper img {
		width: 100%;
		position: absolute;
		left: 0;
		top: 50%;
		transform: translateY(-50%);
	}
	
 	#acco-swiper-wrapper .mySwiper2 img {
 		width: 100%;
		height: 300px;
		object-fit: cover;
	}

 	#acco-swiper-wrapper .mySwiper img {
 		width: 100%;
		height: 70px;
		object-fit: cover;
	}

 	.room-swiper-wrapper .mySwiper2 img {
 		width: 100%;
		height: 400px;
		object-fit: cover;
	}
	
	.room-thumbnail {
		height: 250px;
		object-fit: cover;
	}
	
	/* 크롤링데이터 h3 폰트크기, 스타일 강제변경 */
	#acco-info-detail h3 {
		font-size: 1rem !important;
		font-weight: bold !important;
	}
	@media (min-width: 1200px)
	#acco-info-detail h3 {
	    font-size: 1rem !important;
	    font-weight: bold !important;
	}
	
	/* 크롤링 데이터 잘못 저장된 내용 안보이게 처리 (추후 가능하면 DB 데이터 수정) */
	#acco-info-detail .comment_mobile,#google_maps {
		display: none;
	}

</style>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container my-5" style="min-width:992px; max-width:992px;">
	<!-- 숙소 소개 -->
	<div class="row">
		<!-- 숙소 이미지 swiper -->
		<div class="col-6 mb-3 pe-3">
			<div id="acco-swiper-wrapper">
				<div class="swiper mySwiper2 mb-3" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
					<!-- 숙소 이미지 - 큰이미지 swiper : 첫번째 이미지는 썸네일 이미지, 나머지 상세 이미지 반복문으로 출력 -->
					<div class="swiper-wrapper">
						<!-- 썸네일 이미지 : DB에서 NOT NULL이므로 별도로 empty는 체크하지 않음 -->
						<div class="swiper-slide">
							<img alt="accommodation expanded image" src="/resources/images/acco/thumbnail/${detail.thumbnailImageName }">
						</div>
						<!-- 상세이미지 -->
						<c:forEach var="image" items="${detail.images }">
							<div class="swiper-slide">
								<img alt="accommodation expanded image" src="/resources/images/acco/detail/${image }">
							</div>
						</c:forEach>
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
				<!-- 숙소 이미지 - 미리보기 swiper : 첫번째 이미지는 썸네일 이미지, 나머지 상세 이미지 반복문으로 출력 -->
				<div class="swiper mySwiper">
					<div class="swiper-wrapper">
						<!-- 이미지 미리보기 : 썸네일 이미지, 상세 이미지 3장 총 4장이 첫 화면 가장 먼저 보인다. -->
						<div class="swiper-slide">
							<img alt="accommodation expanded image" src="/resources/images/acco/thumbnail/${detail.thumbnailImageName }">
						</div>
						<c:forEach var="image" items="${detail.images }">
							<div class="swiper-slide">
								<img class="img-fluid" alt="accommodation image" src="/resources/images/acco/detail/${image }" style="cursor: pointer;">
							</div>
						</c:forEach>
						<!-- 이미지 정보가 3개 미만일 경우, 미리 보기에는 부족한 개수만큼 로고 이미지 출력  -->
						<c:if test="${fn:length(detail.images) < 3 }">
							<c:forEach begin="0" end="${2 - fn:length(detail.images) }">
								<div class="swiper-slide">
									<img class="img-fluid" alt="accommodation image" src="/resources/images/logo.png" style="cursor: pointer;">
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<!-- 숙소명, 주소, 한마디 소개
			TO DO : 좋아요 누르면 bi-heart-fill로 변경, DB 찜한 목록에 저장-->
		<div class="col-6">
			<div class="d-flex justify-content-between">
				<h4 id="acco-name" class="fw-semibold text-dark p-1 me-3" style="word-break: keep-all;">${detail.name } </h4>
				<a href="javascript:toggleAccoLike(${detail.id })"><i id="icon-heart" class="bi fs-4 ${isLiked ? 'bi-heart-fill' : 'bi-heart'  }"></i></a>
			</div>
			<p id="acco-address" class="text-muted" data-alat="${detail.latitude }" data-along="${detail.longitude }">${detail.address }</p>
			<div class="bg-light p-3">
				<div class="fw-bold text-dark mb-3">한마디 소개</div>
				<p>
					${detail.introduceComment }
				</p>
			</div>
		</div>
	</div>
	<!-- 상세 정보 탭 -->
	<div class="row">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active text-secondary fw-bold" id="room-tab" data-bs-toggle="tab"
					data-bs-target="#room-tab-pane" type="button" role="tab"
					aria-controls="room-tab-pane" aria-selected="true">객실안내/예약</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link text-muted" id="info-tab" data-bs-toggle="tab"
					data-bs-target="#info-tab-pane" type="button" role="tab"
					aria-controls="info-tab-pane" aria-selected="true">숙소정보</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link text-muted" id="review-tab" data-bs-toggle="tab"
					data-bs-target="#review-tab-pane" type="button" role="tab"
					aria-controls="review-tab-pane" aria-selected="true">리뷰</button>
			</li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<!-- 객실안내/예약 -->
			<div class="tab-pane fade show active" id="room-tab-pane" role="tabpanel" aria-labelledby="room-tab" tabindex="0">
				<div class="my-3">
					<!-- 숙박 일정 선택 : 기본적으로 검색페이지에서 선택한 날짜를 출력, 이 페이지에서 일정을 변경하면 로컬스토리지에 저장돼서 검색 페이지에도 반영된다. -->
					<form id="form-search-rooms">
						<input type="text" id="datepicker" class="form-control w-50" value="" />
						<input type="hidden" name="startDate" value="">
						<input type="hidden" name="endDate" value="">
						<input type="hidden" name="accoId" value="${param.id }">
					</form>
				</div>
				<div id="room-list-wraper" class="mx-0">
					<!-- 스크립트에서 객실 정보 출력 : 현재 선택한 날짜의 예약 가능 여부를 ajax로 조회해서, 그에 따라 예약버튼 내용 변경  -->
				</div>
			</div>
			<!-- 숙소정보 -->
			<div class="tab-pane fade" id="info-tab-pane" role="tabpanel" aria-labelledby="info-tab" tabindex="0">
				<div class="accordion accordion-flush" id="accordion-acco-info">
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-headingOne">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
								기본 정보
							</button>
						</h2>
						<div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordion-acco-info">
							<div class="accordion-body bg-light text-muted p-5 m-3 small">
								<div id="acco-info-detail">
									${detail.detailDescription }
								</div>
								<!-- 숙소 정보 중 위도, 경도를 이용하여 해당 숙소의 위치 지도에 표시 -->
								<div id="map-acco-info" class="mx-auto mt-5" style="width:800px;height:200px;"></div>
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-headingTwo">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
								편의시설 및 서비스</button>
						</h2>
						<div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordion-acco-info">
							<div class="accordion-body bg-light text-muted p-5 m-3">
							<!-- DB에서 조회한 공용시설, 태그 출력 (아이콘 파일명과 각 시설 DB 컬럼으로 연결시키기)-->
								<div id="cofas-wrapper" class="d-flex flex-wrap mb-3">
									<c:forEach var="fac" items="${detail.commonFacilities }">
										<div id="icon-wrapper-${fac.id }" class="text-center">
											<img class="w-50" alt="facility icon" src="/resources/images/icons/${fac.iconName }"><br/>
											<small>${fac.name }</small>
										</div>
									</c:forEach>
								</div>
								<div id="tags-wrapper" class="d-flex flex-wrap">
									<c:forEach var="tag" items="${detail.tags }">
										<span class="mx-1 badge bg-primary">${tag }</span>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 리뷰 -->
			<div class="tab-pane fade" id="review-tab-pane" role="tabpanel" aria-labelledby="review-tab" tabindex="0">
				<div class="row p-5 text-center border-bottom">
					<h5>${detail.reviewRateKeyword }</h5>
					<!-- 숙소 객체의 별점아이콘 객체를 활용해서 평점에 따른 별표 출력 (*.5 미만은 빈 별, *.5 초과는 채운 별) -->
					<div id="review-rate-wrapper" class="text-warning fs-3 mb-3">
						<i class="bi ${detail.reviewRateIcon.star1 }"></i>
						<i class="bi ${detail.reviewRateIcon.star2 }"></i>
						<i class="bi ${detail.reviewRateIcon.star3 }"></i>
						<i class="bi ${detail.reviewRateIcon.star4 }"></i>
						<i class="bi ${detail.reviewRateIcon.star5 }"></i>
						<span class="text-muted mx-1">${detail.reviewRate }</span>
					</div>
					<p>전체 리뷰 ${detail.reviewCount }</p>
				</div>
				<c:choose>
					<c:when test="${empty reviews}">
						<div class="p-5 border-bottom">
							등록된 리뷰가 없습니다.
						</div>
					</c:when>
					<c:otherwise>
						<!-- 리뷰 리스트 출력 -->
						<!-- TODO: 페이징 처리 -->
						<c:forEach var="review" items="${reviews }">
							<div class="row p-5 border-bottom">
								<!-- TODO: 추후 프로필이미지 등록 구현한다면 맞는 이미지 파일명 출력하기 -->
								<div class="col-2 profile-image-wrapper rounded-circle">
									<img class="" alt="user profile" src="/resources/images/logo.png">
								</div>
								<div class="col">
									<strong class="text-dark">${review.title }</strong>
									<div class="text-warning">
										<i class="bi ${review.pointIcon.star1 }"></i>
										<i class="bi ${review.pointIcon.star2 }"></i>
										<i class="bi ${review.pointIcon.star3 }"></i>
										<i class="bi ${review.pointIcon.star4 }"></i>
										<i class="bi ${review.pointIcon.star5 }"></i>
										<span class="text-muted mx-1">${review.point }</span>
									</div>
									<p class="my-1">
										<small>${review.user.nickname }</small> /
										<small>${review.room.name } 이용</small><br/>
									</p>
									<p class="text-dark my-3 small">
										${review.content }
									</p>
									<!-- 첨부파일이 없는 경우 이미지 태그는 출력하지 않음 -->
									<c:if test="${not empty review.image }">
										<div class="my-3">
											<!-- TO DO : 리뷰 이미지 저장경로 확인 필요, 이미지 작게 보여주고 클릭하면 키울건지? -->
											<img class="img-fluid" alt="review image" src="/resources/images/review/${review.image }">
										</div>
									</c:if>
									<!-- js에서 moment.js 라이브러리 이용하여 경과시간을 계산한 후 이 태그의 컨텐츠로 전달한다. -->
									<!-- review.createdDate은 Date객체이므로 패턴을 맞추어 저장한다. -->
									<fmt:formatDate value="${review.createdDate }" var="formattedDate" type="date" pattern="YYYY-MM-dd HH:mm:ss"/>
									<small class="elapsedTime" data-created-date="${formattedDate }"></small>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>

<!-- 객실 정보 모달 -->
<div class="modal fade" id="link-room-info" tabindex="-1" aria-labelledby="roomInfoModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title fw-bold text-dark" id="roomInfoModalLabel">객실 이용 안내</span>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body small">
				<div class="my-3 border-bottom">
					<label class="fw-bold mb-3">기본정보</label>
					<ul>
						<!-- room_name, room_capacity -->
						<li>객실명 <span id="modal-content-name"></span></li>
						<li>정원 <span id="modal-content-capacity"></span>명</li>
					</ul>
				</div>
				<div class="my-3 border-bottom">
					<label class="fw-bold mb-3">객실소개</label>
					<ul>
						<li id="modal-content-description"></li>
					</ul>
				</div>
				<div class="my-3 border-bottom">
					<label class="fw-bold mb-3">편의시설</label>
					<ul>
						<!-- 현재 객실의 room facilities 모두 조회해서 출력 -->
						<li id="modal-content-rofas">전용화장실, 에어컨, 헤어드라이기, 타월, 책상, 화장대, 거울, 옷걸이</li>
					</ul>
				</div>
				<div class="my-3">
					<label class="fw-bold mb-3">선택날짜</label>
					<ul>
						<!-- 현재 사용자가 선택한 날짜를 출력 -->
						<li><span id="modal-content-startdate"></span> ~ <span id="modal-content-enddate"></span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- kakao map js -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=258075821638bd633c20115d42be0584"></script>
<!-- swiper js -->
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(function () {
	
/*
 * 숙소 이미지 swiper 생성
 * TO DO: 화면 요청 시 출력되는 과정(?) 안보이게 할 수 없나?
 */
	let swiper = new Swiper(".mySwiper", {
		loop : true,
		spaceBetween : 10,
		slidesPerView : 4,
		freeMode : true,
		watchSlidesProgress : true,
	});
	let swiper2 = new Swiper(".mySwiper2", {
		loop : true,
		spaceBetween : 10,
		navigation : {
			nextEl : ".swiper-button-next",
			prevEl : ".swiper-button-prev",
		},
		thumbs : {
			swiper : swiper,
		},
	});

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
    	// 날짜를 변경한 뒤 적용시키면 실행되는 함수
    	// 화면에 출력할 시작일, 종료일, 기간에 대한 문자열을 값을 변경하고, 변경된 날짜를 hidden태그, localStorage에도 저장한다.
        startDayString = start.format('YYYY-MM-DD');
        endDayString = end.format('YYYY-MM-DD');
        duration = end.diff(start,'days');
        setDateValues(startDayString, endDayString);
        // 객실 정보 갱신하기
        searchRooms();
    });

	// html이 출력될 때 datepicker의 input태그의 value 저장
	$('#datepicker').val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박');
	// html이 출력될 때에도 날짜 정보를 hidden 태그와 localStorage에 저장
	setDateValues(startDayString, endDayString);
	// 화면 최초 요청 시에 날짜에 대한 값이 모두 저장되면 객실 정보를 조회하여 출력한다. 
	searchRooms();
	
	// 날짜 변경 여부와 무관하게 적용을 누르면 발생하는 이벤트에 함수 등록
	// * input태그의 value 설정 (생성 설정의 날짜변경 이벤트와 다름)
    $('#datepicker').on('apply.daterangepicker', function(ev, picker) {
    	setDateValues(startDayString, endDayString);
    	$(this).val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박')
    	searchRooms();
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
 * 숙소 위치 카카오 openAPI로 지도에 표현하기
 */
 	// html에서 jstl로 출력한 숙소 좌표를 받아온다.
 	let accoLatitude = $("#acco-address").attr("data-alat");
 	let accoLongitude = $("#acco-address").attr("data-along");
	// 지도 정의하기
	let container = document.getElementById('map-acco-info');
 	let mapcenter = new kakao.maps.LatLng(accoLatitude, accoLongitude);
	let options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(accoLatitude, accoLongitude), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
	};
	// 지도 생성
	let map = new kakao.maps.Map(container, options);
	
	// 숙소 위치 마커 생성하고 지도에 표시하기
	let accoMarker = new kakao.maps.Marker({
	    position: mapcenter,
	    image: new kakao.maps.MarkerImage('/resources/images/markericons/geo-alt-fill.svg', new kakao.maps.Size(45,45))
	});
	accoMarker.setMap(map);
	
	// 아코디언이 열렸을 때 카카오맵 레이아웃과 중심 재설정
	$("#flush-collapseOne").on('shown.bs.collapse', function () {
		map.relayout(); 
		map.setCenter(mapcenter);
	});
	
/*
 * 리뷰 게시글 작성일로부터 경과시간 표시하기
 */
 	// elapsedTime 클래스를 가지는 모든 태그에 획득한 경과시간을 출력
	 $(".elapsedTime").each(function() {
		 let elapsedTime = getElapsedTime($(this).attr("data-created-date"));
		 $(this).text(elapsedTime);
	 });
	 // 작성일에 대한 문자열을 전달하면 경과시간을 적절한 단위로 반환하는 함수
	 function getElapsedTime(createdDateString) {
		let now = moment();
		let createdDate = moment(createdDateString, 'YYYY-MM-DD HH:mm:ss');
		// 경과시간 정보
		let duration = moment.duration(now.diff(createdDate));
		// 경과시간에 대해 문자열로 표시할 단위 옵션
		let durationOptions = [
			{"dur" : duration.asYears(), "option" : "년 전"},
			{"dur" : duration.asMonths(), "option" : "개월 전"},
			{"dur" : duration.asWeeks(), "option" : "주 전"},
			{"dur" : duration.asDays(), "option" : "일 전"},
			{"dur" : duration.asHours(), "option" : "시간 전"},
			{"dur" : duration.asMinutes(), "option" : "분 전"},];
		
		// 반복문으로 duration의 값을 확인해 어떤 단위로 반환할지 결정한다.
		// ex) 0.8년전이면 "8개월 전" 반환
		for (let durOption of durationOptions) {
			if (durOption.dur >= 1) {
				return Math.round(durOption.dur) + durOption.option;
			}
		}
		// 분 단위로 검사해도 1 이상이 아니면(반복문에서 함수가 종료되지 않으면) "방금 전" 반환
		return "방금 전"
	}
 
/*
 * 현재 화면에서 선택한 기간에 따른 객실 정보 조회하기
 */
	function searchRooms() {
		let queryString = $("#form-search-rooms").serialize();
		// 객실정보 카드가 출력되는 wrapper의 컨텐츠를 모두 비운다.
		let $wrapper = $("#room-list-wraper").empty();
		$.getJSON("/rooms", queryString).done(function(rooms) {
			if (rooms.length === 0) {
				let content = '<p class="py-5">조회된 결과가 없습니다.</p>'
				$wrapper.append(content);
			} else {
				// 객실별 이미지 박스 콘텐츠 생성 시 사용할 html 태그를 미리 생성
				let imageBoxHTML =	`<div class="box-room-detail-img row bg-light m-3 p-5 position-relative d-none">
										<span>
											<i class="icon-close-room-detail-img bi bi-x-lg fs-5 p-3 position-absolute top-0 end-0" style="cursor: pointer;"></i>
										</span>
										<div class="room-swiper-wrapper w-75 mx-auto">
											<div class="swiper mySwiper2" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
												<div class="swiper-wrapper">
												</div>
												<div class="swiper-button-next"></div>
												<div class="swiper-button-prev"></div>
											</div>
										</div>
									</div>
								</div>`;
				
				// 반복 처리로 객실 별 정보를 보여주는 카드 html콘텐츠 생성, 모달에 정보를 전달하는 이벤트핸들러 등록
				$.each(rooms, function(index, room) {
					// 1. 기본 카드 본문 콘텐츠
					let cardBody = '';
					cardBody +=	`<div class="card-body row">
									<div class="col-5">
										<div class="position-relative">`;
					cardBody +=				'<img class="room-thumbnail img-fluid card-img" alt="room image" src="/resources/images/acco/room/thumbnail/' + room.thumbnailImageName + '">';
					cardBody +=				`<div class="card-img-overlay overlay-room-thumbnail">
												<i class="bi bi-images fs-3 text-white position-absolute bottom-0 end-0 p-3"></i>
											</div>
										</div>
									</div>
									<div class="col-7 p-3 d-flex flex-column justify-content-between">`;
					cardBody +=			'<h5 class="text-dark fw-lighter">' + room.name + '</h5>';
					cardBody +=			'<div class="pb-3 border-bottom text-dark fw-lighter">';
					cardBody +=				'가격<span class="float-end">1박 <span class="fw-bold text-dark">' + room.dayPrice.toLocaleString() + '원</span></span>';
					cardBody +=			'</div>';
					cardBody +=			'<a id="link-modal-' + room.no +'" href="#link-room-info" class="link-modal text-decoration-none text-muted" data-bs-toggle="modal">';
					cardBody +=				`객실 이용 안내
											<i class="bi bi-chevron-right float-end"></i>
										</a>`;
					cardBody +=			'<div class="small fw-bold"><i class="bi bi-exclamation-circle fs-6"></i> 예약 가능한 객실 수 (' + room.stock +'/' + room.numbers + ')</div>';
					if (room.stock > 0) {
						cardBody +=		'<button type="button" class="btn-room-reserve btn btn-danger w-100" data-room-no="' + room.no +'">예약</button>';
					} else {
						cardBody +=		'<button type="button" class="btn btn-dark w-100 disabled">만실</button>';
					}
					cardBody +=		`</div>
								</div>`;
								
					// 2-1. 이미지 swiper에 들어갈 복수개의 이미지를 htmlContent로 생성
					let imageSlides = '';
					$.each(room.images, function(index, imagename){
						imageSlides += '<div class="swiper-slide">';
						imageSlides += 		'<img alt="room expanded image" src="/resources/images/acco/room/detail/' + imagename +'">';
						imageSlides +=	'</div>';
					}); 
					
					// 2-2. 카드 썸네일 클릭시 보이는, 이미지 swiper를 포함하는 이미지 박스 콘텐츠
					let imageBox = '';
					imageBox += 	`<div class="box-room-detail-img row bg-light m-3 p-5 position-relative d-none">
										<span>
											<i class="icon-close-room-detail-img bi bi-x-lg fs-5 p-3 position-absolute top-0 end-0" style="cursor: pointer;"></i>
										</span>
										<div class="room-swiper-wrapper w-75 mx-auto">
											<div class="swiper mySwiper2" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
												<div class="swiper-wrapper">`;
					imageBox += imageSlides;
					imageBox +=				`</div>
												<div class="swiper-button-next"></div>
												<div class="swiper-button-prev"></div>
											</div>
										</div>
									</div>
								</div>`;
					
					// 하나의 객실에 대한 콘텐츠 생성
					let content ='';
					content += '<div class="card-room-info card mb-3">';
					content += cardBody;
					content += imageBox;
					content += '</div>'
					// 생성한 컨텐츠 화면에 추가
					$wrapper.append(content);
					
					// '객실 이용안내' 링크를 눌러서 모달을 열때마다 해당 객실의 정보를 모달에 저장하도록 한다.
					// * 클릭한 링크에 대한 익명함수 등록 : content를 append하기 전에는 a태그가 아직 DOM객체가 아니어서 할 수가 없으므로, 그 이후에 등록한다.
					$("#link-modal-" + room.no).click(function() {
						$("#modal-content-name").text(room.name);
						$("#modal-content-capacity").text(room.capacity);
						$("#modal-content-description").text(room.description);
						let rofas = room.roomFacilities;
						let rofasContent = '';
						if (rofas.length === 0) {
							rofasContent += '등록된 정보가 없습니다. 업소에 문의 바랍니다.'
						} else {
							$.each(rofas, function (index, rofa) {
								rofasContent += (rofa.name + (index === rofas.length-1 ? "" : ", " ));
							});
						}
						$("#modal-content-rofas").text(rofasContent);
						$("#modal-content-startdate").text(startDayString);
						$("#modal-content-enddate").text(endDayString);
					});
				});
				
				// 화면에 추가한 모든 객실카드에 대하여 이벤트핸들러 등록
				addRoomCardEventListener();
				// 화면에 추가한 모든 예약버튼에 대하여 이벤트핸들러 등록
				addReserveBtnEventListener();
			}
		});
	}
 
	
	 // 선택 시 메뉴 스타일 변경하는 이벤트핸들러 등록
	 //		해당 엘리먼트가 클릭될 때마다 각 버튼 태그의 active 여부에 따라 text-muted 클래스, text-secondary, fw-bold 클래스를 추가/삭제한다.
	 //		(active 클래스에 대한 토글은 부트스트랩 js에서 이미 구현하고 있다)
	let $tabButtons = $('#myTab [data-bs-toggle="tab"]');
	$tabButtons.click(function(){
		$tabButtons.each(function (){
			if ($(this).hasClass('active')) {
				$(this).removeClass('text-muted').addClass('fw-bold').addClass('text-secondary');
			} else {
				$(this).addClass('text-muted').removeClass('fw-bold').removeClass('text-secondary');
			}
		});
	});

/*
 * 엘리먼트에 대한 사용자 상호작용 이벤트 관련 함수
 */
 	// 객실 이미지 썸네일을 클릭하면 상세이미지 swiper가 출력되고, swiper의 닫기 아이콘을 클릭하면 지워지는 함수
 	// * ajax로 객실 정보 조회 시 실행된다.
 	function addRoomCardEventListener() {
		$(".overlay-room-thumbnail").click(function() {
			$(this).parents(".card-room-info").find(".box-room-detail-img").removeClass("d-none");
		});
		$(".icon-close-room-detail-img").click(function() {
			$(this).parents(".box-room-detail-img").addClass("d-none");
		});
	}
	
	// 객실 예약 버튼을 누르면 숙소아이디, 객실번호, 체크인/체크아웃 날짜를 파라미터로 하는 예약페이지 GET 요청을 보낸다.
	function addReserveBtnEventListener() {
		let accoId = $("#acco-name a").attr("data-acco-id");
		$(".btn-room-reserve").click(function() {
			let roomNo = $(this).attr("data-room-no");
			location.href="../reservation?id=" + accoId + "&roomno=" + roomNo + "&checkin=" + startDayString + "&checkout=" +endDayString;
		});
	}

});
	
/*
 * 숙소 찜하기 저장/삭제, 아이콘 상태를 변경하는 함수
 * a태그의 href에 연결해두었기 때문에 DOM객체 생성 이전에 정의되어야 한다.
 */
// 하트 아이콘을 누르면, 숙소아이디를 전달해 USER_ACCOMMODATION_LIKES 테이블에 저장한다.
// 이미 좋아요를 누른 숙소일 경우, 아이콘을 누르면 좋아요 정보가 테이블에서 삭제된다.
// * 로그인하지 않은 상태일 경우 alert을 띄우고, 요청을 보내지 않는다.
function toggleAccoLike(accoId) {
	let $icon = $("#icon-heart");
	
	// 로그인 여부 체크
	if ("${LOGIN_USER }" == "") {
		alert("찜하기는 로그인이 필요한 기능입니다.");
		return false;
	}
	
	// 숙소아이디 전달해서 ajax로 like 저장 요청
	$.getJSON("/changelike", "accoId=" + accoId).done(function(result) {
		if (result === true) {
			// 아이콘 표현 토글 처리
			$icon.toggleClass("bi-heart-fill");
			$icon.toggleClass("bi-heart");
		} else {
			alert("오류가 발생했습니다. 다시 시도해주세요.");
		}
	});
}
</script>
</body>
</html>