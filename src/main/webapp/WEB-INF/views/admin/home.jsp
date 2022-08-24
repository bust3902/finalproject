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
				<div class="col-4" style="width:32%;">
					<div class="card mb-2" style="height:320px;">
						<div class="card-header bg-secondary text-center">
				           	<span class="text-light">예약 현황</span>
						</div>
						<div class="card-body p-2">
							<div class="bd-highlight text-center text-box">
									<span class="text">입실 예정인 예약자</span><br>
									<span class="text">${fn:length(reservations) } 명</span>
							</div>
						<button type="button" class="btn btn-secondary position-absolute bottom-0 start-50 translate-middle-x mb-2" data-bs-toggle="modal" data-bs-target="#modal-host" onclick="hostClick()">열기</button>
						</div>
					</div>
				</div>
				
				<!-- 매출 현황 출력 -->
				<div class="col-4" style="width:32%;">
					<div class="card mb-2"style="height:320px;">
						<div class="card-header bg-warning text-center">
				           	<span class="text-light">매출 현황</span>
						</div>
						<div class="card-body p-2 text-center">
							<span class="text">주간 매출 그래프</span><br>
							<span class="text">월간 매출 그래프</span><br>
							<span class="text">연간 매출 그래프</span>
						<button type="button" class="btn btn-warning position-absolute bottom-0 start-50 translate-middle-x mb-2" data-bs-toggle="modal" data-bs-target="#modal-accommodation" onclick="accommodationClick()">열기</button>
						</div>
					</div>
				</div>
				
				<!-- 미답변 문의 출력 -->
				<div class="col-4" style="width:32%;">
					<div class="card mb-2"style="height:320px;">
						<div class="card-header bg-info text-center">
				           	<span class="text-light">문의 현황</span>
						</div>
						<div class="card-body p-2">
							<div class="bd-highlight text-center text-box">
								<span class="text">미답변 문의</span><br>
								<span class="text">${fn:length(QAs) } 개</span>
							</div>
						<button type="button" class="btn btn-info position-absolute bottom-0 start-50 translate-middle-x mb-2" data-bs-toggle="modal" data-bs-target="#modal-restaurant" onclick="restaurantClick()">열기</button>
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
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio1">
						<label class="btn btn-outline-success" id="btn-open-host-modal-host" for="btnradio1">예약 현황</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2">
						<label class="btn btn-outline-warning" id="btn-open-accommodation-modal-host" for="btnradio2">매출 현황</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio3">
						<label class="btn btn-outline-info" id="btn-open-restaurant-modal-host" for="btnradio3">문의 현황</label>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
				
					<div class="accordion accordion-flush" id="accordionFlushExample">
						<c:forEach var="reservation" items="${reservations }" varStatus="status">
							
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-${status.index}" aria-expanded="false" aria-controls="flush-collapseOne">
										예약자 : ${reservation.userName }
									</button>
								</h2>
								<div id="flush-collapse-${status.index}" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
							      		<table>
											<colgroup>
												<col width="88%">
												<col width="*%">
											</colgroup>
											<tbody>
													<tr>
														<td>예약번호 : ${reservation.reservationId }<br>
														예약자 : ${reservation.userName }<br>
														숙소명 : ${reservation.accoName }<br>
														입실 예정일 : ${reservation.checkIn }
														</td>
														<td class="align-middle"><button class="btn btn-secondary btn-sm">취소</button></td>
													</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 매출 현황 모달 -->
	<div class="modal fade" id="modal-accommodation" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<div class="btn-group text-center" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio1">
						<label class="btn btn-outline-success" id="btn-open-host-modal-accommodation" for="btnradio1">예약 현황</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2">
						<label class="btn btn-outline-warning" id="btn-open-accommodation-modal-accommodation" for="btnradio2">매출 현황</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio3">
						<label class="btn btn-outline-info" id="btn-open-restaurant-modal-accommodation" for="btnradio3">문의 현황</label>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					
				</div>
				<div class="modal-body">
					
					
					
					<div class="accordion accordion-flush" id="accordionFlushExample">
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingOne">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
									주간 매출 그래프
								</button>
							</h2>
							<div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
								<div class="accordion-body"><div id="weekly_chart_div"></div></div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingTwo">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
									월간 매출 그래프
								</button>
							</h2>
							<div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
								<div id="monthly_chart_div"></div>
							</div>
						</div>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingThree">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
									연간 매출 그래프
								</button>
							</h2>
							<div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
								<div class="accordion-body"><div id="yearly_chart_div"></div></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 문의 현황 모달 -->
	<div class="modal fade" id="modal-restaurant" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
			<div class="modal-content">
				<div class="modal-header d-flex">
					<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
						<input type="radio" class="btn-check" name="btnradio" id="btnradio1">
						<label class="btn btn-outline-success" id="btn-open-host-modal-restaurant" for="btnradio1">예약 현황</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2">
						<label class="btn btn-outline-warning" id="btn-open-accommodation-modal-restaurant" for="btnradio2">매출 현황</label>
					
						<input type="radio" class="btn-check" name="btnradio" id="btnradio3">
						<label class="btn btn-outline-info" id="btn-open-restaurant-modal-restaurant" for="btnradio3">문의 현황</label>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					
				</div>
				<div class="modal-body">
					<div class="accordion accordion-flush" id="accordionFlushExample">
					
						<c:forEach var="QA" items="${QAs }" varStatus="status">
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse-${status.index}" aria-expanded="false" aria-controls="flush-collapseOne">
										문의내용 : ${QA.title }
									</button>
								</h2>
								<div id="flush-collapse-${status.index}" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
							      		<table>
											<colgroup>
												<col width="88%">
												<col width="*%">
											</colgroup>
											<tbody>
												<tr>
													<td>문의번호 : ${QA.no }<br>
													문의고객 : ${QA.userName }<br>
													문의제목 : ${QA.title }<br>
													문의내용 : ${QA.content }
													</td>
												</tr>
												<tr>
													<td>
														<label class="form-label">답글</label>
														<input class="form-control" id="input-add-answer-${QA.no }" type="text" name="qaAnswer" onkeyup="if(window.event.keyCode==13){(qaAnswerInsert(${QA.no }))}">
														<input class="form-control" id="input-add-no-${QA.no }" type="hidden" name="qaNo" value="${QA.no }">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Close</button>
				</div>
			</div>
		</div>
	</div>
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

