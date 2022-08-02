<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 카카오 로그인지원 자바스크립트 라이브러리를 포함시킨다. -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<title>회원가입</title>
</head>
<body>
<div class="container mt-3">  
	<c:set var="menu" value="register"></c:set>
	<%@ include file="common/nav.jsp" %> 
	<div class="row">
		<div class="col">
		</div>
	</div> 
    <div class="row mb-3">
    	<div class="col">
    		<p>사용자 정보를 입력해서 가입하세요</p>
    		<%-- 
    			회원가입 중 오류가 발생하면 아래 경고창에 표시된다.
    			오류 메세지는 RequestAttributes의 addFlashAttribute(String name, Object value) 메소드를 사용해서 전달한다.
    		 --%>
    		<c:if test="${not empty error }">
    			<div class="alert alert-danger">
    				${error }
    			</div>
    		</c:if>
    		<form class="border p-3" method="post" action="register">
    			<div class="mb-3">
    				<label class="form-label">아이디</label>
    				<input type="text" class="form-control" name="id"/>
    			</div>
    			<div class="mb-3">
    				<label class="form-label">비밀번호</label>
    				<input type="password" class="form-control" name="password"/>
    			</div>
    			<div class="mb-3">
    				<label class="form-label">닉네임</label>
    				<input type="text" class="form-control" name="nickname"/>
    			</div>
    			<div class="mb-3">
    				<label class="form-label">이름</label>
    				<input type="text" class="form-control" name="name"/>
    			</div>
    			<div class="mb-3">
    				<label class="form-label">이메일</label>
    				<input type="text" class="form-control" name="email"/>
    			</div>
    			<div class="mb-3">
    				<label class="form-label">전화번호</label>
    				<input type="text" class="form-control" name="tel"/>
    			</div>
    			<div class="mb-3">
    				<label class="form-label">주소</label>
    				<input type="text" class="form-control" name="address"/>
    			</div>
    			<div class="mb-1 text-end">
    				<a href="/" class="btn btn-secondary">취소</a>
    				<button class="btn btn-primary">등록</button>
    			</div>
    		</form>
    	</div>
    	
    </div>
</div>
</body>
</html>