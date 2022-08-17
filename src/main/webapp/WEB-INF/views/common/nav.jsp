<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="tags.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<style>	
	.nav-container {
		display: flex;
	    flex-wrap: inherit;
	    align-items: center;
	    justify-content: space-between;
		width: 100%;
	    padding-right: calc(var(--bs-gutter-x) * .5);
	    padding-left: calc(var(--bs-gutter-x) * .5);
	    margin-right: auto;
	    margin-left: auto;
        max-width: 1320px;
        --bs-gutter-x: 1.5rem;
    	--bs-gutter-y: 0;
    	padding: var(--bs-navbar-padding-y) var(--bs-navbar-padding-x);
	}
</style>

<nav class="navbar navbar-expand-md sticky-top bg-secondary navbar-dark">
	<div class="nav-container px-3">
		<!-- 홈버튼 -->
		<a class="navbar-brand" href="/">
      		<img src="/resources/images/logo.svg" alt="" width="100" height="auto">
    	</a>
		<ul class="navbar-nav">			
			<div class="container-fluid position-relative" style="width:700px;height:auto">
   				<form id="form-search" class="d-flex justify-content-center my-auto" action="/acco" autocomplete="off">
     					<input class="form-control me-2" type="text" id="search" name="keyword" placeholder="지역, 숙소명" style="max-width:600px;height:auto">
     					<button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
     					<!-- 최근 검색어 box -->
						<ul id="box-keywords" class="position-absolute list-group w-100 d-none" style="top:50px; left:0; z-index: 1000;">
							<li class="list-group-item list-group-flush border">
								<div class="d-flex justify-content-between py-1 align-items-middle">
									<span class="fw-lighter">최근검색어</span>
									<button id="delete-all-keyword" type="button" class="float-end btn text-danger border-0 btn-sm">모두 지우기</button>
								</div>
							</li>
							<div id="list-group-keywords">
					  			<li class="list-group-item list-group-flush border">
									<a href="" class="border-bottom">내주변 검색</a>
										<hr style="display: block;">
									<div class="d-flex justify-content-between">
										<span>최근검색어</span>
										<button type="button" class="float-end btn text-danger border-0 btn-sm">모두 지우기</button>
									</div>
								</li>
								<li class="list-group-item list-group-flush ">
									<div class="d-flex justify-content-between">
										<button type="button" class="float-end btn text-dark border-0 btn-sm">
											<i class="bi bi-clock"></i>
											<span class="ms-4">맛있는 맛집</span>
										</button>
										<button type="button" class="float-end btn text-danger border-0 btn-sm"><i class="bi bi-trash"></i></button>
									</div>
								</li>
							</div>
						</ul>
   				</form>
			</div>
			<!-- 로그인 상태 -->
			<li class="nav-item" style="width:80px;height:auto"><a class="nav-link ${menu eq 'login' ? 'active' : '' }" href="/near">내주변</a></li>
			<li class="nav-item ${empty LOGIN_USER ? 'd-none' : ''}" style="width:90px;height:auto"><a class="nav-link ${menu eq 'register' ? 'active' : '' } " href="/reservation">예약내역</a></li>
			<li class="nav-item dropdown" style="width:90px;height:auto">
   			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="" role="button" aria-expanded="false">더보기</a>
   				<ul class="dropdown-menu">
    				<li><a class="dropdown-item" href="">1:1 문의</a></li>
     				<li><a class="dropdown-item" href="/acco/best">핫한 숙소</a></li>
     				<li><a class="dropdown-item" href="">인기 맛집</a></li>
   				</ul>
			</li>
			<li class="nav-item dropdown ${empty LOGIN_USER ? 'd-none' : ''}" style="width:80px;height:auto">
				<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="" role="button" aria-expanded="false">내정보</a>
    			<ul class="dropdown-menu">
      				<li><a class="dropdown-item" href="/user/imformation?cat=CAT_001">내 정보</a></li>
      				<li><a class="dropdown-item" href="/user/imformation?cat=CAT_002">예약 내역</a></li>
      				<li><a class="dropdown-item" href="/user/imformation?cat=CAT_003">내가 찜한 목록</a></li>
      				<li><a class="dropdown-item" href="/user/imformation?cat=CAT_004">내 리뷰 보기</a></li>
      				<li><hr class="dropdown-divider"></li>
					<li class=" ${empty LOGIN_USER ? 'd-none' : ''}"><a class="dropdown-item" href="/logout">로그아웃</a></li>					
    			</ul>
   			</li>
			
			<!-- 로그아웃 상태 -->
			<c:if test="${empty LOGIN_USER }">
				<li class="nav-item" style="width:80px;height:auto"><a class="nav-link ${menu eq 'login' ? 'active' : '' }" href="/login">로그인</a></li>
				<li class="nav-item" style="width:80px;height:auto"><a class="nav-link ${menu eq 'register' ? 'active' : '' }" href="/register">회원가입</a></li>
			</c:if>
		</ul>
	</div>
