<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.card-img {height:200px; object-fit:cover;}
</style>
<title>서울어때</title>
</head>
<body>
<%@ include file="../common/nav.jsp" %>
<div class="row bg-secondary">
	<div class="container" style="min-width:992px; max-width:992px; height:10vh;">
		<h1 class="fs-3 text-white p-2">수정할 숙소 선택 페이지</h1>
	</div>
</div>
<div class="container" style="min-width:992px; max-width:992px;">
	<div class="row mt-5">
		<div class="col-3">
			<!-- 사이드바 -->
			<aside>
				<jsp:include page="../common/adminsidebar.jsp" />
			</aside>
		</div>
		
		<!-- 숙소 검색 폼 -->
		<div class="col-9 p-0">
			<div><h3>수정할 숙소 혹은 객실을 선택하세요.</h3></div>
			<div class="row">
				<div class="card text-white p-0 rounded-0" style="height:200px">
					<img src="/resources/images/acco/thumbnail/${accommodations.thumbnailImageName }" class="card-img rounded-0">
					<div class="card-img-overlay text-end">
						<p class="card-title fs-3 fw-bold">${accommodations.name }</p>
						<p class="card-text fw-bold">${accommodations.address }</p>
						<a class="btn btn-outline-light" href="/admin/modifyAccommodation?id=${accommodations.id }">수정</a>
						<a class="btn btn-outline-light" href="/admin/delete?id=${accommodations.id }">삭제</a>
					</div>
				</div>
				<c:forEach var="accommodationroom" items="${accommodationrooms }">
					<div class="p-0">
						<div class="card text-white p-0 rounded-0" style="height:200px">
							<img src="/resources/images/acco/room/thumbnail/${accommodationroom.thumbnailImageName }" class="card-img rounded-0">
							<div class="card-img-overlay text-end">
								<p class="card-title fs-3 fw-bold">${accommodationroom.name }</p>
								<a class="btn btn-outline-light" href="/admin/modifyAccommodationRoom?no=${accommodationroom.no }">수정</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>	
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">

// 숙소 검색 스크립트
function SubmitBtnClick(){
	$("button[name=submit-keyword]").click();
}

$(document).ready(function(){
    $("button[name=submit-keyword]").click(function(){
    	
		let queryString = $("input[name=search-keyword]").val();
    	let $div = $("#accommodation-box").empty();
		
		// 검색필드에 값이 있는지 체크하기
		let searchValue = $.trim( $("input[name=search-keyword]").val() );
		if (searchValue === "") {
			alert("검색어를 입력해주세요.");
			return false;
		}
	
		// 숙소정보 검색
		$.getJSON("/admin/searchAccommodation", {keyword:queryString}).done(function(accommodations) {
			if (accommodations.length === 0) {
				let content = `
					<div class="col-12">
						<p class="text-center">검색결과가 존재하지 않습니다.</p>
					</div>
				`;
				$div.append(content);
			} else {
				$.each(accommodations, function(index, accommodation) {
					let content = '';
					content += '<div class="card text-white p-0 rounded-0" style="height:200px">';
					content += '	<img src="/resources/images/acco/thumbnail/'+accommodation.thumbnailImageName+'" class="card-img rounded-0">';
					content += '	<div class="card-img-overlay text-end">';
					content += '		<p class="card-title fs-3 fw-bold">'+accommodation.name+'</p>';
					content += '		<p class="card-text fw-bold">'+accommodation.address+'</p>';
					content += '		<a class="btn btn-outline-light" href="/admin/modifyAccommodation?id='+accommodation.id+' ">수정</a>';
					content += '		<a class="btn btn-outline-light" href="/admin/delete?id='+accommodation.id+' ">삭제</button>';
					content += '	</div>';
					content += '</div>';
					
					$div.append(content);
				});
			}
		});
    });
});



</script>
</html>