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
	
	<form id="form-search-restaurant">
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
								<div class="form-check">
							        <input class="form-check-input" type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
							        <label class="form-check-label" for="optionsRadios1">
							          배달
							        </label>
						      	</div>
						     	<div class="form-check">
							        <input class="form-check-input" type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
							        <label class="form-check-label" for="optionsRadios2">
							          한식
							        </label>
						      	</div>
						      	<div class="form-check">
							        <input class="form-check-input" type="radio" name="optionsRadios" id="optionsRadios3" value="option3">
							        <label class="form-check-label" for="optionsRadios3">
							          일식
							        </label>
						      	</div>
							</div>
						</li>
						<li class="list-group-item py-3">
							<div class="fw-bold mb-3">음식점 태그</div>
							<!-- 음식 태그만큼 내용이 출력되게 하기 -->
							 <div class="form-check">
							     <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							     <label class="form-check-label" for="flexCheckDefault">
							          데이트
							     </label>
						     </div>
							 <div class="form-check">
							     <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							     <label class="form-check-label" for="flexCheckDefault">
							          이국적
							     </label>
						     </div>
							 <div class="form-check">
							     <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							     <label class="form-check-label" for="flexCheckDefault">
							          포장
							     </label>
						     </div>
							 <div class="form-check">
							     <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							     <label class="form-check-label" for="flexCheckDefault">
							          혼밥
							     </label>
						     </div>
						</li>
						<li class="list-group-item py-3">
							<div class="row p-3">
								<select class="form-select w-80" name="city">
									<option value="" data-city-lat="37.5666805" data-city-long="126.9784147" selected>서울 전체</option>
									<!-- 모든 지역정보를 받아와 반복문으로 출력 -->
									<option value="" data-city-lat="37.5666805" data-city-long="126.9784147">홍대/신촌/마포</option>
								</select>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<div class="col-8">
				<div class="d-flex flex-wrap mx-3 mb-3">
					<div id="btn-group-sort" class="btn-group flex-fill pe-2" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" id="btnradio11" name="sort" value="rate" checked>
						<label class="btn btn-secondary" for="btnradio11">평점 순</label>
		
						<input type="radio" class="btn-check" id="btnradio22" name="sort" value="review">
						<label class="btn btn-secondary" for="btnradio22">리뷰 많은 순</label>
						
						<input type="radio" class="btn-check" id="btnradio33" name="sort" value="like">
						<label class="btn btn-secondary" for="btnradio33">좋아요 많은 순</label>
						
						<input type="radio" class="btn-check" id="btnradio44" name="sort" value="distance">
					  	<label class="btn btn-secondary" for="btnradio44">거리 순</label>
					</div>
				</div>
				<div class="row mb-3">
					<h3>내주변 맛집<button class="btn btn-outline-secondary btn-lg border-0 float-end"><i class="bi bi-share"></i></button></h3>
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked="">
					  <label class="btn btn-outline-secondary" for="btnradio1">500m</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
					  <label class="btn btn-outline-secondary" for="btnradio2">1km</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
					  <label class="btn btn-outline-secondary" for="btnradio3">2km</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
					  <label class="btn btn-outline-secondary" for="btnradio4">3km</label>
					</div>
				</div>
					<div>
						<div class="row mb-3" id="map" style="width:100%;height:350px;"></div>
					</div>
				<div class="row mx-auto">
					<div class="card mb-3" style="max-width: 50rem;">
					  <div class="card-body">
					  <!-- <img src="/resources/images/"> -->
					  <p class="card-title"><strong>리춘시장</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
					  <p class="card-text m-0">912m</p>
					  <p class="card-text m-0">중식포차, 중화요리</p>
						  <div class="row mt-3">
						  	<button type="button" class="btn btn-outline-secondary">평가하기</button>
						  </div>
					  </div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 현재 위치를 확인할 수 있는 버튼입니다. -->
<div class="position-absolute" style="top:60px; left:1200px;" >
	<button id="locationButton" class="float-end border-0"><i class="bi bi-geo"></i>현재위치 확인</button>
	<p id="demo"></p>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=49a6f0504323df1e2fbc06bfac690d78"></script>
<script type="text/javascript">
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
</body>
</html>