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
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<div class="col-12">
	<jsp:include page="../common/nav.jsp"></jsp:include>
</div>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<div class="row mb-3">
		<div class="col-8">
			<form action="reservation/complete" method="post" id="form-reserv">
				<div class="my-3">
					<p><strong>예약자 정보</strong></p>
					<label class="form-label" name="reserName">예약자 이름</label>
					<input class="form-control" type="text" placeholder="체크인시 필요한 정보입니다." name="reserName" id="reserName">
				</div>
				<div class="my-3">
					<p class="form-label">휴대폰 번호</p>
					<p class="form-text">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</p>
					<div class="input-group">
						<input type="text" class="form-control" placeholder="체크인시 필요한 정보입니다." name="reserTel" id="reserTel">
						<span class="input-group-btn">
						<button class="btn btn-outline-secondary mx-2" type="button" onclick="phoneCheck()" disabled>인증번호 전송</button>
						</span>
					</div>
				<p id="phoneCheck" class="text-danger"></p>			
				</div>
				<hr>
				<div class="my-5">
					<p><strong>결제수단 선택</strong></p>
					<select class="form-select" id="payType">
						<option value="kakaopay" selected >카카오페이</option>
						<option value="tosspay" >토스</option>
						<option value="payco" >페이코</option>
						<option value="html5_inicis" >이니시스</option>
					</select>	
				</div>
				<div class="form-check">
					<input class="form-check-input" type="checkbox" value="" id="checkboxAll" name='checkboxAll' >
					<label class="form-text" for="checkboxAll">
					 	전체동의
					</label>
				</div>
				<div class="form-check mb-2">
					<input class="form-check-input" type="checkbox" value="" id="checkboxRefundprovision" name=checkbox>
					<label class="form-text" for="checkboxRefund" ><a onclick="openRefundModal()" style="text-decoration: underline; color: gray">
					  숙소이용규칙 및 취소/환불규정 동의</a><strong class="text-danger">(필수)</strong>
					</label>
				</div>
				<div class="form-check mb-2">
					<input class="form-check-input" type="checkbox" value="" id="checkboxInfo1provision" name=checkbox>
					<label class="form-text" for="checkboxInfo1"><a onclick="openinfo1Modal()" style="text-decoration: underline; color: gray">
					  개인정보 수집 및 이용 동의</a><strong class="text-danger">(필수)</strong>
					</label>
				</div>
				<div class="form-check mb-2">
					<input class="form-check-input" type="checkbox" value="" id="checkboxInfo2provision" name=checkbox >
					<label class="form-text" for="checkboxInfo2"><a onclick="openinfo2Modal()"  style="text-decoration: underline; color: gray">
					  개인정보 제 3자 제공 동의</a> <strong class="text-danger">(필수)</strong>
					</label>
				</div>
			</div>
			<div class="col-4 my-3 ">
				<div class="row bg-light">
					<div class="col mx-2">
						<div class="my-5 mx-3">
							<dl>
								<dt id="accoName">${acco.name }
								<dd id="accoType">${room.name } / <span id="days">1박</span>
								<dt class="col-3 form-text">체크인</dt>
								<dd id="checkIn" >${param.checkin } 15:00</dd>
								<dd class="form-text">체크아웃</dd>
								<dd id="checkOut">${param.checkout } 12:00</dd>
							</dl>
							<input type="hidden" id="accoId" name="impUid">
							<input type="hidden" id="accoId" name="merchantUid" >
							
							<input type="hidden" id="accoId" name="accoId" value="${param.id }">
							<input type="hidden" id="roomNo" name="roomNo" value="${param.roomno }">
							<input type="hidden" id="checkIn" name="checkIn" value="${param.checkin }">
							<input type="hidden" id="checkOut" name="checkOut" value="${param.checkout } ">
							<input type="hidden" id="amount" name="amount" value="${room.dayPrice }">
						</div>
					<hr>
					</div>
					<div class="my-3 mx-3">
						<p><strong>총 결제 금액</strong><small>(VAT포함)</small></p>
						<h4><strong class="text-danger" id="dayPrice">${room.dayPrice }</strong></h4>
						<label><small>
							<li class="mx-2">해당 객실가는세금, 봉사료가 포함된 금액입니다.</li>
							<li class="mx-2">결제완료 후 <span class="text-danger">예약자</span> 이름으로 바로 <span class="text-danger">체크인</span> 하시면 됩니다.</li>
						</smail></label>
					</div>						
				</div>
				<div class="row">
					<button type="button" id="modal-button" class="btn btn-danger"> 결제하기</button>
				</div>
			</div>
		</form>
	</div>
