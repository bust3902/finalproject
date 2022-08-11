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
@Alias("AccoRoomDetailImageNamesRegisterForm")
public class AccoRoomDetailImageNamesRegisterForm {

	private int id;
	private String detailImageNames;
	
	public AccoRoomDetailImageNamesRegisterForm(int id, String detailImageNames) {
		this.id = id;
		this.detailImageNames = detailImageNames;
	}
}
