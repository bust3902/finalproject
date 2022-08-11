package kr.co.nc.dto;

import java.util.HashMap;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
/**
 * 빈 별, 절반 채운 별, 채운 별 세 가지 종류를 가지는 별 아이콘 5개로 0 ~ 5 사이의 실수 값인 점수를 표현하는 객체
 * HashMap 클래스를 상속받는다.
 * map 객체에 1,2,3,4,5번째에 대해 html에서 표현할 부트스트랩 클래스 정보를 저장 (bi-star / bi-star-fill / bi-star-half)
 * 유효하지 않은 값으로 객체를 생성할 경우 모든 키값에 "" 공백 문자열이 저장된다.
 * @author doyoung
 *
 */
public class StarIconForRate extends HashMap<String, String> {

	private static final long serialVersionUID = 1L;

	// 조작되지 않은 실수값을 전달받아 이 객체에 key,value값을 저장하는 생성자
	public StarIconForRate(double rawReviewRate) {
		// 유효하지 않은 값으로 객체를 생성할 경우 모든 키값에 "" 공백 문자열이 저장된다.
		if (rawReviewRate < 0 || rawReviewRate > 5) {
			this.put("star1", "");
			this.put("star2", "");
			this.put("star3", "");
			this.put("star4", "");
			this.put("star5", "");
			return;
		}
		
		// 점수를 소수점 첫째 자리까지 반올림하기
		double reviewRate = Math.round(rawReviewRate*10)/10.0;
		System.out.println(rawReviewRate);
		System.out.println(reviewRate);
		for (int i = 1; i <= 5; i++) {
			if (i - 0.5 == reviewRate) {
			// ex) 평점이 1.5이면 2번째 별은 절반 채운 별이다.
				this.put("star" + i, "bi-star-half");
			} else if (i <= Math.round(reviewRate)) {
			// ex) 평점이 1.7이면 2번째 별은 다 채운 별이다.
				this.put("star" + i, "bi-star-fill");
			} else {
			// ex) 평점이 1.3이면 2번째 별은 빈 별이다.
				this.put("star" + i, "bi-star");
			}
		}

	}
}
