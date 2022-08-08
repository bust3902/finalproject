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
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<h1 class="fs-3 text-white p-2">음식점 등록</h1>
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
			
				<!-- DB에서 지역 꺼내와서 c:forEach로 출력 -->
				<div class="mb-3">
					<label class="form-label">지역</label>
					<div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="cityId" value="서울">
							<label class="form-check-label" >지역</label>
						</div>					
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="cityId" value="서울">
							<label class="form-check-label" >지역</label>
						</div>					
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="cityId" value="서울">
							<label class="form-check-label" >지역</label>
						</div>					
					</div>
				</div>
				
				<!-- DB에서 카테고리 꺼내와서 c:forEach로 출력 -->
				<div class="mb-5">
					<label class="form-label">카테고리</label>
					<div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="RestaurantCategory" value="categories">
							<label class="form-check-label" >카테고리</label>
						</div>					
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="RestaurantCategory" value="categories">
							<label class="form-check-label" >카테고리</label>
						</div>					
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="checkbox" name="RestaurantCategory" value="categories">
							<label class="form-check-label" >카테고리</label>
						</div>					
					</div>
				</div>
				
				<!-- 정보 입력 폼 -->
				<div class="mb-3">
					<label class="form-label">음식점명</label>
					<input class="form-control " type="text" name="name">
				</div>
				<div class="mb-3">
					<label class="form-label">전화번호</label>
					<input class="form-control " type="text" name="tel">
				</div>
				<div class="mb-3">
					<label class="form-label">운영시간</label>
					<input class="form-control " type="text" name="opening">
				</div>
				<div class="mb-3">
					<label class="form-label">휴식시간</label>
					<input class="form-control " type="text" name="breakTime">
				</div>
				<div class="mb-3">
					<label class="form-label">휴무일</label>
					<input class="form-control " type="text" name="close">
				</div>
				
				<!-- 음식점 대표 사진 업로드 폼 -->
				<div class="mb-5">
					<label class="form-label">대표 이미지</label>
					<input class="form-control w-50" type="file" name="imgfile" >
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
<script type="text/javascript">

</script>
</body>
</html>