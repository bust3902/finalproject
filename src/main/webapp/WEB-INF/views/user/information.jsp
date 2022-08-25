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
<!-- swiper css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
<style>
	#yeseok {
		width: 100%;
/* 		height: 900px; */
		padding: 0;
		margin: 0;
		max-width: inherit;
	}
	
/* 	#title {
		width: 100%;
	}
	
	#title h2 {
		display: block;
		font-size: 28px;
		font-weight: normal;
		letter-spacing: -4px;
    	color: #fff;
		width: 100%;
    	padding: 41px 0px 61px 355px;
    	margin: 0px;
	} */
	
/* 	#yeseok2 {
		padding: 41px 0px 61px 250px;
 		margin: 0px 105px;		 
	} */
	
	#all-content {
		width: 1000px;
	}
	
	#category-box {
		display: block;
    	float: left;
    	width: 180px;
	}	
	
	#content {
    	padding-top: 20px;
    	display: block;
    	position: relative;
    	float: right;
    	width: 800px;
    	margin: auto;
	}
	
	#content #nickname, #name, #tel {
		color: #000000;
		width: 150px;
	}
	
	#box-tel-btn {
		padding-bottom: 50px;
		border-bottom: 1px solid rgba(0,0,0,0.08);
	}
	
	#user {
		width: 824px;		
		margin: 50px -12px 48px -12px;
		border-top: 1px solid rgba(0,0,0,0.08);
	}
	
	.card-img-top {
		height: 150px;
		object-fit: cover;
	}
