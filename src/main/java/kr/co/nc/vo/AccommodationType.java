package kr.co.nc.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
/**
 * 숙소 유형 정보를 표현하는 객체 (모텔, 호텔리조트, 펜션, 게스트하우스, 캠핑글램핑, 한옥)
 * @author doyoung
 *
 */
public class AccommodationType {

	private String id;
	private String name;
}
