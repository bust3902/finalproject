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
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<h1 class="fs-3 text-white p-2">문의내역</h1>
	</div>
</div>
<div class="container" style="min-width:992px; max-width:992px;">
	<div class="row mt-5">
				
		<!-- 오늘의 예약 현황 출력 -->
		<div class="col-2"></div>
		<div class="col-8">
			<div class="card mb-2">
				<div class="card-header bg-secondary text-center">
		           	<span class="text-light">문의내역</span>
				</div>
				<div class="card-body p-2">
					<div class="row">
						<ul class="list-group list-group-flush">
							<li class="list-group-item text-center fw-bold"><span>제목</span></li>
							<li class="list-group-item">${qasByQaNo.title }</li>
							<li class="list-group-item text-center fw-bold">내역</li>
							<li class="list-group-item">${qasByQaNo.content }</li>
							<li class="list-group-item text-center fw-bold">작성일</li>
							<li class="list-group-item text-center">${qasByQaNo.createdDate }</li>
							<li class="list-group-item"><img src="/resources/images/qa/${qasByQaNo.image }" style="weight:auto; height:200px;"></li>
							<li></li>
							<c:if test="${not empty qasByQaNo.answerContent}">
								<li class="list-group-item text-center fw-bold">답글</li>
								<li class="list-group-item text-center">${qasByQaNo.answerContent }</li>
							</c:if>
						</ul>
					</div>
				</div>
				<div class="text-end">
					<a type="button" href="/qa" class="btn btn-secondary m-3" id="btn-return-main">돌아가기</a>
				</div>
			</div>
		</div>
		<div class="col-2"></div>
	</div>
</div>
				
</body>
</html>