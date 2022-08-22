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
<style type="text/css">
.register #content {
    width: 360px;
    height: 850px;
    margin: 30px auto 0 auto;
}

#logo{
	text-align: center;
}

#logo img {
	width: 180px;
}

#join {
    width: 305px;
}

#join button {
	width: 327px;
}

li {
	display: inline-block;
}

</style>
	<title>회원가입</title>
</head>
<body>
<div class="register">
	<div id="content">
		<!-- 로고 -->
        <div id="logo">
            <a class="navbar-brand" href="/">
      			<img src="/resources/images/logo(pink).png" alt="서울어때" width="80" height="auto">
    		</a>
        </div>
    	<form:form class="border p-3" method="post" action="register" modelAttribute="form">
    		<div class="mb-3">
    			<label class="form-label">아이디</label>
    			<form:input class="form-control" path="id" placeholder="아이디를 입력해주세요."/>
    			<form:errors path="id" class="text-danger small fst-italic"></form:errors>
    		</div>
    		<div class="mb-3">
    			<label class="form-label">비밀번호</label>
    			<form:password  class="form-control" path="password" placeholder="비밀번호를 입력해주세요."/>   			
    			<form:errors path="password" class="text-danger small fst-italic"></form:errors>
    		</div>
    		<div class="mb-3">
    			<label class="form-label">닉네임</label>
    			<form:input  class="form-control" path="nickname" placeholder="닉네임을 입력해주세요."/>
    			<form:errors path="nickname" class="text-danger small fst-italic"></form:errors>
    		</div>
    		<div class="mb-3">
    			<label class="form-label">이름</label>
    			<form:input  class="form-control" path="name" placeholder="이름을 입력해주세요."/>
    			<form:errors path="name" class="text-danger small fst-italic"></form:errors>
    		</div>
    		<div class="mb-3">
    			<label class="form-label">전화번호</label>
    			<form:input  class="form-control" path="tel" placeholder="ex) 010-1234-5678"/>
    			<form:errors path="tel" class="text-danger small fst-italic"></form:errors>
    		</div>
    		<div class="mb-3">
    			<label class="form-label">이메일</label>
    			<form:input class="form-control" path="email" placeholder="이메일을 입력해주세요."/>
    			<form:errors path="email" class="text-danger small fst-italic"></form:errors>
    		</div>
    		<div class="mb-1 text-end" id="join">
    			<button type="submit" class="btn btn-primary btn-lg">가입하기</button>
    		</div>
    	</form:form>
    </div>
</div>
</body>
</html>