package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 객실 시설 정보 저장을 위한 폼
 * ROOM_FACILITIES 테이블에 저장
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccoRoomFacilitiesRegisterForm")
public class AccoRoomFacilitiesRegisterForm {

	private int no;
	private String roomFacilities; // 객실 시설 정보
	
	public AccoRoomFacilitiesRegisterForm(int no, String roomFacilities) {
		this.no = no;
		this.roomFacilities = roomFacilities;
	}
}
