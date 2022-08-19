<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container mt-3">
	<div class="row mb-3">
		<div class="col">
			<div class="border p-5 bg-light">
				<h1 class="display-3 mb-5">리뷰 작성이 완료되었습니다.</h1>
				<a href="/review" class="btn btn-primary">돌아가기</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>