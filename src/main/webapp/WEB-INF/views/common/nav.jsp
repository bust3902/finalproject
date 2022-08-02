<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="tags.jsp" %>
<head>
	<style>
	</style>
</head>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<div class="container">
		<ul class="navbar-nav me-auto">
			<li class="nav-item">
				<a class="nav-link ${menu eq 'home' ? 'active' : '' }" href="/">
					<img src="/resources/images/logo.png" style="width:90px;height:auto;" class="card-img-top" alt="...">
				</a>
			</li>
			
		</ul>
		<ul class="navbar-nav">
			<c:if test="${not empty LOGIN_USER }">
				<div class="container-fluid">
    				<form class="d-flex">
      					<input class="form-control me-2" type="search" placeholder="지역, 숙소명" aria-label="Search">
      					<button class="btn btn-outline-success" type="submit">검색</button>
    				</form>
  				</div>
				<li class="nav-item"><a class="nav-link ${menu eq 'login' ? 'active' : '' }" href="/near">내주변</a></li>
				<li class="nav-item"><a class="nav-link ${menu eq 'register' ? 'active' : '' }" href="/reservation">예약내역</a></li>
				<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="" role="button" aria-expanded="false">내정보</a>
    			<ul class="dropdown-menu">
     				<li><a class="dropdown-item" href="">내 정보</a></li>
      				<li><a class="dropdown-item" href="">내가 찜한 목록</a></li>
      				<li><a class="dropdown-item" href="">예약 내역</a></li>
      				<li><a class="dropdown-item" href="">예약 취소</a></li>
      				<li><a class="dropdown-item" href="">내 리뷰 보기</a></li>
      				<li><hr class="dropdown-divider"></li>
					<li class="dropdown-item"><a class="dropdown-item" href="/logout">로그아웃</a></li>
    			</ul>
			</c:if>
			<c:if test="${empty LOGIN_USER }">
				<div class="container-fluid">
    				<form class="d-flex">
      					<input class="form-control me-2" type="search" placeholder="지역, 숙소명" aria-label="Search">
      					<button class="btn btn-outline-success" type="submit">검색</button>
    				</form>
  				</div>
				<li class="nav-item"><a class="nav-link ${menu eq 'login' ? 'active' : '' }" href="/near">내주변</a></li>
				<li class="nav-item"><a class="nav-link ${menu eq 'register' ? 'active' : '' }" href="/reservation">예약내역</a></li>
				<li class="nav-item dropdown">
    			<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="" role="button" aria-expanded="false">더보기</a>
    			<ul class="dropdown-menu">
     				<li><a class="dropdown-item" href="">1:1 문의</a></li>
      				<li><a class="dropdown-item" href="">핫한 숙소</a></li>
      				<li><a class="dropdown-item" href="">인기 맛집</a></li>
    			</ul>
  				</li>
				<li class="nav-item"><a class="nav-link ${menu eq 'register' ? 'active' : '' }" href="/login">로그인</a></li>
				<li class="nav-item"><a class="nav-link ${menu eq 'register' ? 'active' : '' }" href="/register">회원가입</a></li>
			</c:if>
		</ul>
	</div>
</nav>
</script>