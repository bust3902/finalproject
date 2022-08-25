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

 	.room-swiper-wrapper .roomSwiper img {
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
						<!-- 이미지 (상세이미지 중 첫번째로 저장된 이미지가 썸네일이미지와 동일하다) -->
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
						<!-- 이미지 미리보기 : 이미지 중 4장이 첫 화면 가장 먼저 보인다. -->
						<c:forEach var="image" items="${detail.images }">
							<div class="swiper-slide">
								<img class="img-fluid" alt="accommodation image" src="/resources/images/acco/detail/${image }" style="cursor: pointer;">
							</div>
						</c:forEach>
						<!-- 이미지 정보가 3개 미만일 경우, 미리 보기에는 부족한 개수만큼 로고 이미지 출력  -->
						<c:if test="${fn:length(detail.images) < 4 }">
							<c:forEach begin="0" end="${3 - fn:length(detail.images) }">
								<div class="swiper-slide">
									<img class="img-fluid" alt="accommodation image" src="/resources/images/logo.png" style="cursor: pointer;">
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<!-- 숙소명, 주소, 한마디 소개: 하트 아이콘 누르면 bi-heart-fill로 변경, DB 찜한 목록에 저장되어 아이콘 상태에도 반영됨(비로그인 상태일 경우 무조건 빈 하트)-->
		<div class="col-6">
			<div class="d-flex justify-content-between">
				<h4 id="acco-name" class="fw-semibold text-dark p-1 me-3" style="word-break: keep-all;">${detail.name } </h4>
				<div class="row">
					<a href="javascript:toggleAccoLike(${detail.id })" class="text-center mx-auto">
						<i id="icon-heart" class="bi fs-4 ${isLiked ? 'bi-heart-fill' : 'bi-heart'  }"></i>
					</a>
					<small class="text-center text-primary">(<span id="likeCount">${detail.likeCount }</span>)</small>
				</div>
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
					<form id="form-search-rooms" class="row d-flex flex-wrap">
						<!-- 숙박 일정 선택 : 기본적으로 검색페이지에서 선택한 날짜를 출력, 이 페이지에서 일정을 변경하면 로컬스토리지에 저장돼서 검색 페이지에도 반영된다. -->
						<div class="col">
							<input type="text" id="datepicker" class="form-control w-100" value="" />
							<input type="hidden" name="startDate" value="">
							<input type="hidden" name="endDate" value="">
							<input type="hidden" name="duration" value="">
							<input type="hidden" name="accoId" value="${param.id }">
						</div>
						<div class="col d-flex justify-content-end">
							<p class="small align-middle my-auto me-3">
								예약가능한 객실만 보기
								<input type="checkbox" id="checkbox-onlyAvailable" name="onlyAvailable" value="yes">
							</p>
							<!-- 정원 선택 : DB에서 이 숙소의 모든 인원 수 범위를 조회해서 출력한다. -->
							<select id="select-capacity" class="form-control w-25 text-end" name="capacity">
								<option value="0">객실 정원</option>
								<c:forEach var="capacity" items="${capacities }">
									<option value="${capacity }">${capacity }인</option>
								</c:forEach>
							</select>
						</div>
					</form>
				</div>
				<div id="room-list-wraper" class="mx-0">
					<!-- 스크립트에서 객실 정보 출력 : 현재 선택한 조건의 예약 가능 여부를 ajax로 조회해서, 그에 따라 예약버튼 내용 변경  -->
				</div>
				<!-- 페이징 버튼 : 버튼을 누르면, 해당 값을 currentPage로 해서 숙소정보를 다시 출력한다. -->
				<div id="pagination-wrapper" class="d-flex justify-content-center">
					<ul id="ul-item-wrapper" class="pagination" class="mx-auto">
					</ul>
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
							<!-- DB에서 조회한 공용시설, 객실 편의시설 태그 출력 (아이콘 파일명과 각 시설 DB 컬럼으로 연결시키기)-->
								<c:if test="${not empty detail.commonFacilities }">
									<div class="mb-3 small fw-bold ps-3">공용시설</div>
									<div id="cofas-wrapper" class="d-flex flex-wrap justify-content-start mb-5">
										<c:forEach var="fac" items="${detail.commonFacilities }">
											<div id="icon-wrapper-${fac.id }" class="text-center">
												<img class="w-50" alt="facility icon" src="/resources/images/icons/${fac.iconName }"><br/>
												<small>${fac.name }</small>
											</div>
										</c:forEach>
									</div>
								</c:if>
								<c:if test="${not empty detail.roomFacilities }">
									<div class="mb-3 small fw-bold ps-3">객실 편의시설<span class="fw-normal"> (객실 별 제공 여부는 객실안내 탭의 이용정보를 확인하세요)</span></div>
									<div id="cofas-wrapper" class="d-flex flex-wrap justify-content-start mb-5">
										<c:forEach var="fac" items="${detail.roomFacilities }">
											<div id="icon-wrapper-${fac.id }" class="text-center">
												<img class="w-50" alt="facility icon" src="/resources/images/icons/${fac.iconName }"><br/>
												<small>${fac.name }</small>
											</div>
										</c:forEach>
									</div>
								</c:if>
								<c:if test="${not empty detail.tags }">
									<div class="mb-3 small fw-bold ps-3">태그</div>
									<div id="tags-wrapper" class="d-flex flex-wrap px-3">
										<c:forEach var="tag" items="${detail.tags }">
											<span class="mx-1 badge bg-primary">${tag }</span>
										</c:forEach>
									</div>
								</c:if>
								<c:if test="${(empty detail.commonFacilities) and (empty detail.roomFacilities) and (empty detail.tags)}">
									<div class="small text-center">제공 정보가 없습니다.</div>
								</c:if>
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
					<!-- 리뷰 키워드(평점 범위)별 집계 그래프 -->
					<div id="chart" style="height: 250px;"></div>
				</div>
				<!--  윈도우 바닥으로 스크롤을 내리면 리뷰가 출력된다. -->
			</div>
		</div>
	</div>
	<div class="fixed-bottom d-flex justify-content-end">
		<i class="bi bi-arrow-up-circle fs-2 p-5" onclick="javscript:(function(){window.scrollTo(0,0);})();" style="cursor: pointer;"></i>
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
						<li id="modal-content-rofas"></li>
					</ul>
				</div>
				<div class="my-3">
					<label class="fw-bold mb-3">선택날짜</label>
					<ul>
						<!-- 현재 사용자가 선택한 날짜를 출력 -->
						<li><span id="modal-content-startdate"></span> ~ <span id="modal-content-enddate"></span><span id="modal-cotent-duration"></span></li>
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
<!-- gstatic chart js -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function () {
	
/**
 * 숙소 이미지 swiper를 위한 Swiper 객체 생성
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
			prevEl : ".swiper-button-prev"
		},
		thumbs : {
			swiper : swiper
		},
	});
	
/**
 * 선택 시 메뉴 스타일 변경하는 이벤트핸들러 등록
 * 해당 엘리먼트가 클릭될 때마다 각 버튼 태그의 active 여부에 따라 text-muted 클래스, text-secondary, fw-bold 클래스를 추가/삭제한다.
 * (active 클래스에 대한 토글은 부트스트랩 js에서 이미 구현하고 있다)
 */
	let $tabButtons = $('#myTab [data-bs-toggle="tab"]');
	$tabButtons.click(function(){
		$tabButtons.each(function (){
			if ($(this).hasClass('active')) {
				$(this).removeClass('text-muted').addClass('fw-bold').addClass('text-secondary');
			} else {
				$(this).addClass('text-muted').removeClass('fw-bold').removeClass('text-secondary');
			}
		  	// 사용자가 리뷰를 스크롤링으로 조회하다가 다른 탭을 눌렀을 때 footer를 다시 보여주기
			if ($(this).attr('id') != "review-tab") {
				$("#footer").removeClass('d-none');
			}
		});
	});
	
/**
 * 리뷰 탭을 누르면, id='chart'인 div엘리먼트에 리뷰평점에 대한 차트 그래프를 출력하는 이벤트핸들러 등록
 * (그냥 dom 출력 시 같이 그래프를 draw하도록 하면, 해당 div가 display:none 상태이기 때문에 오류가 발생함)
 * ajax 리뷰데이터 요청 시 획득한 reviewChartData 객체 사용
 */
	 $("#review-tab").click(function() {
	     google.charts.load("current", {packages:["corechart"]});
	     google.charts.setOnLoadCallback(drawChart);
	     function drawChart() {
			 // 리뷰 개수가 0이면 차트를 그리지 않고 컨테이너를 d-none으로 바꾼다.
			 if (isEmpty) {
				 $("#chart").addClass("d-none");
				 return false;
			 }
	       var data = google.visualization.arrayToDataTable([
	         ['review point', 'out of 5'],
	         ['5점 ('+ reviewChartData.point5 + '개)', reviewChartData.point5],
	         ['4점 ('+ reviewChartData.point4 + '개)', reviewChartData.point4],
	         ['3점 ('+ reviewChartData.point3 + '개)', reviewChartData.point3],
	         ['2점 ('+ reviewChartData.point2 + '개)', reviewChartData.point2],
	         ['1점 ('+ reviewChartData.point1 + '개)', reviewChartData.point1]
	       ]);
	
	       var options = {
	         title: '평점 분포',
	         pieHole: 0.4,
	       };
	
	       var chart = new google.visualization.PieChart(document.getElementById('chart'));
	       chart.draw(data, options);
	     };
	 })

/**
 * 예약가능여부, 객실정원 옵션 선택하기 : 각 input 태그의 이벤트에 객실정보 갱신하는 함수를 등록한다. 
 */
	$("#select-capacity").change(function() {
		changeCurrentPage(1);
	});
	$("#checkbox-onlyAvailable").change(function() {
		changeCurrentPage(1);
	});
	 
/**
 * input태그에서 daterangepicker 통해 숙박일정 선택하기
 * TO DO : 가능하면 확인 버튼 위치 등 수정 또는 다른 라이브러리 사용?
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
    });

	// html이 출력될 때 datepicker의 input태그의 value 저장
	$('#datepicker').val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박');
	// html이 출력될 때에도 날짜 정보를 hidden 태그와 localStorage에 저장
	setDateValues(startDayString, endDayString, duration);
	// 화면 최초 요청 시에 날짜에 대한 값이 모두 저장되면 객실 정보를 조회하여 출력한다. 
	changeCurrentPage(1);
	
	// 날짜 변경 여부와 무관하게 적용을 누르면 발생하는 이벤트에 함수 등록
	// * input태그의 value 설정 (생성 설정의 날짜변경 이벤트와 다름)
    $('#datepicker').on('apply.daterangepicker', function(ev, picker) {
    	setDateValues(startDayString, endDayString);
    	$(this).val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박')
    	changeCurrentPage(1);
    });
    
    // 날짜 정보를 hidden 태그와 localStorage에 저장하는 함수
	// * hidden태그 저장 : 검색조건으로 날짜포맷의 값을 전달하기 위함
    // * localStorage 저장 : 이 페이지를 다시 요청하거나 상세조회 페이지를 요청해도 설정한 날짜가 유지되도록 한다.
    function setDateValues(start, end) {
        $(":hidden[name=startDate]").val(start);
        $(":hidden[name=endDate]").val(end);
        $(":hidden[name=duration]").val(duration);
        localStorage.setItem("startDate", start);
        localStorage.setItem("endDate", end);
        localStorage.setItem("duration", duration);
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
	
/**
 * 숙소 위치 카카오 openAPI로 지도에 표현하기
 */
 	// html에서 jstl로 출력한 숙소 좌표를 받아온다.
 	let accoLatitude = $("#acco-address").attr("data-alat");
 	let accoLongitude = $("#acco-address").attr("data-along");
	// 지도 정의하기
	let container = document.getElementById('map-acco-info');
 	let mapcenter = new kakao.maps.LatLng(accoLatitude, accoLongitude);
	let options = { //지도를 생성할 때 필요한 기본 옵션
			draggable: false, // 줌인아웃 방지
			center: mapcenter, //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
	};
	// 지도 생성
	let map = new kakao.maps.Map(container, options);
	// 지도 클릭이벤트 등록(통합검색으로 이동)
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		location.href = "/near?currentLat=" + accoLatitude + "&currentLong=" + accoLongitude;
	});
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
	
});

