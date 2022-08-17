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
	<!-- 검색어를 가져왔습니다. -->
	<div class="position-relative">
		<form id="form-search" class="d-flex" role="search" action="searchList">
	        <input class="form-control me-sm-2" type="text" id="search" name="keyword" placeholder="지역,음식을 검색하세요">
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
	    </form>
	</div>
	<div class="row px-3 pt-5 pb-3">
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card p-1">
			<div id="map" style="width:100%;height:250px;"></div>
			<button type="button" class="float-end btn text-dark border-0 btn-sm">
				<span><strong>'성북동'</strong><p>맛집 더 검색하기</p></span>
			</button>
			</div>
		</div>
		
		<div class="col-9">
			<div class="card p-1 mb-3">
				<h1>${restaurant.name }</h1>
				<p class="lead">성복동</p>
				<p class="m-0">${restaurant.reviewCount }명의 평가
					<i class="bi ${restaurant.reviewPoint gt 0 ? 'bi-star-fill' : 'bi-star' }"></i>
					<i class="bi ${restaurant.reviewPoint gt 1 ? 'bi-star-fill' : 'bi-star' }"></i>
					<i class="bi ${restaurant.reviewPoint gt 2 ? 'bi-star-fill' : 'bi-star' }"></i>
					<i class="bi ${restaurant.reviewPoint gt 3 ? 'bi-star-fill' : 'bi-star' }"></i>
					<i class="bi ${restaurant.reviewPoint gt 4 ? 'bi-star-fill' : 'bi-star' }"></i>
				</p>
				<hr style="display: block;">
				<div class="mb-3">
					<button type="button" class="btn btn-outline-secondary">좋아요(${restaurant.likeCount })</button>
					<button type="button" class="btn btn-outline-secondary">공유</button>
			  		<button type="button" class="btn btn-outline-secondary float-end">리뷰쓰기</button>
				</div>
			</div>
			
			<div class="mb-3 card p-1">
				<ul class="list-group">
					<li class="list-group-item list-group-flush border-0">
						<i class="bi bi-geo-alt"></i><span>${restaurant.location }</span>
					</li>
					<li class="list-group-item list-group-flush border-0">
						<span>${restaurant.tel }</span>
					</li>
					<!-- 카테고리 -->
					<li class="list-group-item list-group-flush border-0">
						<c:forEach var="restaurantCategory" items="${restaurant.categories }">
							<span class="badge bg-secondary">${restaurantCategory.category.name }</span>
						</c:forEach>
					</li>
					<!-- 방문목적 : 태그 -->
					<li class="list-group-item list-group-flush border-0">
						<c:forEach var="restaurantTag" items="${restaurant.tags }">
							<span class="badge rounded-pill bg-light">${restaurantTag.tag }</span>
						</c:forEach>
					</li>
				</ul>
			</div>
			
			<div class="mb-3 card p-1">
				<div class="mb-3">
					<h3>영업시간</h3>
					<ul class="list-group">
						<li class="list-group-item list-group-flush border-0">
							<span>매일</span><span class="float-end">${restaurant.opening }</span>
						</li>
						<li class="list-group-item list-group-flush border-0">
							<span>휴게시간</span><span class="float-end">${restaurant.breakTime }</span>
						</li>
						<li class="list-group-item list-group-flush border-0">
							<span>영업종료시간</span><span class="float-end">${restaurant.close }</span>
						</li>
					</ul>
				</div>
				<div class="mb-3">
					<h3>메뉴정보</h3>
					<ul class="list-group">
						<c:forEach var="restaurantMenue" items="${restaurant.menus }">
							<li class="list-group-item list-group-flush border-0">
								<span>${restaurantMenue.menuName }</span><span class="float-end">${restaurantMenue.price }</span>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="mb-3">
					<h3>맛집태그</h3>
					<!-- 리뷰에서 많이 언급된 태그일 수록 태그의 크기가 크게 출력하고 싶습니다. -->
				</div>
			</div>
			
			<div class="mb-3 card p-1">
				<h3>${restaurant.reviewCount }건의 방문자 평가</h3>
				<hr style="display: block;">
			</div>
		</div>
	</div>
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
	
	// 카카오 map api를 이용해서 지도 불러오기
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
</body>
</html>