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
<title>서울 맛어때</title>
</head>
<body>

<div class="container my-3" style="min-width:992px; max-width:992px;">
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
		<div class="position-absolute" style="top:70px; left:1000px;" >
			<button id="locationButton" class="float-end border-0"><i class="bi bi-geo"></i>현재위치 확인</button>
			<p id="demo"></p>
		</div>
	
	<div class="row my-5">
		<h4>주변 한식집 추천</h4>
		<div class="col-3">
			<div class="card mb-3 border-0" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>명륜 손칼국수</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">587m</p>
			    <p class="card-text m-0">칼국수, 수육</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>명륜 손칼국수</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">587m</p>
			    <p class="card-text m-0">칼국수, 수육</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>명륜 손칼국수</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">587m</p>
			    <p class="card-text m-0">칼국수, 수육</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>명륜 손칼국수</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">587m</p>
			    <p class="card-text m-0">칼국수, 수육</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div><span class="float-end"><strong>'한식집'</strong> 더보기</span></div>
	</div>
	
	<div class="row my-5">
		<h4>주변 일식집 추천</h4>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>기꾸스시</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">772m</p>
			    <p class="card-text m-0">초밥, 스시</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>기꾸스시</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">772m</p>
			    <p class="card-text m-0">초밥, 스시</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>기꾸스시</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">772m</p>
			    <p class="card-text m-0">초밥, 스시</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
			  <div class="card-body">
			  <!-- <img src="/resources/images/"> -->
			    <p class="card-title"><strong>기꾸스시</strong><button class="btn btn-outline-secondary border-0 float-end"><i class="bi bi-heart"></i></button></p>
			    <p class="card-text m-0">772m</p>
			    <p class="card-text m-0">초밥, 스시</p>
			    <div class="row mt-3">
			    	<button type="button" class="btn btn-outline-secondary">평가하기</button>
			  	</div>
			  </div>
			</div>
		</div>
		<div><span class="float-end"><strong>'일식집'</strong> 더보기</span></div>
	</div>
	
	<div class="row my-5">
		<h4>주변 중국집 추천</h4>
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
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
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
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
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
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
		<div class="col-3 mb-3">
			<div class="card mb-3" style="max-width: 20rem;">
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
		<div><span class="float-end"><strong>'중국집'</strong> 더보기</span></div>
	</div>

	<div class="row my-3">
		<h4>실시간 맛집 평가</h4>
		<div class="mb-3 col-6">
			<div class="card mb-3">
			  <div class="card-body">
				  <div>
					  <p class="card-text m-0">냥냥(89곳 평가,199개 공감받음)</p>
					    <p class="card-text m-0">
					    	<strong>아따커피</strong><i class="bi bi-geo-alt"></i>광주
					    </p>
					    <p class="card-text m-0">
					    <i class="bi-star-fill"></i>
					    <i class="bi-star-fill"></i>
					    <i class="bi-star-fill"></i>
					    <i class="bi-star"></i>
					    <i class="bi-star"></i>
					    방금전
					    </p>
				  </div>
			  
				    <p></p>
				    <p class="card-text">카페가 예쁘고 좋은데 생각보다 작음 쿠키 하나씩 다 샀더니 원하는쿠키 하나 더 주셨음 !!^^
				    		부드러운 쿠키(티라미수, 레몬, 레드벨벳) 같은건 너무 달아서 내취향
				    		아닌듯..... 말차랑 초코칩 대박맛있음 초코칩은 진짜 또먹고싶음 .. 초코마니박혀있어서 좋았음
				    </p>
			    
				    <div class="mt-3">
				   		<span class="badge rounded-pill bg-light">데이트</span>
				   		<span class="badge rounded-pill bg-light">간식</span>
				   		<span class="badge rounded-pill bg-light">숨은맛집</span>
				   		<span class="badge rounded-pill bg-light">조용한</span>
				   		<span class="badge rounded-pill bg-light">예쁜</span>
				    </div>
			  </div>
			  <div class="mb-3 mt-3">
			  	<button type="button" class="btn btn-outline-secondary">공감(1)</button>
			  	<button type="button" class="btn btn-outline-secondary float-end">나도평가하기</button>
			  </div>
			</div>
		</div>
		<div class="mb-3 col-6">
			<div class="card mb-3">
			  <div class="card-body">
				  <div>
					  <p class="card-text m-0">냥냥(89곳 평가,199개 공감받음)</p>
					    <p class="card-text m-0">
					    	<strong>아따커피</strong><i class="bi bi-geo-alt"></i>광주
					    </p>
					    <p class="card-text m-0">
					    <i class="bi-star-fill"></i>
					    <i class="bi-star-fill"></i>
					    <i class="bi-star-fill"></i>
					    <i class="bi-star"></i>
					    <i class="bi-star"></i>
					    방금전
					    </p>
				  </div>
			  
				    <p></p>
				    <p class="card-text">카페가 예쁘고 좋은데 생각보다 작음 쿠키 하나씩 다 샀더니 원하는쿠키 하나 더 주셨음 !!^^
				    		부드러운 쿠키(티라미수, 레몬, 레드벨벳) 같은건 너무 달아서 내취향
				    		아닌듯..... 말차랑 초코칩 대박맛있음 초코칩은 진짜 또먹고싶음 .. 초코마니박혀있어서 좋았음
				    </p>
			    
				    <div class="mt-3">
				   		<span class="badge rounded-pill bg-light">데이트</span>
				   		<span class="badge rounded-pill bg-light">간식</span>
				   		<span class="badge rounded-pill bg-light">숨은맛집</span>
				   		<span class="badge rounded-pill bg-light">조용한</span>
				   		<span class="badge rounded-pill bg-light">예쁜</span>
				    </div>
			  </div>
			  <div class="mb-3 mt-3">
			  	<button type="button" class="btn btn-outline-secondary">공감(1)</button>
			  	<button type="button" class="btn btn-outline-secondary float-end">나도평가하기</button>
			  </div>
			</div>
		</div>
		<div class="mb-3 col-6">
			<div class="card mb-3">
			  <div class="card-body">
				  <div>
					  <p class="card-text m-0">냥냥(89곳 평가,199개 공감받음)</p>
					    <p class="card-text m-0">
					    	<strong>아따커피</strong><i class="bi bi-geo-alt"></i>광주
					    </p>
					    <p class="card-text m-0">
					    <i class="bi-star-fill"></i>
					    <i class="bi-star-fill"></i>
					    <i class="bi-star-fill"></i>
					    <i class="bi-star"></i>
					    <i class="bi-star"></i>
					    방금전
					    </p>
				  </div>
			  
				    <p></p>
				    <p class="card-text">카페가 예쁘고 좋은데 생각보다 작음 쿠키 하나씩 다 샀더니 원하는쿠키 하나 더 주셨음 !!^^
				    		부드러운 쿠키(티라미수, 레몬, 레드벨벳) 같은건 너무 달아서 내취향
				    		아닌듯..... 말차랑 초코칩 대박맛있음 초코칩은 진짜 또먹고싶음 .. 초코마니박혀있어서 좋았음
				    </p>
			    
				    <div class="mt-3">
				   		<span class="badge rounded-pill bg-light">데이트</span>
				   		<span class="badge rounded-pill bg-light">간식</span>
				   		<span class="badge rounded-pill bg-light">숨은맛집</span>
				   		<span class="badge rounded-pill bg-light">조용한</span>
				   		<span class="badge rounded-pill bg-light">예쁜</span>
				    </div>
			  </div>
			  <div class="mb-3 mt-3">
			  	<button type="button" class="btn btn-outline-secondary">공감(1)</button>
			  	<button type="button" class="btn btn-outline-secondary float-end">나도평가하기</button>
			  </div>
			</div>
		</div>
	</div>
		
