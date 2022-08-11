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
@Alias("AccoRoomFacilitiesRegisterForm")
public class AccoRoomFacilitiesRegisterForm {

	private int no;
	private String roomFacilities;
	
	public AccoRoomFacilitiesRegisterForm(int no, String roomFacilities) {
		this.no = no;
		this.roomFacilities = roomFacilities;
	}
}
