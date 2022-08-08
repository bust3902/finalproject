<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
div.fixed {
  position: fixed;
  bottom: 10%;
  right: 20%;
  width: 20%;
}
</style>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container" style="min-width:992px; max-width:992px;">
	<div class="row mt-5">
		<div class="col-3">
			<!-- 사이드바 -->
			<aside>
				<jsp:include page="../common/adminsidebar.jsp" />
			</aside>
		</div>
		
		<!-- 메인페이지 현황 출력 -->
		<div class="col-9 p-0">
			<div class="row">
				
				<!-- 입점요청자 요약 출력 -->
				<div class="col-4 rounded border-success bg-success d-flex justify-content-center me-2" style="width:32%; height:45vh;">
					<div class="row d-flex flex-column text-center bd-highlight position-relative">
						<div class="m-2 d-flex text-light fs-5">입점 요청 현황</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>

						<button type="button" class="btn btn-link text-decoration-none text-light position-absolute bottom-0 start-50 translate-middle-x" data-bs-toggle="modal" data-bs-target="#modal-host" onclick="hostClick()">열기</button>
					</div>
				</div>
				
				<!-- 입점업체 숙소 신청 요약출력 -->
				<div class="col-4 rounded border-warning bg-warning d-flex justify-content-center me-2" style="width:32%; height:45vh;">
					<div class="row d-flex flex-column text-center bd-highlight position-relative">
						<div class="m-2 d-flex text-light fs-5">숙소 신청 현황</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>

						<button type="button" class="btn btn-link text-decoration-none text-light position-absolute bottom-0 start-50 translate-middle-x" data-bs-toggle="modal" data-bs-target="#modal-accommodation" onclick="accommodationClick()">열기</button>
					</div>
				</div>
				
				<!-- 입점업체 음식점 신청 요약출력 -->
				<div class="col-4 rounded border-info bg-info d-flex justify-content-center" style="width:32%; height:45vh;">
					<div class="row d-flex flex-column text-center bd-highlight position-relative">
						<div class="m-2 d-flex text-light fs-5"> 음식점 신청 현황</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>
						<div class="bd-highlight">사용자:ㅇㅇㅇ 점포명:ㅇㅇㅇ</div>

						<button type="button" class="btn btn-link text-decoration-none text-light position-absolute bottom-0 start-50 translate-middle-x" data-bs-toggle="modal" data-bs-target="#modal-restaurant" onclick="restaurantClick()">열기</button>
					</div>
				</div>
				
				<div class="row mt-2 pe-0">
					<!-- 미답변 문의 요약출력 -->
					<div class="col-5 border rounded border-secondary bg-secondary d-flex justify-content-center me-2" style="height:25vh;">
						<div class="row d-flex flex-column text-center bd-highlight position-relative">
							<div class="text-light fs-5">미답변 문의</div>
							<div class="bd-highlight">문의 제목</div>
							<div class="bd-highlight">문의 제목</div>
							<div class="bd-highlight">문의 제목</div>
							<button type="button" class="btn btn-link text-decoration-none text-light position-absolute bottom-0 start-50 translate-middle-x" data-bs-toggle="modal" data-bs-target="#modal-qa">열기</button>
						</div>
					</div>
					
					<!-- 월간 매출 그래프 -->
					<div class="col border rounded border-secondary bg-secondary" style="height:25vh;">
						<a href="#" class="mb-3 text-decoration-none text-light fs-5">그래프</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 입점요청 상세출력 및 관리 -->
	<div class="modal fade modal-fullscreen" id="modal-host" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen" role="document">
			<div class="modal-content">
				<div class="modal-header d-flex">
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio1">
						<label class="btn btn-outline-success" id="btn-open-host-modal-host" for="btnradio1">입점</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2">
						<label class="btn btn-outline-warning" id="btn-open-accommodation-modal-host" for="btnradio2">숙소</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio3">
						<label class="btn btn-outline-info" id="btn-open-restaurant-modal-host" for="btnradio3">음식점</label>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					
				</div>
				<div class="modal-body">
					Host
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 숙소 등록 요청 상세출력 및 관리 -->
	<div class="modal fade modal-fullscreen" id="modal-accommodation" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen d-flex" role="document">
			<div class="modal-content d-flex justify-content-center">
				<div class="modal-header d-flex justify-content-center">
					<div class="btn-group d-flex justify-content-center text-center" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio1">
						<label class="btn btn-outline-success" id="btn-open-host-modal-accommodation" for="btnradio1">입점</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2">
						<label class="btn btn-outline-warning" id="btn-open-accommodation-modal-accommodation" for="btnradio2">숙소</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio3">
						<label class="btn btn-outline-info" id="btn-open-restaurant-modal-accommodation" for="btnradio3">음식점</label>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					
				</div>
				<div class="modal-body">
					accommodation
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 음식점 등록 요청 상세출력 및 관리 -->
	<div class="modal fade modal-fullscreen" id="modal-restaurant" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen" role="document">
			<div class="modal-content">
				<div class="modal-header d-flex">
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio1">
						<label class="btn btn-outline-success" id="btn-open-host-modal-restaurant" for="btnradio1">입점</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2">
						<label class="btn btn-outline-warning" id="btn-open-accommodation-modal-restaurant" for="btnradio2">숙소</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio3">
						<label class="btn btn-outline-info" id="btn-open-restaurant-modal-restaurant" for="btnradio3">음식점</label>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					
				</div>
				<div class="modal-body">
					restaurant
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 미답변 문의 상세출력 및 댓글형식 답변 -->
	<div class="modal fade modal-fullscreen" id="modal-qa" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen" role="document">
			<div class="modal-content">
				<div class="modal-header d-flex">
					<span class="fw-bold text-center">미답변 문의 리스트</span>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					
				</div>
				<div class="modal-body">
		        ...
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
				</div>
			</div>
		</div>
	</div>
	<div>
		<div class="fixed border border-success border-3 rounded-circle" style="width:57px; height:57px;">
			<a href="#" class=""><img src="/resources/images/headset.svg" alt="Bootstrap" width="50" height="50"></a>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">
