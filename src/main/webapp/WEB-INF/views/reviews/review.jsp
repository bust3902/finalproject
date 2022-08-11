<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>리뷰</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container border mb-3">
	<div class="row">
		<div class="col-3">
			<div class="card p-3">
				<ul class="list-group list-group-flush">
					<li class="list-group-item"><a href="#">포인트</a></li>
					<li class="list-group-item"><a href="#">쿠폰함</a></li>
					<li class="list-group-item"><a href="#">예약 내역</a></li>
					<li class="list-group-item"><a href="#">내 정보 관리</a></li>
					<li class="list-group-item"><a href="#">내 리뷰 보기</a></li>
				</ul>
			</div>
		</div>
		<c:if test="${empty review }">
			<div class="alert alert-danger">
				등록된 리뷰가 없습니다.
			</div>
		</c:if>
		<c:if test="${not empty review }">
			<div class="text-center">
				<table class="table">
					<thead>
						<tr>
							<th>제목</th>
							<th>작성자</th>
							<th>내용</th>
							<th>평점</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>제목</td>
							<td>작성자</td>
							<td>내용</td>
							<td>5점</td>
							<td>2022-07-27</td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
</div>
</body>
<footer>
	<div class="container my-3">
		<div class="row mb-3">
			<h3 class="fs-4 mb-3 border text-center">임시</h3>
		</div>
	</div>
</footer>
</html>