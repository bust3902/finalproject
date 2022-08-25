<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
span.text {
	font-weight:bold;
	font-size:14px;
}
div.text-box {

	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden
}
</style>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<h1 class="fs-3 text-white p-2">관리자 홈</h1>
	</div>
</div>
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
				
				<!-- 오늘의 예약 현황 출력 -->
				<div class="col-6" style="width:48%;">
					<div class="card mb-2" style="height:320px;">
						<div class="card-header bg-secondary text-center">
				           	<span class="text-light">예약 현황</span>
						</div>
						<div class="card-body p-2">
							<div class="bd-highlight text-center text-box" id="reservation-Preview">
								<span class="text">입실 예정인 예약자</span><br>
								<span class="text">${fn:length(reservations) } 명</span>
							</div>
						<button type="button" class="btn btn-secondary position-absolute bottom-0 start-50 translate-middle-x mb-2" data-bs-toggle="modal" data-bs-target="#modal-host" id="loading-reservation">열기</button>
						</div>
					</div>
				</div>
				<!-- 미답변 문의 출력 -->
				<div class="col-6" style="width:48%;">
					<div class="card mb-2"style="height:320px;">
						<div class="card-header bg-info text-center">
				           	<span class="text-light">문의 현황</span>
						</div>
						<div class="card-body p-2">
							<div class="bd-highlight text-center text-box" id="qa-Preview">
								<span class="text">미답변 문의</span><br>
								<span class="text">${fn:length(QAs) } 개</span>
							</div>
						<button type="button" class="btn btn-info position-absolute bottom-0 start-50 translate-middle-x mb-2" data-bs-toggle="modal" data-bs-target="#modal-restaurant" id="loading-qa">열기</button>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
	
	<!-- 예약 현황 모달 -->
	<div class="modal fade" id="modal-host" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
			<div class="modal-content">
				<div class="modal-header">
				예약 현황
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="accordion accordion-flush" id="accordionFlushExample">
						<div id="reservation-Content"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close" id="btn-reservation-qa">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 문의 현황 모달 -->
	<div class="modal fade" id="modal-restaurant" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
			<div class="modal-content">
				<div class="modal-header d-flex">
					문의 현황
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="accordion accordion-flush" id="accordionFlushExample">
						<div id="qa-Content"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close" id="btn-close-qa">Close</button>
				</div>
			</div>
		</div>
	</div>
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

// 예약 현황 출력
$('#loading-reservation').click(function() {
	$.getJSON("/admin/searchReservationAdmin").done(function(reservations) {

		let $reservationPreview = $("#reservation-Preview").empty();
		let $reservationContent = $("#reservation-Content").empty();
		
		if (reservations.length === 0) {
			let content = `
				<div class="col-12">
					<p class="text-center">검색결과가 존재하지 않습니다.</p>
				</div>
			`;
			$reservationContent.append(content);
		} else {
			$.each(reservations, function(index, reservation) {
				
				let content = '';
				
				content += '<div class="accordion-item">';
				content += '	<h2 class="accordion-header" id="flush-headingOne">';
				content += '		<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-'+index+'" aria-expanded="false" aria-controls="flush-collapseOne">';
				content += '			예약자 : '+reservation.userName+'';
				content += '		</button>';
				content += '	</h2>';
				content += '	<div id="flush-collapse-'+index+'" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">';
				content += '		<div class="accordion-body">';
				content += '      		<table>';
				content += '				<colgroup>';
				content += '					<col width="88%">';
				content += '					<col width="*%">';
				content += '				</colgroup>';
				content += '				<tbody>';
				content += '						<tr>';
				content += '							<td>예약번호 : '+reservation.reservationId+'<br>';
				content += '							예약자 : '+reservation.userName+'<br>';
				content += '							숙소명 : '+reservation.accoName+'<br>';
				content += '							입실 예정일 : '+reservation.checkIn+'';
				content += '							</td>';
				content += '							<td class="align-middle"><button class="btn btn-secondary btn-sm" id="del-reservation-'+reservation.reservationId+'" onclick="cancelUserReservation('+reservation.reservationId+')">취소</button></td>';
				content += '						</tr>';
				content += '				</tbody>';
				content += '			</table>';
				content += '		</div>';
				content += '	</div>';
				content += '</div>';
				
				$reservationContent.append(content);
			});
		}

		let preview = '';
		
		preview += '<span class="text">입실 예정인 예약자</span><br>';
		preview += '<span class="text">'+reservations.length+' 명</span>';

		$reservationPreview.append(preview);
	});
})

