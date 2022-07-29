<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery range slider를 위해 필요한 라이브러리 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<!-- javascript date range picker를 위해 필요한 라이브러리 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<title>서울어때</title>
</head>
<body>
<!-- 
	1. 해당 페이지를 요청한 방식에 따라 카드의 상세조건 옵션 다르게 보이게 하기 (data-search="type" 또는 "keyword")
	* 요청 시 전달받는 Criteria를 통해 요청한 방식 판별, 숙소정보리스트와 요청한 방식에 따른 상세 옵션내용 출력(공용시설, 객실시설, 기타 태그)
	2. 초기화 버튼을 누르면 사용자가 변경한 옵션을 모두 초기화시키기
	3. 적용 버튼을 누르면 form에 저장된 input태그의 값들을 검색조건으로 모두 전달해 ajax로 숙소정보 요청URL보내고, 데이터 획득하기.
	4. 획득한 데이터를 출력하기. (처음 화면 로드될 때는 아무 조건 없이 조회할 것)
	* 적용한 검색조건이 화면에서 계속 유지되게 하기
	5. 정렬 옵션 클릭 시에도 3~4번과 마찬가지로 처리하기
	6. 지도 버튼을 누르면 모달 창으로 지도 출력하기, 이 때 3번에서 획득한 데이터의 위도와 경도를 이용해 검색결과 지도에 표시하기.
 -->
<!-- navbar include start-->
<div class="contatiner">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-5 border text-center">임시헤더</h1>
		</div>
	</div>
