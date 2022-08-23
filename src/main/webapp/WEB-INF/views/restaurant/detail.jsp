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
<style type="text/css">

	#thumbnail-wrapper img {
		height: 400px;
		object-fit: cover;
	}

</style>
</head>
<body>
<div class="col-12">
	<jsp:include page="../common/nav.jsp" />
</div>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<div class="row my-5">
		<div class="col-3">
			<div class="card p-1">
			<div id="map" style="width:100%;height:250px;"></div>
			<button id="near-btn" type="button" class="float-end btn text-dark border-0 btn-sm p-2">
				<strong>'<span id="district">${restaurant.district }</span>'</strong></br>
				<span>맛집 더 검색하기</span>
			</button>
			</div>
		</div>
		<div class="col-9">
			<div class="card p-1 mb-3">
				<div id="thumbnail-wrapper" class="p-3">
					<img class="card-img" alt="thumbnail" src="/resources/images/restaurant/thumbnail/${restaurant.imgname }">
				</div>
				<div class="m-3 mb-0">
					<div class="d-flex justify-content-between">
						<h4 id="title" class="text-dark fw-semibold" data-lat="${restaurant.latitud }" data-long="${restaurant.longitude }">${restaurant.name }</h4>
						<div class="row">
							<a href="" class="text-center mx-auto">
								<i id="icon-heart" class="text-primary px-1 fs-4 bi ${restaurant.liked ? 'bi-heart-fill' : 'bi-heart'  }"></i></br>
							</a>
							<small class="text-center text-primary">(<span id="likeCount">${restaurant.likeCount }</span>)</small>
						</div>
					</div>
					<small >${restaurant.location }</small>
					<div class="text-start">
						<span class="fs-5 text-warning mb-1">
							<i class="bi ${restaurant.reviewRateIcon.star1}"></i>
							<i class="bi ${restaurant.reviewRateIcon.star2}"></i>
							<i class="bi ${restaurant.reviewRateIcon.star3}"></i>
							<i class="bi ${restaurant.reviewRateIcon.star4}"></i>
							<i class="bi ${restaurant.reviewRateIcon.star5}"></i>
						</span>
						<small class="text-muted ms-1">${restaurant.reviewCount }명의 평가</small>
					</div>
				</div>
				<hr class="mx-3" style="display: block;">
				<div class="m-3">
			  		<button type="button" class="btn btn-outline-secondary float-end mx-3" onclick="location.href='/reviewform?restaurantNo=${restaurant.no}'">리뷰쓰기</button>
				</div>
			</div>
			<div class="mb-3 card p-3">
				<ul class="list-group">
					<li class="list-group-item list-group-flush border-0">
						<i class="bi bi-geo-alt me-1"></i><span>${restaurant.location }</span>
					</li>
					<li class="list-group-item list-group-flush border-0">
						<i class="bi bi-telephone me-1"></i><span>${restaurant.tel }</span>
					</li>
					<!-- 카테고리 -->
					<li class="list-group-item list-group-flush border-0">
					<i class="bi bi-tag"></i>
						<c:forEach var="restaurantCategory" items="${restaurant.categories }">
							<span class="badge bg-secondary" >${restaurantCategory.category.name }</span>
						</c:forEach>
					</li>
					<!-- 방문목적 : 태그 -->
					<c:if test="${not empty restaurant.tags }">
						<li class="list-group-item list-group-flush border-0">
							<c:forEach var="restaurantTag" items="${restaurant.tags }">
								<span class="badge rounded-pill bg-light">${restaurantTag.tag }</span>
							</c:forEach>
						</li>
					</c:if>
				</ul>
			</div>
			<div class="mb-3 card p-1">
				<div class="m-3">
					<h5 class="pb-2 border-bottom" style="color:black;"><strong>영업시간</strong></h3>
					<ul class="list-group">
						<li class="list-group-item list-group-flush border-0">
							<span>매일</span><span class="float-end">${restaurant.opening }</span>
						</li>
						<c:if test='${restaurant.breakTime != null and restaurant.breakTime != "" }'>
							<li class="list-group-item list-group-flush border-0">
								<span>브레이크 타임</span><span class="float-end">${restaurant.breakTime }</span>
							</li>
						</c:if>
						<c:if test='${restaurant.close != null and restaurant.close != "" }'>
							<li class="list-group-item list-group-flush border-0">
								<span>휴무일</span><span class="float-end">${restaurant.close }</span>
							</li>
						</c:if>
					</ul>
				</div>
			 	<div class="m-3">
					<h5 class="pb-2 border-bottom" style="color:black;"><strong>메뉴</strong></h3>
					<ul class="list-group">
						<c:forEach var="restaurantMenue" items="${restaurant.menus }">
							<li class="list-group-item list-group-flush border-0">
								<span>${restaurantMenue.menuName }</span><span class="float-end"><fmt:formatNumber value="${restaurantMenue.price }" /></span>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
				<div class="mb-3 card p-3">
					<div class="m-3" style="color:black;">
						<h5 style="color:black;">${restaurant.reviewCount }건의 방문자 평가</h5>
						<hr style="display: block;">
						<c:forEach var="review" items="${review }">
							<div class="row ">
								<div class="col-2">
									<img alt="" width="100px" src="../resources/images/homeicons/restaurant.png""> 
								</div>
								<div class="col">
									<div>${review.user.nickname }님</div>
									<span class="text-warning">
									    <i class="${review.pointIcon.star1 }"></i>
									    <i class="${review.pointIcon.star2 }"></i>
									    <i class="${review.pointIcon.star3 }"></i>
									    <i class="${review.pointIcon.star4 }"></i>
									    <i class="${review.pointIcon.star5 }"></i>
									</span>
									(${review.point }점)
								</div>
								<p><strong>${review.title }</strong></p>
								<p>${review.content }</p>
							</div>
							<!-- 리뷰 이미지 출력 여부? -->
						</c:forEach>
					</div>
				</div>
		</div>
	</div>
</div>
<div>
<%@ include file="../common/footer.jsp" %>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=49a6f0504323df1e2fbc06bfac690d78"></script>
<script type="text/javascript">
$(function() {
	// 식당 좌표값 html태그에서 가져오기
	let lat = $("#title").attr("data-lat");
	let lng = $("#title").attr("data-long");
	// 카카오 map api를 이용해서 지도 불러오기
	let mapContainer = document.getElementById('map'); // 지도를 표시할 div 
	let locationCenter = new kakao.maps.LatLng(lat, lng);
    let mapOption = { 
        center: locationCenter, // 지도의 중심좌표이자 식당 위치
        level: 3 // 지도의 확대 레벨
    };
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성
	let map = new kakao.maps.Map(mapContainer, mapOption); 
	// 지도에 마커 표시
	let marker = new kakao.maps.Marker({
	    position: locationCenter,
	    image: new kakao.maps.MarkerImage('/resources/images/markericons/geo-alt-fill.svg', new kakao.maps.Size(45,45))
	});
	marker.setMap(map);
	
	$("#near-btn").click(function() {
		let keyword = $(this).find("#district").text();
		location.href="/near?keyword=" + keyword;
	});
});
</script>
</body>
</html>