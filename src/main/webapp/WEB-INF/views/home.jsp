<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>홈</title>
<style>
	.home{
		display: block;
	}
</style>
</head>
<body>
<%@ include file="common/nav.jsp" %>
<div class="home" >
<div class="container my-3">
		<div class="row">
			<a href="#" class="d-flex justify-content-center my-5"><img alt="" src=""></a>
		</div>
		<div class="d-flex flex-wrap justify-content-evenly" style="min-height: 350px;">
			<!-- 숙소유형별 조회 아이콘은 DB에서 숙소유형 조회해서 출력 -->
			<c:forEach var="accoType" items="${accoTypes }">
				<div class="text-center my-auto">
					<a href="acco?type=${accoType.id }"><img class="img-fluid" src="/resources/images/homeicons/${accoType.id }.png" style="width:100px;height:auto;"></a><br/>
			    	<a href="acco?type=${accoType.id }" class="text-decoration-none text-dark fw-light">${accoType.name }</a>
				</div>
			</c:forEach>
			<!-- TODO : 내 주변 조회 - 추후 가능하면 구현, 아니면 삭제하기  -->
			<div class="text-center my-auto">
				<a href="#"><img class="img-fluid" src="/resources/images/homeicons/near.png" style="width:100px;height:auto;"></a><br/>
		    	<a href="#" class="text-decoration-none text-dark fw-light">내주변</a>
			</div>
			<div class="text-center my-auto">
				<a href="restaurant"><img class="img-fluid" src="/resources/images/homeicons/restaurant.png" style="width:100px;height:auto;"></a><br/>
		    	<a href="restaurant" class="text-decoration-none text-dark fw-light">맛어때</a>
			</div>
		</div>
		<div class="row my-5 mx-auto" style="max-width: 950px;">
			<div class="fw-bold text-dark mb-3"> 서울어때 소식</div>
			<div class="d-flex flex-wrap justify-content-between ">
				<div class="card flex-fill p-1 mb-3 me-3">
					<div class="row g-0">
			  			<div class="col-md-4">
			    			<img src="/resources/images/logo.png" style="width:170px;" class="img-fluid rounded-start" alt="...">
			  			</div>
			  			<div class="col-md-8">
			    			<div class="card-body">
			      				<h5 class="card-title">서울어때 비즈니스</h5>
			      				<p class="card-text">출장부터 복지까지<br>서울어때 비즈니스로 서마터하게</p>
			    			</div>
			  			</div>
					</div>
				</div>
				<div class="card flex-fill p-1 mb-3">
					<div class="row g-0">
						<div class="col-md-4">
				    		<img src="/resources/images/logo.png" style="width:170px;" class="img-fluid rounded-start" alt="...">
				  		</div>
				  		<div class="col-md-8">
				    		<div class="card-body">
				      			<h5 class="card-title">서울어때 서체 출시</h5>
				      			<p class="card-text">젊고 당당한 서울어때 잘난체<br>지금 다운로드 받으세요!</p>
				    		</div>
				  		</div>
					</div>
				</div>
			</div>
		</div>
</div>
</div>
<script type="text/javascript">
</script>
<%@ include file="common/footer.jsp" %>
</body>
</html>
