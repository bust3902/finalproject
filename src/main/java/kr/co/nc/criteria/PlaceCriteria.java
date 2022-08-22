package kr.co.nc.criteria;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PlaceCriteria {

	private String type; // 숙소는 A, 식당은 R, 지정하지 않으면 숙소, 식당을 모두 조회
	private String keyword;
	private String currentLat;
	private String currentLong;
	// 페이징을 위해 요청파라미터로 전달받는 값
	private int currentPage;
	// 페이징을 위해 서비스에서 저장하는 값
	private int beginIndex;
	private int endIndex;
}