</style>
<title>내 정보</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="yeseok">
	<div class="row bg-secondary m-0" style="height:13vh;">
		<div class="px-3 pt-5 pb-3 mx-auto my-auto" style="min-width:992px; max-width:992px;">
			<h3 class="text-white ps-0 mb-3">내 정보</h3>
		</div>
	</div>
	<div id="all-content" class="mt-5 mx-auto">
		<!-- 카테고리 리스트 -->	
		<div id="category-box">
			<c:forEach var="category" items="${categories }">
				<a href="information?cat=${category.id }" data-category="${category.id }" class="list-group-item list-group-item-action py-3 ${param.cat eq category.id ? 'active' : '' }"> ${category.name }</a>
			</c:forEach>
		</div>
		<!-- 메뉴 클릭 후 재요청마다 parameter에 따라 다른 내용을 보여준다. -->
		<div id="content">
			<!-- CAT_001 내 정보 수정 -->
			<c:if test="${param.cat eq 'CAT_001'}">
				<strong><h3>내 정보 수정</h3></strong>
				<div class="col-10">"${LOGIN_USER.loginType}" 회원으로 로그인</div>
				<div class="col-2 mt-5" id="nickname"><h3>닉네임</h3></div>
				<div class="col-10">${LOGIN_USER.nickname}</div>
				<div class="row mb-3" id="box-nickname-btn">
					<div class="col-2"><button class="btn btn-outline-secondary" id="btn-show-nickname-form">수정</button></div>
				</div>
				<div class="row mb-3 d-none" id="box-nickname-update">
					<div class="col-6">
						<form id="form-nickname" action="updateNickname">
							<input type="text" name="nickname" class="form-control" />
							<button type="submit" class="btn btn-primary" id="complete">수정완료 </button>
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
						<form id="form-name" action="updateName">
							<input type="text" name="name" class="form-control" />
							<button type="submit" class="btn btn-primary" id="complete">수정완료 </button>
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
						<form id="form-tel" action="updateTel">
							<input type="text" name="tel" class="form-control" />
							<button type="submit" class="btn btn-primary" id="complete">수정완료 </button>
							<button type="button" class="btn btn-secondary" id="btn-hide-tel-form">수정취소 </button> 
						</form>
					</div>
				</div>
				<div class="col mb-5" id="user">
					<div class="col mt-5"><p>서울어때를 이용하고 싶지 않으신가요?</p></div>
					<button type="button" class="btn btn-link"><a href="/logout">로그아웃</a></button>
					<button type="button" class="btn btn-link"><a href="/user/changePassword">비밀번호 변경</a></button>
				</div>
			</c:if>
			<!-- CAT_002 예약 내역 -->
			<c:if test="${param.cat eq 'CAT_002'}">
			<div class="m-3">
				<h5 class="fw-bold pb-3 border-bottom mb-3">숙소내역</h5>
				<div class="row">
					<c:choose >
						<c:when test="${!empty payment }">
							<c:forEach var="payment" items="${payment }" >
								<div class="card col-4 m-2 " >
									<img class="card-img-top mt-1" src="/resources/images/acco/thumbnail/${payment.reservation.acco.thumbnailImageName}"><br>
									<div class="card-body">
										<a href="/myreservation?reservationNo=${payment.reservation.reservationNo}" style="text-decoration: none; color:black;">
											<p class="text-center"><span class="badge  ${payment.paymentStatus eq '예약완료' ? 'bg-danger' : 'bg-info' }">${payment.paymentStatus }</span></p>
											<p class="text-center"><strong>${payment.reservation.acco.name }</strong></p>
											<p class="form-text text-center">체크인 : <fmt:formatDate value="${payment.reservation.checkIn }" pattern="yyyy-MM-dd (E)"/></p>
											<p class="form-text text-center" >체크아웃 : <fmt:formatDate value="${payment.reservation.checkOut }" pattern="yyyy-MM-dd (E)"/></p>
										</a>
									</div>
									<div class="row">
										<button class="btn  ${payment.paymentStatus eq '예약완료' ? 'btn-danger' : 'btn-info disabled'}" type="button" onclick="location.href='/reviewform?accoId=${payment.reservation.acco.id }&roomNo=${payment.reservation.room.no}'">리뷰 작성</button>
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
			<div class="m-3" >
				<h5 class="fw-bold pb-3 border-bottom mb-3">이용내역</h5>
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
										<img class="card-img-top" src="/resources/images/acco/thumbnail/${Readyreservation.reservation.acco.thumbnailImageName}"><br>
										<div class="card-body">
											<a href="/myreservation?reservationNo=${Readyreservation.reservation.reservationNo}"  style="text-decoration: none; color:black;">
												<p class="text-center"><span class="badge ${Readyreservation.paymentStatus eq '예약완료' ? 'bg-danger' : 'bg-info' }">${Readyreservation.paymentStatus }</span></p>
												<p class="text-center"><strong>${Readyreservation.reservation.acco.name }</strong></p>
												<p class="form-text text-center">체크인 : <fmt:formatDate value="${Readyreservation.reservation.checkIn }" pattern="yyyy-MM-dd (E)"/></p>
												<p class="form-text text-center" >체크아웃 : <fmt:formatDate value="${Readyreservation.reservation.checkOut }" pattern="yyyy-MM-dd (E)"/></p>
											</a>
										</div>
									<div class="row">
										<button class="btn  ${Readyreservation.paymentStatus eq '예약완료' ? 'btn-danger' : 'btn-info disabled'}" type="button" href="#">리뷰 작성</button>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="m-3">
				<h5 class="fw-bold pb-3 border-bottom mb-3">취소내역</h5>
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
										<img class="card-img-top" src="/resources/images/acco/thumbnail/${Refundreservation.reservation.acco.thumbnailImageName}"><br>
										<div class="card-body">
											<a href="/myreservation?reservationNo=${Refundreservation.reservation.reservationNo}"  style="text-decoration: none; color:black;">
												<p class="text-center"><span class="badge ${Refundreservation.paymentStatus eq '예약완료' ? 'bg-danger' : 'bg-info' }">${Refundreservation.paymentStatus }</span></p>
												<p class="text-center"><strong>${Refundreservation.reservation.acco.name }</strong></p>
												<p class="form-text text-center">체크인 : <fmt:formatDate value="${Refundreservation.reservation.checkIn }" pattern="yyyy-MM-dd (E)"/></p>
												<p class="form-text text-center" >체크아웃 : <fmt:formatDate value="${Refundreservation.reservation.checkOut }" pattern="yyyy-MM-dd (E)"/></p>
											</a>
										</div>
									<div class="row">
										<button class="btn  ${Refundreservation.paymentStatus eq '예약완료' ? 'btn-danger' : 'btn-info disabled'}" type="button" href="#">리뷰 작성</button>
									</div>
								</div>
								</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			</c:if>
			<!-- CAT_003 내가 찜한 목록 -->
			<c:if test="${param.cat eq 'CAT_003' }">
				<div class="mb-5">
					<h5 class="fw-bold pb-3 border-bottom mb-3">숙소 찜 목록</h5>
					<c:choose>
						<c:when test="${not empty likedAccommodations }">
							<div class="swiper like-acco-swiper" style="--swiper-navigation-color: gray;">
								<div class="swiper-wrapper" style="height: auto;">
									<c:forEach var="item" items="${likedAccommodations }">
										<div id="slide-${item.id }" class="swiper-slide" style="height: auto;">
											<div class="card p-1 h-100" style="max-width: 20rem;">
												<a href="/acco/detail?id=${item.id }">
													<img src="/resources/images/acco/thumbnail/${item.thumbnailImageName }" class="card-img-top" alt="...">
												</a>
												<div class="card-body d-flex flex-column justify-content-between my-auto">
													<div class="row pb-3 border-bottom">
														<div class="d-flex my-auto">
															<a class="text-decoration-none " href="/acco/detail?id=${item.id }">
																<strong class="flex-fill text-dark fw-light small pe-2" style="word-break: keep-all;">${item.name }</strong>
															</a>
															<i class="text-primary fs-5 float-end bi bi-heart-fill" onclick="deleteAccoLike(${item.id});"></i>
														</div>
													</div>
													<div class="row mt-3 mb-0">
														<span class="small text-center">${item.likeCount } 명이 찜한 숙소</span>
														<div class="text-warning text-center small mb-3">
															<i class="bi ${item.reviewRateIcon.star1 }"></i>
															<i class="bi ${item.reviewRateIcon.star2 }"></i>
															<i class="bi ${item.reviewRateIcon.star3 }"></i>
															<i class="bi ${item.reviewRateIcon.star4 }"></i>
															<i class="bi ${item.reviewRateIcon.star5 }"></i></br>
															<span class="badge bg-warning fw-bold">${item.reviewRate }</span>
														</div>
														<!-- 해당 아이디의 숙소 상세페이지로 이동 -->
														<a href="/acco/detail?id=${item.id }" class="btn btn-outline-danger small">예약가능객실 보기</a>
													</div>
												 </div>
											</div>
										</div>
									</c:forEach>
								</div>
								<div class="swiper-button-next acco-swiper-button"></div>
								<div class="swiper-button-prev acco-swiper-button"></div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="text-center py-5">찜한 숙소가 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="mb-5">
					<h5 class="fw-bold pb-3 border-bottom mb-3">맛집 찜 목록</h5>
					<c:choose>
						<c:when test="${not empty likedRestaurants }">
							<div class="swiper like-restaurant-swiper" style="--swiper-navigation-color: gray;">
								<div class="swiper-wrapper" style="height: auto;">
									<c:forEach var="item" items="${likedRestaurants }">
										<div id="slide-${item.no }" class="swiper-slide" style="height: auto;">
											<div class="card p-1 h-100" style="max-width: 20rem;">
												<a href="/restaurant/detail?no=${item.no }">
													<img src="/resources/images/restaurant/thumbnail/${item.imgname }" class="card-img-top" alt="...">
												</a>
												<div class="card-body d-flex flex-column justify-content-between my-auto">
													<div class="row pb-3 border-bottom">
														<div class="d-flex my-auto">
															<a class="text-decoration-none " href="/restaurant/detail?no=${item.no }">
																<strong class="flex-fill text-dark fw-light small pe-2" style="word-break: keep-all;">${item.name }</strong>
															</a>
															<i class="text-primary fs-5 float-end bi bi-heart-fill" onclick="deleteRestaurantLike(${item.no});"></i>
														</div>
													</div>
													<div class="row mt-3 mb-0">
														<span class="small text-center">${item.likeCount } 명이 찜한 식당</span>
														<div class="text-warning text-center small mb-3">
															<i class="bi ${item.reviewRateIcon.star1 }"></i>
															<i class="bi ${item.reviewRateIcon.star2 }"></i>
															<i class="bi ${item.reviewRateIcon.star3 }"></i>
															<i class="bi ${item.reviewRateIcon.star4 }"></i>
															<i class="bi ${item.reviewRateIcon.star5 }"></i></br>
															<span class="badge bg-warning fw-bold">${item.reviewPoint }</span>
														</div>
														<!-- 리뷰폼 페이지로 이동, 식당번호 전달 -->
														<a href="/reviewform?restaurantNo=${item.no }" class="btn btn-outline-danger small">평가하기</a>
													</div>
												 </div>
											</div>
										</div>
									</c:forEach>
								</div>
								<div class="swiper-button-next restaurant-swiper-button"></div>
								<div class="swiper-button-prev restaurant-swiper-button"></div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="text-center py-5">찜한 맛집이 없습니다.</div>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
			<!-- CAT_004 내 리뷰 보기 -->
			<c:if test="${param.cat eq 'CAT_004' }">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
				  <li class="nav-item" role="presentation">
				    <button class="nav-link active" id="acco-tab" data-bs-toggle="tab" data-bs-target="#acco-tab-pane" type="button" role="tab" aria-controls="acco-tab-pane" aria-selected="true">숙소</button>
				  </li>
				  <li class="nav-item" role="presentation">
				    <button class="nav-link" id="restaurant-tab" data-bs-toggle="tab" data-bs-target="#restaurant-tab-pane" type="button" role="tab" aria-controls="restaurant-tab-pane" aria-selected="false">맛집</button>
				  </li>
				</ul>
				<div class="tab-content" id="myTabContent">
				  <div class="tab-pane fade show active" id="acco-tab-pane" role="tabpanel" aria-labelledby="acco-tab" tabindex="0">
					<div class="mb-5" style="min-height: 400px;">
						<table class="table table-sm">
							<colgroup>
								<col width="15%">
								<col width="*">
								<col width="20%">
								<col width="14%">
								<col width="14%">
								<col width="10%">
							</colgroup>
							<tbody>
							<c:choose>
								<c:when test="${not empty accommodationReviews }">
										<tr>
											<th class="p-3 align-middle">장소명</th>
											<th class="p-3 align-middle">리뷰 제목</th>
											<th class="p-3 align-middle">평점</th>
											<th class="p-3 align-middle">등록일</th>
											<th class="p-3 align-middle">최종작성일</th>
											<th></th>
										</tr>
										<c:forEach var="item" items="${accommodationReviews }">
											<tr>
												<td class="p-3 align-middle">
													<a class="text-muted" href="/acco/detail?id=${item.acco.id }">${item.acco.name }</a>
												</td>
												<td class="p-3 align-middle">
													<a class="text-muted" href="/reviewmodify?no=${item.no }">${item.title }</a>
												</td>
												<td class="p-3 align-middle text-warning">
													<i class="${item.pointIcon.star1 }"></i>
													<i class="${item.pointIcon.star2 }"></i>
													<i class="${item.pointIcon.star3 }"></i>
													<i class="${item.pointIcon.star4 }"></i>
													<i class="${item.pointIcon.star5 }"></i>
												</td>
												<td class="p-3 align-middle">
													<fmt:formatDate value="${item.createdDate }" pattern="YYYY.MM.dd"/>
												</td>
												<td class="p-3 align-middle">
													<fmt:formatDate value="${item.updatedDate }" pattern="YYYY.MM.dd"/>
												</td>
												<td class="p-3 align-middle text-end">
													<a href="/reviewdelete?no=${item.no }" class="btn btn-sm btn-secondary">삭제</a>
												</td>
											</tr>
										</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="p-5 border-bottom-0 align-middle text-center">리뷰 정보가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				  <div class="tab-pane fade" id="restaurant-tab-pane" role="tabpanel" aria-labelledby="restaurant-tab" tabindex="0">
					<div class="mb-5" style="min-height: 400px;">
						<table class="table table-sm">
							<colgroup>
								<col width="15%">
								<col width="*">
								<col width="20%">
								<col width="14%">
								<col width="14%">
								<col width="10%">
							</colgroup>
							<tbody>
							<c:choose>
								<c:when test="${not empty restaurantReviews }">
										<tr>
											<th class="p-3 align-middle">장소명</th>
											<th class="p-3 align-middle">리뷰 제목</th>
											<th class="p-3 align-middle">평점</th>
											<th class="p-3 align-middle">등록일</th>
											<th class="p-3 align-middle">최종작성일</th>
											<th></th>
										</tr>
										<c:forEach var="item" items="${restaurantReviews }">
											<tr>
												<td class="p-3 align-middle">
													<a class="text-muted" href="/restaurant/detail?no=${item.restaurant.no }" style="word-break: keep-all; ">${item.restaurant.name }</a>
												</td>
												<td class="p-3 align-middle">
													<a class="text-muted" href="/reviewmodify?no=${item.no}">${item.title }</a>
												</td>
												<td class="p-3 align-middle text-warning">
													<i class="${item.pointIcon.star1 }"></i>
													<i class="${item.pointIcon.star2 }"></i>
													<i class="${item.pointIcon.star3 }"></i>
													<i class="${item.pointIcon.star4 }"></i>
													<i class="${item.pointIcon.star5 }"></i>
												</td>
												<td class="p-3 align-middle">
													<fmt:formatDate value="${item.createdDate }" pattern="YYYY.MM.dd"/>
												</td>
												<td class="p-3 align-middle">
													<fmt:formatDate value="${item.updatedDate }" pattern="YYYY.MM.dd"/>
												</td>
												<td class="p-3 align-middle text-end">
													<a href="/reviewdelete?no=${item.no }" class="btn btn-sm btn-secondary">삭제</a>
												</td>
											</tr>
										</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="p-5 border-bottom-0 align-middle text-center">리뷰 정보가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>		 				
		</c:if>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<!-- swiper js -->
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 취소
	$(".cencle").on("click", function(){
		
		location.href = "/";
				    
	})

	$("#submit").on("click", function(){
		if($("#userPass").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#userPass").focus();
			return false;
		}	
	});	
})

