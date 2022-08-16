package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소 태그 정보 저장을 위한 폼
 * ACCO_TAGS 테이블에 저장
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccoTagRegisterForm")
public class AccoTagRegisterForm {

	private int id;
	private String tag; // 숙소 태그 정보
	
	public AccoTagRegisterForm(int id, String tag) {
		this.id = id;
		this.tag = tag;
	}
}
