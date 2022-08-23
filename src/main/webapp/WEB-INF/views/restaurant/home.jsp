<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<style type="text/css">
	.card-img-top {
		height: 150px;
		object-fit: cover;
	}
</style>
<title>서울 맛어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary m-0" style="height:13vh;">
	<div class="px-3 pt-5 pb-3 mx-auto my-auto" style="min-width:992px; max-width:992px;">
		<h4 class="text-white ps-0 mb-3">서울의 맛집을 찾아보세요 !</h4>
	</div>
</div>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<form id="form-search" class="row d-flex position-relative my-5" role="search" action="../near">
		<div class="col-6">
			<!-- 식당 검색창 -->
			<div class="d-flex">
		        <input class="form-control w-50 me-sm-2" type="text" id="search" name="keyword" placeholder="지역,식당명을 검색하세요" autocomplete="off">
				<button class="btn btn-outline-primary" type="submit"><i class="bi bi-search"></i></button>
				<input type="hidden" name="sort" value="dist" />
				<input type="hidden" name="currentLat" value="" />
				<input type="hidden" name="currentLong" value="" />
			</div>
			<div id="box-keywords" class="position-absolute w-25 d-none" style="top:44px; left:0; z-index: 1000;">
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
				</ul>
			</div>
		</div>
		<!-- 내 위치 출력, 좌표값 hidden태그에 저장 -->
		<div class="col-6 d-flex justify-content-end my-auto">
			<small class="my-auto">
				현재 내 위치는 <strong id="home-current-location-address"></strong>
			</small>
			<a id="locationButton">
				<i id="icon-refresh-location" class="bi bi-compass fs-4 text-primary ps-2" style="cursor: pointer;"></i>
			</a>
		</div>
    </form>
	<!-- 한식집 추천 -->
	<div class="row mb-3">
		<h5 class="fw-semibold mb-3"><i class="bi bi-geo-alt"></i> 주변 한식집 추천</h5>
		<div id="CAT_004-wrapper" class="row mb-3">
		</div>
		<!-- 
		<div>
			<a href="restaurant/searchlist?categoryId=CAT_004" class="text-decoration-none text-muted float-end"><strong>'한식집'</strong> 더보기 <i class="bi bi-chevron-double-right"></i></a>
		</div>
		-->
	</div>
	<!-- 일식집 추천 -->
	<div class="row mb-3">
		<h5 class="fw-semibold mb-3"><i class="bi bi-geo-alt"></i> 주변 일식집 추천</h5>
		<div id="CAT_005-wrapper" class="row mb-3">
		</div>
		<!-- 
		<div>
			<a href="restaurant/searchlist?categoryId=CAT_005" class="text-decoration-none text-muted float-end"><strong>'일식집'</strong> 더보기 <i class="bi bi-chevron-double-right"></i></a>
		</div>
		 -->
	</div>
	<!-- 중식집 추천 -->
	<div class="row mb-3">
		<h5 class="fw-semibold mb-3"><i class="bi bi-geo-alt"></i> 주변 중국집 추천</h5>
		<div id="CAT_006-wrapper" class="row mb-3">
		</div>
		<!-- 
		<div>
			<a href="restaurant/searchlist?categoryId=CAT_006" class="text-decoration-none text-muted float-end"><strong>'중국집'</strong> 더보기 <i class="bi bi-chevron-double-right"></i></a>
		</div>
		 -->
	</div>
	<div class="row my-3">
		<h5 class="fw-semibold mb-3"><i class="bi bi-clock"></i> 실시간 맛집 평가</h5>
		<c:forEach var="review" items="${reviews }">
			<div class="card mb-3 p-1">
			  <div class="card-body">
					<p class="m-0 mb-1">
						${review.user.nickname } </br>
					</p>
					<div class="d-flex flex-wrap justify-content-between">
					    <div>
					    	<a class="text-decoration-none" href="/restaurant/detail?no=${review.restaurant.no }">
							    <strong class="text-dark">${review.restaurant.name }</strong>
					    	</a>
						    <i class="bi bi-geo-alt ms-3 me-1"></i>${review.restaurant.district }
					    </div>
					    <div class="text-warning text-end m-0 mb-3">
						    <i class="${review.pointIcon.star1 }"></i>
						    <i class="${review.pointIcon.star2 }"></i>
						    <i class="${review.pointIcon.star3 }"></i>
						    <i class="${review.pointIcon.star4 }"></i>
						    <i class="${review.pointIcon.star5 }"></i>
					    </div>
					</div>
				    <p class="card-text">${review.content }</p>
				    <div class="elapsedTime small text-end">
				    	<fmt:formatDate value="${review.createdDate }" var="createdDate"/>
				    	${createdDate }
			    	</div>
			    	<c:if test="${not empty review.reviewRestaurantTags }">
					    <div class="mt-3">
					    	<c:forEach var="tag" items="${review.reviewRestaurantTags }">
						   		<span class="badge rounded-pill bg-light">${tag }</span>
					    	</c:forEach>
					    </div>
			    	</c:if>
				  <div class="mt-3">
				  	<a href="/reviewform?restaurantNo=${review.restaurant.no }" class="btn btn-outline-secondary float-end">나도평가하기</a>
				  </div>
			  </div>
			</div>
		</c:forEach>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
