<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.0/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- javascript date range picker를 위해 필요한 라이브러리 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<!-- swiper css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
<style type="text/css">
	.profile-image-wrapper {
		width: 70px;
		height: 70px;
		overflow: hidden;
		position: relative;
		background: rgba(0, 0, 0, 0.5);
	}
	
	.profile-image-wrapper img {
		width: 100%;
		position: absolute;
		left: 0;
		top: 50%;
		transform: translateY(-50%);
	}
	
 	#acco-swiper-wrapper .mySwiper2 img {
		width: 100%;
		height: 330px;
		object-fit: cover;
	}

 	.room-swiper-wrapper .mySwiper2 img {
		width: 100%;
		height: 400px;
		object-fit: cover;
	}

</style>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container my-5" style="min-width:992px; max-width:992px;">
	<!-- 숙소 소개 -->
	<div class="row">
		<!-- 숙소 이미지 swiper -->
		<div class="col-6 mb-3 pe-3">
			<div id="acco-swiper-wrapper">
				<div class="swiper mySwiper2 mb-3" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img alt="expanded image" src="/resources/images/sampleacco1.jpg">
						</div>
						<div class="swiper-slide">
							<img alt="expanded image" src="/resources/images/sampleacco2.jpg">
						</div>
						<div class="swiper-slide">
							<img alt="expanded image" src="/resources/images/sampleacco3.jpg">
						</div>
						<div class="swiper-slide">
							<img alt="expanded image" src="/resources/images/logo.png">
						</div>
						<div class="swiper-slide">
							<img alt="expanded image" src="/resources/images/logo.png">
						</div>
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
				<div class="swiper mySwiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img class="img-fluid" alt="accommodation image" src="/resources/images/sampleacco1.jpg" style="cursor: pointer;">
						</div>
						<div class="swiper-slide">
							<img class="img-fluid" alt="accommodation image" src="/resources/images/sampleacco2.jpg" style="cursor: pointer;">
						</div>
						<div class="swiper-slide">
							<img class="img-fluid" alt="accommodation image" src="/resources/images/sampleacco3.jpg" style="cursor: pointer;">
						</div>
						<div class="swiper-slide">
							<img class="img-fluid" alt="accommodation image" src="/resources/images/logo.png" style="cursor: pointer;">
						</div>
						<div class="swiper-slide">
							<img class="img-fluid" alt="accommodation image" src="/resources/images/logo.png" style="cursor: pointer;">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 숙소명, 주소, 한마디 소개
			TO DO : 좋아요 누르면 bi-heart-fill로 변경 -->
		<div class="col-6">
			<h5 class="fw-bold text-dark">
				숙소명 <a href=""><i class="bi bi-heart float-end"></i></a>
			</h5>
			<p class="text-muted">서울특별시 마포구 연남동 382-10</p>
			<div class="bg-light p-3">
				<div class="fw-bold text-dark mb-3">한마디 소개</div>
				<p>
					연남동 거리 중심부에 위치한 BB 홍대는 홍대입구역 도보 3분 거리에 있습니다
					모든 객실에 전용 화장실, 간이 주방, TV를 갖추고 있습니다
					호스텔에서 가까운 도보 거리, 특히 연남동 지역에 수많은 레스토랑과 술집이 모여 있습니다
					연남동에서 편안하게 쉬실 수 있는 호스텔이 되겠습니다!
					감사합니다 ^^
				</p>
			</div>
		</div>
	</div>
	<!-- 상세 정보 탭 -->
	<div class="row">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active text-secondary fw-bold" id="room-tab" data-bs-toggle="tab"
					data-bs-target="#room-tab-pane" type="button" role="tab"
					aria-controls="room-tab-pane" aria-selected="true">객실안내/예약</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link text-muted" id="info-tab" data-bs-toggle="tab"
					data-bs-target="#info-tab-pane" type="button" role="tab"
					aria-controls="info-tab-pane" aria-selected="true">숙소정보</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link text-muted" id="review-tab" data-bs-toggle="tab"
					data-bs-target="#review-tab-pane" type="button" role="tab"
					aria-controls="review-tab-pane" aria-selected="true">리뷰</button>
			</li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<!-- 객실안내/예약 -->
			<div class="tab-pane fade show active" id="room-tab-pane" role="tabpanel" aria-labelledby="room-tab" tabindex="0">
				<div class="py-3">
					<!-- 숙박 일정 선택 : 기본적으로 검색페이지에서 선택한 날짜를 출력, 이 페이지에서 일정을 변경하면 로컬스토리지에 저장돼서 검색 페이지에도 반영된다. -->
					<input type="text" id="datepicker" class="form-control w-50" value="" />
					<input type="hidden" name="startDate" value="">
					<input type="hidden" name="endDate" value="">
				</div>
				<div class="list-wraper mx-0">
					<!-- TO DO: 객실 정보 출력 : 현재 선택한 날짜의 예약 가능 여부를 ajax로 조회해서, 그에 따라 예약버튼 내용 변경  -->
					<div class="card mb-3">
						<div class="card-body row">
							<div class="col-5">
								<img class="room-thumbnail-img img-fluid" alt="room image" src="/resources/images/sampleacco2.jpg">
							</div>
							<div class="col-7 d-flex flex-column justify-content-between">
								<h5 class="fw-bold text-dark">6인 여성 도미토리</h5>
								<div class="pb-3 border-bottom text-dark">
									가격<span class="float-end fw-bold">14,900원</span>
								</div>
								<a href="#link-room-info" class="text-decoration-none text-muted" data-bs-toggle="modal">
									객실 이용 안내
									<i class="bi bi-chevron-right float-end"></i>
								</a>
								<button type="button" class="btn btn-secondary w-100">예약</button>
							</div>
						</div>
						<div class="box-room-detail-img row bg-light m-3 p-5 position-relative d-none">
							<span>
								<i class="icon-close-room-detail-img bi bi-x-lg fs-5 p-3 position-absolute top-0 end-0" style="cursor: pointer;"></i>
							</span>
							<!-- 객실 이미지 wrapper -->
							<div class="room-swiper-wrapper w-75 mx-auto">
								<div class="swiper mySwiper2" style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff">
									<div class="swiper-wrapper">
										<div class="swiper-slide">
											<img alt="expanded image" src="/resources/images/sampleacco1.jpg">
										</div>
										<div class="swiper-slide">
											<img alt="expanded image" src="/resources/images/sampleacco2.jpg">
										</div>
										<div class="swiper-slide">
											<img alt="expanded image" src="/resources/images/sampleacco3.jpg">
										</div>
										<div class="swiper-slide">
											<img alt="expanded image" src="/resources/images/logo.png">
										</div>
										<div class="swiper-slide">
											<img alt="expanded image" src="/resources/images/logo.png">
										</div>
									</div>
									<div class="swiper-button-next"></div>
									<div class="swiper-button-prev"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 숙소정보 -->
			<div class="tab-pane fade" id="info-tab-pane" role="tabpanel" aria-labelledby="info-tab" tabindex="0">
				<div class="accordion accordion-flush" id="accordion-acco-info">
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-headingOne">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
								기본 정보
							</button>
						</h2>
						<div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordion-acco-info">
							<div class="accordion-body bg-light text-muted p-5 m-3 small">
								<!-- DB에 저장되어 있는 HTML컨텐츠 그대로 출력하기 -->
								<strong>오시는 길</strong>
								<ul>
									<li>[홍대입구역에서 오시는 방법]</li>
									<li>홍대입구역 3번출구로 나오셔서 정면 오른쪽 방향에 보이는 공원을 건너가주세요.</li>
									<li>정면으로 100미터 직진하시면 오른쪽편에 핑크색 건물에 I'm PLASTIC이라는 간판이
										보이실거에요</li>
									<li>그 건물 기준 오른쪽 골목길로 50미터 직진하시고 갈림길이 나오시면 왼쪽 골목길로 들어가주세요.
									</li>
									<li>앞으로 조금만 오시다보면 낙랑파라 카페가 보이실거에요. 그 건물 정면에 있는 오른쪽 골목길로
										들어가주세요.</li>
									<li>정면으로 100미터 직진하시면 갈림길이 보이실거에요. GS25 편의점이 있는 건물 기준 왼쪽
										골목길로 가주세요.</li>
									<li>정면으로 50미터 직진하시면 호스텔 도착입니다!!</li>
									<li>네이버,구글지도에 BB홍대를 검색해주세요~</li>
								</ul>
								<strong>주변정보</strong>
								<ul>
									<li>홍대입구역 도보 3분</li>
									<li>연트럴파크 도보 1분</li>
									<li>홍대거리 도보 5분</li>
								</ul>
								<strong>숙소 이용 규칙</strong>
								<ul>
									<li>체크인 : 15시~22시 / 체크아웃 : ~11시</li>
									<li>24시간 출입 자유</li>
									<li>보안을 위하여 투숙객 본인 외에 외부인 동반 출입을 금지합니다</li>
									<li>호스텔 전구역은 금연입니다</li>
									<li>애완동물 출입 금지입니다</li>
									<li>타인에게 피해나 불쾌감을 주는 행위 또는 이용규정을 지키지 않을 경우 강제 퇴실 조치합니다</li>
									<li>시설물을 파손하거나 침구류 훼손 및 오염 (세탁 불가능) 시 전액 배상해야 합니다</li>
									<li>보호자 동반 없는 미성년자 입실 불가 (업체 문의 필수)</li>
								</ul>
								<strong>주차장 정보</strong>
								<ul>
									<li>숙소 앞 무료주차 가능 (업체 문의 필수)</li>
								</ul>
								<strong>취소 및 환불 규정</strong>
								<ul>
									<li>체크인일 기준 7일 전 : 100% 환불</li>
									<li>체크인일 기준 6 ~ 4일 전 : 50% 환불</li>
									<li>체크인일 기준 3일 전 ~ 당일 및 No-Show : 환불 불가</li>
									<li>취소, 환불 시 수수료가 발생할 수 있습니다</li>
								</ul>
								<strong>확인 사항 및 기타</strong>
								<ul>
									<li>외국인 관광객을 위한 전용 게스트하우스입니다</li>
									<li>위의 정보는 게스트하우스 사정에 따라 변경될 수 있습니다</li>
									<li>해당 이미지는 실제와 상이 할 수 있습니다</li>
									<li>예약 확정 이후의 취소는 취소 환불 규정에 의거하여 적용됩니다</li>
								</ul>
								<!-- TO DO : 숙소 정보 중 위도, 경도를 이용하여 해당 숙소의 위치를 지도에 표시하기 -->
								<div id="map-acco-info" class="mx-auto" style="width:800px;height:200px;"></div>
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-headingTwo">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
								편의시설 및 서비스</button>
						</h2>
						<div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordion-acco-info">
							<div class="accordion-body bg-light text-muted p-5 m-3 d-flex flex-wrap">
							<!-- TO DO : DB에서 조회한 공용시설, 객실시설 출력 (아이콘 파일명과 각 시설 DB 컬럼으로 연결시키기)-->
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
								<div class="icon-img-wrapper text-center">
									<img class="w-50" alt="facility icon" src="/resources/images/icons/ic_facility_kitchen_dark_secondary_normal_25px.png"><br/>
									<small class="mx-3">주방/식당</small>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 리뷰 -->
			<div class="tab-pane fade" id="review-tab-pane" role="tabpanel" aria-labelledby="review-tab" tabindex="0">
				<div class="row p-5 text-center border-bottom">
					<h5>추천해요</h5>
					<div class="fs-3 mb-3 text-warning">
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-fill"></i>
						<i class="bi bi-star-half"></i>
						<span class="text-muted mx-1">4.5</span>
					</div>
					<p>전체 리뷰 192</p>
				</div>
				<!-- TO DO : 리뷰 리스트 출력, 페이징 처리 (제목, 작성자, 내용, 좋아요 수, 예약정보, n일전(작성일 이용해서 표시), 사진) 
							추후 여유가 되면 리뷰 태그 기능 추가 ? -->
				<div class="row p-5 border-bottom">
					<div class="col-2 profile-image-wrapper rounded-circle">
						<img class="" alt="user profile" src="/resources/images/logo.png">
					</div>
					<div class="col">
						<strong class="text-dark">조금 아쉬웠지만 이용할만해요.</strong>
						<div class="text-warning">
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-half"></i>
							<span class="text-muted mx-1">4.5</span>
						</div>
						<p class="my-1">
							<small>작성자명</small> /
							<small>6인 여성 도미토리 객실 이용</small><br/>
						</p>
						<p class="text-dark my-3">
							<small>
								일단 게스트하우스라 가격이 저렴한 편이라 좋아요. 홍대 연남동 부근이라 위치가 매우 좋습니다. 핫플 접근성이 좋아요. 4명이 묵을 수 있어서 좋았어요. 단점은 화장실 변기가 조금 흔들려서 무서웠어요. 이불도 좀 많이 얇았습니다.
							</small>
						</p>
						<!-- 첨부파일이 없는 경우 이미지 태그는 출력하지 않음 -->
						<div class="my-3">
							<img alt="review image" src="/resources/images/sampleacco1.jpg">
						</div>
						<small>18일 전</small>
					</div>
				</div>
				<div class="row p-5 border-bottom">
					<div class="col-2 profile-image-wrapper rounded-circle">
						<img class="" alt="user profile" src="/resources/images/logo.png">
					</div>
					<div class="col">
						<strong class="text-dark">조금 아쉬웠지만 이용할만해요.</strong>
						<div class="text-warning">
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-half"></i>
							<span class="text-muted mx-1">4.5</span>
						</div>
						<p class="my-1">
							<small>작성자명</small> /
							<small>6인 여성 도미토리 객실 이용</small><br/>
						</p>
						<p class="text-dark my-3">
							<small>
								일단 게스트하우스라 가격이 저렴한 편이라 좋아요. 홍대 연남동 부근이라 위치가 매우 좋습니다. 핫플 접근성이 좋아요. 4명이 묵을 수 있어서 좋았어요. 단점은 화장실 변기가 조금 흔들려서 무서웠어요. 이불도 좀 많이 얇았습니다.
							</small>
						</p>
						<!-- 첨부파일이 없는 경우 이미지 태그는 출력하지 않음 -->
						<div class="my-3">
							<img alt="review image" src="/resources/images/sampleacco1.jpg">
						</div>
						<small>18일 전</small>
					</div>
				</div>
				<div class="row p-5 border-bottom">
					<div class="col-2 profile-image-wrapper rounded-circle">
						<img class="" alt="user profile" src="/resources/images/logo.png">
					</div>
					<div class="col">
						<strong class="text-dark">조금 아쉬웠지만 이용할만해요.</strong>
						<div class="text-warning">
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-fill"></i>
							<i class="bi bi-star-half"></i>
							<span class="text-muted mx-1">4.5</span>
						</div>
						<p class="my-1">
							<small>작성자명</small> /
							<small>6인 여성 도미토리 객실 이용</small><br/>
						</p>
						<p class="text-dark my-3">
							<small>
								일단 게스트하우스라 가격이 저렴한 편이라 좋아요. 홍대 연남동 부근이라 위치가 매우 좋습니다. 핫플 접근성이 좋아요. 4명이 묵을 수 있어서 좋았어요. 단점은 화장실 변기가 조금 흔들려서 무서웠어요. 이불도 좀 많이 얇았습니다.
							</small>
						</p>
						<!-- 첨부파일이 없는 경우 이미지 태그는 출력하지 않음 -->
						<div class="my-3">
							<img alt="review image" src="/resources/images/sampleacco1.jpg">
						</div>
						<small>18일 전</small>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>