$("#form-nickname").submit(function() {
	let inputValue = $("#form-nickname input[name='nickname']").val();
	if (inputValue.length < 2) {
		alert("2자 이상 입력하세요.");
		return false;
	}

	var nicknameRe = /^[가-힣]{2,6}$/;
    if( !nicknameRe.test( $("#form-nickname input[name='nickname']").val())) {
        alert("닉네임은 한글로 2글자 이상 7글자 미만까지 허용됩니다.");
        return false;
    }
	return true;
});

$("#form-name").submit(function() {
	let inputValue = $("#form-name input[name='name']").val();
	if (inputValue.length < 2) {
		alert("2자 이상 입력하세요.");
		return false;
	}
	var nameRe = /^[가-힣]{2,6}$/;
    if( !nameRe.test( $("#form-name input[name='name']").val())) {
        alert("이름은 한글로 2글자 이상 7글자 미만까지 허용됩니다.");
        return false;
    }
	return true;
});

$("#form-tel").submit(function() {
	let inputValue = $("#form-tel input[name='tel']").val();
	if (inputValue.length < 2) {
		alert("2자 이상 입력하세요.");
		return false;
	}
	var telRe = /^\d{3}-\d{3,4}-\d{4}$/;
    if( !telRe.test( $("#form-tel input[name='tel']").val())) {
        alert("유효한 전화번호 형식이 아닙니다.");
        return false;
    }
	return true;
});

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
	$("#box-name-btn").addClass('d-none')
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

