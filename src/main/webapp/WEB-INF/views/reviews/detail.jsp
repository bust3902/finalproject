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
	<div class="container my-3">
		<div class="row mb-3">
			<div class="col-8">
				<form action="">
					<div class="my-3">
						<p><strong>리뷰 작성하기</strong></p>
						<label type="title-field" class="form-label">제목</label>
						<input type="text" class="form-control" name="title" id="title-field">
					</div>
					<div class="my-3">
						<label type="category-field" class="form-label">카테고리</label>
						<div class="form-check form-check-inline">
							<select name="category" style="width:800px;height:30px;">
								<option value="rooms">객실</option>
								<option value="accommodations">숙소</option>
								<option value="restaurant">음식점</option>
							</select>
						</div>
					</div>
					<div class="my-3">
						<p>평점</p>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="1점" value="point">
							<label class="form-check-label">1점</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="2점" value="point">
							<label class="form-check-label">2점</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="3점" value="point">
							<label class="form-check-label">3점</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="4점" value="point">
							<label class="form-check-label">4점</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="5점" value="point">
							<label class="form-check-label">5점</label>
						</div>
					</div>
					<div class="my-3">
						<label type="image-field" class="form-label">사진첨부</label>
						<input type="file" class="form-control" name="imageFile" id="image-field">
					</div>
					<div class="my-3">
						<label type="text-field" class="form-label">리뷰</label>
						<textarea class="form-control" rows="13" name="content"></textarea>
					</div>
					<div class="text-end">
						<a href="#" class="btn btn-secondary px-3">취소</a>
						<button type="submit" class="btn btn-primary px-3">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>