</div>
<div class="col-12">
	<jsp:include page="../common/footer.jsp"></jsp:include>
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
						<dt class="form-text mt-3">숙소이름</dt>
						<dd>${acco.name }</dd>
						<dt class="form-text mt-3">객실 타입/기간</dt>
						<dd>${room.name } / 1박</dd>
						<dt class="form-text mt-3">체크인</dt>
						<dd >${param.checkin } 15:00</dd>
						<dt class="form-text mt-3">체크아웃</dt>
						<dd>${param.checkout } 12:00</dd>
					</div>
					<div class="col">
						<ul class="form-text mb-3"><small><strong class="text-danger">당일예약</strong>은 체크인 시간 기준 <strong class="text-danger">3시간 전</strong>까지 취소 가능합니다</small></ul>
						<ul class="form-text"><small><strong class="text-danger">예약 후 15분</strong> 이내 고객행복센터로 취소 요청 시 100% 환불 가능합니다.</small></ul>
					</div>
	      		</div>
	      	</div>
	      	<div class="modal-footer">
	        	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        	<button type="button" class="btn btn-primary" onclick="startPay()">동의후 결제</button>
	      	</div>
   		</div>
 	</div>
</div>
<!-- 환불규정 modal창 -->
<div class="modal fade" id="checkboxRefund" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
		<div class="modal-header">
        	<h5 class="modal-title"><strong>숙소 이용규칙 및 취소/ 환불 규정 (필수)</strong></h5>
      		</div> 
			<div class="modal-body my-3">
			<ol>
			<p><strong>이용 규칙</strong></p>
			<li>최대 인원 초과 시 입실 불가합니다</li>
			<li>정원 기준 요금 외 인원 추가 요금은 현장결제입니다.</li>
			<li>제공 이미지는 배정된 객실과 다를 수 있습니다.</li>
			<li>제공 정보는 숙소의 사정에 따라 변경될 수 있습니다.</li>
			<li>미성년자는 보호자 동반 시 투숙이 가능합니다.</li>
			<li>체크인 시 배정의 경우, 객실과 베드타입을 보장하지 않습니다.</li>
			<li>객실 타입에 시간이 별도 기재된 경우, 체크인/아웃 시간이 상이할 수 있습니다.</li>
			<li>조식, 인원, 침구, 침대 등 추가는 예약하신 <strong class="text-danger">숙소로 요청 및 결제</strong>가 가능합니다.</li>
			<li>업체 현장에서 객실 컨디션 및 서비스로 인해 발생된 분쟁은 서울어때에서 책임지지 않습니다.</li>
			</ol>
			<ol>
			<p><strong>취소/환불규정</strong></p>
			<li>숙소 사정에 의해 취소 발생 시 100% 환불이가능합니다.</li>
			<li>예약 상품 별 숙소 정보에 기재된 취소, 환불규정을 반드시 확인 후 이용해주시기 바랍니다.</li>
			<li>예약 이후의 취소는 취소/환불 규정에 의거하여적용됩니다.</li>
			<li>취소, 변경 불가 상품은 규정과 상관없이 취소,변경이 불가합니다.</li>
			<li>당일 결제를 포함한 체크인 당일 취소는 취소,변경이 불가합니다.</li>
			<li>체크인 시 배정의 경우, 객실과 베드타입을 보장하지 않습니다.</li>
			<li>예약 취소가 불가능한 시간에 고객 사정에 의한 취소 시, 여기어때가 제공하는 모든 혜택에서 제외될 수 있으며 (혜택받기 포인트 미지급, 할인쿠폰 미제공, 이벤트 대상자 제외), 본 예약 시 사용한 쿠폰은 소멸됩니다.</li>
			<li>단! 숙소의 객실 정보가 수시로 변경될 수 있으며 이로 인한 불이익은 여기어때가 책임지지 않습니다.</li>
			</ol>
			</div>
		</div>
	</div>
