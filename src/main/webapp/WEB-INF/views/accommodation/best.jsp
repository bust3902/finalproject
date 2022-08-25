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
<div class="row bg-secondary m-0" style="height:13vh;">
	<div class="px-3 pt-5 pb-3 mx-auto my-auto" style="min-width:992px; max-width:992px;">
		<h3 class="text-white ps-0 mb-3 my-auto">지금 가장 핫한 숙소</h3>
	</div>
</div>
<div class="container my-3" style="min-width:992px; max-width:992px;">
	<!-- 검색결과 조회 리스트 -->
	<div id="accos-wrapper" class="row px-3">
		<!-- 숙소 검색결과 -->
		<div class="row mb-5">
			<c:forEach var="acco" items="${bests }">
				<div class="card-acco card text-bg-light p-0 rounded-0">
					<a href="detail?id=${acco.id }">
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
					</a>
				</div>
			</c:forEach>
		</div>
		<div class="row mb-3 my-auto">
			<!-- 화면에 출력된 인기숙소의 리뷰 최신 상위 5건 조회 -->
			<table class="table table-sm small">
				<colgroup>
					<col width="25%">
					<col width="45%">
					<col width="*">
				</colgroup>
				<tbody>
					<c:forEach var="review" items="${reviews }">
						<tr onclick="location.href='detail?id=${review.acco.id}'" style="cursor: pointer;">
							<td class="text-center">${fn:substring(review.title,0,9)} ${fn:length(review.title) gt 10 ? '...' : '' }</td>
							<td>${fn:substring(review.content,0,34) } ${fn:length(review.content) gt 35 ? '...' : '' }</td>
							<td class="text-end ">${review.acco.name }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
</script>
</body>
</html>