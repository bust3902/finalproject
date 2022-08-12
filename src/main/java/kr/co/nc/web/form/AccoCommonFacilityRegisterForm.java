package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소 공용시설 저장을 위한 폼
 * ACCO_COMMON_FACILITIES 테이블에 저장
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccoCommonFacilityRegisterForm")
public class AccoCommonFacilityRegisterForm {

	private int id;
	private String commonFacility; // 숙소 공용시설 정보
	
	public AccoCommonFacilityRegisterForm(int id, String commonFacility) {
		this.id = id;
		this.commonFacility = commonFacility;
	}
}