<!-- 객실 정보 모달 -->
<div class="modal fade" id="link-room-info" tabindex="-1" aria-labelledby="roomInfoModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title fw-bold text-dark" id="roomInfoModalLabel">객실 이용 안내</span>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body small">
				<div class="my-3 border-bottom">
					<label class="fw-bold mb-3">기본정보</label>
					<ul>
						<!-- room_name, room_capacity -->
						<li>객실명</li>
						<li>정원 6명</li>
					</ul>
				</div>
				<div class="my-3 border-bottom">
					<label class="fw-bold mb-3">객실소개</label>
					<ul>
						<!-- room_description, 베드타입 정보가 있다면 베드타입도 출력 -->
						<li>객실소개내용</li>
					</ul>
				</div>
				<div class="my-3 border-bottom">
					<label class="fw-bold mb-3">편의시설</label>
					<ul>
						<!-- 현재 객실의 room facilities 모두 조회해서 출력 -->
						<li>전용화장실, 에어컨, 헤어드라이기, 타월, 책상, 화장대, 거울, 옷걸이</li>
					</ul>
				</div>
				<div class="my-3">
					<label class="fw-bold mb-3">선택날짜</label>
					<ul>
						<!-- 현재 사용자가 선택한 날짜를 출력 -->
						<li>08월 01일 ~ 08월 02일</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- kakao map js -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=258075821638bd633c20115d42be0584"></script>
