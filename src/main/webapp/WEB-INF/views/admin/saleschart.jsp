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
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<a href="/admin" class="fs-3 text-white text-decoration-none p-2">매출</a>
	</div>
</div>
<div class="container" style="min-width:992px; max-width:992px;">
	<div class="row mt-5">
				
			<!-- 매출 현황 모달 -->

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
		    'width':1100,
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
			    hAxis: {title: '날짜',  titleTextStyle: {color: '#333'}, maxValue: 10},
			    'width':1100,
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
			    'width':1100,
			    'height':400,
			    vAxis: {title: '매출', minValue: 0}
			};
		
			var chart = new google.visualization.AreaChart(document.getElementById('yearly_chart_div'));
			chart.draw(data, options);
		});
	}
})

</script>
</html>