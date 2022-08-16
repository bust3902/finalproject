package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소 타입 저장을 위한 폼
 * ACCO_TYPES 테이블에 저장
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccoTypeRegisterForm")
public class AccoTypeRegisterForm {

	private int id;
	private String typeId; // 숙소 타입 아이디
	
	public AccoTypeRegisterForm(int id, String typeId) {
		this.id = id;
		this.typeId = typeId;
	}
}
