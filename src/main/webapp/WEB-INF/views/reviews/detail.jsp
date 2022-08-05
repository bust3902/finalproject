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
<title>리뷰작성</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div id="review" class="container my-3">
	<div class="row mb-6">
		<div class="col-8">
			<form action="">
				<div class="my-3">
					<p><strong>리뷰 작성하기</strong></p>
					<label type="title-field" class="form-label">제목</label>
					<input type="text" class="form-control" name="title" id="title-field" placeholder="제목을 작성해주세요.">
				</div>
				<div class="my-3">
					<p><strong>카테고리</strong></p>
					<div class="form-check form-check-inline">
						<select class="form-select" name="category" id="category">
							<option value="selectCategory">카테고리를 선택해주세요.</option>
							<option value="rooms">객실</option>
							<option value="accommodations">숙소</option>
							<option value="restaurant">음식점</option>
						</select>
					</div>
				</div>
				<div class="my-3">
					<p><strong>평점</strong></p>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="point1">
						<label class="form-check-label">1점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="point2">
						<label class="form-check-label">2점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="point3">
						<label class="form-check-label">3점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="point4">
						<label class="form-check-label">4점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="point5">
						<label class="form-check-label">5점</label>
					</div>
				</div>
				<div class="my-3">
					<label type="image-field" class="form-label">사진첨부</label>
					<input type="file" class="form-control" name="imageFile" id="image-field">
				</div>
				<div class="my-3">
					<label type="text-field" class="form-label">내용</label>
					<textarea class="form-control" rows="13" name="content" placeholder="내용을 10자 이상 작성해주세요."></textarea>
				</div>
				<div class="text-end">
					<a href="#" class="btn btn-secondary px-3">취소</a>
					<button type="submit" class="btn btn-primary px-3" id="modal-button" data-bs-target="reviewConfirm">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 리뷰 제목/카테고리/평점/내용을 입력 및 선택하지 않을 시 경고창을 출력하는 모달창 -->
<div id="modal-danger" class="modal fade">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<p class="text-center" id="modal-message-box">미입력</p>
			</div>
		</div>
	</div>
</div>
<!-- 리뷰 등록 시 확인하는 모달창 -->
<div id="reviewConfirm" class="modal fade" >
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
				<button type="button" class="btn btn-primary">등록</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
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