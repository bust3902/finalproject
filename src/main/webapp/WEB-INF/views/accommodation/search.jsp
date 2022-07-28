<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
		<!-- 검색조건 form -->
		<div class="col-3">
			<div class="card p-3">
				<ul class="list-group list-group-flush">
					<li class="list-group-item">
						<div class="fw-bold mb-1">날짜</div>
						<!-- date picker 라이브러리 확인 필요 -->
						<input type="date" class="" />
					</li>
					<li class="list-group-item">상세조건 초기화/적용</li>
					<li class="list-group-item">인원</li>
					<li class="list-group-item">가격</li>
					<li class="list-group-item">베드 타입</li>
					<li class="list-group-item">공용 시설</li>
					<li class="list-group-item">객실 내 시설</li>
					<li class="list-group-item">기타</li>
				</ul>
			</div>
		</div>
		<!-- 정렬기준, 지도버튼, 숙소 리스트 -->
		<div class="col-9">
			<!-- 정렬기준 radio button, 지도 modal button (버튼 스타일 식당 조회와 통일시킬 예정) -->
			<div class="d-flex flex-wrap p-3 mb-3">
				<div class="btn-group flex-fill pe-2" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off">
					<label class="btn btn-light" style="border-color: gray"; for="btnradio1">추천 순</label>
	
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
</body>
</html>