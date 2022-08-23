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
	<!-- 페이스북 로그인 버튼 -->
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v14.0&appId=1236926960491051&autoLogAppEvents=1" nonce="WOnf17HA"></script>
	<!-- 네이버 로그인 버튼 -->
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


.kakao ul{
	padding: 0px;
	margin-bottom: 5px;
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
		<!-- 로고 -->
        <div id="logo">
            <a class="navbar-brand" href="/">
      			<img src="/resources/images/logo(pink).png" alt="서울어때" width="80" height="auto">
    		</a>
        </div>
            
        <!-- 카카오톡 로그인 -->
        <div class="kakao">
    		<ul style="height: 50px;">
				<li onclick="kakaoLogin();">
      				<a href="javascript:void(0)">
          				<img src="/resources/images/login/kakaoLogin.png" alt="카카오톡 로그인" width="336px;">
      				</a>
				</li>
				<li onclick="kakaoLogout();">
      				<a href="javascript:void(0)"></a>
				</li>
			</ul>
    	</div>
    	<form id="form-kakao-login" method="post" action="kakao-login">
    		<input type="hidden" name="id" />
    		<input type="hidden" name="nickname" />
    		<input type="hidden" name="email" />
    	</form>
    		
    	<!-- 페이스북 로그인 -->
    	<div class="facebook mb-1">
    		<div class="fb-login-button" data-width="336" data-size="large" data-button-type="login_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" onlogin="checkLoginState()"></div>
			<div id="fb-root"></div>

			<form id="form-facebook" method="post" action="facebook-login">
				<input type="hidden" name="email">
				<input type="hidden" name="name">
			</form>   			
		</div>
			
        <!-- 네이버 로그인 -->
        <div class="naver">
        	<!-- 네이버 로그인 버튼 -->
        	<div id="naver_id_login"></div>
        	
			<form id="form-naver" method="post" action="naver-login">
				<input type="hidden" name="name">
				<input type="hidden" name="email">
				<input type="hidden" name="nickname">
			</form>   
 		</div>
            
        <!-- 일반 로그인 -->
        <div class="normal">
           <c:set var="menu" value="login"></c:set>
    		<div class="row">
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
    				<div class="mb-3 text-end">
    					<button class="btn btn-primary btn-lg">로그인</button>
    				</div>
    				<div class="finish">
						<button class="btn btn-light mb-2" type="button" data-bs-toggle="modal" data-bs-target="#findId" style="padding-left: 33px; padding-right:33px;width: 190px;height: 42px;">아이디 찾기</button>
						<a href="/register" class="btn btn-light mb-2" style="padding-left: 33px; padding-right:33px;height: 42px;">회원가입</a>
            			<button class="btn btn-light" type="button" data-bs-toggle="modal" data-bs-target="#findPw" style="padding-left: 33px; padding-right:33px;height: 45px;">비밀번호 찾기</button>
    				</div>
    			</form>
    		</div>
		</div>
		
		<!-- 아이디 찾기 -->
		<div class="modal fade" id="findId" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"><strong>아이디 찾기</strong></h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<table class="table findId">
							<tr>
                            	<td><label>이름</label></td>
								<td><input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이름을 입력해주세요.'"></td>
							</tr>
							<tr>
								<td><label>이메일</label></td>
								<td><input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일을 입력해주세요.'"></td>
							</tr>
						</table>
						<div class="showId"></div>
					</div>
					<div class="modal-footer">
                        <button type="button" class="btn btn-primary btnConfirm" onclick="findId()">확인</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 비밀번호 찾기 -->
		<div class="modal fade" id="findPw" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"><strong>비밀번호 찾기</strong></h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<table class="table findPw">
							<tr>
                            	<td><label>아이디</label></td>
								<td><input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력해주세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이름을 입력해주세요.'"></td>
							</tr>
							<tr>
								<td><label>이메일</label></td>
								<td><input type="text" class="form-control" id="email2" name="email" placeholder="이메일을 입력해주세요." onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일을 입력해주세요.'"></td>
							</tr>
						</table>
						<div class="showPw"></div>
					</div>
					<div class="modal-footer">
                        <button type="button" class="btn btn-primary btnConfirm2" onclick="findPw()">확인</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
    </div>
</div>

<%-- 카카오 스크립트 --%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('1c64be084ffd66ec4e090f13f7ff9ac8'); //발급받은 키 중 javascript키를 사용해준다.

//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
			$("#form-kakao-login input[name=id]").val(response.id);
			$("#form-kakao-login input[name=nickname]").val(response.kakao_account.profile.nickname);
			$("#form-kakao-login input[name=email]").val(response.kakao_account.email);
			// 사용자 정보가 포함된 폼의 서버로 제출한다.
			$("#form-kakao-login").trigger("submit");
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
			$("#form-kakao-login input[name=id]").val(response.id);
        	$("#form-kakao-login input[name=nickname]").val(response.kakao_account.profile.nickname);
			$("#form-kakao-login input[name=email]").val(response.kakao_account.email);
			$("#form-kakao-login").trigger("submit");
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
	}
}
</script>