// 입점 신청 상세보기 모달 클릭시 모달창 내 입점 버튼 액티브 시키는 스크립트
function hostClick() {
	$(".btn[id=btn-open-host-modal-host]").addClass("active");
	$(".btn[id=btn-open-accommodation-modal-host]").removeClass("active");
	$(".btn[id=btn-open-restaurant-modal-host]").removeClass("active");
}
// 숙소 신청 상세보기 모달 클릭시 모달창 내 숙소 버튼 액티브 시키는 스크립트
function accommodationClick() {
	$(".btn[id=btn-open-accommodation-modal-accommodation]").addClass("active");
	$(".btn[id^=btn-open-host-modal]").removeClass("active");
	$(".btn[id^=btn-open-restaurant-modal]").removeClass("active");
}
// 음식점 신청 상세보기 모달 클릭시 모달창 내 음식점 버튼 액티브 시키는 스크립트
function restaurantClick() {
	$(".btn[id=btn-open-restaurant-modal-restaurant]").addClass("active");
	$(".btn[id^=btn-open-host-modal]").removeClass("active");
	$(".btn[id^=btn-open-accommodation-modal]").removeClass("active");
}

// 모달 내부 이동시 모달창 내 입점/숙소/음식점 버튼 액티브 시키는 스크립트
$(function() {
	let hostModal = new bootstrap.Modal(document.getElementById("modal-host"));
	let accommodationModal = new bootstrap.Modal(document.getElementById("modal-accommodation"));
	let restaurantModal = new bootstrap.Modal(document.getElementById("modal-restaurant"));
	
	//$(".modal-fullscreen").on('hidden.bs.modal', function() {
	//	$(".btn[id^=btn-open-host-modal]").removeClass("active");
	//	$(".btn[id^=btn-open-accommodation-modal]").removeClass("active");
	//	$(".btn[id^=btn-open-restaurant-modal]").removeClass("active");
	//})
	
	$(".btn[id^=btn-open-host-modal]").click(function() {
		accommodationModal.hide();
		restaurantModal.hide();
		hostModal.show();
		
		if (".btn[id^=btn-open-host-modal]") {
			$(".btn[id^=btn-open-host-modal]").addClass("active");
			$(".btn[id^=btn-open-accommodation-modal]").removeClass("active");
			$(".btn[id^=btn-open-restaurant-modal]").removeClass("active");
		}
		
	})
	
	$(".btn[id^=btn-open-accommodation-modal]").click(function() {
		hostModal.hide();
		restaurantModal.hide();
		accommodationModal.show();
		
		if (".btn[id^=btn-open-accommodation-modal]") {
			$(".btn[id^=btn-open-accommodation-modal]").addClass("active");
			$(".btn[id^=btn-open-host-modal]").removeClass("active");
			$(".btn[id^=btn-open-restaurant-modal]").removeClass("active");
		}
	})

	$(".btn[id^=btn-open-restaurant-modal]").click(function() {
		hostModal.hide();
		accommodationModal.hide();
		restaurantModal.show();
		
		if (".btn[id^=btn-open-restaurant-modal]") {
			$(".btn[id^=btn-open-restaurant-modal]").addClass("active");
			$(".btn[id^=btn-open-accommodation-modal]").removeClass("active");
			$(".btn[id^=btn-open-host-modal]").removeClass("active");
		}
	})
	
})

</script>
</html>