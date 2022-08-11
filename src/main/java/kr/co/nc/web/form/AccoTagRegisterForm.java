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
@Alias("AccoTagRegisterForm")
public class AccoTagRegisterForm {

	private int id;
	private String tag;
	
	public AccoTagRegisterForm(int id, String tag) {
		this.id = id;
		this.tag = tag;
	}
}
