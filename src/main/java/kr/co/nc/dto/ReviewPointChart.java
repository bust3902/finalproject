package kr.co.nc.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
/**
 * 평점 분포 차트를 위한 집계 정보를 표현하는 hashMap 구현객체
 * key=point1, point2, ..., point5 / value=(n점에 대한 리뷰정보 개수)
 * @author doyoung
 *
 */
public class ReviewPointChart extends HashMap<String, Integer> {

	// 해당 업소에 대해 사용자가 남긴 평점 중 1 ~ 5 사이인 정수 n점에 대한 개수를 저장한다. (리뷰 등록에서 1,2,3,4,5만 선택할 수 있게 되어있음)
	// db로부터 전달받은 집계정보를 이용해 값을 저장해야 객체를 생성할 수 있다.
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ReviewPointChart(List<Map<String, Integer>> countResults) {
		if (countResults.isEmpty()) {
			this.put("point1", 0);
			this.put("point2", 0);
			this.put("point3", 0);
			this.put("point4", 0);
			this.put("point5", 0);
		} else {
			for (Map<String, Integer> result : countResults) {
				// 해당 평점의 리뷰가 없어도, 0으로 집계되어 map객체에 저장되어 있으므로 point1부터 point5까지 모두 저장된다.
				// 오라클의 number값은 캐스팅 오류가 발생하기도 하기 때문에 아래처럼 직접 형변환해줄것
				this.put("point" + Integer.parseInt(String.valueOf(result.get("POINT"))), Integer.parseInt(String.valueOf(result.get("COUNT"))));
			}
		}
	}
}
