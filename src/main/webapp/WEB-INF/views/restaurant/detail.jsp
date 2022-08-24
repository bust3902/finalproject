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
<!-- moment.js -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<title>서울 맛어때</title>
<style type="text/css">

	#thumbnail-wrapper img {
		height: 400px;
		object-fit: cover;
	}

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
</style>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<div class="row my-5">
		<div class="col-3">
			<div class="card p-1" style="position: fixed; width:13rem;">
				<div id="map" style="width:100%;height:250px;"></div>
				<button id="near-btn" type="button" class="float-end btn text-dark border-0 btn-sm p-2">
					<strong>'<span id="district">${restaurant.district }</span>'</strong></br>
					<span>맛집 더 검색하기</span>
				</button>
			</div>
		</div>
		<div class="col-9">
			<!-- 기본 정보 카드 -->
			<div class="card p-1 mb-3">
				<div id="thumbnail-wrapper" class="p-3">
					<img class="card-img" alt="thumbnail" src="/resources/images/restaurant/thumbnail/${restaurant.imgname }">
				</div>
				<div class="m-3 mb-0">
					<div class="d-flex justify-content-between">
						<h4 id="title" class="text-dark fw-semibold" data-no="${restaurant.no }" data-lat="${restaurant.latitud }" data-long="${restaurant.longitude }">${restaurant.name }</h4>
						<div class="row">
							<span class="text-center mx-auto">
								<i id="icon-heart" class="text-primary px-1 fs-4 bi ${restaurant.liked ? 'bi-heart-fill' : 'bi-heart'  }"></i></br>
							</span>
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
				<div class="row m-3">
					<ul class="list-group mb-3">
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
			  		<button type="button" class="btn btn-outline-secondary" onclick="location.href='/reviewform?restaurantNo=${restaurant.no}'">리뷰쓰기</button>
				</div>
			</div>
			<!-- 영업시간 / 메뉴 아코디언 -->
			<div class="accordion" id="accordion-restaurant-info">
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingOne">
						<button class="accordion-button fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
						  영업 시간
						</button>
					</h2>
					<div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne">
						<div class="accordion-body small">
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
					</div>
				</div>
				<div class="accordion-item">
					<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
						<button class="accordion-button collapsed fw-bold" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
							메뉴
						</button>
					</h2>
					<div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
						<div class="accordion-body small">
							<ul class="list-group">
								<c:forEach var="restaurantMenue" items="${restaurant.menus }">
									<li class="list-group-item list-group-flush border-0">
										<span>${restaurantMenue.menuName }</span><span class="float-end"><fmt:formatNumber value="${restaurantMenue.price }" /></span>
									</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 리뷰 평점 통계, 무한스크롤링 리스트 -->
			<div class="mb-3 p-3">
				<div class="m-3">
					<h5 class="fw-light" style="color:black;">${restaurant.reviewCount }건의 방문자 평가</h5>
					<hr style="display: block;">
					<!-- 통계 컨테이너 -->
					<div id="chart" class="border-bottom" style="height: 250px;"></div>
					<!-- 리뷰 -->
					<div id="review-wrapper">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="fixed-bottom d-flex justify-content-end">
		<i class="bi bi-arrow-up-circle fs-2 p-5" onclick="javscript:(function(){window.scrollTo(0,0);})();" style="cursor: pointer;"></i>
	</div>
</div>
<div>
<%@ include file="../common/footer.jsp" %>
</div>
<!-- kakao map js -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=49a6f0504323df1e2fbc06bfac690d78"></script>
<!-- gstatic chart js -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function() {
	// 식당 좌표값 html태그에서 가져오기
	let lat = $("#title").attr("data-lat");
	let lng = $("#title").attr("data-long");
	// 카카오 map api를 이용해서 지도 불러오기
	let mapContainer = document.getElementById('map'); // 지도를 표시할 div 
	let locationCenter = new kakao.maps.LatLng(lat, lng);
    let mapOption = { 
   		draggable: false, // 줌인아웃 방지
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
		let lat = $("#title").attr("data-lat");
		let long = $("#title").attr("data-long");
		location.href="/near?keyword=" + keyword + "&currentLat=" + lat + "&currentLong=" + long;
	});
	
	// 찜하기 토글
	$("#icon-heart").click(function() {
		let no = $("#title").attr("data-no");
		let $icon = $(this);
		
		// 로그인 여부 체크
		if ("${LOGIN_USER }" == "") {
			alert("찜하기는 로그인이 필요한 기능입니다.");
			return false;
		}
		
		// 숙소아이디 전달해서 ajax로 like 저장 요청
		$.getJSON("/changelike/restaurant", "restaurantNo=" + no).done(function(result) {
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
	});
	
	// 평점통계 차트 그리기
	 // 리뷰 개수가 0이면 차트를 그리지 않고 컨테이너를 d-none으로 바꾼다.
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
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

});

/**
 * 작성일을 표현하는 날짜값을 전달하면 경과시간을 적절한 단위로 반환하는 함수
 * 리뷰 게시글에 작성일로부터 경과한 시간을 표시하는 데 사용한다.
 */
 function getElapsedTime(value) {
	let now = moment();
	// 경과시간 정보
	let createdDate = moment(new Date(value)).format('YYYY-MM-DD HH:mm:ss');
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

/**
 * 리뷰 차트 정보 획득, 리뷰 데이터에 대한 무한스크롤링
 */
// 1. ajax로 리뷰정보 획득해서 차트정보 꺼내기, 배열에 html콘텐츠 담기
// * 차트정보reviewArray, 리뷰 존재여부isEmpty는 그래프 표시에서 사용한다.
let reviewChartData = '';
let reviewArray = [];
let isEmpty = false; 
$.getJSON("/reviews/restaurant", "restaurantNo=" + ${param.no}).done(function(data) {
	reviewChartData = data.chartData;
	let $wrapper = $("#review-wrapper").empty();
	let reviews = data.reviews
	if (reviews.length == 0) {
		isEmpty = true;
		let content = '<div class="p-5 text-center">등록된 리뷰가 없습니다.</div>';
		// 배열에 담지 않고 바로 append시킨다.
		$wrapper.append(content);
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
			content += '<div class="row p-3 border-bottom">';
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
			content += '            <small>' + nickname +'</small>';
			content += '        </p>';
			content += '        <p class="text-dark my-3 small">' + review.content +'</p>';
			if (!(review.image == null || review.image === "")) {
				content += '            <div class="my-3">';
				content += '                <img class="img-fluid" alt="review image" src="/resources/images/review/' + review.image +'">';
				content += '            </div>';
			}
			// review.createdDate은 iso-8601 형식의 날짜정보를 반환한다. 이 값을 getElapsedTime 함수에 전달해 경과시간을 획득한다.
			content += '        <small class="elapsedTime float-end">' + getElapsedTime(review.createdDate) + '</small>';
			content += '    </div>';
			content += '</div>';
			count++;
			
			// 3개까지는 화면에 바로 출력시키고, 나머지는 스크롤링으로 제공한다.
			if (count < 4) {
				$wrapper.append(content);
			} else {
				reviewArray.push(content);
			}
		}
	}
});
 
// 2. 스크롤 바닥 감지 했을 때에 대한 이벤트핸들러 등록
window.onscroll = function(e) {
	// 배열에 있는 정보를 다 꺼내면, 콘텐츠 추가를 수행하지 않고, footer를 보여준다.
	// 배열에 있는 정보가 아직 남아있으면 footer를 d-none상태로 유지한다.
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
		$("#review-wrapper").append(addContent);
	}
};
</script>
</body>
</html>