//구글 그래프 API
$(function() {
	
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawWeeklyChart);
	google.charts.setOnLoadCallback(drawMonthlyChart);
	google.charts.setOnLoadCallback(drawYearlyChart);
	
	// 주간 매출 그래프
	function drawWeeklyChart() {
	
		$.getJSON("/admin/weeklyChartData").done(function(weeklyDataList) {
			//weeklyDataList = [{"salesDate":"19","salesPrice":2109000}, {"salesDate":"20","salesPrice":209000}, {"salesDate":"21","salesPrice":409000}, {"salesDate":"22","salesPrice":709000}]
			
			let array = [];
			array.push(['날짜', "매출액"]);
			$.each(weeklyDataList, function(index, weeklyData) {
				array.push([weeklyData.salesDate, weeklyData.salesPrice]);
			});
			
			var data = google.visualization.arrayToDataTable(array);
		
			var options = {
		    title: '주간 매출',
		    hAxis: {title: '날짜', titleTextStyle: {color: '#333'}},
		    'width':1000,
		    'height':400,
		    vAxis: {title: '매출', minValue: 0}
			};
		
			var chart = new google.visualization.AreaChart(document.getElementById('weekly_chart_div'));
			chart.draw(data, options);
		});
		
	}
	// 월간 매출 그래프
	function drawMonthlyChart() {
	
		$.getJSON("/admin/monthlyChartData").done(function(monthlyDataList) {
			
			let array = [];
			array.push(['날짜', "매출액"]);
			$.each(monthlyDataList, function(index, monthlyData) {
				array.push([monthlyData.salesDate, monthlyData.salesPrice]);
			});
			
			var data = google.visualization.arrayToDataTable(array);
		
			var options = {
				title: '월간 매출',
			    hAxis: {title: '날짜',  titleTextStyle: {color: '#333'}},
			    'width':1000,
			    'height':400,
			    vAxis: {title: '매출', minValue: 0}
			};
		
			var chart = new google.visualization.AreaChart(document.getElementById('monthly_chart_div'));
			chart.draw(data, options);
		});
		
	}
	// 연간 매출 그래프
	function drawYearlyChart() {
	
		$.getJSON("/admin/yearlyChartData").done(function(yearlyDataList) {
			
			let array = [];
			array.push(['날짜', "매출액"]);
			$.each(yearlyDataList, function(index, yearlyData) {
				array.push([yearlyData.salesMonth, yearlyData.salesPrice]);
			});
			
			var data = google.visualization.arrayToDataTable(array);
		
			var options = {
			    title: '연간 매출',
			    hAxis: {title: '월',  titleTextStyle: {color: '#333'}},
			    'width':1000,
			    'height':400,
			    vAxis: {title: '매출', minValue: 0}
			};
		
			var chart = new google.visualization.AreaChart(document.getElementById('yearly_chart_div'));
			chart.draw(data, options);
		});
	}
})

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