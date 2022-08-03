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
<div class="container">
	<div class="position-relative">
		<form class="d-flex" role="search" action="searchList" onsubmit="savedKeyword();">
	        <input class="form-control me-sm-2" type="text" id="search" name="keyword" placeholder="지역,음식을 검색하세요">
	        <button class="btn btn-secondary my-2 my-sm-0" type="submit">
	        	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				</svg>
			</button>
			<input type="hidden" name="lat" value="" />
			<input type="hidden" name="lng" value="" />
			<div id="box-keywords" class="position-absolute w-100" style="top:48px; left:0; z-index: 10000;">
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
							<span>
								<i class="bi bi-clock"></i>
								<span class="ms-4">맛있는 맛집</span>
							</span>
							<button type="button" class="float-end btn text-danger border-0 btn-sm"><i class="bi bi-trash"></i></button>
						</div>
					</li>
					<li class="list-group-item list-group-flush ">
						<div class="d-flex justify-content-between">
							<span>
								<i class="bi bi-clock"></i>
								<span class="ms-4">맛있는 맛집</span>
							</span>
							<button type="button" class="float-end btn text-danger border-0 btn-sm"><i class="bi bi-trash"></i></button>
						</div>
					</li>
					<li class="list-group-item list-group-flush ">
						<div class="d-flex justify-content-between">
							<span>
								<i class="bi bi-clock"></i>
								<span class="ms-4">맛있는 맛집</span>
							</span>
							<button type="button" class="float-end btn text-danger border-0 btn-sm"><i class="bi bi-trash"></i></button>
						</div>
					</li>
				</ul>
			</div>
			
	    </form>
	</div>
	
	<!-- <div class="position-absolute top-20 end-30">
		<button id="locationButton">현재위치 확인</button>
		<p id="demo"></p>
	</div> -->
	
</div>
<script type="text/javascript">
$(function() {
	$("#locationButton").click(function() {
		let x = document.getElementById("demo");
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
	
	$("#search").click(function() {
		// 저장된 키워드를 가져오는 코드입니다.
		let text = localStorage.getItem("keywords") || '[]';
		let array = JSON.parse(text);
		
		/*
			<div id="box-keywords">
				<ul id="list-group-keywords" class="list-group"></ul>
			</div>
		*/
		let $listGroup = $("#list-group-keywords");
		$.each(array, function(index, keyword) {
			
			let content = '<li class="list-group-item list-group-flush border"> <i class="bi bi-clock"> '+keyword+' <button>X</button> </li>';
			//$listGroup.append(content);
		})
	});
	
});
	
	// 최근 검색어를 저장하는 기능
	function savedKeyword() {
		let keyword = $(":input[name=keyword]").value;
		let text = localStorage.getItem("keywords") || '[]';
		let array = JSON.parse(text);
		
		if (keywords === "") {
			return;
		} else {
			array.unshift(keywords);
		}
		
		text = JSON.stringify(array);
		localStorage.setItem("keywords", text);
	}
	
	// 최근 검색어를 하나씩 삭제하는 기능
	
	// 최근 검색어 클릭시 search 페이지로 이동하는 기능
	
	// 최근 검색어 전체 삭제하는 기능

</script>
</body>
</html>