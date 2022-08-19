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
<div class="container-flex m-3">
	<div class="row">
		<div class="col-4 bg-light">
		</div>
		<div class="col-8">
			<div class="m-3" style="color:black;"><strong>예약 내역</strong>
				<div class="row">
					<c:choose >
						<c:when test="${!empty payment }">
							<c:forEach var="payment" items="${payment }" >
								<div class="card col-4 m-2 " >
										<img class="img-fluid" src="/resources/images/acco/thumbnail/${payment.reservation.acco.thumbnailImageName}"><br>
										<div class="card-body">
											<a href="/myreservation?reservationNo=${payment.reservation.reservationNo}" style="text-decoration: none; color:black;">
												<p class="text-center"><span class="badge rounded-pill ${payment.paymentStatus eq '예약완료' ? 'bg-danger' : 'bg-info' } mt-3">${payment.paymentStatus }</span></p>
												<p class="text-center"><strong>${payment.reservation.acco.name }</strong></p>
												<p class="form-text text-center">체크인 : <fmt:formatDate value="${payment.reservation.checkIn }" pattern="yyyy-MM-dd"/></p>
												<p class="form-text text-center" >체크아웃 : <fmt:formatDate value="${payment.reservation.checkOut }" pattern="yyyy-MM-dd"/></p>
											</a>
										</div>
									<div class="row">
										<button class="btn btn-success" type="button" href="#">리뷰 작성</button>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
								<div class="border col m-2 " >
									<tr>
										<td colspan="5" class="text-center">예약내역이 없습니다.</td>
									</tr>
								</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="m-3" style="color:black;"><strong>이용 내역</strong>
				<div class="row" >
					<c:choose>
						<c:when test="${empty Readyreservation }">
							<div class="card col m-2 " >
								<tr>
									<td colspan="5" class="text-center">예약내역이 없습니다.</td>
								</tr>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="Readyreservation" items="${Readyreservation }" >
								<div class="card col-4 m-2 " >
										<img class="img-fluid" src="/resources/images/acco/thumbnail/${Readyreservation.reservation.acco.thumbnailImageName}"><br>
										<div class="card-body">
											<a href="/myreservation?reservationNo=${Readyreservation.reservation.reservationNo}"  style="text-decoration: none; color:black;">
												<p class="text-center"><span class="badge rounded-pill ${Readyreservation.paymentStatus eq '예약완료' ? 'bg-danger' : 'bg-info' } mt-3">${Readyreservation.paymentStatus }</span></p>
												<p class="text-center"><strong>${Readyreservation.reservation.acco.name }</strong></p>
												<p class="form-text text-center">체크인 : <fmt:formatDate value="${Readyreservation.reservation.checkIn }" pattern="yyyy-MM-dd"/></p>
												<p class="form-text text-center" >체크아웃 : <fmt:formatDate value="${Readyreservation.reservation.checkOut }" pattern="yyyy-MM-dd"/></p>
											</a>
										</div>
									<div class="row">
										<button class="btn btn-success" type="button" href="#">리뷰 작성</button>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="m-3" style="color:black;"><strong>취소 내역</strong>
				<div class="row">
					<c:choose>
						<c:when test="${empty Refundreservation }">
							<div class="border col m-2 " >
								<tr>
									<td colspan="5" class="text-center">취소내역이 없습니다.</td>
								</tr>
							</div>
						</c:when>
						<c:otherwise>
								<c:forEach var="Refundreservation" items="${Refundreservation }" >
									<div class="card col-4 m-2 " >
										<img class="img-fluid" src="/resources/images/acco/thumbnail/${Refundreservation.reservation.acco.thumbnailImageName}"><br>
										<div class="card-body">
											<a href="/myreservation?reservationNo=${Refundreservation.reservation.reservationNo}"  style="text-decoration: none; color:black;">
												<p class="text-center"><span class="badge rounded-pill ${Refundreservation.paymentStatus eq '예약완료' ? 'bg-danger' : 'bg-info' } mt-3">${Refundreservation.paymentStatus }</span></p>
												<p class="text-center"><strong>${Refundreservation.reservation.acco.name }</strong></p>
												<p class="form-text text-center">체크인 : <fmt:formatDate value="${Refundreservation.reservation.checkIn }" pattern="yyyy-MM-dd"/></p>
												<p class="form-text text-center" >체크아웃 : <fmt:formatDate value="${Refundreservation.reservation.checkOut }" pattern="yyyy-MM-dd"/></p>
											</a>
										</div>
									<div class="row">
										<button class="btn btn-success" type="button" href="#">리뷰 작성</button>
									</div>
								</div>
								</c:forEach>
						</c:otherwise>
					</c:choose>
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
function reservationNoSubmit(){
	
	
	
	document.getElementById('reservationNoForm').submit();
}


</script>
</html>