<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<div class="col-12">
	<jsp:include page="../common/nav.jsp" />
</div>
<div class="container m-3">
	<div class="row">
		<div class="col-4 bg-light">
		</div>
		<div class="col-8">
			<div class="row" style="width:250px; height:200px;" onclick="location.href='myreservation'">
				<p class="m-3"><strong>예약내역</strong></p>
				<div class="col m-2 bg-light">
					<img src="/resources/images/sampleacco1.jpg" style="width:230px; height:100px;"><br>
					<p class="text-center"><span class="badge rounded-pill bg-danger mt-3">예약확정</span></p>
					<p class="text-center"><strong>천안 호텔 소설 스미스</strong></p>
					<p class="text-center">체크인 : 07.29 금 15:00 / 1박 </p>
					<div class="row">
						<button class="btn btn-success" type="button" href="#">리뷰 작성</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

</script>
</html>