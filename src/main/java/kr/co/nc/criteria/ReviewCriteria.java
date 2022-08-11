package kr.co.nc.criteria;

import lombok.Getter;

/**
 * 리뷰를 조회할 때 사용하는 검색기준.
 * accoId != 0 이면 식당 리뷰 중 해당 id를 식당번호로 하는 식당 리뷰만 모두 조회한다.
 * restaurantNo != 0이면 숙소 리뷰 중 해당 no를 숙소번호로 하는 숙소 리뷰만 모두 조회한다.
 * 두 값을 모두 저장할 경우를 방지하기 위해 setter메소드를 정의하지 않고, 특정 생성자를 강제한다.
 * @author doyoung
 *
 */
@Getter
public class ReviewCriteria {

	private int accoId; 
	private int restaurantNo;
	
	/**
	 * ReviewCriteria 객체를 생성하기 위해 강제되는 생성자 메소드.
	 * @param option : accommodation 또는 restaurant 를 입력. 둘 중 어느 문자열과도 일치하지 않으면 두 필드에 0이 저장된다.
	 * @param value : 해당 숙소/식당의 식별번호(accoId/restaurantNo)를 입력
	 */
	public ReviewCriteria(String option, int value) {
		if ("accommodation".equals(option)) {
			this.accoId = value;
		} else if ("restaurant".equals(option)) {
			this.restaurantNo = value;
		}
	}
}
