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
		<a href="/admin" class="fs-3 text-white text-decoration-none p-2">음식점 관리 페이지</a>
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
					<input type="text" name="search-keyword" class="form-control" placeholder="검색하실 음식점명을 입력해주세요" id="enter-search">
				</div>
				<div class="col-3">
					<button type="submit" name="submit-keyword" class="btn btn-secondary">검색</button>
				</div>
			</div>
			
			<!-- 검색한 음식점 데이터 출력박스 -->
			<div id="restaurant-box"></div>
		</div>
	</div>
</div>	
<%@ include file="../common/footer.jsp" %>
</body>
<script type="text/javascript">

// 엔터키 입력시 음식점 검색 버튼 클릭 이벤트
$('#enter-search').keydown(function( event ) {
	if (event.keyCode === 13) {
		$("button[name=submit-keyword]").trigger("click");
	}
});

$(document).ready(function(){
    $("button[name=submit-keyword]").click(function(){
    	
		let queryString = $("input[name=search-keyword]").val();
    	let $div = $("#restaurant-box").empty();
		
		// 검색필드에 값이 있는지 체크하기
		let searchValue = $.trim( $("input[name=search-keyword]").val() );
		if (searchValue === "") {
			alert("검색어를 입력해주세요.");
			return false;
		}
	
		// 음식점정보 검색
		$.getJSON("/admin/searchRestaurant", {keyword:queryString}).done(function(restaurants) {
			if (restaurants.length === 0) {
				let content = `
					<div class="col-12">
						<p class="text-center">검색결과가 존재하지 않습니다.</p>
					</div>
				`;
				$div.append(content);
			} else {
				$.each(restaurants, function(index, restaurant) {
					let content = '';
					content += '<div class="card text-white p-0 rounded-0" style="height:200px">';
					content += '	<img src="/resources/images/restaurant/thumbnail/'+restaurant.imgname+'" class="card-img rounded-0">';
					content += '	<div class="card-img-overlay text-end">';
					content += '		<p class="card-title fs-3 fw-bold">'+restaurant.name+'</p>';
					// content += '		<p class="card-text fw-bold">'+restaurant.deleted+'</p>';
					content += '		<p class="card-text fw-bold">'+restaurant.location+'</p>';
					content += '		<a class="btn btn-outline-light" href="/admin/modifyRestaurant?no='+restaurant.no+' ">수정</a>';
					// content += '		<a class="btn btn-outline-light" href="/admin/delete?id='+accommodation.id+' ">삭제</a>';
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