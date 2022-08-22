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
		<h1 class="fs-3 text-white p-2">숙소 관리 페이지</h1>
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
			<div class="row g-3 align-items-center mb-5">
				<div class="col-9">
					<input type="text" name="search-keyword" class="form-control" placeholder="검색하실 숙소명을 입력해주세요" onkeypress="SubmitBtnClick()">
				</div>
				<div class="col-3">
					<button type="submit" name="submit-keyword" class="btn btn-secondary">검색</button>
				</div>
			</div>
			
			<!-- 검색한 숙소 데이터 출력박스 -->
			<div id="accommodation-box"></div>
		
			<!-- 검색한 숙소 출력 폼 --><!-- 도영님께 높이조절 어떻게 하셨는지 물어보기
			<div class="card text-white p-0 rounded-0" style="height:10vw">
				<a href="#"><img src="/resources/images/acco/thumbnail/11213.jpg" class="card-img rounded-0"></a>
				<div class="card-img-overlay text-end">
					<p class="card-title fs-3 fw-bold">숙소명</p>
					<p class="card-text fw-bold">입력자 아이디</p>
					<p class="card-text fw-bold">주소</p>
					<button type="button" class="btn btn-outline-light" onclick="modifyAccommodation()">수정</button>
					<button type="button" class="btn btn-outline-light" onclick="deleteAccommodation()">삭제</button>
				</div>
			</div>
			 -->
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
					content += '		<p class="card-text fw-bold">입력자 아이디</p>';
					content += '		<p class="card-text fw-bold">'+accommodation.address+'</p>';
					content += '		<a class="btn btn-outline-light" href="/admin/accommodationmodify?no='+accommodation.id+' ">수정</a>';
					content += '		<a class="btn btn-outline-light" href="/admin/accommodationdelete?no='+accommodation.id+' ">삭제</button>';
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