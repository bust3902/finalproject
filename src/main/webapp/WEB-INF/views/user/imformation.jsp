<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	#yeseok {
		width: 100%;
		height: 900px;
		padding: 0;
		margin: 0;
		max-width: inherit;
	}
	
	#title {
		width: 100%;
	}
	
	#title h2 {
		display: block;
		font-size: 28px;
		font-weight: normal;
		letter-spacing: -4px;
    	color: #fff;
    	background-color: #ff9999;
		width: 100%;
    	padding: 41px 0px 61px 355px;
    	margin: 0px;
	}
	
	#yeseok2 {
		padding: 41px 0px 61px 250px;
		margin: 0px 105px;		
	}
	
	#all-content {
		width: 1000px;
	}
	
	#category-box {
		display: block;
    	float: left;
    	width: 180px;
	}	
	
	#content {
		color: #000000;
    	padding-top: 20px;
    	display: block;
    	position: relative;
    	float: right;
    	width: 800px;
    	margin: auto;
	}
	
	
	
	#content #nickname, #name, #tel {
		width: 150px;
	}
</style>
<title>내 정보</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="yeseok">
	<div id="title">
		<h2>내정보</h2>
	</div>
	<div id="yeseok2">
		<div id="all-content">
			<!-- 카테고리 리스트 -->	
			<div id="category-box">
				<c:forEach var="category" items="${categories }">
					<a href="imformation?cat=${category.id }" data-category="${category.id }" class="list-group-item list-group-item-action py-3 ${param.cat eq category.id ? 'active' : '' }"> ${category.name }</a>
				</c:forEach>
			</div>
			<c:choose>
			<c:when test="${param.cat eq 'CAT_001'}">
			<!-- 내용 -->
			<div id="content">
				<strong><h3>내 정보 수정</h3></strong>
				<div class="col-10">"${LOGIN_USER.loginType}" 회원으로 로그인</div>
				<div class="col-2 mt-5" id="nickname"><h3>닉네임</h3></div>
				<div class="col-10">${LOGIN_USER.nickname}</div>
				<div class="row mb-3" id="box-nickname-btn">
					<div class="col-2"><button class="btn btn-outline-secondary" id="btn-show-nickname-form">수정</button></div>
				</div>
				<div class="row mb-3 d-none" id="box-nickname-update">
					<div class="col-6">
						<form action="updateNickname">
							<input type="text" name="nickname" class="form-control" />
							<button type="submit" class="btn btn-primary">수정완료 </button>
							<button type="button" class="btn btn-secondary" id="btn-hide-nickname-form">수정취소 </button> 
						</form>
					</div>
				</div>
				<div class="col-2 mt-5" id="name"><h3>예약자 이름</h3></div>
				<div class="col-10">${LOGIN_USER.name}</div>
				<div class="row mb-3" id="box-name-btn">
					<div class="col-2"><button class="btn btn-outline-secondary" id="btn-show-name-form">수정</button></div>
				</div>
				<div class="row mb-3 d-none" id="box-name-update">
					<div class="col-6">
						<form action="updateName">
							<input type="text" name="name" class="form-control" />
							<button type="submit" class="btn btn-primary">수정완료 </button>
							<button type="button" class="btn btn-secondary" id="btn-hide-name-form">수정취소 </button> 
						</form>
					</div>
				</div>
				<div class="col-2 mt-5" id="tel"><h3>휴대폰 번호</h3></div>
				<div class="col-10">${LOGIN_USER.tel}</div>
				<div class="row mb-3" id="box-tel-btn">
					<div class="col-2"><button class="btn btn-outline-secondary" id="btn-show-tel-form">수정</button></div>
				</div>
				<div class="row mb-3 d-none" id="box-tel-update">
					<div class="col-6">
						<form action="updateTel">
							<input type="text" name="tel" class="form-control" />
							<button type="submit" class="btn btn-primary">수정완료 </button>
							<button type="button" class="btn btn-secondary" id="btn-hide-tel-form">수정취소 </button> 
						</form>
					</div>
				</div>
			</div>						
		</div>
	</div>
</div>
</c:when>
<c:otherwise>
dddd
</c:otherwise>
</c:choose>
<%@ include file="../common/footer.jsp" %>
<script>
$("#btn-show-nickname-form").click(function() {
	$("#box-nickname-update").removeClass('d-none');
	$("#box-nickname-btn").addClass('d-none');
})

$("#btn-hide-nickname-form").click(function() {
	$("#box-nickname-update").addClass('d-none');
	$("#box-nickname-btn").removeClass('d-none');
})

$("#btn-show-name-form").click(function() {
	$("#box-name-update").removeClass('d-none');
	$("#box-name-btn").addClass('d-none');
})

$("#btn-hide-name-form").click(function() {
	$("#box-name-update").addClass('d-none');
	$("#box-name-btn").removeClass('d-none');
})

$("#btn-show-tel-form").click(function() {
	$("#box-tel-update").removeClass('d-none');
	$("#box-tel-btn").addClass('d-none');
})

$("#btn-hide-tel-form").click(function() {
	$("#box-tel-update").addClass('d-none');
	$("#box-tel-btn").removeClass('d-none');
})
</script>
</body>
</html>