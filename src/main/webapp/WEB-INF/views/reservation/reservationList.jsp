<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
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
			<div class="m-3" style="color:black;"><strong>예약 내역</strong>
				<div class="row" style="width:250px;">
				<c:forEach var="reserv" items="${reservationList }" >
					<div class="border col m-2 " >
						<img class="img-fluid" src="/resources/images/acco/thumbnail/${reserv.acco.thumbnailImageName}"><br>
						<a href="myreservation" style="text-decoration: none; color:black;">
							<p class="text-center"><span class="badge rounded-pill bg-danger mt-3">예약확정</span></p>
							<p class="text-center"><strong>${reserv.acco.name }</strong></p>
							<p class="form-text text-center">체크인 : ${reserv.checkIn } -  체크아웃 : ${reserv.checkOut } </p>
						</a>
						<div class="row">
							<button class="btn btn-success" type="button" href="#">리뷰 작성</button>
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
			<div class="m-3" style="color:black;"><strong>이용 내역</strong>
				<div class="row" style="width:250px;">
					<c:forEach var="reserv" items="${reservationList }" >
					<div class="border col m-2 " >
						<img class="img-fluid" src="/resources/images/acco/thumbnail/${reserv.acco.thumbnailImageName}"><br>
						<a href="myreservation" style="text-decoration: none; color:black;">
							<p class="text-center"><span class="badge rounded-pill bg-danger mt-3">예약확정</span></p>
							<p class="text-center"><strong>${reserv.acco.name }</strong></p>
							<p class="form-text text-center">체크인 : ${reserv.checkIn } -  체크아웃 : ${reserv.checkOut } </p>
						</a>
						<div class="row">
							<button class="btn btn-success" type="button" href="#">리뷰 작성</button>
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
			<div class="m-3" style="color:black;"><strong>취소 내역</strong>
				<div class="row" style="width:250px;">
					<c:forEach var="reserv" items="${reservationList }" >
					<div class="border col m-2 " >
						<img class="img-fluid" src="/resources/images/acco/thumbnail/${reserv.acco.thumbnailImageName}"><br>
						<a href="myreservation" style="text-decoration: none; color:black;">
							<p class="text-center"><span class="badge rounded-pill bg-info mt-3">예약취소</span></p>
							<p class="text-center"><strong>${reserv.acco.name }</strong></p>
							<p class="form-text text-center">체크인 : ${reserv.checkIn } -  체크아웃 : ${reserv.checkOut } </p>
						</a>
						<div class="row">
							<button class="btn btn-success" type="button" href="#">리뷰 작성</button>
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-12">
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
</body>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">



</script>
</html>