package kr.co.nc.argumentResolver;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.vo.User;



/**
 * <p>사용자정의 ArgumentResolver 다.
 * <p>ArgumentResolver는 요청핸들러 메소드의 매개변수를 분석해서 적절한 값 혹은 객체를 매개변수에 전달한다.
 * <p>사용자정의 ArgumentResolver는 HandlerMethodArgumentResolver 인터페이스를 구현한다.
 * <p>HandlerMethodArgumentResolver 인터페이스의
 * 		<p>boolean supportsParameter(MethodParameter parameter) 메소드가 true를 반환하면 resolveArgument()메소드를 실행시켜서
 *    	   매개변수에 적절한 값 혹은 객체를 전달한다.
 * 		<p>요청핸들러의 매개변수에 @LoginUser 어노테이션이 지정되어 있으면 true를 반환하도록 구현한다.
 * 
 * 		<p>Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception
 * 		<p>Object resolveArgument() 메소드는 요청핸들러 메소드의 매개변수에 전달할 값 혹은 객체를 제공하는 메소드다.
 * 		<p>이 메소드가 반환하는 객체가 요청핸들러 메소드의 매개변수에 전달된다.
 * 		<p>HttpSession객체에서 "LOGIN_USER"라는 속성명으로 저장된 인증된 사용자정보를 반환하도록 구현한다.
 * @author lysuk
 *
 */
public class LoginUserArgumentResolver implements HandlerMethodArgumentResolver {

	/*
	 * MethodParameter
	 * 		요청핸들러 메소드의 매개변수 정보를 포함하고 있는 객체다.
	 * 		parameter.hasParameterAnnotation(Class<A> annotationType)
	 * 			매개변수가 지정된 어노테이션을 포함하고 있으면 true를 반환한다.
	 * 
	 * 요청핸들러의 매개변수에 @LoginUser 어노테이션이 지정되어 있으면 true를 반환하도록 구현한다.
	 */
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return parameter.hasParameterAnnotation(LoginUser.class);
	}
	
	/*
	 * boolean supportsParameter(MethodParameter parameter) 메소드가 true를 반환할 때만 실행되는 메소드다.
	 * 요청핸들러 메소드의 매개변수에 제공할 객체를 반환한다.
	 * 
	 * HttpSession객체에 "LOGIN_USER"라는 이름으로 저장한 인증된 사용자정보를 조회해서 반환한다.
	 * 
	 * NativeWebRequest
	 * 		요청객체와 응답객체에 관련된 유용한 메소드를 제공하는 객체다.
	 */
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		
		User user = (User) webRequest.getAttribute("LOGIN_USER", WebRequest.SCOPE_SESSION);
		return user;
	}
}