</nav>
<script type="text/javascript">
	
/*
 * 검색창 최근검색어 기능 (restaurant/searchlist 페이지와 동일한 로직의 스크립트 코드를 사용함)
 */
	let $boxKeywords = $("#box-keywords");
	
	$("#search").click(function() {
		// 최근 검색어 출력 토글
		$boxKeywords.toggleClass("d-none");
		refreshKeywordList();
	});
	
	// 최근 검색어를 저장하는 기능
	$("#form-search").submit(function() {
		let keyword = $(":input[name=keyword]").val();
		let text = localStorage.getItem("accoKeywords") || '[]';
		let array = JSON.parse(text);
		if (keyword != "") {
			array.unshift(keyword);
			text = JSON.stringify(array);
			localStorage.setItem("accoKeywords", text);
			return true;
		} else {
			alert("검색어를 입력하세요");
			return false;
		}
		
	});
	
	// 최근 검색어 전체 삭제하는 기능
	$("#delete-all-keyword").click(function() {
		localStorage.setItem("accoKeywords",[]);
		refreshKeywordList();
	});
	
	// 최근 검색어를 최신화 하는 기능
	function refreshKeywordList() {
		let text = localStorage.getItem("accoKeywords") || '[]';
		let array = JSON.parse(text);
		
		// empty를 사용해서 기존의 검색했던 최근 검색어를 지웁니다.
		let $listGroup = $("#list-group-keywords").empty();
		
		$.each(array, function(index, keyword) {
			let content = '';
			content += '<li class="list-group-item list-group-flush ">'
			content += '	<div class="d-flex justify-content-between">'
			content += '		<button type="button" class="float-end btn text-dark border-0 btn-sm">'
			content += '			<i class="bi bi-clock"></i>'
			content += '			<span class="ms-4" onclick="searchKeyword(\''+keyword+'\')">'+keyword+'</span>'
			content += '		</button>'
			content += '		<button type="button" class="float-end btn text-danger border-0 btn-sm" onclick="deleteKeyword('+index+')"+ keylass="bi bi-trash"></i></button>'
			content += '	</div>'
			content += '</li>'
			$listGroup.append(content);
		})
	}
	
	// 최근 검색어를 하나씩 삭제하는 기능
	function deleteKeyword(index) {
		let text = localStorage.getItem("accoKeywords") || '[]';
		let array = JSON.parse(text);
		
		array.splice(index, 1);
		text = JSON.stringify(array);
		localStorage.setItem("accoKeywords", text);
		
		refreshKeywordList();
	};
	
	// 최근 검색어 클릭시 검색되게 하는 기능
	// index를 주고 받지 말고 쉽게 keyword를 주고 받기
	function searchKeyword(keyword) {
		location.href="/acco?keyword=" + keyword;
	};
	
	// 최근 검색어 외부 영역 클릭 시 최근 검색어 팝업 닫기
	$(document).mouseup(function (e) {
		if ($boxKeywords.has(e.target).length === 0) {
			$boxKeywords.addClass("d-none");
		}
	});
</script>