<!-- swiper js -->
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
$(function () {

/*
 * 숙소 이미지 swiper 생성
 * TO DO: 화면 요청 시 출력되는 과정(?) 안보이게 할 수 없나?
 */
	let swiper = new Swiper(".mySwiper", {
		loop : true,
		spaceBetween : 10,
		slidesPerView : 4,
		freeMode : true,
		watchSlidesProgress : true,
	});
	let swiper2 = new Swiper(".mySwiper2", {
		loop : true,
		spaceBetween : 10,
		navigation : {
			nextEl : ".swiper-button-next",
			prevEl : ".swiper-button-prev",
		},
		thumbs : {
			swiper : swiper,
		},
	});

/*
	선택 시 메뉴 스타일 변경하는 이벤트핸들러 등록
 		해당 엘리먼트가 클릭될 때마다 각 버튼 태그의 active 여부에 따라 text-muted 클래스, text-secondary, fw-bold 클래스를 추가/삭제한다.
		(active 클래스에 대한 토글은 부트스트랩 js에서 이미 구현하고 있다)
 */
	let $tabButtons = $('#myTab [data-bs-toggle="tab"]');
	$tabButtons.click(function(){
		$tabButtons.each(function (){
			if ($(this).hasClass('active')) {
				$(this).removeClass('text-muted').addClass('fw-bold').addClass('text-secondary');
			} else {
				$(this).addClass('text-muted').removeClass('fw-bold').removeClass('text-secondary');
			}
		});
	});

/*
	input태그에서 daterangepicker 통해 숙박일정 선택하기
	TO DO : 가능하면 확인 버튼 위치 등 수정
*/
	// 화면 로드 시 날짜 및 기간 초기화
	// * 로컬스토리지에 기존에 조회한 날짜가 저장되어 있으면 그 값을, 없으면 오늘/내일 날짜를 가져온다.
	// * 이 변수의 값이 hidden태그, 로컬스토리지, daterangepicker 에서 관리된다.
	let startDayString = getDateValues().start
	let endDayString = getDateValues().end;
	let duration = 1;
	
	// daterangepicker 생성 설정
    $('#datepicker').daterangepicker({
    	// 직접 커스텀한 문자열을 input태그의 value에 넣기 위해 autoUpdate 해제
    	"autoUpdateInput": false,
    	// 최대 7박까지 예약 가능
		"maxSpan": {
		    "days": 7
		},
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "minDate": moment().format('YYYY-MM-DD'), // 오늘 이전의 날짜는 조회 불가능하다.
        "startDate": startDayString,
        "endDate": endDayString,
        "drops": "down"
    }, function (start, end, label) {
    	// 날짜를 변경한 뒤 적용시키면 실행되는 함수
    	// 화면에 출력할 시작일, 종료일, 기간에 대한 문자열을 값을 변경하고, 변경된 날짜를 hidden태그, localStorage에도 저장한다.
        startDayString = start.format('YYYY-MM-DD');
        endDayString = end.format('YYYY-MM-DD');
        duration = end.diff(start,'days');
        setDateValues(startDayString, endDayString);
        // TO DO : 객실 예약가능 여부 갱신하기
    });

	// html이 출력될 때 datepicker의 input태그의 value 저장
	$('#datepicker').val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박');
	// html이 출력될 때에도 날짜 정보를 hidden 태그와 localStorage에 저장
	setDateValues(startDayString, endDayString);
	
	// 날짜 변경 여부와 무관하게 적용을 누르면 발생하는 이벤트에 함수 등록
	// * input태그의 value 설정 (생성 설정의 날짜변경 이벤트와 다름)
    $('#datepicker').on('apply.daterangepicker', function(ev, picker) {
    	setDateValues(startDayString, endDayString);
    	$(this).val(startDayString + ' ~ ' + endDayString + ' · '  + duration + '박')
    });
    
    // 날짜 정보를 hidden 태그와 localStorage에 저장하는 함수
	// * hidden태그 저장 : 검색조건으로 날짜포맷의 값을 전달하기 위함
    // * localStorage 저장 : 이 페이지를 다시 요청하거나 상세조회 페이지를 요청해도 설정한 날짜가 유지되도록 한다.
    function setDateValues(start, end) {
        $(":hidden[name=startDate]").val(start);
        $(":hidden[name=endDate]").val(end);
        localStorage.setItem("startDate", start);
        localStorage.setItem("endDate", end);
    }
    
    // 초기화할 날짜 정보를 가져오는 함수.
    // localStorage에 값이 있으면 그 값을, 없으면 현재 날짜, 현재 날짜 + 1을 가져온다.
    function getDateValues() {
    	let startvalue = localStorage.getItem("startDate");
    	let endvalue = localStorage.getItem("endDate")
    	let selectedDate = {
   			start : ((typeof startvalue == "undefined" || startvalue == null || startvalue == "") ? moment().format('YYYY-MM-DD') : startvalue),
   			end : ((typeof endvalue == "undefined" || endvalue == null || endvalue == "") ? moment().add(+1, 'd').format('YYYY-MM-DD') : endvalue)
    	};
    	return selectedDate;
    }
	
/*
 * 검색 결과 카카오 openAPI로 지도에 표현하기
 */
	// 지도 정의하기
	let container = document.getElementById('map-acco-info');
	let mapcenter = new kakao.maps.LatLng(37.564214, 127.0016985);
	let options = { //지도를 생성할 때 필요한 기본 옵션
			center: mapcenter, //지도의 중심좌표.
			level: 5 //지도의 레벨(확대, 축소 정도)
	};
	let map = new kakao.maps.Map(container, options); // 지도 생성

	// 아코디언이 열렸을 때 카카오맵 레이아웃과 중심 재설정
	// TO DO : 숙소 위치 표시하기
	$("#flush-collapseOne").on('shown.bs.collapse', function () {
		map.relayout(); 
		map.setCenter(mapcenter);
	});
	
/*
 * 엘리먼트에 대한 사용자 상호작용 이벤트 등록
 */
 	// 객실 이미지 썸네일을 클릭하면 상세이미지 swiper가 출력되고, swiper의 닫기 아이콘을 클릭하면 지워진다. 
	$(".room-thumbnail-img").click(function() {
		$(this).parents(".card").find(".box-room-detail-img").removeClass("d-none");
	});
	$(".icon-close-room-detail-img").click(function() {
		$(this).parents(".box-room-detail-img").addClass("d-none");
	});
})
</script>
</body>
</html>