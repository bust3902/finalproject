package kr.co.nc.web.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.UserService;
import kr.co.nc.util.SessionUtils;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.FacebookLoginForm;
import kr.co.nc.web.form.KakaoLoginForm;
import kr.co.nc.web.form.NaverLoginForm;
import kr.co.nc.web.form.UserRegisterForm;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class HomeController {
	
	private static final String NORMAL_LOGIN_TYPE = "normal";
	private static final String KAKAO_LOGIN_TYPE = "kakao";
	private static final String FACEBOOK_LOGIN_TYPE = "facebook";
	private static final String NAVER_LOGIN_TYPE = "naver";
	
	@Autowired
	private UserService userService;
	@Autowired
	private AccommodationService accommodationService;
	
	/*
	 * 홈화면 요청을 처리한다.
	 * 요청URI : /
	 * 요청 파라미터 : 없음
	 * 뷰 페이지 : /WEB-INF/views/home.jsp
	 */
	@GetMapping(path = "/")
	public String home(Model model) {
		// 홈 메뉴에 출력할 숙소 유형 정보를 전달한다.
		model.addAttribute("accoTypes", accommodationService.getAllTypes());
		// 홈 화면에 출력할 인기 숙소 정보를 전달한다.
		model.addAttribute("bestAccos", accommodationService.getBestAccommodations(5));
		return "home";
	}
	
	
	/*
	 * 회원가입폼 요청을 처리한다.
	 * 요청 URI : /register
	 * 요청 파라미터 : 없음
	 * 뷰 페이지 : /WEB-INF/views/registerform.jsp
	 */
	@GetMapping("/register")
	public String registerform(Model model) {
		model.addAttribute("form", new UserRegisterForm());
		return "registerform";
	}
	
	/*
	 * 회원가입 요청을 처리한다.
	 * 요청 URI : /register
	 * 폼 데이터 : username, password, email
	 * 재요청 URI : 성공 - /completed, 실패 - /register
	 */
	@PostMapping("/register") 
	public String register(@ModelAttribute("form") @Valid UserRegisterForm form, BindingResult errors, RedirectAttributes redirectAttributes) {
		log.info("일반 회원가입 정보: " + form);
		
		if (errors.hasErrors()) {
			return "registerform";
		}
		
		User user = User.builder()
				.id(form.getId())
				.password(form.getPassword())
				.nickname(form.getNickname())
				.name(form.getName())
				.tel(form.getTel())
				.email(form.getEmail())
				.loginType(NORMAL_LOGIN_TYPE)	// 일반회원 가입은 로그인타입을 "normal"로 설정한다.
				.build();
		try {
			// 서비스에 회원정보를 전달해서 회원가입을 처리하게 한다. 
			userService.registerUser(user);
			redirectAttributes.addFlashAttribute("user", user);
			
			return "redirect:/completed";
		} catch (RuntimeException e) {
			errors.rejectValue("email", null, e.getMessage());
			return "registerform";
		}
	}
	
	/*
	 * 회원가입 완료 페이지 요청을 처리한다.
	 * 요청 URI : /completed
	 * 요청 파라미터 : 없음
	 * 뷰 페이지 : /WEB-INF/views/completed.jsp
	 */
	@GetMapping("/completed") 
	public String completed(){
		return "completed";
	}
	
	/*
	 * 로그인 페이지 요청을 처리한다.
	 * 요청 URI : /login
	 * 요청 파라미터 : 없음
	 * 뷰 페이지 : /WEB-INF/views/login.jsp
	 */
	@GetMapping("/login") 
	public String loginform(){
		return "login";
	}
	
	/*
	 * 일반 로그인 요청을 처리한다.
	 * 요청 URI : /login
	 * 요청 파라미터 : id, password
	 */
	@PostMapping("/login") 
	public String login(String id, String password, RedirectAttributes redirectAttributes){
		log.info("일반 로그인 정보: " + id);
		try {
			User user = userService.login(id, password);
			SessionUtils.addAttribute("LOGIN_USER", user);
			log.info("일반 로그인 처리 완료");
			if ( "A".equals(user.getAuthority())) { 
				return "redirect:/admin"; }
			else {
				return "redirect:/";
			}
		} catch (RuntimeException e) {
			log.warn("일반 로그인 오류: " + e.getMessage());
			
			redirectAttributes.addFlashAttribute("error", e.getMessage());
			return "redirect:/login";
		}
				
	}
	
	// 카카오 로그인 요청을 처리한다.
	@PostMapping("/kakao-login")
	public String kakaoLogin(KakaoLoginForm form) {
		log.info("카카오 로그인 인증정보: " + form);
			
		User user = User.builder()
						.id(form.getId())
						.name(form.getNickname())
						.email(form.getEmail())
						.loginType(KAKAO_LOGIN_TYPE)
						.build();
			
		User savedUser = userService.loginWithKakao(user);
			
		if (savedUser != null) {
			SessionUtils.addAttribute("LOGIN_USER", savedUser);
		} else {
			SessionUtils.addAttribute("LOGIN_USER", user);
		}
		log.info("카카오 로그인 완료");
			
		return "redirect:/";		
	}
		
	// 로그아웃 요청을 처리한다.
	@GetMapping("/logout")
	public String logout() {
		SessionUtils.sessionInvlidate();
		return "redirect:/";
	}
		
	// 페이스북 로그인 요청을 처리한다.
	@PostMapping("/facebook-login")
	public String facebookLogin(FacebookLoginForm form) {
		log.info("페이스북 로그인 인증정보: " + form);
		
		User user = User.builder()				
						.name(form.getName())
						.email(form.getEmail())
						.loginType(FACEBOOK_LOGIN_TYPE)
						.build();
		
		User savedUser = userService.loginWithFacebook(user);
		
		if (savedUser != null) {
			SessionUtils.addAttribute("LOGIN_USER", savedUser);
		} else {
			SessionUtils.addAttribute("LOGIN_USER", user);
		}
		log.info("페이스북 로그인 완료");

		return "redirect:/";
	}
	
	// 네이버 로그인 요청을 처리한다.
	@PostMapping("/naver-login")
	public String NaverLoginForm (NaverLoginForm form) {
		log.info("네이버 로그인 인증정보: " + form);
			
		User user = User.builder()
						.name(form.getName())
						.email(form.getEmail())
						.nickname(form.getNickname())
						.loginType(NAVER_LOGIN_TYPE)
						.build();
			
		User savedUser = userService.loginWithNaver(user);
			
		if (savedUser != null) {
			SessionUtils.addAttribute("LOGIN_USER", savedUser);
		} else {
			SessionUtils.addAttribute("LOGIN_USER", user);
		}
		log.info("네이버 로그인 완료");

		return "redirect:/";
	}

	/*
	 * 내주변 통합검색 페이지 요청을 처리한다.
	 */
	@GetMapping("/near")
	public String near(@RequestParam(required = false) String keyword, Model model) {
		// 맛집 홈에서 검색한 경우 keyword를 전달
		model.addAttribute("keyword", keyword);
		return "near";
	}
	
	// 아이디 찾기
	@PostMapping(path ="/findId")
	@ResponseBody
	public String findId(@RequestParam("name") String name, @RequestParam("email") String email) {
		String findId = userService.findId(name, email);
		return findId;
	}

}
