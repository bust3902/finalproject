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
	#review {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	}
</style>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="review" class="container my-3">
	<div class="row mb-6">
		<div class="col-8">
			<form action="/reviewmodify" method="post" enctype="multipart/form-data">
				<div class="my-3">
					<h4 class="text-center"><strong>리뷰 수정하기</strong></h4>
				</div>
				<div class="my-3">
					<c:if test="${not empty review.restaurant }">
						${review.restaurant.name }
					</c:if>
					<c:if test="${not empty review.acco }">
						${review.acco.name } / ${review.room.name }
					</c:if>
				</div>
				<div class="my-3">
					<p><strong>제목</strong></p>
					<input class="form-control" type="text" name="title" style="width:800px;" value="${review.title }"/>
				</div>
				<div class="my-3">
					<input type="hidden" name="no" value="${review.no }">
				</div>
				<div class="my-3">
					<p><strong>평점</strong></p>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="1" ${review.point eq 1 ? 'checked' : ''}>
						<label class="form-check-label">1점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="2" ${review.point eq 2 ? 'checked' : ''}>
						<label class="form-check-label">2점</label>                         
					</div>                                                                  
					<div class="form-check form-check-inline">                              
						<input class="form-check-input" type="radio" name="point" value="3" ${review.point eq 3 ? 'checked' : ''}>
						<label class="form-check-label">3점</label>                         
					</div>                                                                  
					<div class="form-check form-check-inline">                              
						<input class="form-check-input" type="radio" name="point" value="4" ${review.point eq 4 ? 'checked' : ''}>
						<label class="form-check-label">4점</label>                         
					</div>                                                                  
					<div class="form-check form-check-inline">                              
						<input class="form-check-input" type="radio" name="point" value="5" ${review.point eq 5 ? 'checked' : ''}>
						<label class="form-check-label">5점</label>
					</div>
				</div>
				<div class="my-3">
					<p><strong>이미지변경</strong></p>
					<input type="file" class="form-control" name="imageFile" multiple="multiple" id="image-field" style="width:800px;">
					<c:if test="${not empty review.image }">
						<p class="mt-3">기존 업로드 이미지</p>
						<img class="p-1" style="width:15rem; height:auto;" alt="" src="/resources/images/review/${review.image }">
					</c:if>
				</div>
				<div class="my-3">
					<label type="text-field" class="form-label">내용</label>
					<textarea class="form-control" rows="13" name="content" style="width:800px;">${review.content }</textarea>
				</div>
				<div class="text-end">
					<a href="/" class="btn btn-secondary px-3">취소</a>
					<button type="submit" class="btn btn-primary px-3" id="modal-button" data-bs-target="reviewConfirm">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 리뷰 제목/카테고리/평점/내용을 입력 및 선택하지 않을 시 경고창을 출력하는 모달창 -->
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
<!-- 리뷰 등록 시 확인하는 모달창 -->
<div id="reviewConfirm" class="modal fade" data-bs-backdrop="static">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="text-center">리뷰 등록</h3>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p>작성하신 리뷰를 등록하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary">등록</button>
			</div>
		</div>
	</div>
</div>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
let reviewConfirm = new bootstrap.Modal(document.getElementById("reviewConfirm"));
$(document).ready(function() {
	var reviewModal = new bootstrap.Modal(document.getElementById("modal-danger"))
	$("#modal-button").click(function() {
		if($("input[name=title]").val() === "") {
			$("#modal-message-box").text("제목을 입력해주세요.");
			reviewModal.show();
			return false;
		}
		if($("select[name=category]").val() === "selectCategory") {
			$("#modal-message-box").text("카테고리를 선택해주세요.");
			reviewModal.show();
			return false;
		}
		if($("input[name=point]").is(":checked") === false) {
			$("#modal-message-box").text("평점을 선택해주세요.");
			reviewModal.show();
			return false;
		}
		if($("#textarea[name=content]").val().length <= 10) {
			$("#modal-message-box").text("내용 10자 이상 입력해주세요");
			reviewModal.show();
			return false;
		}
	});
})
</script>
</body>
</html>