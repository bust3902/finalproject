<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.0/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
	.list-thumbnail {
		height: 150px;
		object-fit: cover;
	}
	
	.list-overlay {
		background-color: rgba(0, 0, 0, 0.3);
	}
	
	.list-overlay:hover {
		background-color: rgba(255, 255, 255, 0.15);
	}
</style>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<div class="row px-0 pt-5 pb-3">
		<h3>지금 가장 핫한 숙소</h3>
	</div>
	<!-- 검색결과 조회 리스트 -->
	<div id="accos-wrapper" class="row px-3 my-5">
		<!-- TODO: 검색결과, 지역 관련 통계 -->
		<div class="row mb-3">
			<h5 class="fw-bold">통계</h5>
		</div>
		<!-- 숙소 검색결과 -->
		<c:forEach var="acco" items="${bests }">
			<div data-acco-id="${acco.id }" class="card-acco card text-bg-light p-0 rounded-0">
				<img src="/resources/images/acco/thumbnail/${acco.thumbnailImageName }" class="list-thumbnail card-img img-fluid rounded-0" alt="accommodation thumbnail">
				<div class="list-overlay card-img-overlay p-3 rounded-0 text-light d-flex justify-content-between">
					<div class="my-auto">
						<h5 class="fw-semibold"> ${acco.name } </h5>
						<p class="text-warning">
							<span class="badge bg-warning"><fmt:formatNumber value="${acco.reviewRate }" pattern=".0" /></span><strong class="ms-2">${acco.reviewRateKeyword }(${acco.reviewCount })</strong>
						</p>
						<small>${acco.district }</small>
						<!-- TODO: 대표 리뷰 출력? -->
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=258075821638bd633c20115d42be0584"></script>
<script type="text/javascript">
$(function () {
	
	// 카드에 클릭이벤트 연결
	$(".card-acco").click(function() {
		location.href = "detail?id=" + $(this).attr("data-acco-id");
	});
	
});
</script>
</body>
</html>