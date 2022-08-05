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
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<form id="form-search-restaurant">
		<div class="row px-3 pt-5 pb-3">
		</div>
		<div class="row">
			<div class="col-4">
				<div class="card p-1">
					<ul class="list-group list-group-flush">
						<li class="list-group-item py-3">
							<div class="fw-bold mb-3">카테고리</div>
							<div class="row">
								<div class="col-12 mb-3">
									<input class="form-check-input" type="checkbox" name="" value="">
									<label class="form-check-label">배달</label>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- 현재 위치를 확인할 수 있는 버튼입니다. -->
<div class="position-absolute" style="top:60px; left:1000px;" >
	<button id="locationButton" class="float-end border-0"><i class="bi bi-geo"></i>현재위치 확인</button>
	<p id="demo"></p>
</div>
<script type="text/javascript"></script>
</body>
</html>