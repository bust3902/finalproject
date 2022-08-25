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
		<a href="/admin" class="fs-3 text-white text-decoration-none p-2">객실 수정</a>
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
			<form id="form-accommodation-room" class="col p-3" method="post" action="roommodifycompleted" enctype="multipart/form-data">

				<!-- 정보 수정 폼 -->
				<div class="row mt-5 p-0">
				<c:forEach var="accommodationRoom" items="${accommodationRooms }">
					<div class="col-6 mb-3">
						<label class="form-label">객실명</label>
						<input class="form-control" type="text" name="name" value="${accommodationRoom.name}">
					</div>
					<div class="col-6 mb-3">
						<label class="form-label">총 객실 수</label>
						<input class="form-control" type="text" name="numbers" value="${accommodationRoom.numbers}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
					</div>
					<div class="col-6 mb-3">
						<label class="form-label">최대 숙박 인원</label>
						<input class="form-control" type="text" name="capacity" value="${accommodationRoom.capacity}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
					</div>
					<div class="col-6 mb-3">
						<label class="form-label">1박 기본 요금</label>
						<input class="form-control" type="text" name="dayPrice" value="${accommodationRoom.dayPrice}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
					</div>
					<div class="mb-3">
						<label class="form-label">객실 소개</label>
						<input class="form-control " type="text" name="description" value="${accommodationRoom.description}">
					</div>
						<input class="form-control " type="hidden" name="no" value="${accommodationRoom.no}">
				</c:forEach>
				</div>
	
				<!-- 객실 시설 선택 체크박스 -->
				<div class="mb-5">
					<label class="form-label">객실 시설 정보</label>
					<div>
						<c:forEach var="rofacility" items="${rofacilities }">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="stringRoomFacilities" value="${rofacility.id }"
										<c:forEach var="roomFacility" items="${roomFacilities }">
											<c:if test="${rofacility.id eq roomFacility}">
												checked
											</c:if>
										</c:forEach>
							>
							<label class="form-check-label" >${rofacility.name }</label>
						</div>
						</c:forEach>			
					</div>
				</div>
				
				<!-- 객실 메인 이미지 업로드 폼 -->
				<div class="mb-5 visually-hidden" id="div-mainimage">
					<label class="form-label">객실 메인 이미지</label>
					<input class="form-control w-50" type="file" name="thumbnailImageFile" id="main-photo-add">
				</div>
				<c:forEach var="accommodationRoom" items="${accommodationRooms }">
				<div class="row">
					<div class="col-lg-12">
						<div class="card mb-4">
							<div class="card-header">
				            	<span>첨부 이미지</span>
							</div>
				         	<div class="card-body">
				         		<div class="row">
				            		<div class="col-4 d-grid main-gallery">
										<img src="/resources/images/acco/room/thumbnail/${accommodationRoom.thumbnailImageName}" class="card-img main-image">
										<button type="button" class="btn btn-sm btn-secondary main-image-btn mt-1" onclick="deleteMainImage()">삭제</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				
				<!-- 객실 상세 이미지 수정 폼 -->
				<div class="mb-3">
					<label class="form-label">상세 이미지(여러장 등록 가능)</label>
					<input class="form-control w-50" multiple="multiple" type="file" name="detailImageFiles" id="detail-photo-add">
				</div>
				<div class="row">
					<div class="col-lg-12">
						<div class="card mb-4">
							<div class="card-header">
				            	<span>첨부 이미지</span>
							</div>
				         	<div class="card-body">
				         		<div class="row detail-gallery">
									<c:forEach var="roomImage" items="${roomImages }" varStatus="status">
				            			<div class="col-4 d-grid" id="img-box-${status.index}">
					            			<img src="/resources/images/acco/room/detail/${roomImage}" class="card-img" style="height:150px;">
				            				<button type="button" class="btn btn-sm btn-secondary mt-1 mb-3" onclick="detailImageDelete('${status.index}', '${roomImage}')">삭제</button>
										</div>
									</c:forEach>
				         		</div>
				      		</div>
						</div>
					</div>
				</div>
				
				<!-- submit -->
				<div class="text-end mt-5">
					<button type="submit" class="btn btn-secondary px-5" id="btn-modify-room">입력 완료</button>
				</div>
				
			</form>
		</div>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>
