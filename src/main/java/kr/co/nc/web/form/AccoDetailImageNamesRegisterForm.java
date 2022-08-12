package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소 이미지명 저장을 위한 폼
 * ACCO_DETAIL_IMAGES 테이블에 저장
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccoDetailImageNamesRegisterForm")
public class AccoDetailImageNamesRegisterForm {

	private int id;
	private String detailImageName; // 숙소 상세 이미지명
	
	public AccoDetailImageNamesRegisterForm(int id, String detailImageName) {
		this.id = id;
		this.detailImageName = detailImageName;
	}
}
