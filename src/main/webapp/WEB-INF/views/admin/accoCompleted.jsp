<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>서울어떄</title>
</head>
<body>
<div class="container mt-3">
	<c:set var="menu" value="home"/>
	<%@ include file="../common/nav.jsp" %>
	<div class="row mb-3">
		<div class="col">
			<div class="border p-5 bg-light">
				<h1 class="display-3 mb-5">숙소 입력이 완료되었습니다.</h1>
				<a href="home" class="btn btn-primary btn-lg">홈으로</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>