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
<style type="text/css">
.login #content {
    width: 336px;
    margin: 100px auto 0 auto;
}

#logo{
	text-align: center;
}

#logo img {
	width: 180px;
}

.normal .login button {
	width: 329px;
}

.kakao{
	width: 336px;
	list-style: none;
	padding: 0px;
	margin: 0px;
}

.kakao {
	width: 329px;
}

ul{
	padding: 0px;
}

li {
	display: inline-block;
}
</style>
	<title>로그인</title>
</head>
<body>
<!-- 로그인 양식 -->
<div class="login">
	<div id="content">
        <form id="loginForm" action="" autocomplete="off" method="post" novalidate="novalidate">
            <input type="hidden" name="seoul" value="">
            <div id="logo">
                <a class="navbar-brand" href="/">
      				<img src="/resources/images/logo.png" alt="서울어때" width="80" height="auto">
    			</a>
            </div>
            
            <!-- 카카오톡 로그인 -->
            <div class="kakao">
    			<ul>
					<li onclick="kakaoLogin();">
      					<a href="javascript:void(0)">
          					<img src="/resources/images/login/kakaoLogin.png" alt="카카오톡 로그인" width="329px;">
      					</a>
					</li>
					<li onclick="kakaoLogout();">
      					<a href="javascript:void(0)">
          					<img src="#" alt="카카오톡 로그아웃" width="329px;">
      					</a>
					</li>
				</ul>
    		</div>
    		<form id="form-kakao-login" method="post" action="kakao-login">
    			<input type="hidden" name="id" />
    			<input type="hidden" name="nickname" />
    			<input type="hidden" name="email" />
    		</form>
    		
    		<!-- 페이스북 로그인 -->
    		<div class="facebook">
    			<fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
				<button onclick="logout()">로그아웃</button>
				<div id="status"></div>

				<form id="form-facebook" method="post" action="facebook">
					<input type="hidden" name="email">
					<input type="hidden" name="name">
				</form>   			
			</div
    		<form id="form-facebook-login" method="post" action="facebook-login">
				<input type="hidden" name="email">
			</form>
			
            <!-- 네이버 로그인 -->
            <div class="naver">
    			
			</div>
            
            <p class="space_or"><span>또는</span></p>
            
            <!-- 일반 로그인 -->
            <div class="normal">
               <c:set var="menu" value="login"></c:set>
    			<div class="row mb-3">
    				<c:if test="${not empty error }">
    					<div class="alert alert-danger">
    						${error }
    					</div>
    				</c:if>
    				<form class="login p-3" method="post" action="login">
    					<div class="mb-2">
    						<input type="text" class="form-control" name="id" placeholder="아이디를 입력하세요."/>
    					</div>
    					<div class="mb-3">
    						<input type="password" class="form-control" name="password" placeholder="비밀번호를 입력하세요."/>
    					</div>
    					<div class="mb-1 text-end">
    						<button class="btn btn-primary btn-lg">로그인</button>
    					</div>
    				</form>
    			</div>
            	<ul class="link">
					<li class="password"><a href="#">비밀번호 재설정</a><span>|</span></li>
					<li class="register"><a href="/register">회원가입</a></li>
				</ul>
            </div>
    	</form>
    </div>
</div>

<%-- 카카오 로그인 --%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('1c64be084ffd66ec4e090f13f7ff9ac8'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>
<%-- 페이스북 로그인 --%>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>
<script>
	window.fbAsyncInit = function() {
		FB.init({
			appId : '2878645332429159',
			cookie : true,
			xfbml : true,
			version : 'v14.0'
		});
     	FB.AppEvents.logPageView();   
     };

	function checkLoginState() {
   		FB.getLoginStatus(function(response) {
     		statusChangeCallback(response);
		});
	}
 
	function logout() {
   		FB.logout(function(response) {
	   		location.href = "/";
		});
  	}
 
	function statusChangeCallback(response) {  // Called with the results from FB.getLoginStatus().
   		console.log('statusChangeCallback');
		console.log(response);                   // The current login status of the person.
		if (response.status === 'connected') {   // Logged into your webpage and Facebook.
			FB.api('/me', function(response) {
				console.log(response);
				
				$("#form-facebook input[name=name]").val(response.name);
				$("#form-facebook input[name=email]").val(response.name);
				$("#form-facebook").trigger("submit");
				
				
				console.log('Successful login for: ' + response.name);
				document.getElementById('status').innerHTML =  'Thanks for logging in, ' + response.name + '!';
			});
  		} else {                                 // Not logged into your webpage or we are unable to tell.
			document.getElementById('status').innerHTML = 'Please log ' + 'into this webpage.';
		}
	}
</script>
</body>
</html>