package kr.co.nc.web.form;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserRegisterForm {

	private String id;
	private String password;
	private String nickname;
	private String name;
	private String email;
}
