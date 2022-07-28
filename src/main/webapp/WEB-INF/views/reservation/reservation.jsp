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
</head>
<body>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<div class="row mb-3">
		<div class="col-8">
			<form action="">
				<div class="my-3">
					<p><strong>예약자 정보</strong></p>
					<label class="form-label">예약자 이름</label>
					<input class="form-control" type="text" placeholder="체크인시 필요한 정보입니다.">
				</div>
				<div class="my-3">
					<p class="form-label">휴대폰 번호</p>
					<p class="form-text">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</p>
				<div class="input-group">
					<input type="text" class="form-control" placeholder="체크인시 필요한 정보입니다.">
					<span class="input-group-btn">
					<button class="btn btn-outline-secondary mx-2" type="button">인증번호 전송</button>
					</span>
				</div>
					<div id="emailHelp" type="text" class="form-text"><p class="text-danger">휴대폰 번호를 확인해주세요.<p></div>					
				</div>
				<hr>
				<div class="my-5">
					<p><strong>결제수단 선택</strong></p>
					<select class="form-select">
						<option value="kakaopay" selected >카카오페이</option>
						<option value="toss" >토스</option>
					</select>	
				</div>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" value="" id="checkbox_All" name="checkbox_All">
					<label class="form-text" for="checkbox_All">
					 	전체동의
					</label>
				</div>
				<div class="form-check mb-2">
					<input class="form-check-input" type="checkbox" value="" id="checkbox_refund" name="checkbox">
					<label class="form-text" for="checkbox_refund" ><a  href="#" style="text-decoration: underline; color: gray">
					  숙소이용규칙 및 취소/환불규정 동의</a><strong class="text-danger">(필수)</strong>
					</label>
				</div>
				<div class="form-check mb-2">
					<input class="form-check-input" type="checkbox" value="" id="checkbox_info1" name="checkbox">
					<label class="form-text" for="checkbox_info1"><a  href="#" style="text-decoration: underline; color: gray">
					  개인정보 수집 및 이용 동의</a><strong class="text-danger">(필수)</strong>
					</label>
				</div>
				<div class="form-check mb-2">
					<input class="form-check-input" type="checkbox" value="" id="checkbox_info2" name="checkbox">
					<label class="form-text" for="checkbox_info2"><a  href="#" style="text-decoration: underline; color: gray">
					  개인정보 제 3자 제공 동의</a> <strong class="text-danger">(필수)</strong>
					</label>
				</div>
			</form>
		</div>
		<div class="col-4 my-3">
			<div class="row bg-light">
				<div class="col">
					<div class="my-5 mx-3">
						<dl>
							<dt class="form-text mt-3">숙소이름</dt>
							<dd>보코 서울 강남</dd>
							<dt class="form-text mt-3">객실 타입/기간</dt>
							<dd>디럭스 싱글 / 1박</dd>
							<dt class="form-text mt-3">체크인</dt>
							<dd >07.28 목 15:00</dd>
							<dt class="form-text mt-3">체크아웃</dt>
							<dd>07.29 금 12:00</dd>
						</dl>
					</div>
				<hr>
				</div>
				<div class="my-3 mx-3">
					<p><strong>총 결제 금액</strong><small>(VAT포함)</small></p>
					<h4><strong class="text-danger">99000원</strong></h4>
					<label><small>
						<li>해당 객실가는세금, 봉사료가 포함된 금액입니다.</li>
						<li>결제완료 후 <span class="text-danger">예약자</span> 이름으로 바로 <span class="text-danger">체크인</span> 하시면 됩니다.</li>
					</smail></label>
				</div>						
			</div>
			<div class="row">
				<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop"> 결제하기</button>
			</div>
		</div>
	</div>
</div>
	<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body my-3">
				<!-- 필수입력값 미 입력이 항목이 바뀌어야함. -->
				<p class="text-center">필수 이용 동의 항목에 동의(체크)해주세요.</p>
				<div class="d-grid gap-2 col-6 mx-auto">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">

$(document).ready(function() {
	$("#checkbox_All").click(function() {
		if($("#checkbox_All").is(":checked")) $("input[name=checkbox]").prop("checked", true);
		else $("input[name=checkbox]").prop("checked", false);
	});
	
	$("input[name=checkbox]").click(function() {
		var total = $("input[name=checkbox]").length;
		var checked = $("input[name=checkbox]:checked").length;
		
		if(total != checked) $("#checkbox_All").prop("checked", false);
		else $("#checkbox_All").prop("checked", true); 
	});
});
</script>
</html>