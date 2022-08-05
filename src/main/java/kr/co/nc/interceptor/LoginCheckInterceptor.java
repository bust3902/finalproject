package kr.co.nc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.MethodParameter;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.nc.annotation.LoginUser;



/**
 * <p>요청핸들러 메소드가 실행되기 전에 수행할 작업이 구현된 인터셉터다.
 * <p>요청핸들러 메소드의 매개변수에 @LoginUser 어노테이션이 정의되어 있는 경우, 로그인 여부를 체크한다.
 * 
 * <p>요청핸들러 메소드의 매개변수에 @LoginUser 어노테이션이 없으면, preHandler() 메소드가 true를 반환한다.
 * <p>요청핸들러 메소드의 매개변수에 @LoginUser 어노테이션이 있으면, 
 * 		<p>세션에 로그인된 사용자 정보가 존재하면, preHandler() 메소드가 true를 반환한다.
 * 		<p>세션에 로그인된 사용자 정보가 존재하지 않으면, preHandler() 메소드가 false를 반환한다.
 * 
 * 
 * @author lysuk
 *
 */
public class LoginCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// handle을 HandlerMethod로 형변환한다.
		// HandlerMethod는 요청핸들러 메소드를 표현하는 객체다.
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		
		boolean isLoginRequired = false;
		// 요청핸들러 메소드의 모든 매개변수 정보를 조회한다.
		// MethodParameter은 메소드의 매개변수 정보를 표현하는 객체다.
		MethodParameter[] parameters = handlerMethod.getMethodParameters();
		for (MethodParameter parameter : parameters) {
			// 매개변수에서 @LoginUser 어노테이션 정보를 조회한다.
			// 매개변수에 @LoginUser 어노테이션이 있는 경우에만 loginUser는 null 아니다.
			// @LoginUser 어노테이션이 조회되는 경우는 로그인이 필요한 경우로 판단할 수 있다.
			LoginUser loginUser = parameter.getParameterAnnotation(LoginUser.class);
			if (loginUser != null) {
				isLoginRequired = true;
				break;
			}
		}
		
		// 로그인을 요구하지 않는 요청핸들러 메소드인 경우다.
		if (!isLoginRequired) {
			return true;
		}
		
		// 로그인을 요구하는 요청핸들러 메소드다.
		// 세션에 로그인된 사용자 정보가 존재한다.
		if (request.getSession().getAttribute("LOGIN_USER") != null) {
			return true;
		}
		
		// 로그인을 요구하는 요청핸들러 메소드다.
		// 세션에 로그인된 사용자 정보가 존재하지 않는다.
		// 로그인화면을 재요청하는 URL을 응답으로 보낸다.
		response.sendRedirect("/login?fail=deny");
		return false;
	}
}

/*
 * 사용자정의 인터셉터 구현하기
 * 		인터셉터는 컨트롤러의 요청핸들러 메소드 실행전/실행후 작업을 수행할 수 있다.
 * 		HandlerInterceptor 인터페이스를 구현해서 정의한다.
 * 		HandlerInterceptor의 주요 API
 * 			boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
 * 				요청핸들러 메소드 실행전에 실행된다.
 * 				preHandle() 메소드가 true를 반환하면 요청핸들러 메소드가 실행된다.
 * 				preHandle() 메소드가 false를 반환하면 요청핸들러 메소드가 실행되지 않는다.
 * 
 * 			void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception
 * 				요청핸들러 메소드 실행후에 실행된다.
 * 			void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception
 * 				View객체의 render()메소드 실행 후 실행된다.
 * 			
 */
