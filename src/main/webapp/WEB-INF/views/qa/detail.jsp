<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>서울어때</title>
</head>
<body>
<div class="container my-4">
	<div class="col-5 mb-3">
		<div>
			<img src="/resources/images/review/${review.image }" class="img-thumbnail rounded-0"/>
		</div>
		<div>
			<h4>${review.title }</h4>
			<p>${review.user.nikname }</p>
			<p>
				<i class="bi ${review.likeCount gt 0 ? 'bi-star-fill' : 'bi-star' }"></i>
				<i class="bi ${review.likeCount gt 1 ? 'bi-star-fill' : 'bi-star' }"></i>
				<i class="bi ${review.likeCount gt 2 ? 'bi-star-fill' : 'bi-star' }"></i>
				<i class="bi ${review.likeCount gt 3 ? 'bi-star-fill' : 'bi-star' }"></i>
				<i class="bi ${review.likeCount gt 4 ? 'bi-star-fill' : 'bi-star' }"></i>
				(${review.likeCount })
			</p>
		</div>
	</div>
</div>
</body>
</html>