<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Time Picker -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">

<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<a href="/admin" class="fs-3 text-white text-decoration-none p-2">음식점 등록</a>
	</div>
</div>
<div class="container mt-5" style="min-width:992px; max-width:992px;">
	<div class="row mb-3 px-3">
	
		<!-- 사이드바 -->
		<div class="col-3 border rounded">
			<div class="mt-3">
				<aside>
					<jsp:include page="../common/adminsidebar.jsp" />
				</aside>
			</div>
		</div>
		
		<div class="col-9 bg-white">
			<form id="form-restaurant" class="col p-3" method="post" action="restaurant2" enctype="multipart/form-data">
			
				<!-- 지역(CITIES 테이블) 선택 폼 -->
				<div class="mb-3">
					<label class="form-label">지역</label>
					<div>
						<select class="form-select" name="cityId" aria-label="select box cities" id="select-cities">
							<option selected value="">지역을 선택해주세요</option>
							<option></option>
							<c:forEach var="city" items="${cities }">
								<option value="${city.id }">${city.name }</option>
							</c:forEach>
						</select>			
					</div>
				</div>
				
				<!-- 레스토랑 카테고리 폼 -->
				<div class="mb-5 mt-5">
					<label class="form-label">카테고리</label>
					<div>
						<c:forEach var="category" items="${categories }">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="categories" value="${category.id }">
							<label class="form-check-label me-5">${category.name }</label>
						</div>
						</c:forEach>
					</div>
				</div>
				
				<!-- 정보 입력 폼 -->
				<div class="row">
					<div class="mb-3 col-6">
						<label class="form-label">음식점명</label>
						<input class="form-control" type="text" name="name">
					</div>
					<div class="mb-3 col-6">
						<label class="form-label">전화번호</label>
						<input class="form-control" type="text" name="tel">
					</div>
				</div>
				<div class="row">
					<div class="mb-3 col-6">
						<label class="form-label">개점시간</label>
						<input class="form-control timepicker opening" name="openTime" type="text">
					</div>
					<div class="mb-3 col-6">
						<label class="form-label">폐점시간</label>
						<input class="form-control timepicker opening" name="closeTime" type="text">
						
						<input class="form-control" type="hidden" name="opening" id="opening-box">
					</div>
				</div>
				<div class="row">
					<div class="mb-3 col-6">
						<label class="form-label">브레이크타임 시작 시간</label>
						<input class="form-control breaktimepicker" type="text" name="breakTimeStart">
					</div>
					<div class="mb-3 col-6">
						<label class="form-label">브레이크타임 종료 시간</label>
						<input class="form-control breaktimepicker" type="text" name="breakTimeEnd">
						
						<input class="form-control" type="hidden" name="breakTime" id="breakTime-box">
					</div>
				</div>
				<div class="row mt-5">
					<div class="mb-3 col-12">
						<label class="form-label">휴무일</label>
						<input class="form-control " type="text" name="close">
					</div>
				</div>
				
				<!-- 음식점 대표 사진 업로드 폼 -->
				<div class="row mb-5 mt-5">
					<div class="col-6">
						<label class="form-label">대표 이미지</label>
						<input class="form-control" type="file" name="imgfile" >
					</div>
				</div>

				<!-- 음식점 입력폼2로 -->
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5">다음</button>
				</div>				
			</form>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#form-restaurant").submit(function() {
		
		// 지역 셀렉트박스가 설정되어있는지 체크하기
		let citiesValue = $("#select-cities option:selected").val();
		if (citiesValue === "") {
			alert("지역을 선택해주세요.");
			return false;
		}

		// 카테고리 체크박스가 체크되어있는지 확인하기
		let categoriesFieldLength = $(":input[name=categories]:checked").length;
		if (categoriesFieldLength < 1) {
			alert("카테고리를 선택해주세요.");
			return false;
		}
		
		// 음식점필드에 값이 있는지 체크하기
		let nameValue = $.trim( $(":input[name=name]").val() );
		if (nameValue === "") {
			alert("음식점명을 입력해주세요.");
			return false;
		}
		
		// 전화번호 필드에 값이 있는지 체크하기
		let telValue = $.trim( $(":input[name=tel]").val() );
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		if (regPhone.test(telValue) === false) {
			alert("휴대폰 번호 형식에 맞춰 입력해주세요.");
			return false;
		}

		// 개점시간 필드에 값이 있는지 체크하기
		let openingValue = $.trim( $(":input[name=openTime]").val() );
		if (openingValue === "") {
			alert("개점시간을 입력해주세요.");
			return false;
		}
		// 브레이크타임 필드에 값이 있는지 체크하기
		// let breakTimeValue = $.trim( $(":input[name=breakTime]").val() );
		// if (breakTimeValue === "") {
		//	alert("브레이크타임을 입력해주세요.");
		//	return false;
		//}
		
		// 폐점시간 필드에 값이 있는지 체크하기
		let closeValue = $.trim( $(":input[name=closeTime]").val() );
		if (closeValue === "") {
			alert("폐점시간을 입력해주세요.");
			return false;
		}
		
		// 숙소 메인 이미지가 설정되어있는지 체크하기
		let imgfileValue = $.trim( $(":file[name=imgfile]").val() );
		if (imgfileValue === "") {
			alert("음식점 이미지를 첨부해주세요");
			return false;
		}
		
		// 영업시간 데이터 저장
		// let $box = $("#opening-box");
		let $openTime = $(":input[name=openTime]");
		let $closeTime = $(":input[name=closeTime]");
		
		let open = $openTime.val();
		let close = $closeTime.val();

		let $data = $(":input[name=opening]").val(open+'-'+close);
		let data = $(":input[name=opening]").val();
		// alert(data);
		
		// 브레이크타임 데이터 저장
		// let $breakBox = $("#breakTime-box");
		let $startTime = $(":input[name=breakTimeStart]");
		let $endTime = $(":input[name=breakTimeEnd]");
		
		let start = $startTime.val();
		let end = $endTime.val();

		let $breakData = $(":input[name=breakTime]").val(start+'-'+end);
		let breakData = $(":input[name=breakTime]").val();
		// alert(breakData);
	});
})

// jQuery TimePicker
$('.timepicker').timepicker({
    timeFormat: 'a h시:mm분',
    interval: 30,
    minTime: '24',
    maxTime: '11:00pm',
    defaultTime: '',
    startTime: '01:00am',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});

// jQuery TimePicker
$('.breaktimepicker').timepicker({
    timeFormat: 'a h시',
    interval: 30,
    minTime: '24',
    maxTime: '11:00pm',
    defaultTime: '',
    startTime: '01:00am',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});

// 인풋 텍스트 서밋 방지
$('input[type="text"]').keydown(function() {
	if (event.keyCode === 13) {
		event.preventDefault();
	};
});
</script>
</body>
</html>