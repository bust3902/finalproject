package kr.co.nc.criteria;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlaceCriteria {

	private String type; // 숙소는 A, 식당은 R, 지정하지 않으면 숙소, 식당을 모두 조회
	private String keyword;
	
}
