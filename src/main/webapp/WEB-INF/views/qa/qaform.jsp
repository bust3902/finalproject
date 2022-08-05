<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>문의사항 작성</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="content" class="container my-3">
	<div class="row mb-3">
		<div class="col-3">
			<div clss="p-5">
				<ul class="list-group list-group-flush">
					<li class="list-group-item"><a href="#">공지사항</a></li>
					<li class="list-group-item"><a href="#">이벤트</a></li>
					<li class="list-group-item"><a href="#">자주 묻는 질문</a></li>
					<li class="list-group-item"><a href="#">1:1 문의</a></li>
					<li class="list-group-item"><a href="#">약관 및 정책</a></li>
					<li class="list-group-item"><a href="#">채용 약관</a></li>
				</ul>
			</div>
		</div>
		<div class="col">
			<div class="tab">
				<span class="tab-btn active">나의 문의 내역</span>
				<span class="tab-btn">새 문의 작성</span>
			</div>
			<form action="">
				<div class="alter-top">
					<p>서울어때 이용 중 불편하신 점을 문의해주시면 빠른 시일내에 답변 드리겠습니다.</p>
				</div>
				<p><strong>카테고리 유형</strong></p>
				<select class="form-select" name="categoryType" id="categoryType" style="width:800px;">
					<option value="1">카테고리 유형을 선택해주세요.</option>
					<option value="rooms">객실</option>
					<option value="accommodations">숙소</option>
					<option value="restaurant">음식점</option>
				</select>
				<div class="my-3">
					<p><strong>문의 유형</strong></p>
					<select class="form-select" name="qaType" id="qaType" style="width:800px;">
						<option value="1">문의 유형을 선택해주세요.</option>
						<option value="cancle/refund">취소/환불</option>
						<option value="reserve/payment">예약/결제</option>
						<option value="refund">환불신청</option>
						<option value="reserveQa">예약문의</option>
					</select>
				</div>
				<div class="phone-block my-3">
					<p><strong>휴대폰 번호</strong></p>
					<input class="form-control" data-type="phone-number" type="tel" placeholder="선택사항 입니다." style="width:800px;height:40px;">
				</div>
				<div class="email-block my-3">
					<p><strong>이메일</strong></p>
					<input class="form-control" type="text" placeholder="선택사항 입니다." style="width:800px;height:40px;">
				</div>
				<div class="account-block row g-3 my-3" name="account" data-account-select id="account">
					<div class="col md-6">
						<p><strong>환불받을 계좌정보 입력</strong></p>
						<select class="form-select" data-account-bank name="accountBank" style="width:150px;">
							<option value="1">은행 선택</option>
							<option value="2">신한은행</option>
							<option value="3">국민은행</option>
							<option value="4">하나은행</option>
							<option value="5">우리은행</option>
							<option value="6">농협은행</option>
							<option value="7">새마을금고</option>
							<option value="8">카카오뱅크</option>
							<option value="9">부산은행</option>
							<option value="10">신협은행</option>
						</select>
					</div>
					<div class="col p-3">
						<input type="text" class="form-control" placeholder="계좌번호를 입력하세요." style="">
					</div>
					<div class="col p-3">
						<input type="text" class="form-control" placeholder="예금주를 입력하세요.">
					</div>
				</div>
				<div class="my-3">
					<p><strong>문의 내용</strong></p>
					<textarea class="form-control" style="width:800px;" rows="13" name="content" id="content" placeholder="문의하실 내용을 10자 이상 입력해주세요.
																											  문의하시는 제휴점 이름과 예약정보를 남겨주시면 보다 빠른 상담이 가능합니다.
																											  문의 내용 작성 시 개인정보가 입력되지 않도록 주의 부탁드립니다." ></textarea>
				</div>
				<div class="my-3">
					<p><strong>이미지 첨부</strong></p>
					<input type="file" class="form-control" name="image" style="width:800px;">
				</div>
				<div class="text-center">
					<button id="modal-button" class="btn btn-primary" type="button" data-bs-target="#completeQa">작성 완료</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 카테고리 미선택 경고창 출력 팝업 -->
<div id="modal-danger" class="modal fade" >
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p class="text-center" id="modal-message-box">카테고리/문의 유형 선택은 필수입니다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- 문의사항 작성 완료 후 메세지 -->
<div id="completeQa" class="modal fade">
	<div class="modal-diolog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h3>문의사항 작성</h3>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>작성하신 내용을 문의하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary">확인</button>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	// 카테고리/문의 유형을 선택하지 않을 시
	var unselectedTypeModal = new bootstrap.Modal(document.getElementById('modal-danger'))
	$("#modal-button").click(function() {
		if($("select[name=categoryType]").val() === "1") {
			$("#modal-message-box").text("카테고리 선택은 필수입니다.");
			unselectedTypeModal.show();
			return false;
		}
		if($("select[name=qaType]").val() === "1") {
			$("#modal-message-box").text("문의유형 선택은 필수입니다.");
			unselectedTypeModal.show();
			return false;
		}
		if($("textarea[name=content]").val().length <= 10) {
			$("#modal-message-box").text("내용을 10자 이상 입력해주세요.");
			unselectedTypeModal.show();
			return false;
		}
	});
})
</script>
</html>