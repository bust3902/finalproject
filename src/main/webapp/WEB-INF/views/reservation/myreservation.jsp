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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<style type="text/css">

</style>
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
			<p class="text"><span class="badge ${payment.paymentStatus eq '예약완료' ? 'bg-danger' : 'bg-info' } mt-3">${payment.paymentStatus }</span></p>
			<h5>${payment.reservation.acco.name }</h5>
			<h6>${payment.reservation.room.name }</h6>
			<dl>
				<dt class="form-text col-3">체크인</dt>
				<dd class="form-text col-7"><fmt:formatDate value="${payment.reservation.checkIn }" pattern="yyyy-MM-dd (E)"/> 15:00 </dd>
				<dt class="form-text col-3">체크아웃</dt>
				<dd class="form-text col-7"><fmt:formatDate value="${payment.reservation.checkOut }" pattern="yyyy-MM-dd (E)"/> 14:00 </dd>
				<dt class="form-text col-3 mt-2">예약번호</dt>
				<dd class="form-text col-7">${param.reservationNo }</dd> <!-- 난수생성 -->
				<dt class="form-text col-3">예약자이름</dt>
				<dd class="form-text col-7">${payment.reservation.reserName }</dd>
				<dt class="form-text col-3">안심번호</dt>
				<dd class="form-text col-7">050440257369</dd> <!-- 형식에 맞는 난수생성 -->
				<dd class="form-text"><i class="bi bi-exclamation-circle"  ></i><small>휴대폰 번호 ${payment.reservation.reserTel }은(는)<p>안심번호로 숙소에 전송되며, 퇴실 후 7일간 보관됩니다. </p></small></dd>
			</dl>
			<hr>
			<div class="row">
				<h5 class="mb-3"><strong>결제정보</strong></h5>
				<dl>
					<dt>총 결제금액</dt>
					<h4 class="text-danger"><strong><fmt:formatNumber>${payment.paymentTotalPrice }</fmt:formatNumber> 원</strong></h4>
				</dl>			
			</div>
			<hr>
			<!--  여기 c:when 달아서 예약완료일때 예약취소 / 예약취소일땐 / disabled 설정하기.
					or 삼항연산자로 그냥 disable 처리하기? 
			 -->
			<c:choose>
				<c:when test="${payment.paymentStatus eq '예약완료' }">
					<div class="row">
						<div class="col">
							<p class="text-danger"><small> * <fmt:formatDate value="${payment.reservation.checkIn }" pattern="yyyy년MM월dd일"/> 전 까지 무료취소 가능합니다.</small></p>
							<div class="row">
								<button type="button" id="modal-button" class="btn btn-danger" onclick="openReservationConfirm()" > 예약취소</button>
							</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="col">
							<div class="row">
								<button type="button" id="modal-button" class="btn btn-success" onclick="location.href='/acco/detail?id=${payment.reservation.acco.id }'" > 재예약</button>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<!-- 취소환불 프로세스 모달창 -->