// dom객체 생성되자마자 실행 되는 내용
$(function(){
	// 현재 위치를 조회하며 현재위치에 대한 식당 정보를 ajax로 조회한다.
	refreshLocation();
	
	// 실시간 리뷰 정보의 작성일을 이용해 경과시간으로 바꿔준다.
	$(".elapsedTime").each(function(){
		let createdDate = $(this).text();
		$(this).text(getElapsedTime(createdDate));
	});
});

$("#locationButton").click(function() {
	refreshLocation();
});

// 최근검색어 저장된 곳
let $boxKeywords = $("#box-keywords");

$("#search").click(function() {
	// 최근 검색어 토굴을 이용. 체크박스를
	$boxKeywords.toggleClass("d-none");
	refreshKeywordList() 
});

// 최근 검색어를 저장하는 기능
$("#form-search").submit(function() {
	let keyword = $("#search").val();
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
	
	location.href="restaurant/searchlist?keyword=" + keyword;
};

// 현재 위치 좌표를 저장하는 변수
let currentLat = '';
let currentLong = '';
function refreshLocation() {
	// navigator.geolocation에서 지원하는 메소드를 사용해 사용자의 현재 위치 좌표값을 획득한다.
	// 받아온 좌표값은 hidden태그에 저장해서 숙소 검색 시 거리계산 조건에 사용할 수 있게 한다.
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			// 성공 시 콜백함수
	    	currentLat = position.coords.latitude;
	    	currentLong = position.coords.longitude;
			$(":hidden[name=currentLat]").val(currentLat);
			$(":hidden[name=currentLong]").val(currentLong);
			// 화면, 모달창에 현재 위치 주소를 출력한다.
			getLocationAddress();
			// 식당 조회;
			refreshRecommendedContents();
    	}, function(position) {
			// 실패 시 콜백함수
			// 현재 위치를 받을 수 없으면 서울 중심 좌표를 저장
		  	currentLat = 37.564214;
		  	currentLong = 127.0016985;
			$(":hidden[name=currentLat]").val(currentLat);
			$(":hidden[name=currentLong]").val(currentLong);
			// 화면에 (정보없음)을 출력한다. (위치는 서울 중심으로 되어있지만 정보가 없음을 알려주기)
	 	  	$("#home-current-location-address").text('(정보 없음)');
			// 식당 조회;
			refreshRecommendedContents();
		});
	}
}
// 현재 위치 좌표값으로 주소 정보를 조회해 모달 창 화면에 출력하는 함수
function getLocationAddress() {
    $.getJSON('https://maps.googleapis.com/maps/api/geocode/json', 
  		  {sensor:false, 
  	       language:"ko",
  	       latlng: currentLat+","+currentLong, 
  	       key: "AIzaSyCLpyfe2_7Lvws3-UCb2qAtTouxy1xzCJo"})
  .done(function(data) {
	  	let location = data.results[0];
	  	let address = location.formatted_address.split(' ');
	  	$("#modal-current-location-address").text(address[2]+' '+address[3]);
	  	$("#home-current-location-address").text(address[2]+' '+address[3]);
  })
}

/**
 * 카테고리 별 주변 식당 조회하기
 */