<script>

	// 수정화면에서 메인이미지 삭제 버튼 클릭시 이미지를 화면에서 지워주기 위한 스크립트
	function deleteMainImage() {
		$("#div-mainimage").removeClass("visually-hidden");
		$(".main-image").addClass("visually-hidden");
		$(".main-image-btn").addClass("visually-hidden");
	}
	// 메인이미지 삭제 후 다른이미지 업로드 시 화면에 출력시켜주는 코드
	$('#main-photo-add').on('change', function() {
	
		let input = $("#main-photo-add");
		let ImagePreview = $(".main-gallery");
	    var imagesPreview = function(input, ImagePreview) {
	    	$(".main-gallery img").remove();
	        if (input.files != null) {
	        	var filesAmount = input.files.length;
	
	        	for (i = 0; i < filesAmount; i++) {
	         	var reader = new FileReader();
	         		
	             reader.onload = function(event) {
	                 $($.parseHTML('<img>')).attr('src', event.target.result).attr('class', "card-img main-img").appendTo(ImagePreview);
	             }
	
	             reader.readAsDataURL(input.files[i]);
	        	}
	        }
	    };
	    imagesPreview(this, ImagePreview);
	});
    
    // 버튼 클릭시 상세이미지 화면에서 감추는 스크립트
    function detailImageDelete(ImgNum, imgFileName) {
    	// alert(ImgNum);
    	// alert(imgFileName);
    	let $gallery = $(".detail-gallery");
    	$('#img-box-' + ImgNum).addClass("visually-hidden");
		
    	let hiddenContent = '<input type="hidden" name="deleteDetailImageNames" value="'+imgFileName+'" />'
		$gallery.append(hiddenContent);
    }
    // 상세이미지 삭제 후 다른이미지 업로드 시 화면에 출력시켜주는 코드
    $('#detail-photo-add').on('change', function() {

		let inputDetail = $("#detail-photo-add");
		let detailImagePreview = $(".detail-gallery");
		let $DIP = detailImagePreview;
		
        var detailImagesPreview = function(inputDetail, detailImagePreview) {
            if (inputDetail.files) {
            	var detailFilesAmount = inputDetail.files.length;

            	for (i = 0; i < detailFilesAmount; i++) {
             	var detailImgReader = new FileReader();
             		
             	detailImgReader.onload = function(event) {

					let spanContent = '';
					
					spanContent += '<div class="col-4 mb-3">';
					spanContent += '<img src="'+event.target.result+'" class="card-img d-grid" style="height:150px;">';
					spanContent += '</div>';
         			
					$DIP.append(spanContent);
                }

             	detailImgReader.readAsDataURL(inputDetail.files[i]);
            	}
            }
        };
        detailImagesPreview(this, detailImagePreview);
    });

    
    // 인풋 텍스트 서밋 방지
    $('input[type="text"]').keydown(function() {
    	if (event.keyCode === 13) {
    		event.preventDefault();
    	};
    });

 // 객실 추가 버튼
 $("#btn-modify-room").click(function() {
 	// 객실수 필드에 값이 있는지 체크하기
 	let numbersValue = $.trim( $(":input[name=numbers]").val() );
 	if (numbersValue === "") {
 		alert("객실수를 입력해주세요.");
 		return false;
 	}
 	if (numbersValue > 500) {
 		alert("500호실 이상 입력하실 수 없습니다.");
 		return false;
 	}
 	
 	// 최대 숙박 인원 필드에 값이 있는지 체크하기
 	let capacityCommentValue = $.trim( $(":input[name=capacity]").val() );
 	if (capacityCommentValue === "") {
 		alert("최대 숙박 가능 인원을 입력해주세요.");
 		return false;
 	}
 	if (capacityCommentValue > 20) {
 		alert("20인 이상 입력하실 수 없습니다.");
 		return false;
 	}
 	
 	// 1박 기본 요금 필드에 값이 있는지 체크하기
 	let dayPriceCommentValue = $.trim( $(":input[name=dayPrice]").val() );
 	if (dayPriceCommentValue === "") {
 		alert("1일 기본 요금을 입력해주세요.");
 		return false;
 	}
 	
 	// 객실 시설정보가 체크되었는지 확인하기
 	let checkedRoomFacilities = document.querySelectorAll('input[name=roomFacilities]:checked').length;
 	if (checkedRoomFacilities < 1) {
 		alert("객실 시설 정보를 1개 이상 선택해주세요.");
 		return false;
 	}
 	
 });
</script>
</body>
</html>