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
		<form class="d-flex">
	        <input class="form-control me-sm-2" type="text" id="search" name="keyword" placeholder="지역,음식을 검색하세요">
	        <button class="btn btn-secondary my-2 my-sm-0" type="submit">검색</button>
	    </form>
	</div>
	<button onclick="getLocation()">Try It</button>
	<p id="demo"></p>
</div>
<script type="text/javascript">

	let x = document.getElementById("demo");
	
	function getLocation() {
		  if (navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		    	let latitude = position.coords.latitude;
		        let longitude = position.coords.longitude;
		        //alert(latitude + ", " + longitude);
		        
		        $.getJSON('https://maps.googleapis.com/maps/api/geocode/json', 
		        		  {sensor:false, 
		        	       language:"ko",
		        	       latlng: "37.5881728,126.992384", 
		        	       key: "AIzaSyCLpyfe2_7Lvws3-UCb2qAtTouxy1xzCJo"})
		        .done(function(data) {
		        	console.log(data);
		        	let location = data.results[0];
		        	let address = location.formatted_address.replace("대한민국 ", " ");
		        	alert(address);
		        })
		    });
		  } else { 
		    x.innerHTML = "Geolocation is not supported by this browser.";
		  }
	}

</script>
</body>
</html>