</div>
<script type="text/javascript">

	$("#locationButton").click(function() {
		let x = document.getElementById("demo");
		// 위도와 경도 값을 가져오는 코드입니다.
		if (navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		    	let latitude = position.coords.latitude;
		        let longitude = position.coords.longitude;
		        //alert(latitude + ", " + longitude);
		        
		        // 구글 map api를 이용해서 위도 경도 값을 통해 해당하는 주소값 가져오기
		        $.getJSON('https://maps.googleapis.com/maps/api/geocode/json', 
		        		  {sensor:false, 
		        	       language:"ko",
		        	       latlng: latitude+","+longitude, 
		        	       key: "AIzaSyCLpyfe2_7Lvws3-UCb2qAtTouxy1xzCJo"})
		        .done(function(data) {
		        	console.log(data);
		        	let location = data.results[0];
		        	//let address = location.formatted_address.replace("대한민국 ", " ");
		        	let address2 = location.formatted_address.split(' ');
		        	//alert(address2[2]+' '+address2[3]);
		        	//alert(address);
		        	$("#locationButton").text(address2[2]+' '+address2[3]);
		        })
		    });
		  } else { 
			// 현재 위치를 받을 수 없으면 서울 중심 위경도를 저장
		    	currentLat = 37.564214;
		    	currentLong = 127.0016985;
				$(":hidden[name=currentLat]").val(currentLat);
				$(":hidden[name=currentLong]").val(currentLong);
		  }
	});
	
	/* function getLocation() {
		  if (navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		    	let latitude = position.coords.latitude;
		        let longitude = position.coords.longitude;
		        //alert(latitude + ", " + longitude);
		        
		        $.getJSON('https://maps.googleapis.com/maps/api/geocode/json', 
		        		  {sensor:false, 
		        	       language:"ko",
		        	       latlng: latitude+","+longitude, 
		        	       key: "AIzaSyCLpyfe2_7Lvws3-UCb2qAtTouxy1xzCJo"})
		        .done(function(data) {
		        	console.log(data);
		        	let location = data.results[0];
		        	//let address = location.formatted_address.replace("대한민국 ", " ");
		        	let address2 = location.formatted_address.split(' ');
		        	//alert(address2[2]+' '+address2[3]);
		        	//alert(address);
		        	$("#locationButton").text(address2[2]+' '+address2[3]);
		        })
		    });
		  } else { 
		    x.innerHTML = "Geolocation is not supported by this browser.";
		  }
	} */
	
	// 최근검색어 저장된 곳
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


</script>
</body>
</html>