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

<!-- javascript date range picker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<title>서울어때</title>
</head>
<body>
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
		<!-- 검색조건 form : 검색 경로에 따라 표시되는 form이 다름 (두개 만들어서 d-none으로 변경시킬 것) -->
		<div class="col-4">
			<div class="card p-3">
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
								<button type="button" class="btn btn-outline-secondary w-100">초기화</button>
							</div>
							<div class="col">
								<button type="button" class="btn btn-secondary w-100">적용</button>
							</div>
						</div>
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted">
						<div class="row d-flex justify-content-center">
							<div class="col-3 fw-bold text-muted my-auto">인원</div>
							<!-- 인원 수 표시 input 대신 span 태그 사용, 이벤트 script에서 설정하는 것으로 변경 예정 -->
							<div class="col-9 hstack gap-3">
								<button class="form-control btn btn-sm btn-light fs-4"
									onclick="this.parentNode.querySelector('input[type=number]').stepDown(); changeTotalPrice();">-</button>
								<input class="form-control form-control-lg fs-6 mx-auto"
									min="1" name="quantity" id="modal-quantity" value="1"
									type="number" onchange="changeTotalPrice();">
								<button class="form-control btn btn-sm btn-light fs-4"
									onclick="this.parentNode.querySelector('input[type=number]').stepUp(); changeTotalPrice();">+</button>
							</div>
						</div>
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted">
						<div class="fw-bold mb-3">가격<small class="text-secondary ms-3">1만원 이상</small></div>
						<!-- 이상~이하로 표현하려면 jQuery range로 수정 필요 -->
						<input type="range" class="form-range" min="1" max="30" step="1" id="range-price" value="1">
					</li>
					<li class="list-group-item py-3 border-bottom-0 text-muted">
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
					<li class="list-group-item py-3 border-bottom-0 text-muted">
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
					<li class="list-group-item py-3 border-bottom-0 text-muted">
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
					<li class="list-group-item py-3 border-bottom-0 text-muted">
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
				</ul>
			</div>
		</div>
		<!-- 정렬기준, 지도버튼, 숙소 리스트 -->
		<div class="col-8">
			<!-- 정렬기준 radio button, 지도 modal button (버튼 스타일 식당 조회와 통일시킬 예정) -->
			<div class="d-flex flex-wrap mx-3 mb-3">
				<div class="btn-group flex-fill pe-2" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off">
					<label class="btn btn-light" style="border-color: gray" for="btnradio1">추천 순</label>
	
					<input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" checked>
					<label class="btn btn-light" style="border-color: gray" for="btnradio2">거리 순</label>
					
					<input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
					<label class="btn btn-light" style="border-color: gray" for="btnradio3">낮은 가격 순</label>
					
					<input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
				  	<label class="btn btn-light" style="border-color: gray" for="btnradio4">높은 가격 순</label>
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
// 날짜 기간 선택하기
// TO DO : '1박' 표시하는법? 디자인 커스텀
$(function () {
    $('#datepicker').daterangepicker({
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
        "startDate": "2022-08-01",
        "endDate": "2022-08-02",
        "drops": "down"
    }, function (start, end, label) {
        console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
    });
});
</script>
</body>
</html>