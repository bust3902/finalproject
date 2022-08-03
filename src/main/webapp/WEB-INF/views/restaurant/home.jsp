<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>서울 맛어때</title>
</head>
<body>
<div class="container">
	<div>
		<form class="d-flex" role="search" onsubmit="savedKeyword();">
	        <input class="form-control me-sm-2" type="text" id="search" name="keyword" placeholder="지역,음식을 검색하세요">
	        <button class="btn btn-secondary my-2 my-sm-0" type="submit">
	        	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
				</svg>
			</button>
			<input type="hidden" name="lat" value="" />
			<input type="hidden" name="lng" value="" />
	    </form>
	</div>
	
	<div class="position-absolute top-20 end-30">
		<button id="locationButton">현재위치 확인</button>
		<p id="demo"></p>
	</div>
	
	<div id="box-keywords" class="position-absolute top-10 start-50">
		<ul class="list-group">
  			<li class="list-group-item list-group-flush border border-white">
	  			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
	  				<path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
	  				<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"/>
				</svg>
			An item
			</li>
  			<li class="list-group-item list-group-flush border border-white">A second item</li>
  			<li class="list-group-item list-group-flush border border-white">A third item</li>
 			<li class="list-group-item list-group-flush border border-white">A fourth item</li>
  			<li class="list-group-item list-group-flush border border-white">And a fifth one</li>
		</ul>
	</div>
	
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
			
			let content = '<li class="list-group-item">'+keyword+'</li>';
			$listGroup.append(content);
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

</script>
</body>
</html>