<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<div class="layer_fix layer_unfix pop_login pop_mem_reserve">
    <section>
        <form id="loginForm" action="https://www.goodchoice.kr/user/loginProcess" autocomplete="off" method="post" novalidate="novalidate">
            <input type="hidden" name="yeogi_token" value="342471ccc99832fd457ef9cd8ff7059c">
            <div class="fix_title">
                <strong class="logo"><a href="https://www.goodchoice.kr/">여기어때</a></strong>
            </div>
            <button type="button" id="kakao-login-btn" class="btn_start btn_kakao" data-device-type="W"><span><i class="icon-ic_login_kakaotalk"></i>카카오톡으로 로그인</span></button>
            <button type="button" id="facebook-login-btn" class="btn_start btn_fb"><span><i class="icon-icn_login_facebook"></i>Facebook으로 로그인</span></button>
            <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&amp;client_id=r3Mjf4OpPMMq8Lib0JKw&amp;redirect_uri=https%3A%2F%2Fwww.goodchoice.kr%2Fuser%2FnaverLoginProcess&amp;state=e0cefc4875f172437aff836de47859b0" id="naver_id_login" class="btn_start btn_naver"><span><i class="icon-ic_login_naver"></i>네이버로 로그인</span></a>
            <p class="space_or"><span>또는</span></p>
            <div class="inp_type_1 ico_email form-errors"><!-- focus / err -->
                <input type="email" name="uid" placeholder="이메일 주소" required="" class="required" value="" data-msg-required="이메일 주소를 입력해 주세요.">
            <button type="button" class="reset_val">초기화</button></div>
            <div class="inp_type_1 ico_pw form-errors">
                <input type="password" name="upw" placeholder="비밀번호" required="" class="required" data-msg-required="비밀번호를 입력해 주세요.">
            <button type="button" class="reset_val">초기화</button></div>
            <button class="btn_link gra_left_right_red" type="submit"><span>로그인</span></button>
                            <div class="link_half">
                    <div><a href="https://www.goodchoice.kr/user/passwdResetStart"><span>비밀번호 재설정</span></a></div>
                    <div><a href="https://www.goodchoice.kr/user/join"><span>회원가입</span></a></div>
                </div>
            
            <!--
            <div class="layer_fix_footer">
                <p>
                    <a href="http://www.withinnovation.co.kr/" target="_blank">회사소개</a>|
                    <a href="https://www.goodchoice.kr/more/terms">이용약관</a>|
                    <a href="https://www.goodchoice.kr/more/terms/privacy">개인정보처리방침</a>|
                    <a href="https://www.goodchoice.kr/more/terms/teenager">청소년보호정책</a>
                </p>
                <p class="copyright">Copyright WITHINOVATION Corp. All rights reserved.</p>
            </div>
            -->
        </form>
    </section>

</div>
</body>
</html>