</div>
<!-- 개인정보 수집동의 modal창 -->
<div class="modal fade" id="checkboxInfo1" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
        		<h5 class="modal-title"><strong>개인정보 수집 및 이용 동의(필수)</strong></h5>
      		</div> 
			<div class="modal-body my-3">
				<table class="table table-hover">
					<thead>
					    <tr>
			      			<th scope="col">구분</th>
					      	<th scope="col">수집/이용 목적</th>
					      	<th scope="col">수집 항목</th>
					      	<th scope="col">보유/이용기간</th>
					    </tr>
				  	</thead>
				  	<tbody>
					    <tr class="table-active">
							<th scope="row">필수</th>
							<td>예약/결제 서비스 이용</td>
							<td>
					      	<ul>
					      		<li>예약서비스이용 : 예약자이름, 휴대폰 번호, CI</li>
					      		<li>결제서비스이용 : (카드 결제 시) 카드사명, 카드번호,유효기간,이메일<br>(휴대폰 결제 시) 휴대폰 번호, 통신사, 결제승인번호<br>서비스이용 : 서비스 이용시간/이용기록, 접수로그, 이용컨텐츠, 접속IP정보, 기기모델명, 브라우저 정보
					      	</ul>
				      		</td>
					      	<td><h6><strong><u>전자상거래 상 소비자 보호에 관한 법률에 따라 5년간 보관</u></strong></h6></td>
					    </tr>
				  	</tbody>
				</table>
				<p>※ 위 동의 내용을 거부하실 수 있으나, 동의를 거부하실 경우 서비스를 이용하실 수 없습니다.</p>
				<p>※ 개인정보 처리와 관련된 상세 내용은 '개인정보처리방침'을 참고</p>
			</div>
		</div>
	</div>
</div>
<!-- 개인정보 제공동의 modal창 -->
<div class="modal fade" id="checkboxInfo2" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
        		<h5 class="modal-title"><strong>개인정보 제 3자 제공 동의(필수)</strong></h5>
      		</div> 
			<div class="modal-body my-3">
				<table class="table table-hover">
					<thead>
					    <tr>
			      			<th scope="col">제공받는 자</th>
					      	<th scope="col">제공 목적</th>
					      	<th scope="col">제공하는 항목</th>
					      	<th scope="col">제공받는 자의 개인정보 보유 및 이용기간</th>
					    </tr>
				  	</thead>
				  	<tbody>
					    <tr class="table-active">
							<td>숙소</td>
							<td>숙박예약서비스 이용 계약 이행(서비스제공,확인,이용자 정보확인)</td>
							<td><small>예약한 숙박서비스의 이용자정보(예약자 이름, 휴대폰번호, 예약번호, 예약한업체명, 예약한 객실명, 결제금액)</small></td>
					      	<td><h6><strong><u>예약서비스 제공 완료후 6개월</u></strong></h6></td>
					    </tr>
				  	</tbody>
				  	<tbody>
					    <tr class="table-active">
							<td>(주)시너츠</td>
							<td>OTA 상품 공급 및 예약관리 / 통지서비스</td>
							<td><small>예약정보 (이름/휴대전화번호)</small></td>
					      	<td><h6><strong><u>예약서비스 제공 완료후 6개월</u></strong></h6></td>
					    </tr>
				  	</tbody>
				</table>
				<p>※ 위 동의 내용을 거부하실 수 있으나, 동의를 거부하실 경우 서비스를 이용하실 수 없습니다.</p>
				<p>※ 개인정보 처리와 관련된 상세 내용은 '개인정보처리방침'을 참고</p>
			</div>
		</div>
	</div>
</div>
</body>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
let reservationConfirm = new bootstrap.Modal(document.getElementById("reservationConfirm"));
let refundModal = new bootstrap.Modal(document.getElementById("checkboxRefund"));
let info1Modal = new bootstrap.Modal(document.getElementById("checkboxInfo1"));
let info2Modal = new bootstrap.Modal(document.getElementById("checkboxInfo2"));

let reserName = document.getElementById("reserName");
let reserTel = document.getElementById("reserTel");

// 필수 규정 모달
function openRefundModal() {
	refundModal.show();
}
function openinfo1Modal() {
	info1Modal.show();
}
function openinfo2Modal() {
	info2Modal.show();	
}

// api 포트번호
var IMP = window.IMP;
IMP.init("imp72261061");

// 아임포트 결제API 사용하기
function startPay(){
	IMP.request_pay({
		pg: $("#payType option:selected").val(), // 셀렉트창에서 pg사를 선택 
	    pay_method: "card", 
		merchant_uid : new Date().getTime(),
		name : '${acco.name}',
		// 숙소명 : accoName.value
		amount : ${room.dayPrice},
		// 가격 : accoPrice.value
		buyer_name : reserName.value,
		buyer_tel : reserTel.value,
		imp_uid : "imp_00"+new Date()
	}, function(rsp) {
		if ( rsp.success ) {
			
				$("input[name=impUid]").val(rsp.imp_uid);
				$("input[name=merchantUid]").val(rsp.merchant_uid);
				$("input[name=amount]").val(rsp.paid_amount);
				
				document.getElementById("form-reserv").submit();
	      } else {
	        alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
	      }
	});
}

// 체크박스 전체 선택
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
	
	
// 필수기입항목 미입력시 오류 모달
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
		reservationConfirm.show();
	});
// 전화번호 유효성체크
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