<%--
/**
 * 현재 비밀번호가 맞는지 요청하기
 */
$.ajax({
	type: "POST",
	url: "/user/information",
	headers: {
		"Content-Type": "application/json",
		"X-HTTP-Method-Override": "POST"
	},
	data: password,
	datatype: "json",
	success: function(result) {
		console.log(result);
		
		if(result === "pwContirmOK") {
			$('#pwMsg').html('');
			chk1 = true;
		} else {
			$('#pwMsg').html('');
			chk1 = false;
		}
	},
	error : function(error) {
		console.log("error:" + error)
	}
});

/**
 * 새 비밀번호랑 기존의 비밀번호가 일치하는지 확인
 */
 $('#newPwCheck').on('keyup', function() {
	 if($("#newPwCheck").val() === "") {
		$('#newPwMsg').html('<b>비밀번호 확인은 필수 정보입니다.</b>');
		chk3 = false;
	 } else if($("#newPw").val() != $("#newPwCheck").val()) {
	   $('#newPwMsg').html('<b>비밀번호가 일치하지 않습니다.</b>');
	   chk3 = false;
	 } else {
	   $('#newPwMsg').html('');
	   chk3 = true;
	 }
 });
 
 /**
  * 비밀번호 변경 요청 처리하기
  */
 $('.emailChkBtn').click(function(e) {
	 if(chk1 == false) {
		 alert('현재 비밀번호가 틀렸습니다.');
	 } else if(chk2 ==false) {
		 alert('2번 틀림');
	 } else if(chk2 ==false) {
		 alert('3번 틀림');
	 } else if(chk1 && chk2 && chk3) {
		 const userNo = $('#userNo').val();
		 const password = $('#newPw').val();
		 const email = $('#email').val();
		 const id = $('#id').val();
		 const name = $('#name').val();
		 const user = {
			userNo: userNo,
			id: id,
			password: password,
			email: email,
			name: name
		};
		console.log(user);
		
		$.ajax({
			type: "POST",
			url: "/user/information",
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "POST"
			},
			datatype: "json",
			data: JSON.stringify(user),
			success: function(result) {
				console.log(result);				
				if(result === "changeSuccess") {
					alert('비밀번호가 변경되었습니다.');
					location.href="/user/information";
				} else {
					alert('현재 비밀번호가 틀렸습니다.');
				}
			}
		});
	 } else {
		 alert('입력정보를 다시 확인하세요.');
	 }
 });
 --%>
 
