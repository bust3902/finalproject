<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="resources/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<!-- 카카오 로그인지원 자바스크립트 라이브러리를 포함시킨다. -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<title>로그인</title>
</head>
<body>
<div class="container mt-3">  
	<c:set var="menu" value="login"></c:set>
    <div class="row mb-3">
    	<div class="col-7">
    		<p>아이디 비밀번호를 입력해서 로그인하세요</p>
    		<%-- 
    			일반 로그인 처리중 중 오류가 발생하면 아래 경고창에 표시된다.
    			오류 메세지는 RequestAttributes의 addFlashAttribute(String name, Object value) 메소드를 사용해서 전달한다.
    		 --%>
    		<c:if test="${not empty error }">
    			<div class="alert alert-danger">
    				${error }
    			</div>
    		</c:if>
    		<form class="border p-3 bg-light" method="post" action="login">
    			<div class="mb-3">
    				<label class="form-label">아이디</label>
    				<input type="text" class="form-control" name="id"/>
    			</div>
    			<div class="mb-3">
    				<label class="form-label">비밀번호</label>
    				<input type="password" class="form-control" name="password"/>
    			</div>
    			<div class="mb-1 text-end">
    				<a href="/register" class="btn btn-secondary">회원가입</a>
    				<button class="btn btn-primary">로그인</button>
    			</div>
    		</form>
    	</div>
    	<div class="col-5">
    		<p>카카오, 네이버 계정을 이용해서 로그인하세요
    		<%-- 
    			카카오 로그인 처리중 중 오류가 발생하면 아래 경고창에 표시된다.
    			카카오 로그인 오류는 스크립트에서 아래 경고창에 표시합니다.
    		 --%>
    		<div class="alert alert-danger d-none" id="alert-kakao-login">오류 메세지</div>
    		
    		<div class="border p-3 mb-4 bg-light">
    			<a id="btn-kakao-login" href="kakao/login">
  					<img src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222" alt="카카오 로그인 버튼"/>
				</a>
    		</div>
    	</div>
    	<%--
    		카카오 로그인 서비스가 제공하는 사용자 정보를 서버로 제출할 때 사용하는 폼과 폼 입력요소다.
    		카카오 로그인 인증이 완료되면 사용자정보를 전달받아서 아래 폼 입력필드에 설정하고, 폼을 서버로 제출한다.
    	 --%>
    	<form id="form-kakao-login" method="post" action="kakao-login">
    		<input type="hidden" name="id" />
    		<input type="hidden" name="nickname" />
    		<input type="hidden" name="email" />
    	</form>
    </div>
</div>
<script type="text/javascript">
$(function() {
	// 카카오 로그인 버튼을 클릭할 때 실행할 이벤트 핸들러 함수를 등록한다.
	$('#btn-kakao-login').click(function(event){
		// a태그는 클릭이벤트가 발생하면 페이지를 이동하는 기본동작이 수행되는데, 그 기본동작이 실행되지 않게 한다.
		event.preventDefault();
		// 카카오 로그인 실행시 오류메세지를 표시하는 경고창을 화면에 보이지 않게 한다.
		$("#alert-kakao-login").addClass("d-none");
		// 사용자키를 전달해서 카카오 로그인 서비스를 초기화한다.
		Kakao.init('9f3a5b1dadaeae93a5ebb2ab206b6506');
		// 카카오 로그인 서비스 실행하기 및 사용자 정보 가져오기
		Kakao.Auth.login({
			success: function(auth) {
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(response) {
						// 사용자 정보를 가져와서 폼에 추가한다.
						var account = response.kakao_account;
						
						$('#form-kakao-login input[name=username]').val(response.id);
						$('#form-kakao-login input[name=nickname]').val(account.profile.nickname);
						$('#form-kakao-login input[name=email]').val(account.email);
						// 사용자 정보가 포함된 폼을 서버로 제출한다.
						document.querySelector("#form-kakao-login").submit()
					},
					fail: function(error) {
						// 경고창에 에러 메세지를 표시한다.
						$("#alert-kakao-login").removeClass("d-none").text("카카오 로그인 처리 중 오류가 발생하였습니다.");
					}
				});
			},
			fail: function(error) {
				// 경고창에 에러 메세지를 표시한다.
				$("#alert-kakao-login").removeClass("d-none").text("카카오 로그인 처리 중 오류가 발생하였습니다.");
			}
		});		
	})
})
</script>
</body>
</html>