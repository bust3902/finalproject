package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccoCommonFacilityRegisterForm")
public class AccoCommonFacilityRegisterForm {

	private int id;
	private String commonFacility;
	
	public AccoCommonFacilityRegisterForm(int id, String commonFacility) {
		this.id = id;
		this.commonFacility = commonFacility;
	}
}