//////////////////////////////////////////// DOM 생성 전에 정의되는 내용
/**
 * 페이징 버튼을 누르면 객실정보를 갱신하면서 currentPage의 값을 바꾸고, active 클래스의 상태를 변경시키는 함수 
 */
function changeCurrentPage(num) {
	$("#pagination-wrapper .page-item").removeClass("active");
	$('li[data-page-num="' + num +'"]').addClass("active");
	// num을 currentPage로 하는 객실 정보 출력
	searchRooms(num);
	// 페이지 버튼 상태 갱신
	refreshPaginationButton(num);
}

/**
 * 현재 페이지에 대한 pagination 객체를 db로부터 조회해 페이지 버튼 엘리먼트를 생성하는 함수
 * 검색날짜를 변경해서, 객실 데이터 행 수가 변경될 때 실행한다.
 */
function refreshPaginationButton(currentPage) {
	let queryString = $("#form-search-rooms").serialize() + "&currentPage=" + currentPage;
	$.getJSON("/rooms/pagination", queryString).done(function(pagination) {
		let $wrapper = $("#ul-item-wrapper").empty();
		let content = '';
		content += '<li class="page-item">';
		//href에 ajax 숙소조회 요청 다시 하도록 연결하기
		content += '	<a class="page-link ' + (pagination.currentPage <= 1 ? "disabled" : "") + '" href="javascript:changeCurrentPage(' + (currentPage - 1) +');" aria-label="Previous">';
		content += '		<span aria-hidden="true">&laquo;</span>';
		content += '	</a>';
		content += '</li>';
		for (let num = pagination.beginPage; num <= pagination.endPage; num ++) {
			content += '<li class="page-item ' + (pagination.currentPage == num ? "active" : "") + '" data-page-num="' + num + '">';
			content += '	<a class="page-link" href="javascript:changeCurrentPage(' + num +');">' + num +'</a>';
			content += '</li>';
		}
		content += '<li class="page-item">';
		content += '  <a class="page-link ' + (pagination.currentPage >= pagination.totalPages ? "disabled" : "") + '" href="javascript:changeCurrentPage(' + (currentPage + 1) +');" aria-label="Next">';
		content += '    <span aria-hidden="true">&raquo;</span>';
		content += '  </a>';
		content += '</li>';
		$wrapper.append(content);
		
	});
}	

