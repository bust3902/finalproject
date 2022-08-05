package kr.co.nc.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/*
 * @Target
 * 		사용자정의 어노테이션이 적용대상을 지정한다.
 * 		ElementType.TYPE				클래스, 인터페이스
 * 		ElementType.METHOD				메소드
 * 		ElementType.FIELD				멤버변수
 * 		ElementType.CONSTRUCTOR			생성자
 * 		ElementType.PARAMETER			매개변수
 * 		ElementType.ANNOTATION_TYPE		다른 어노테이션
 * @Retention
 * 		사용자정의 어노테이션이 활용되는 싯점을 지정한다.
 * 		RetentionPolicy.SOURCE		소스코드레벨에서 분석되고 활용된다.
 * 		RetentionPolicy.CLASS		컴파일할 때 분석되고 활용된다.
 * 		RetentionPolicy.RUNTIME		프로그램 실행시에 분석되고 활용된다.
 * 		
 */

/**
 * <p>사용자정의 어노테이션이다.
 * <p>메소드의 매개변수에 정의하는 어노테이션이다.
 * <p>이 어노테이션은 로그인된 사용자정보를 전달받아야할 때 사용한다.
 * <pre>
 * @GetMapping("/user/dashboard")
 * public String home(@LoginUser User user, Model model) {
 * 		
 * }	
 * </pre>
 * @author lysuk
 *
 */
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
public @interface LoginUser {

}