</div>
<!-- navbar include end -->
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<div class="row">
		<div class="col-4">
		<!--
			TO DO : 검색 옵션 폼 script
			1. 숙소 유형을 선택해 조회하는 경우 data-search="keyword"인 list태그는 d-none으로 변경한다. 
			2. 검색으로 조회하는 경우 data-search="type"인 list태그는 d-none으로 변경한다.
			또는 if태그 사용? 이 페이지 요청 방식에 따라 수정할 것.
		-->
			<div class="card p-1">
				<ul class="list-group list-group-flush">
					<li class="list-group-item py-3">
						<div class="fw-bold mb-3 fs-5">날짜</div>
						<!-- date range picker 라이브러리 확인 필요 -->
						<input type="text" id="datepicker" class="form-control" value="" />
					</li>
					<li class="list-group-item py-3">
						<div class="fw-bold mb-3 fs-5">상세조건</div>
						<div class="btn-toolbar row g-2" role="toolbar" aria-label="Toolbar with button groups">
							<div class="col">
								<button type="button" class="btn btn-outline-primary w-100">초기화</button>
							</div>
							<div class="col">
								<button type="button" class="btn btn-secondary w-100">적용</button>
							</div>
						</div>
					</li>
					<li class=" list-group-item py-3 border-bottom-0 text-muted" data-search="type">
						<div class="row d-flex justify-content-center">
							<div class="col-3 fw-bold text-muted my-auto">인원</div>
							<!-- 인원 수 표시 input 대신 span 태그 사용, 이벤트 script에서 설정하는 것으로 변경 예정 -->
							<div class="col-9 hstack gap-3">
								<button class="form-control btn btn-sm btn-light fs-4"
									onclick="this.parentNode.querySelector('input[type=number]').stepDown();">-</button>
								<input class="form-control form-control-lg fs-6 mx-auto"
									min="1" name="quantity" id="modal-quantity" value="1" max="20"
									type="number">
								<button class="form-control btn btn-sm btn-light fs-4"
									onclick="this.parentNode.querySelector('input[type=number]').stepUp();">+</button>
							</div>
						</div>
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted">
						<div class="fw-bold mb-3">가격<small id="amount" class="text-secondary ms-3">1만원 이상</small></div>
						<!-- 이상~이하로 표현하려면 jQuery range로 수정 필요 -->
						<input type="hidden" name="min-price" value="10000" />
						<input type="hidden" name="max-price" value="300000" />
						<div id="slider-range"></div>
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted" data-search="type">
						<div class="fw-bold mb-3">베드 타입</div>
						<div class="d-flex justify-content-between mx-auto p-1">
							<div class="text-center">
								<a>침대아이콘</a><br/>
								<small>싱글</small>
							</div>
							<div class="text-center">
								<a>침대아이콘</a><br/>
								<small>더블</small>
							</div>
							<div class="text-center">
								<a>침대아이콘</a><br/>
								<small>트윈</small>
							</div>
							<div class="text-center">
								<a>침대아이콘</a><br/>
								<small>온돌</small>
							</div>
						</div>
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted" data-search="type">
						<div class="fw-bold mb-3">공용 시설</div>
						<div class="row">
							<!-- 선택한 숙소 유형에 맞는 객실시설 옵션을 컨트롤러로부터 전달받아 반복문으로 출력한다. -->
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">세탁기</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">라운지</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">세탁기</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">라운지</label>
							</div>
						</div>
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted" data-search="type">
						<div class="fw-bold mb-3">객실 시설</div>
						<div class="row">
							<!-- 모든 객실시설 옵션을 컨트롤러로부터 전달받아 반복문으로 출력한다. -->
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">와이파이</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">욕실용품</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">에어컨</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">TV</label>
							</div>
						</div>
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted" data-search="type">
						<div class="fw-bold mb-3">기타</div>
						<div class="row">
							<!-- 모든 부가사항 옵션을 컨트롤러로부터 전달받아 반복문으로 출력한다. -->
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">조식포함</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">객실내흡연</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">짐보관가능</label>
							</div>
							<div class="col-6 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">프린터사용</label>
							</div>
						</div>
					</li>
					<!-- 2. 검색창으로 조회하는 경우 아래 옵션들이 카드에 표시된다. data-search="keyword" -->
					<li class="list-group-item py-3 border-bottom-0 text-muted d-none" data-search="keyword">
						<div class="fw-bold mb-3">숙소 유형</div>
						<div class="row">
							<!-- 모든 숙소유형을 전달받아 반복문으로 출력한다. -->
							<div class="col-12 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">모텔</label>
							</div>
							<div class="col-12 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">호텔·리조트</label>
							</div>
							<div class="col-12 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">한옥</label>
							</div>
							<div class="col-12 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">펜션</label>
							</div>
							<div class="col-12 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">게스트하우스</label>
							</div>
							<div class="col-12 mb-3">
								<input class="form-check-input" type="checkbox" value="" id="">
								<label class="form-check-label" for="">캠핑</label>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- 정렬기준, 지도버튼, 숙소 리스트 -->
		<div class="col-8">
			<!-- 정렬기준 radio button, 지도 modal button (버튼 스타일 식당 조회와 통일시킬 예정) -->
			<div class="d-flex flex-wrap mx-3 mb-3">
				<div class="btn-group flex-fill pe-2" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off">
					<label class="btn btn-secondary" for="btnradio1">추천 순</label>
	
					<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" checked>
					<label class="btn btn-secondary" for="btnradio2">거리 순</label>
					
					<input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
					<label class="btn btn-secondary" for="btnradio3">낮은 가격 순</label>
					
					<input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
				  	<label class="btn btn-secondary" for="btnradio4">높은 가격 순</label>
				</div>
				<!-- hover, click 시 css 효과 없애기 -->
				<button class="btn btn-light" style="border-color: gray">지도</button>
			</div>
			<!-- 검색결과 조회 리스트 -->
			<div class="row mx-auto">
				<table class="table">
					<colgroup>
						<col width="30%">
						<col width="*">
						<col width="20%">
					</colgroup>
					<tbody>
						<!-- 숙소 조회 결과 반복문으로 출력할 것 -->
						<tr>
							<td class="align-middle p-3">
								<img class="img-thumbnail list-image" alt="thumbnail" src="/resources/images/logo.png" />
							</td>
							<td class="p-3">
								<h5 class="fw-bold text-dark">숙소명</h5>
								<p class="text-warning">
									<!-- 리뷰 평점 범위에 따라 최고에요/추천해요/만족해요/좋아요 다르게 출력 -->
									<span class="badge bg-warning">4.8</span><strong class="ms-2">추천해요 (210)</strong>
								</p>
								<p>
									<small>마포구</small>
								</p>
							</td>
							<td class="align-bottom p-3">
								<p class="text-end text-dark fs-5 fw-bold">127,900원</p>
							</td>
						</tr>
						<tr>
							<td class="align-middle p-3">
								<img class="img-thumbnail list-image" alt="thumbnail" src="/resources/images/logo.png" />
							</td>
							<td class="p-3">
								<h5 class="fw-bold text-dark">숙소명</h5>
								<p class="text-warning">
									<span class="badge bg-warning">4.8</span><strong class="ms-2">추천해요 (210)</strong>
								</p>
								<p>
									<small>마포구</small>
								</p>
							</td>
							<td class="align-bottom p-3">
								<p class="text-end text-dark fs-5 fw-bold">127,900원</p>
							</td>
						</tr>
						<tr>
							<td class="align-middle p-3">
								<img class="img-thumbnail list-image" alt="thumbnail" src="/resources/images/logo.png" />
							</td>
							<td class="p-3">
								<h5 class="fw-bold text-dark">숙소명</h5>
								<p class="text-warning">
									<span class="badge bg-warning">4.8</span><strong class="ms-2">추천해요 (210)</strong>
								</p>
								<p>
									<small>마포구</small>
								</p>
							</td>
							<td class="align-bottom p-3">
								<p class="text-end text-dark fs-5 fw-bold">127,900원</p>
							</td>
						</tr>
						<tr>
							<td class="align-middle p-3">
								<img class="img-thumbnail list-image" alt="thumbnail" src="/resources/images/logo.png" />
							</td>
							<td class="p-3">
								<h5 class="fw-bold text-dark">숙소명</h5>
								<p class="text-warning">
									<span class="badge bg-warning">4.8</span><strong class="ms-2">추천해요 (210)</strong>
								</p>
								<p>
									<small>마포구</small>
								</p>
							</td>
							<td class="align-bottom p-3">
								<p class="text-end text-dark fs-5 fw-bold">127,900원</p>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- footer include start -->
<div class="contatiner">
   	<div class="row">
		<div class="col">
			<h1 class="fs-4 p-2 mb-3 border text-center">임시푸터</h1>
		</div>
	</div>
</div>
<!-- footer include end -->
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
    });
    
	// html이 출력될 때 input태그의 value 설정
	$('#datepicker').val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박');
    
    $('#datepicker').on('showCalendar.daterangepicker', function(ev, picker) {
    	console.log('show');
    })
    
    $('#datepicker').on('apply.daterangepicker', function(ev, picker) {
    	$(this).val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박')
    })
    
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
				$("input[name='min-price']").val(ui.values[0]);
				$("input[name='max-price']").val(ui.values[1]);
			}
	});
	// 처음에는 1만원 이상으로 표시한다. (hidden태그 기본 최소/최대값도 1~30으로 저장되어있음)
	$("#amount").text($("#slider-range").slider("values", 0) + "만원 이상");

	});
</script>
</body>
</html>