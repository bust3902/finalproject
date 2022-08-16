<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>서울어때</title>
	<style>
	.ck.ck-editor {
    	max-width: 800px;
	}
	.ck-editor__editable {
	    min-height: 300px;
	}
	</style>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<h1 class="fs-3 text-white p-2">숙소 등록</h1>
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
			<form id="form-accommodation-room" class="col p-3" method="post" action="accommodation3-room" enctype="multipart/form-data">

				<!-- 정보 입력 폼 -->
				<div class="row mt-5 p-0">
					<div class="col-6 mb-3">
						<label class="form-label">객실명</label>
						<input class="form-control " type="text" name="name">
					</div>
					<div class="col-6 mb-3">
						<label class="form-label">총 객실 수</label>
						<input class="form-control " type="text" name="numbers">
					</div>
					<div class="col-6 mb-3">
						<label class="form-label">최대 숙박 인원</label>
						<input class="form-control " type="text" name="capacity">
					</div>
					<div class="col-6 mb-3">
						<label class="form-label">1박 기본 요금</label>
						<input class="form-control " type="text" name="dayPrice">
					</div>
				</div>
				
				<!-- 객실 소개(null허용) -->
				<div class="mb-3">
					<label class="form-label">객실 소개</label>
					<input class="form-control " type="text" name="description">
				</div>
	
				<!-- 객실 시설 선택 체크박스 -->
				<div class="mb-5">
					<label class="form-label">객실 시설 정보</label>
					<div>
						<c:forEach var="rofacility" items="${rofacilities }">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="stringRoomFacilities" value="${rofacility.id }">
							<label class="form-check-label" >${rofacility.name }</label>
						</div>
						</c:forEach>			
					</div>
				</div>
				
				<!-- 객실 메인 이미지 업로드 폼 -->
				<div class="mb-5">
					<label class="form-label">객실 메인 이미지</label>
					<input class="form-control w-50" type="file" name="thumbnailImageFile" >
				</div>
				
				<!-- 객실 디테일 이미지 업로드 폼 -->
				<div class="mb-5">
					<label class="form-label">상세 이미지(여러장 등록 가능)</label>
					<input class="form-control w-50" multiple="multiple" type="file" name="detailImageFiles" >
				</div>
				
				<!-- 
				객실 타입 저장버튼
				<div class="text-end mt-5">
					<button type="button" class="btn btn-secondary px-5" id="btn-add-room">객실 타입 저장</button>
				</div>
				
				<div id="save-room">${accommodationRegisterForm}</div>

				완료
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5">다음</button>
				</div>
				 -->

				<!-- 객실 타입 저장버튼 -->
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5">객실 타입 저장</button>
				</div>
				
				<!-- 입력된 방 갯수 출력 -->
				<div id="save-room">저장된 객실 유형 : ${rooms }실</div>
				
				<!-- 완료 -->
				<div class="text-end mt-5">
					<button type="button" class="btn btn-secondary px-5" onclick="inputCompleted()">입력 완료</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
// 객실 추가 버튼
$("#btn-add-room").click(function() {
	// 객실수 필드에 값이 있는지 체크하기
	let numbersValue = $.trim( $(":input[name=numbers]").val() );
	if (numbersValue === "") {
		alert("객실수를 입력해주세요.");
		return false;
	}
	
	// 최대 숙박 인원 필드에 값이 있는지 체크하기
	let capacityCommentValue = $.trim( $(":input[name=capacity]").val() );
	if (capacityCommentValue === "") {
		alert("최대 숙박 가능 인원을 입력해주세요.");
		return false;
	}
	
	// 1박 기본 요금 필드에 값이 있는지 체크하기
	let dayPriceCommentValue = $.trim( $(":input[name=dayPrice]").val() );
	if (dayPriceCommentValue === "") {
		alert("1일 기본 요금을 입력해주세요.");
		return false;
	}
	
	let checkedRoomFacilities = document.querySelectorAll('input[name=roomFacilities]:checked').length;
	if (checkedRoomFacilities < 1) {
		alert("객실 시설 정보를 1개 이상 선택해주세요.");
		return false;
	}
	
	// 객실 메인 이미지가 설정되어있는지 체크하기
	let thumbnailImageNameValue = $.trim( $(":file[name=thumbnailImageName]").val() );
	if (thumbnailImageNameValue === "") {
		alert("객실 메인 이미지를 첨부해주세요");
		return false;
	}
	
	// 객실 상세 이미지가 설정되어있는지 체크하기
	let detailImageNameValue = $.trim( $(":file[name=detailImageNames]").val() );
	if (detailImageNameValue === "") {
		alert("객실 상세 이미지를 첨부해주세요");
		return false;
	}
	
});

function inputCompleted(){
	let inputCompleted = document.createElement('form');
	inputCompleted.setAttribute('method', 'post');
	inputCompleted.setAttribute('action', '/admin/insert');
	document.body.appendChild(inputCompleted);
	inputCompleted.submit();
}
</script>
</body>
</html>