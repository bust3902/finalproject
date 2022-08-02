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

<style type="text/css">

</style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col">
			<button type="button" id="modal-button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#reservationConfirm" > 결제하기</button>
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
						<p>60000원</p>
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
						<p>60000원</p>
					</div>
				</div>
     		</div>
		</div>
      	<div class="row">
        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        	<button type="button" class="btn btn-primary">취소진행</button>
      	</div>
   		</div>
 	</div>
</div>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">

// 툴팁
var collapseElementList = [].slice.call(document.querySelectorAll('.collapse'))
var collapseList = collapseElementList.map(function (collapseEl) {
  return new bootstrap.Collapse(collapseEl)
})
</script>
</body>
</html>