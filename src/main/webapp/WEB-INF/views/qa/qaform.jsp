<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>서울어때</title>
</head>
<style>
	#content {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	}
</style>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="content" class="container my-3">
	<div class="row mb-6">
		<div class="col-10">
			<form method="post" action="qacomplete" enctype="multipart/form-data">
				<div class="alter-top">
					<p class="text-center"><strong>서울어때 이용 중 불편하신 점을 문의해주시면 빠른 시일내에 답변 드리겠습니다.</strong></p>
				</div>
				<div class="my-3">
					<p><strong>제목</strong></p>
					<input class="form-control" name="title" type="text" style="width:800px;height:40px;" placeholder="제목을 작성해주세요."/>
				</div>
				<!-- <div class="my-3">
				<p><strong>카테고리 유형</strong></p>
					<select class="form-select" name="categoryType" id="categoryType" style="width:800px;">
						<option value="1">카테고리 유형을 선택해주세요.</option>
						<option value="rooms">객실</option>
						<option value="accommodations">숙소</option>
						<option value="restaurant">음식점</option>
					</select>
				</div>
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
				</div> -->
				<!-- <div class="account-block container" name="account" id="account" style="display:none;">
					<div class="col-3">
						<p><strong>환불받을 계좌정보 입력</strong></p>
						<select class="form-select" data-account-bank name="accountBank">
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
					<div class="row p-2">
						<input type="text" class="form-control" placeholder="계좌번호를 입력하세요." onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" style="width:300px;">
					</div>
					<div class="row p-2">
						<input type="text" class="form-control" placeholder="예금주를 입력하세요." style="width:300px;">
					</div>
				</div> -->
				<div class="my-3">
					<p><strong>문의 내용</strong></p>
					<textarea class="form-control" style="width:800px;" rows="13" name="content" id="content" placeholder="문의하실 내용을 10자 이상 입력해주세요.
																											  문의하시는 제휴점 이름과 예약정보를 남겨주시면 보다 빠른 상담이 가능합니다.
																											  문의 내용 작성 시 개인정보가 입력되지 않도록 주의 부탁드립니다." ></textarea>
				</div>
				<!-- <div class="form-check mb-2">
					<input class="form-check-input" type="checkbox" id="infoCheckBox" name="checkbox">
					<label class="form-text" for="checkboxInfo"><a onclick="openInfoModal()" style="width:500px; height:300px;">개인정보 수집. 이용동의</a></label>
					<btn class="reviewContent"><strong>[내용보기]</strong></btn>
				</div> -->
				<div class="my-3">
					<p><strong>이미지 첨부</strong></p>
					<input type="file" class="form-control" name="imageFile" style="width:800px;">
				</div>
				<div class="text-center">
					<button id="modal-button" class="btn btn-primary" type="submit" data-bs-target="#completeQa">작성 완료</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<!-- 카테고리 미선택 경고창 출력 팝업 -->
<div id="modal-danger" class="modal fade" >
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p class="text-center" id="modal-message-box">미입력</p>
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
				<button type="submit" class="btn btn-primary">확인</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="infoCheckBoxModal">
	<div class="modal-diolog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<strong class="privacy-title">개인정보 수집·이용에 동의하십니까?</strong>
			</div>
			<div class="modal-body privacy-bill">
				<p id="info-message">(주)서울어때컴퍼니는 '유선답변 및 이메일 답변'을 희망하는 이용자를 대상으로 아래와 같이 개인정보를 수집하고 있습니다. 
				   개인정보 수집/이용에 대한 내용을 확인하고, 동의 여부를 결정하여 주시기 바랍니다.</p>
				<br>
				<ul>
					<li>1. 수집, 개인정보 항목 : (선택)휴대전화번호, 이메일</li>
					<li>2. 수집 및 이용 목적 : 고객상담 및 정보제공</li>
					<li>3. 보유 및 이용기간 : <b>상담완료 후 3년</b></li>
				</ul>
				<br>
				<p>동의를 원하지 않는 경우 수집/이용 동의를 거부할 수 있으며, 동의 거부시에도 1:1 문의 서비스를 이용할 수 있습니다.
				   다만, ‘유선 및 이메일 답변’ 서비스는 불가함을 알려드립니다.</p>
				<br>
				위 내용을 포함하여 개인정보 관련 상세사항은 <strong>'개인정보 처리방침'</strong>을 준수하고 있습니다.
			</div>
			<div class="modal-footer">
				<button type="button" class="btn disagree" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
let infoModal = new bootstrap.Modal(document.getElementById('infoCheckBoxModal'));

function openInfoModal() {
	infoModal.show();
}

$(document).ready(function() {
	// 카테고리/문의 유형을 선택하지 않을 시
	var unselectedTypeModal = new bootstrap.Modal(document.getElementById('modal-danger'));
	$("#modal-button").click(function() {
		if($("input[name=title]").val() === "") {
			$("#modal-message-box").text("제목을 입력해주세요.");
			unselectedTypeModal.show();
			return false;
		}			
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
	
	// 문의사항 유형 -> 환불신청 선택시 은행명, 계좌번호, 예금주 입력창을 보여주는 객체
	$("#qaType").change(function() {
		var result = $("select[name=qaType]").val();
		if (result == "refund") {
			$("#account").show();
		} else {
			$("#account").hide();
		}
	});
})
</script>
</html>