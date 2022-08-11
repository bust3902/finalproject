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
@Alias("AccoTypeRegisterForm")
public class AccoTypeRegisterForm {

	private int id;
	private String typeId;
	
	public AccoTypeRegisterForm(int id, String typeId) {
		this.id = id;
		this.typeId = typeId;
	}
}
