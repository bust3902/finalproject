<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<style>
        	.box {
				background: #fiebd6;
				padding: 220px 0 60px 0;
				width: 400px;
				margin: auto;
			}
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>로그인</title>
</head>
<body>
<c:set var="menu" value="login" />
<div class="box">
    <section>
        <form id="loginForm" action="https://www.goodchoice.kr/user/loginProcess" autocomplete="off" method="post" novalidate="novalidate">
            <input type="hidden" name="seoul_token" value="8927861f5f44941cbf695eae907eb3d9">
            <div class="fix_title">
                <strong class="logo"><a href="/"><img src="/resources/images/logo.png" style="width:90px;height:auto;" class="card-img-top" alt="..."></a></strong>
            </div>
            <button type="button" id="kakao-login-btn" class="btn_start btn_kakao" data-device-type="W"><span><i class="icon-ic_login_kakaotalk"></i>카카오톡으로 로그인</span></button>
            <button type="button" id="facebook-login-btn" class="btn_start btn_fb"><span><i class="icon-icn_login_facebook"></i>Facebook으로 로그인</span></button>
            <a href="" id="naver_id_login" class="btn_start btn_naver"><span><i class="icon-ic_login_naver"></i>네이버로 로그인</span></a>
            <p class="space_or"><span>또는</span></p>
            <div class="inp_type_1 ico_email form-errors"><!-- focus / err -->
                <input type="email" name="uid" placeholder="이메일 주소" required="" class="required" value="" data-msg-required="이메일 주소를 입력해 주세요.">
            <button type="button" class="reset_val">초기화</button></div>
            <div class="inp_type_1 ico_pw form-errors">
                <input type="password" name="upw" placeholder="비밀번호" required="" class="required" data-msg-required="비밀번호를 입력해 주세요.">
            <button type="button" class="reset_val">초기화</button></div>
            <button class="btn_link gra_left_right_red" type="submit"><span>로그인</span></button>
                            <div class="link">
                    <span>비회원으로 예약하셨나요? </span>
                    <a href="" class="guest_link"><span>비회원 예약 내역 조회</span></a>
                </div>
        </form>
    </section>
</div>


<style>
/* layer_unfix 존재시 footer 숨김 */
.mobile_appdown,
header,
footer{display:none !important}
</style>
<script type="text/javascript">
$(function() {
	// $("#form-login") : 아이디가 form-login인 엘리먼트를 선택한다. -> jQuery 객체(선택된 엘리먼트 + 메소드)
	// .submit(함수) : 선택된 엘리먼트에 submit 이벤트가 발생하면 실행될 함수를 등록시킨다.
	
	// .val() : 선택된 입력요소의 값을 읽어온다.
	// .text() : 선택된 엘리먼트가 포함하고 있는 텍스트 컨텐츠를 읽어온다.
	// .html() : 선택된 엘리먼트가 포함하고 있는 html 컨텐츠를 읽어온다.
	// .attr(name) : 선택된 엘리먼트에서 지정된 속성명의 속성값을 읽어온다.
	
	$("#form-login").submit(function() {
		let emailValue = $("#email-field").val();	// let emailValue = document.querySelector("#email-field").value;
		if (emailValue === "") {
			alert("이메일은 필수입력값입니다.");
			return false;
		}
		
		let passwordValue = $("#password-field").val();
		if (passwordValue === "") {
			alert("비밀번호는 필수입력값입니다.");
			return false;
		}
		
		return true;
	});
});
</script>
</body>
</html>