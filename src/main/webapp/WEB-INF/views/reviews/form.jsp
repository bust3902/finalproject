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
			<form action="/reviewcomplete" method="post" enctype="multipart/form-data">
				<div class="my-3">
					<h4 class="text-center"><strong>리뷰 작성하기</strong></h4>
				</div>
				<div class="my-3">
					<c:if test="${not empty param.restaurantNo }">
						${restaurantName }
					</c:if>
					<c:if test="${not empty param.accoId }">
						${roomName.accoName } / ${roomName.name }
					</c:if>
				</div>
				<div class="my-3">
					<p><strong>제목</strong></p>
					<input class="form-control" type="text" name="title" style="width:800px;" placeholder="제목을 작성해주세요."/>
				</div>
				<div class="my-3">
					<c:if test="${not empty param.restaurantNo }">
						<input type="hidden" name="restaurantNo" value="${param.restaurantNo }">
					</c:if>
					<c:if test="${not empty param.accoId }">
						<input type="hidden" name="accoId" value="${param.accoId }">
					</c:if>
					<c:if test="${not empty param.roomNo }">
						<input type="hidden" name="roomNo" value="${param.roomNo }">
					</c:if>
				</div>
				<div class="my-3">
					<p><strong>평점</strong></p>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="1">
						<label class="form-check-label">1점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="2">
						<label class="form-check-label">2점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="3">
						<label class="form-check-label">3점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="4">
						<label class="form-check-label">4점</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="point" value="5">
						<label class="form-check-label">5점</label>
					</div>
				</div>
				<div class="my-3">
					<label type="image-field" class="form-label">이미지첨부</label>
					<input type="file" class="form-control" name="imageFile" multiple="multiple" id="image-field" style="width:800px;">
				</div>
				<div class="my-3">
					<label type="text-field" class="form-label">내용</label>
					<textarea class="form-control" rows="13" name="content" placeholder="내용을 5자 이상 작성해주세요." style="width:800px;" minlengh="5"></textarea>
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
	});
})
</script>
</body>
</html>