<%-- 페이스북 스크립트 --%>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>
<script>
	window.fbAsyncInit = function() {
		FB.init({
			appId : '1236926960491051',
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
				$("#form-facebook input[name=email]").val(response.email);
				$("#form-facebook").trigger("submit");
				
				
				console.log('Successful login for: ' + response.name);
				document.getElementById('status').innerHTML =  'Thanks for logging in, ' + response.name + '!';
			});
  		} else {                                 // Not logged into your webpage or we are unable to tell.
			document.getElementById('status').innerHTML = 'Please log ' + 'into this webpage.';
		}
	}
</script>

<%-- 네이버 로그인 버튼--%>
<script type="text/javascript">
  	var naver_id_login = new naver_id_login("iHN5BdpjdVVavFwk_Qfg", "https://localhost/"); <%-- naver_id_login라는 함수가 없다함... navar에서 api를 잘못 만든 것 같습니다...--%>
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 3,45);
  	naver_id_login.setDomain("https://localhost/login");
  	naver_id_login.setState(state);
  	naver_id_login.setPopup();
  	naver_id_login.init_naver_id_login();
</script>
  		
<%-- 네이버 로그인 응답 --%>
<script type="text/javascript">
  	var naver_id_login = new naver_id_login("iHN5BdpjdVVavFwk_Qfg", "https://localhost/");
  	// 접근 토큰 값 출력
  	alert(naver_id_login.oauthParams.access_token);
  	// 네이버 사용자 프로필 조회
  	naver_id_login.get_naver_userprofile("naverSignInCallback()");
  	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  	function naverSignInCallback() {
    	alert(naver_id_login.getProfileData('name'));
    	alert(naver_id_login.getProfileData('email'));
    	alert(naver_id_login.getProfileData('nickname'));
  	}
</script>

<%-- 아이디 찾기 --%>
<script type="text/javascript">
function findId() {
   let name = document.getElementById('name').value;
   let email = document.getElementById('email').value;
   
   $.ajax({
      url: '/findId',
      type: 'post',
      data: {"name":name, "email":email},
      success:function(data){
         if(data == 0) {
            alert("아이디가 존재하지 않습니다.");
         } else {
            $(".findId").css('display','none');
            $(".btnConfirm").css('display','none');
            let content = '<p class="text-center">아이디는 <strong>'+data+'</strong> 입니다.</p>';
            $(".showId").append(content);
         }
      }, 
      error:function(){
         alert("에러입니다.");
      }
   })
};

<%-- 비밀번호 찾기 --%>
function findPw() {
   let id = document.getElementById('id').value;
   let email = document.getElementById('email2').value;
   
   $.ajax({
      url: '/findPw',
      type: 'post',
      data: {"id":id, "email":email},
      success:function(data){
         if(data == "success") {
            $(".findPw").css('display','none');
            $(".btnConfirm2").css('display','none');
            let content = '<p class="text-center">임시 비밀번호를 '+email+'로 보냈습니다.</p>';
            $(".showPw").append(content);
         } else if (data =="fail"){
            alert("아이디 혹은 이메일이 잘못되었습니다.");
         }
      }, 
      error:function(){
         alert("에러입니다.");
      }
   })
};
</script>
</body>
</html>