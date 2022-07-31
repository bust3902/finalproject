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
					<input class="form-control" type="text" placeholder="체크인시 필요한 정보입니다." name="reserName" >
				</div>
				<div class="my-3">
					<p class="form-label">휴대폰 번호</p>
					<p class="form-text">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</p>
					<div class="input-group">
						<input type="text" class="form-control" placeholder="체크인시 필요한 정보입니다." name="reserTel">
						<span class="input-group-btn">
						<button class="btn btn-outline-secondary mx-2" type="button">인증번호 전송</button>
						</span>
					</div>
				<p id="phoneCheck" class="text-danger"></p>			
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
					<input class="form-check-input" type="checkbox" value="" id="checkboxAll" name="checkboxAll">
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
		<div class="col-4 my-3 ">
			<div class="row bg-light">
				<div class="col mx-2">
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
						<li class="mx-2">해당 객실가는세금, 봉사료가 포함된 금액입니다.</li>
						<li class="mx-2">결제완료 후 <span class="text-danger">예약자</span> 이름으로 바로 <span class="text-danger">체크인</span> 하시면 됩니다.</li>
					</smail></label>
				</div>						
			</div>
			<div class="row">
				<button type="button" id="modal-button" class="btn btn-danger" data-bs-target="#reservationConfirm" > 결제하기</button>
			</div>
		</div>
	</div>
</div>
	<!-- Modal / 필수항목 미입력 / 미입력 -->
<div class="modal fade" id="agreement" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="agreement" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body my-3">
				<!-- 필수입력값 미 입력이 항목이 바뀌어야함. -->
				<p class="text-center" id="modal-message-box">미 입력.</p>
				<div class="d-grid gap-2 col-6 mx-auto">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
</div>
	<!-- Modal / 예약내역 확인 / 확인시 마이페이지 예약내역확인/ 취소시 취소모달창 -->
<div class="modal fade" id="reservationConfirm" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="reservationConfirm" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
      		<div class="modal-header">
        	<h5 class="modal-title" id="staticBackdropLabel">예약내역 확인</h5>
      	</div>
      	<div class="modal-body">
      		<div class="row">
				<div class="col-5">
					<dt>보코 서울 강남</dt>
					<dd>디럭스 싱글 / 1박</dd>	
					
					<dt class="col-3 form-text">체크인</dt>
					<dd>07.28 목 15:00</dd>
						
					<dd class="form-text">체크아웃</dd>	
					<dd>07.29 금 12:00</dd>
				</div>
				<div class="col">
					<ul class="form-text mb-3"><small><strong class="text-danger">당일예약</strong>은 체크인 시간 기준 <strong class="text-danger">3시간 전</strong>까지 취소 가능합니다</small></ul>
					<ul class="form-text"><small><strong class="text-danger">예약 후 15분</strong> 이내 고객행복센터로 취소 요청 시 100% 환불 가능합니다.</small></ul>
				</div>
      		</div>
      	</div>
      	<div class="modal-footer">
        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        	<button type="button" class="btn btn-primary">동의후 결제</button>
      	</div>
   		</div>
 	</div>
</div>
</body>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	$("#checkboxAll").click(function() {
		if($("#checkboxAll").is(":checked")) $("input[name=checkbox]").prop("checked", true);
		else $("input[name=checkbox]").prop("checked", false);
	});
	
	$("input[name=checkbox]").click(function() {
		var total = $("input[name=checkbox]").length;
		var checked = $("input[name=checkbox]:checked").length;
		if(total != checked) $("#checkboxAll").prop("checked", false);
		else $("#checkboxAll").prop("checked", true); 
	});
	
	var paymentModal = new bootstrap.Modal(document.getElementById('agreement'))
	$("#modal-button").click(function(){
		if ($("input[name='reserName']").val() === ""){
			$("#modal-message-box").text("이름을 입력하세요");
			paymentModal.show();
			return false;
		}
		if ($("input[name='reserTel']").val() === ""){
			$("#modal-message-box").text("전화번호를 입력하세요");
			paymentModal.show();
			return false;
		}
		if ($("input[name='checkboxAll']").is(':checked') == false) {
			$("#modal-message-box").text("필수 이용 동의 항목에 동의(체크)해주세요.");
			paymentModal.show();
			return false;
		}
	});
	
	$(function(){
    	$("input[name=reserTel]").on('keydown', function(e){
	       // 숫자만 입력받기
	        var trans_num = $(this).val().replace(/-/gi,'');
			var k = e.keyCode;
		if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) )){
	  	    e.preventDefault();
		}
	    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
	        if($(this).val() == '') return;
	        // 기존 번호에서 - 를 삭제합니다.
	        var trans_num = $(this).val().replace(/-/gi,'');
	        // 입력값이 있을때만 실행합니다.
	        if(trans_num != null && trans_num != '')
	        {
	            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
	            if(trans_num.length==11 || trans_num.length==10){   
	                // 유효성 체크
	                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
	                if(regExp_ctn.test(trans_num)) {
	                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.
	                    trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
	                    $(this).val(trans_num);
	                    $(function(){
	                    $("#phoneCheck").hide();
	                    });
	                }else{
	                    $("#phoneCheck").text("휴대폰 번호를 확인하세요");
	                    $("#phoneCheck").show();
	                    $(this).val("");
	                    $(this).focus();
	                }
				}else{
					$("#phoneCheck").text("휴대폰 번호를 확인하세요");
					$("#phoneCheck").show();
	                $(this).val("");
	                $(this).focus();
	            }
	      }
	  });  
	});
	
});
</script>
</html>