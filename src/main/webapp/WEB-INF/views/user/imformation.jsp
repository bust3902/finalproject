<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

	#title {
    	height: 211px;
    	margin: 0 auto;
    	padding-top: 72px;
    	border-radius: 0;
	}
	
	#title h2 {
		display: block;
    	margin: 21px 0 0 31px;
    	font-size: 38px;
    	font-weight: normal;
    	letter-spacing: -1px;
    	color: #fff;
    	background-color: #ff9999;
    	box-sizing: border-box;
	}
	
	.container{
		height: 250px;
	}
</style>
<title>내 정보</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container">
	<div id="title">
		<h2>내정보</h2>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>