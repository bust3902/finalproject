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
<title>서울어때</title>
</head>
<body>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<!-- 숙소 소개 -->
	<div class="row">
		<!-- 숙소 이미지 
			TO DO : 클릭하면 해당 이미지를 크게 출력 -->
		<div class="col me-3 mb-3">
			<div class="row">
				<img id="expanded-img" alt="expanded image" src="/resources/images/sampleacco1.jpg">
			</div>
			<div class="row justify-content-between p-3">
				<div class="col-3">
					<img class="img-fluid" alt="accommodation image" src="/resources/images/sampleacco1.jpg">
				</div>
				<div class="col-3">
					<img class="img-fluid" alt="accommodation image" src="/resources/images/sampleacco2.jpg">
				</div>
				<div class="col-3">
					<img class="img-fluid" alt="accommodation image" src="/resources/images/sampleacco3.jpg">
				</div>
				<div class="col-3">
					<img class="img-fluid" alt="accommodation image" src="/resources/images/sampleacco3.jpg">
				</div>
			</div>
		</div>
		<!-- 숙소명, 주소, 한마디 소개
			TO DO : 좋아요 누르면 bi-heart-fill로 변경 -->
		<div class="col">
			<h5 class="fw-bold text-dark">
				숙소명 <a href=""><i class="bi bi-heart float-end"></i></a>
			</h5>
			<p class="text-muted">서울특별시 마포구 연남동 382-10</p>
			<div class="bg-light p-3">
				<div class="fw-bold text-dark mb-3">한마디 소개</div>
				<p>
					연남동 거리 중심부에 위치한 BB 홍대는 홍대입구역 도보 3분 거리에 있습니다
					모든 객실에 전용 화장실, 간이 주방, TV를 갖추고 있습니다
					호스텔에서 가까운 도보 거리, 특히 연남동 지역에 수많은 레스토랑과 술집이 모여 있습니다
					연남동에서 편안하게 쉬실 수 있는 호스텔이 되겠습니다!
					감사합니다 ^^
				</p>
			</div>
		</div>
	</div>
	<!-- 상세 정보 탭 -->
	<div class="row">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link text-secondary fw-bold active" id="room-tab" data-bs-toggle="tab"
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
				<div class="py-3">
					<!-- TO DO : 현재보다 지난 날짜는 선택 못하게 하기 -->
					<input type="text" id="datepicker" class="form-control w-50" value="" />
					<input type="hidden" name="startDate" value="">
					<input type="hidden" name="endDate" value="">
				</div>
				<!-- 객실 정보 출력 -->
				<div class="list-wraper mx-0">
					<div class="card mb-3">
						<div class="card-body row">
							<div class="col-5">
								<!-- TO DO : 이미지 클릭 시 상세 이미지 더 조회 가능하게 할지? (DB관련 수정 필요함) -->
								<img class="img-fluid" alt="room image" src="/resources/images/sampleacco2.jpg">
							</div>
							<div class="col-7 d-flex flex-column justify-content-between">
								<h5 class="fw-bold text-dark">6인 여성 도미토리</h5>
								<div class="pb-3 border-bottom text-dark">
									가격<span class="float-end fw-bold">14,900원</span>
								</div>
								<a href="" class="text-decoration-none text-muted">
									객실 이용 안내
									<i class="bi bi-chevron-right float-end"></i>
								</a>
								<button type="button" class="btn btn-secondary w-100">예약</button>
							</div>
						</div>
					</div>
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
							<div class="accordion-body bg-light text-muted p-5 m-3">
								<!-- TO DO : HTML컨텐츠 그대로 DB에서 관리할지? -->
								<small id="wrapper-acco-info">
									<strong>오시는 길</strong>
									<ul>
										<li>[홍대입구역에서 오시는 방법]</li>
										<li>홍대입구역 3번출구로 나오셔서 정면 오른쪽 방향에 보이는 공원을 건너가주세요.</li>
										<li>정면으로 100미터 직진하시면 오른쪽편에 핑크색 건물에 I'm PLASTIC이라는 간판이
											보이실거에요</li>
										<li>그 건물 기준 오른쪽 골목길로 50미터 직진하시고 갈림길이 나오시면 왼쪽 골목길로 들어가주세요.
										</li>
										<li>앞으로 조금만 오시다보면 낙랑파라 카페가 보이실거에요. 그 건물 정면에 있는 오른쪽 골목길로
											들어가주세요.</li>
										<li>정면으로 100미터 직진하시면 갈림길이 보이실거에요. GS25 편의점이 있는 건물 기준 왼쪽
											골목길로 가주세요.</li>
										<li>정면으로 50미터 직진하시면 호스텔 도착입니다!!</li>
										<li>네이버,구글지도에 BB홍대를 검색해주세요~</li>
									</ul>
									<strong>주변정보</strong>
									<ul>
										<li>홍대입구역 도보 3분</li>
										<li>연트럴파크 도보 1분</li>
										<li>홍대거리 도보 5분</li>
									</ul>
									<strong>숙소 이용 규칙</strong>
									<ul>
										<li>체크인 : 15시~22시 / 체크아웃 : ~11시</li>
										<li>24시간 출입 자유</li>
										<li>보안을 위하여 투숙객 본인 외에 외부인 동반 출입을 금지합니다</li>
										<li>호스텔 전구역은 금연입니다</li>
										<li>애완동물 출입 금지입니다</li>
										<li>타인에게 피해나 불쾌감을 주는 행위 또는 이용규정을 지키지 않을 경우 강제 퇴실 조치합니다</li>
										<li>시설물을 파손하거나 침구류 훼손 및 오염 (세탁 불가능) 시 전액 배상해야 합니다</li>
										<li>보호자 동반 없는 미성년자 입실 불가 (업체 문의 필수)</li>
									</ul>
									<strong>주차장 정보</strong>
									<ul>
										<li>숙소 앞 무료주차 가능 (업체 문의 필수)</li>
									</ul>
									<strong>취소 및 환불 규정</strong>
									<ul>
										<li>체크인일 기준 7일 전 : 100% 환불</li>
										<li>체크인일 기준 6 ~ 4일 전 : 50% 환불</li>
										<li>체크인일 기준 3일 전 ~ 당일 및 No-Show : 환불 불가</li>
										<li>취소, 환불 시 수수료가 발생할 수 있습니다</li>
									</ul>
									<strong>확인 사항 및 기타</strong>
									<ul>
										<li>외국인 관광객을 위한 전용 게스트하우스입니다</li>
										<li>위의 정보는 게스트하우스 사정에 따라 변경될 수 있습니다</li>
										<li>해당 이미지는 실제와 상이 할 수 있습니다</li>
										<li>예약 확정 이후의 취소는 취소 환불 규정에 의거하여 적용됩니다</li>
									</ul>
								</small>
								<div id="map-acco-info" class="mx-auto" style="width:800px;height:200px;"></div>
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-headingTwo">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
								편의시설 및 서비스</button>
						</h2>
						<div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordion-acco-info">
							<div class="accordion-body bg-light text-muted p-5 m-3 d-flex flex-wrap">
							<!-- TO DO : DB에서 조회한 공용시설, 객실시설 출력 (아이콘은 여기어때에서 png 저장 후 각 시설키워드와 파일명 연결시키기)-->
								<small class="mx-3">주방/식당</small>
								<small class="mx-3">세탁기</small>
								<small class="mx-3">건조기</small>
								<small class="mx-3">탈수기</small>
								<small class="mx-3">주차장</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
								<small class="mx-3">와이파이</small>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 리뷰 -->
			<div class="tab-pane fade" id="review-tab-pane" role="tabpanel" aria-labelledby="review-tab" tabindex="0">
				<div class="row p-5 text-center border-bottom">
					<h5>추천해요</h5>
					<div class="fs-3 mb-3 text-warning">
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-half"></i>
						<span class="text-muted mx-1">4.5</span>
					</div>
					<p>전체 리뷰 192</p>
				</div>
				<!-- TO DO : 리뷰 리스트 출력 -->
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=258075821638bd633c20115d42be0584"></script>
<script type="text/javascript">
$(function () {
/*
	input태그에서 daterangepicker 통해 숙박일정 선택하기
	TO DO : input태그의 value가 '날짜 ~ 날짜 . 숙박일수' 이므로 date로 전달해줄 값은 따로 저장해두어야 한다.
	TO DO : 로컬스토리지에 값을 저장해 화면 리로딩 또는 상세 조회페이지나, 마이페이지로 이동해도 선택한 일정을 이용할 수 있게 하기.
	TO DO : 가능하면 확인 버튼 위치 등 수정
*/
	// 화면 로드 시 날짜 및 기간 초기화 : 이 값이 input태그의 val에 저장된다.
	// 기본설정은 오늘날짜, 내일날짜이다.
	// TO DO : 저장한 값이 있는 경우 그 값을 가져오기.
	let startDayString = moment().format('YYYY-MM-DD');
	let endDayString = moment().add(+1, 'd').format('YYYY-MM-DD');
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
	    "startDate": startDayString,
	    "endDate": endDayString,
	    "drops": "down"
	}, function (start, end, label) {
		// 날짜가 변경된 뒤 실행되는 함수
		// 시작일, 종료일, 기간의 값을 초기화한다.
	    startDayString = start.format('YYYY-MM-DD');
	    endDayString = end.format('YYYY-MM-DD');
	    duration = end.diff(start,'days');
	    $(":hidden[name=startDate]").val(startDayString);
	    $(":hidden[name=endDate]").val(endDayString);
	});
	
	// html이 출력될 때 input태그의 value 설정
	$('#datepicker').val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박');
	// 날짜 변경 시 input태그의 value 설정
	$('#datepicker').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박')
	});
	
	
/*
 * 검색 결과 카카오 openAPI로 지도에 표현하기
 */
	// 지도 정의하기
	let container = document.getElementById('map-acco-info');
	let mapcenter = new kakao.maps.LatLng(37.564214, 127.0016985);
	let options = { //지도를 생성할 때 필요한 기본 옵션
			center: mapcenter, //지도의 중심좌표.
			level: 5 //지도의 레벨(확대, 축소 정도)
	};
	let map = new kakao.maps.Map(container, options); // 지도 생성

	// 아코디언이 열렸을 때 카카오맵 레이아웃과 중심 재설정
	// TO DO : 숙소 위치 표시하기
	$("#flush-collapseOne").on('shown.bs.collapse', function () {
		map.relayout(); 
		map.setCenter(mapcenter);
	});
})
</script>
</body>
</html>