// 문의 현황 출력
$('#loading-qa').click(function() {
	$.getJSON("/admin/searchQaAdmin").done(function(qas) {

		let $qaPreview = $("#qa-Preview").empty();
		let $qaContent = $("#qa-Content").empty();
		
		if (qas.length === 0) {
			let content = `
				<div class="col-12">
					<p class="text-center">검색결과가 존재하지 않습니다.</p>
				</div>
			`;
			$qaContent.append(content);
		} else {
			$.each(qas, function(index, qa) {
				
				let qaContent = '';
				
				qaContent += '<div class="accordion-item">';
				qaContent += '<h2 class="accordion-header" id="flush-headingOne">';
				qaContent += '	<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-'+index+'" aria-expanded="false" aria-controls="flush-collapseOne">';
				qaContent += '		문의내용 : '+qa.title+'';
				qaContent += '	</button>';
				qaContent += '</h2>';
				qaContent += '<div id="flush-collapse-'+index+'" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">';
				qaContent += '	<div class="accordion-body">';
				qaContent += '  		<table>';
				qaContent += '			<colgroup>';
				qaContent += '				<col width="88%">';
				qaContent += '				<col width="*%">';
				qaContent += '			</colgroup>';
				qaContent += '			<tbody>';
				qaContent += '				<tr>';
				qaContent += '					<td>문의번호 : '+qa.no+'<br>';
				qaContent += '					문의고객 : '+qa.userName+'<br>';
				qaContent += '					문의제목 : '+qa.title+'<br>';
				qaContent += '					문의내용 : '+qa.content+'';
				qaContent += '					</td>';
				qaContent += '				</tr>';
				qaContent += '				<tr>';
				qaContent += '					<td>';
				qaContent += '						<label class="form-label">답글</label>';
				qaContent += '						<input class="form-control" id="input-add-answer-'+qa.no+'" type="text" name="qaAnswer" onkeyup="if(window.event.keyCode==13){(qaAnswerInsert('+qa.no+'))}">';
				qaContent += '						<input class="form-control" id="input-add-no-'+qa.no+'" type="hidden" name="qaNo" value="'+qa.no+'">';
				qaContent += '						</td>';
				qaContent += '					</tr>';
				qaContent += '				</tbody>';
				qaContent += '			</table>';
				qaContent += '		</div>';
				qaContent += '	</div>';
				qaContent += '</div>';

				$qaContent.append(qaContent);
			});
		}

		let qaPreview = '';
		
		qaPreview += '<span class="text">미답변 문의</span><br>';
		qaPreview += '<span class="text">'+qas.length+' 개</span>';

		$qaPreview.append(qaPreview);
	});
})
		
//관리자 게시판에서 사용자 예약을 강제 취소시키기 위한 스크립트
function cancelUserReservation(reserId) {

	$.ajax({
		url : "/admin/deleteReservationByAdmin",
		type : "post",
		data : {
			reservationId : reserId
		}
	});
}

// 문의 답변 작성을 위한 스크립트
function qaAnswerInsert(no) {
	let qaAnswerData = $('#input-add-answer-'+no).val();
	let qaNoData = $('#input-add-no-'+no).val();
	// console.log(qaAnswer);
	// console.log(qaNo);
	
	$.ajax({
		url : "/admin/insertQaAnswer",
		type : "post",
		data : {
			qaAnswer : qaAnswerData,
			qaNo : qaNoData,
		}
	});
}
</script>
</html>