<div class="modal fade" id="reservationConfirm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="reservationConfirm" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    	<div class="modal-content">
      		<div class="modal-header">
     			<div class="col-1">		
			        <button type="button" class="btn btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      			</div>
        		<h5 class="modal-title" id="staticBackdropLabel">예약내역 확인</p></h5>
      		</div>
      		<div class="modal-body">
				<h5>지금 예약 취소 시</h5>
				<h5>취소 수수료 <strong class="text-danger">0원</strong>이 발생합니다.</h5>
				<div class="row" name="collapseBody">
					<p>
						<a class="text" href="#" role="button" data-bs-toggle="collapse" data-bs-target="#collapse" aria-expanded="true" aria-controls="collapse">원 결제내역 펼치기</a>
					</p>
					<div class="collapse" id="collapse">
						<div class="row mx-2 my-2" style="background: coral; color:white;">
							<h6 class="my-3"><strong style="color:white;">환불 예정 정보</strong></h6>
							<div class="col" >
								<p>결제금액 </p>	
								<p>취소 수수료 발생</p>	
								<p>ㄴ 상품권에서 차감</p>	
								<p>ㄴ 포인트에서 차감</p>	
								<p>ㄴ 현금에서 차감</p>	
							</div>
							<div class="text-end col">
								<p><fmt:formatNumber>${payment.paymentTotalPrice }</fmt:formatNumber>원</p>
								<p>0원</p>
								<p>0원</p>
								<p>0P</p>
								<p>0원</p>
							</div>
							<hr>
							<div class="col-8">
								<p>포인트 환금</p>	
								<p>상품권 환금</p>	
								<p>환불방법</p>	
								<p></p>	
								<p><strong>최종 환불금액</strong></p>	
							</div>
							<div class="text-end col">
								<p>0P</p>
								<p>0원</p>
								<p>카카오페이 환불</p>
								<p><fmt:formatNumber>${payment.paymentTotalPrice }</fmt:formatNumber>원</p>
							</div>
						</div>
		     		</div>
				</div>
				<div class="row m-4" name="reason">
					<h6 class="my-3"><strong>취소사유</strong></h6>
					<!-- 환불이유란 DB에 추가하기 -->
					<select id="reason" class="form-select" aria-label="Default select example">
						<option selected>[필수] 취소 사유를 선택해주세요</option>
						<option value="1">방문불가/여행취소</option>
						<option value="2">타 서비스에서 더 싼 상품발견</option>
						<option value="3">다시예약_같은숙소 일정/객실변경</option>
						<option value="4">다시예약_다른숙소로 변경</option>
						<option value="5">결제수단변경/쿠폰사용</option>
						<option value="6">업체요청</option>
						<option value="7">단순변심</option>
					</select>
					<ul>
						<li><small>취소수수료가 발생한 경우 포인트 -> 상품권 -> 현금 순으로 차감됩니다. 실결제금액에서 현금에서 차감되는 취소수수료를 뺀 금액이 결제수단으로 환불 됩니다.</small></li>
						<li><small>취소수수료는 판매가(상품가격)기준으로 산정 됩니다</small></li>
						<li><small>예약/결제 당시에 적용된 <span class="text-danger">취소/환불 규정</span>에 따라 취소수수료가 계산됩니다.</small></li>
						<li><small>예약/결제 당시에 적용된 예약/결제 시 사용한 포인트는 포인트로, 상품권은 해당 상품권의 잔액으로 복원됩니다. 단, 취소 수수료를 차감한 금액으로 복원될 수 있습니다. 포인트나 상품권 잔액은 취소에 의한 복원 여부에 상관없이 원 유효기간 등에 따라 잔액이 소멸될 수 있으니 주의 바랍니다.</small></li>
						<li><small>결제수단이 휴대폰결제인 경우 취소 시점에 다라 취소수수료가 재승인될 수 있습니다</small></li>
						<li><small>휴대폰 전월 결제 건은 예약취소 후 예약자 본인 명의의 통장으로 환불처리 됩니다.</small></li>
						<li><small>환불은 예약취소후 PG사 승인 취소 기간에 따라 주말, 공휴일을 제외한 영업일 기준 최대 3~5일 소요됩니다.</small></li>
					</ul>
				</div>
			</div>
			<div class="modal-footer">
      			<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-dismiss="modal">닫기</button>
      			<button type="button" class="btn btn-primary" onclick="openCancelModal()">취소진행</button>
			</div>
		</div>
	</div>
</div>
<!-- 취소진행 모달 -->
<div class="modal fade" id="cancelModal"  data-bs-backdrop="static" data-bs-keyboard="false" aria-hidden="true" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
 	 	<div class="modal-content">
    		<div class="modal-body m-2">
				<p>환불 예정금액을 모두 확인하셨나요?</p>
				<p>예약을 정말 취소하시겠습니까 ?</p>
    		</div>
    		<div class="modal-footer">
       			<button type="button" class="btn btn-light" data-bs-toggle="modal" data-bs-dismiss="modal">닫기</button>
       			<button class="btn btn-success" data-bs-target="#cancelconfirmModal" data-bs-toggle="modal">확인</button>
    		</div>
  		</div>
	</div>
</div>
<!-- 취소확인 모달 -->
<div class="modal fade" id="cancelconfirmModal"  data-bs-backdrop="static" data-bs-keyboard="false" aria-hidden="true" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
  		<div class="modal-content">
			<div class="modal-body m-2">
				예약취소 되었습니다.
			</div>
      		<div class="modal-footer">
	      		<form action="/reservation/refund" id="reservationNoForm">
	  				<!-- 환불창으로 정보전달. -->
		        	<a class="btn btn-danger" data-bs-toggle="modal" onclick="reservationNoSubmit()" role="button">확인</a>
					<input type="hidden" id="reservationNo" name="reservationNo" value="${payment.reservation.reservationNo }">
	      		</form>
      		</div>
   		</div>
 	</div>
</div>

    

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous">
</script>
<script type="text/javascript">

let reservationConfirmModal = new bootstrap.Modal(document.getElementById("reservationConfirm"));
let cancelModal = new bootstrap.Modal(document.getElementById("cancelModal"));
let cancelconfirmModal = new bootstrap.Modal(document.getElementById("cancelconfirmModal"));

function openReservationConfirm() {
	reservationConfirmModal.show();
}

function openCancelModal() {
	reservationConfirmModal.hide();
	cancelModal.show();
}

// 툴팁
var collapseElementList = [].slice.call(document.querySelectorAll('.collapse'))
var collapseList = collapseElementList.map(function (collapseEl) {
  return new bootstrap.Collapse(collapseEl)
})

function reservationNoSubmit(){
	document.getElementById('reservationNoForm').submit();
}





</script>
</body>
</html>