/**
 * 현재 화면에서 선택한 기간에 따른 객실 정보 조회해서 엘리먼트 생성하는 함수
 * changeCurrentPage(num) 함수를 통해 실행된다.
 */
function searchRooms(currentPage) {
	let queryString = $("#form-search-rooms").serialize() + "&currentPage=" + currentPage;
	// 객실정보 카드가 출력되는 wrapper의 컨텐츠를 모두 비운다.
	let $wrapper = $("#room-list-wraper").empty();
	$.getJSON("/rooms", queryString).done(function(rooms) {
		if (rooms.length === 0) {
			let content = '<p class="py-5">조회된 결과가 없습니다.</p>'
			$wrapper.append(content);
		} else {
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
										<div class="swiper roomSwiper" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
											<div class="swiper-wrapper">`;
				imageBox += imageSlides;
				imageBox +=				`</div>
											<div class="roomSwiper-button swiper-button-next"></div>
											<div class="roomSwiper-button swiper-button-prev"></div>
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
					$("#modal-content-description").text((room.description == null || room.description === "") ? "등록된 정보가 없습니다." : room.description);
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
					$("#modal-content-startdate").text($(":hidden[name=startDate]").val());
					$("#modal-content-enddate").text($(":hidden[name=endDate]").val());
					$("#modal-content-duration").text($(":hidden[name=duration]").val());
				});
			});
			
			// 이미지 swiper 기능을 제공하는 Swiper 객체를 생성한다. (dom객체 생성 후 생성해야 함)
			 new Swiper(".roomSwiper", {
					loop : true,
					spaceBetween : 10,
					navigation : {
						nextEl : ".roomSwiper-button",
						prevEl : ".roomSwiper-button"
					}
				});
			
			// 화면에 추가한 모든 객실카드에 대하여 이벤트핸들러 등록
			addRoomCardEventListener();
			// 화면에 추가한 모든 예약버튼에 대하여 이벤트핸들러 등록
			addReserveBtnEventListener();

		}
	});
}