/**
 * 찜 목록에서 하트를 클릭하면, 해당 카드가 화면에서 사라지고 DB정보에서 찜 정보를 삭제시킨다.
 */
 function deleteAccoLike(id) {
	$.getJSON('/changelike/acco', 'accoId=' + id).done(function(result) {
		if (result === true) {
			// ajax로 DB작업이 정상 완료되면 엘리먼트를 삭제
			$("#slide-" + id).remove();
		} else {
			alert("오류가 발생했습니다. 다시 시도해주세요.");
		}
	});
}

 function deleteRestaurantLike(id) {
	$.getJSON('/changelike/restaurant', 'restaurantNo=' + id).done(function(result) {
		if (result === true) {
			// ajax로 DB작업이 정상 완료되면 엘리먼트를 삭제
			$("#slide-" + id).remove();
		} else {
			alert("오류가 발생했습니다. 다시 시도해주세요.");
		}
	});
}

/**
 * 내가 찜한 목록 페이지의 카드 슬라이더 기능을 제공하는 Swiper 객체를 생성한다.
 */
 new Swiper(".like-acco-swiper", {
		loop : false,
		spaceBetween : 10,
		slidesPerView : 4,
		freeMode : true,
		watchSlidesProgress : true,
		navigation : {
			nextEl : ".acco-swiper-button",
			prevEl : ".acco-swiper-button"
		}
	});
	
 new Swiper(".like-restaurant-swiper", {
		loop : false,
		spaceBetween : 10,
		slidesPerView : 4,
		freeMode : true,
		watchSlidesProgress : true,
		navigation : {
			nextEl : ".restaurant-swiper-button",
			prevEl : ".restaurant-swiper-button"
		}
	});

</script>
</body>
</html>