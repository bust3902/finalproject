package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 객실 상세 이미지명 저장을 위한 폼
 * ACCO_ROOM_DETAIL_IMAGES 테이블에 저장
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccoRoomDetailImageNamesRegisterForm")
public class AccoRoomDetailImageNamesRegisterForm {

	private int no;
	private String detailImageName; // 객실 상세 이미지명
	
	public AccoRoomDetailImageNamesRegisterForm(int no, String detailImageName) {
		this.no = no;
		this.detailImageName = detailImageName;
	}
}
