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
	<div class="position-relative">
		<form id="form-search" class="d-flex" role="search" action="searchlist">
	        <input class="form-control me-sm-2" type="text" id="search" name="keyword" placeholder="지역,음식을 검색하세요" value="${keyword }">
	        <button class="btn btn-secondary my-2 my-sm-0" type="submit">
	        	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				</svg>
			</button>
			<input type="hidden" name="lat" value="" />
			<input type="hidden" name="lng" value="" />
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
								<div class="col-12 mb-3">
									<input class="form-check-input" type="radio" name="categories" value="${category.ID}">
									<label class="form-check-label" for="optionsRadios1">${category.NAME }</label>
								</div>
							</c:forEach>
							</div>
						</li>
						<li class="list-group-item py-3">
							<div class="fw-bold mb-3">음식점 태그</div>
							<!-- 음식 태그만큼 내용이 출력되게 하기 -->
							<c:forEach var="tag" items="${tags }">
								 <div class="form-check" id="box-buttons">
								     <input class="form-check-input" type="checkbox" value="${tag.RESTAURANT_NO }" id="flexCheckDefault" name="flexCheckDefault">
								     <label class="form-check-label" for="flexCheckDefault">
								          ${tag.RESTAURANT_TAG }
								     </label>
							     </div>
							</c:forEach>
						</li>
						<li class="list-group-item py-3">
							<div class="row p-3">
								<select class="form-select w-80" name="city">
									<option value="" data-city-lat="37.5666805" data-city-long="126.9784147" selected>서울 전체</option>
									<!-- 모든 지역정보를 받아와 반복문으로 출력 -->
									<c:forEach var="city" items="${cities }">
										<option value="${city.id }" data-city-lat="37.5666805" data-city-long="126.9784147">${city.name }</option>
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
					<c:if test="${empty searchKeyword }">
					데이터가 없습니다.
					</c:if>
					<c:forEach var="r" items="${searchKeyword }">
						<div class="row mx-auto">
							<div class="card mb-3" style="max-width: 50rem;">
							  <div class="card-body">
							  <!-- <img src="/resources/images/"> -->
							  <p class="card-title"><strong>${r.RESTAURANT_NAME }</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
							  <p class="card-text m-0">912m</p>
							  <p class="card-text m-0">${r.RESTAURANT_TAG }</p>
								  <div class="row mt-3">
								  	<button type="button" class="btn btn-outline-secondary">평가하기</button>
								  </div>
							  </div>
							</div>
						</div>
					</c:forEach>
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
		
		location.href="/searchlist.jsp?keyword=" + keyword;
	};
	
	// 카카오 맵 api를 이용한 지도 구현
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