//CAT_004,005,006에 대한 컨텐츠 출력 모두 실행하기
function refreshRecommendedContents() {
	showRecommendedRestaurantsByCategory("CAT_004");
	showRecommendedRestaurantsByCategory("CAT_005");
	showRecommendedRestaurantsByCategory("CAT_006");
}
// 현재 위치 좌표값으로 가까운 식당들을 카테고리별로 조회해서 html컨텐츠로 출력한다. (카테고리별로 상위 4건씩)
function showRecommendedRestaurantsByCategory(categoryId) {
	// 로그인 상태인 경우, 식당 별 찜하기 상태 여부를 확인하기 위해 userNo를 같이 보낸다.
	let queryString = $("#form-search").serialize() + "&categoryId=" + categoryId + ("${LOGIN_USER }" == "" ? "" : "&userNo=" + "${LOGIN_USER.no}");
	// 조회한 정보를 이용해 해당 카테고리의 wrapper에 콘텐츠를 추가한다.
	let $wrapper = $("#" + categoryId + "-wrapper").empty();
	$.getJSON('/restaurants', queryString).done(function(restaurants) {
		if (restaurants.length == 0) {
			let content = '<p class="my-5 text-center mx-auto">조회된 결과가 없습니다.</p>';
		} else {
			let content = '';
			// 식당 정보 카드 컨텐츠 생성 (최대 4개만 출력)
			$.each(restaurants, function(index, item) {
				if (index > 3) {
					return;
				}
				content += '<div class="col-3">';
				content += '	<div class="card mb-3 p-1 h-100" style="max-width: 20rem;">';
				content += '		<a class="text-decoration-none" href="restaurant/detail?no=' + item.no + '">';
				content += '			<img src="/resources/images/restaurant/thumbnail/' + item.imgname +'" class="card-img-top" alt="...">';
				content += '		</a>';
				content += '	  <div class="card-body d-flex flex-column justify-content-between my-auto">';
				content += '		<div class="row">';
				content += '	   		<div class="d-flex my-auto">';
				content += '				<a class="flex-fill text-decoration-none" href="restaurant/detail?no=' + item.no + '">';
				content += '					<strong class="text-dark fw-light fs-5 pe-2">' + item.name + '</strong>';
				content += '				</a>';
				// 식당 찜하기 클릭하면 관련 ajax 요청 함수 실행 // 로그인 상태일 경우 하트 채워지는 여부 다르게 출력
				content += '				<i id="icon-heart-' + item.no +'" class="text-primary fs-5 float-end bi ' + (item.liked ? 'bi-heart-fill' : 'bi-heart') + '" onclick="toggleRestaurantLike(' + item.no + ');"></i>';
				content += '			</div>';
				content += '		</div>';
				content += '	    <div class="row mt-3 border-top">';
				content += '	        <p class="text-warning my-1">'
				content += '		    	<i class="bi ' + item.reviewRateIcon.star1 + '"></i>';
				content += '		    	<i class="bi ' + item.reviewRateIcon.star2 + '"></i>';
				content += '		    	<i class="bi ' + item.reviewRateIcon.star3 + '"></i>';
				content += '		    	<i class="bi ' + item.reviewRateIcon.star4 + '"></i>';
				content += '		    	<i class="bi ' + item.reviewRateIcon.star5 + '"></i>';
				content += '		    </p>';
				content += '	        <p class="card-text mb-1">' + item.distance + ' km</p>';
				content += '	        <p class="card-text mb-3">'
				if (item.menus != null) {
					let menuLength = item.menus.length;
					for (let i = 0; i < 3; i++) {
						// 3개까지만 보여준다
						content += item.menus[i].menuName + ((i == 2) ? ' 등' : ', ');
					}
				} else {
					content += '메뉴 정보가 없습니다.'
				}
				content += '			</p>';
				content += '	    	<a href="/reviewform?restaurantNo='+ item.no +'" class="btn btn-outline-primary">평가하기</a>';
				content += '	  	</div>';
				content += '	  </div>';
				content += '	</div>';
				content += '</div>';
			});
			$wrapper.append(content);
		}
	});
}

/*
 * 식당 찜하기정보 저장/삭제
 */
// 하트 아이콘을 누르면, 식당번호를 전달해 USER_RESTAURANT_LIKES 테이블에 저장한다.
// 이미 좋아요를 누른 식당일 경우, 아이콘을 누르면 좋아요 정보가 테이블에서 삭제된다.
// * 로그인하지 않은 상태일 경우 alert을 띄우고, 요청을 보내지 않는다.
function toggleRestaurantLike(no) {
	let $icon = $("#icon-heart-" + no);
	
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
	
</script>
</body>
</html>