/*
 * 객실 카드 엘리먼트에 대한 사용자 상호작용 이벤트 관련 함수
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
	$(".btn-room-reserve").click(function() {
		let roomNo = $(this).attr("data-room-no");
		location.href="../reservation?id=" + ${param.id} + "&roomno=" + roomNo + "&checkin=" + $(":hidden[name=startDate]").val() + "&checkout=" +$(":hidden[name=endDate]").val()+ "&duration="+$(":hidden[name=duration]").val();
	});
}
	
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
	$.getJSON("/changelike/acco", "accoId=" + accoId).done(function(result) {
		if (result === true) {
			// 아이콘 표현 토글 처리
			$icon.toggleClass("bi-heart-fill");
			$icon.toggleClass("bi-heart");
			let likeCount = Number($("#likeCount").text());
			let change = $icon.hasClass("bi-heart") ? -1 : 1;
			$("#likeCount").text(likeCount + change);
		} else {
			alert("오류가 발생했습니다. 다시 시도해주세요.");
		}
	});
	
}

/**
 * 작성일을 표현하는 날짜값을 전달하면 경과시간을 적절한 단위로 반환하는 함수
 * 리뷰 게시글에 작성일로부터 경과한 시간을 표시하는 데 사용한다.
 */
 function getElapsedTime(value) {
	let now = moment();
	// 경과시간 정보
	let updatedDate = moment(new Date(value)).format('YYYY-MM-DD HH:mm:ss');
	let duration = moment.duration(now.diff(updatedDate));
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

/**
 * 리뷰 차트 정보 획득, 리뷰 데이터에 대한 무한스크롤링
 */
// 1. ajax로 리뷰정보 획득해서 차트정보 꺼내기, 배열에 html콘텐츠 담기
// * 차트정보reviewArray, 리뷰 존재여부isEmpty는 그래프 표시에서 사용한다.
let reviewChartData = '';
let reviewArray = [];
let isEmpty = false; 
$.getJSON("/reviews/acco", "accoId=" + ${param.id}).done(function(data) {
	reviewChartData = data.chartData;
	let reviews = data.reviews
	if (reviews.length == 0) {
		isEmpty = true;
		let content = '<div class="p-5 text-center">등록된 리뷰가 없습니다.</div>';
		// 배열에 담지 않고 바로 append시킨다.
		$("#review-tab-pane").append(content);
	} else {
		let count = 0;
		for (let review of reviews) {
			let nickname= '';
			if (!review.user.nickname) {
				nickname = "닉네임정보없음 (" + review.user.loginType + " 연동계정)";
			} else {
				nickname = review.user.nickname;
			}
			
			let content = '';
			content += '<div class="row p-5 border-bottom">';
			content += '    <div class="col-2 profile-image-wrapper rounded-circle">';
			content += '        <img class="" alt="user profile" src="/resources/images/logo.png">';
			content += '    </div>';
			content += '    <div class="col">';
			content += '        <strong class="text-dark">' + review.title +'</strong>';
			content += '        <div class="text-warning">';
			content += '            <i class="bi ' + review.pointIcon.star1 +'"></i>';
			content += '            <i class="bi ' + review.pointIcon.star2 +'"></i>';
			content += '            <i class="bi ' + review.pointIcon.star3 +'"></i>';
			content += '            <i class="bi ' + review.pointIcon.star4 +'"></i>';
			content += '            <i class="bi ' + review.pointIcon.star5 +'"></i>';
			content += '            <span class="text-muted mx-1">' + review.point +'</span>';
			content += '        </div>';
			content += '        <p class="my-1">';
			content += '            <small>' + nickname +'</small> /';
			content += '            <small>' + review.room.name + ' 이용</small><br/>';
			content += '        </p>';
			content += '        <p class="text-dark my-3 small">' + review.content +'</p>';
			if (!(review.image == null || review.image === "")) {
				content += '            <div class="my-3">';
				content += '                <img style="height: 15rem; width:auto;" alt="review image" src="/resources/images/review/' + review.image +'">';
				content += '            </div>';
			}
			// review.updatedDate은 iso-8601 형식의 날짜정보를 반환한다. 이 값을 getElapsedTime 함수에 전달해 경과시간을 획득한다.
			content += '        <small class="elapsedTime">' + getElapsedTime(review.updatedDate) + '</small>';
			content += '    </div>';
			content += '</div>';
			count++;
			
			// 3개까지는 화면에 바로 출력시키고, 나머지는 스크롤링으로 제공한다.
			if (count < 4) {
				$("#review-tab-pane").append(content);
			} else {
				reviewArray.push(content);
			}
		}
	}
});
 
// 2. 스크롤 바닥 감지 했을 때에 대한 이벤트핸들러 등록
window.onscroll = function(e) {
	// 리뷰 탭 눌렀을 때만 스크롤링 실행되게 하기
	if (!$("#review-tab").hasClass("active")) {
		return false;
	}
	
	// 배열에 있는 정보를 다 꺼내면, 콘텐츠 추가를 수행하지 않고, footer를 보여준다.
	// 배열에 있는 정보가 아직 남아있으면 footer를 d-none상태로 유지한다.
	// 탭 버튼에 대한 클릭 이벤트핸들러 함수에 리뷰를 끝까지 보기 전에 다른 탭을 누르면, footer를 보여주도록 되어있다. 
	$("#footer").addClass("d-none");
	if (reviewArray.length == 0) {
		$("#footer").removeClass("d-none");
		return false;
	}
	
	// 임시 콘텐츠(리뷰정보) 추가하기
	// window의 높이와 현재 스크롤 위치 값을 더했을 때 문서의 높이보다 크거나 같으면 리뷰정보 배열에서 가장 앞에 있는 값을 꺼내 콘텐츠를 추가시킨다.
	// 화면에 제공한 콘텐츠는 배열에서 삭제된다.
	if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
		let addContent = reviewArray.shift();
		$("#review-tab-pane").append(addContent);
	}
};

</script>
</body>
</html>