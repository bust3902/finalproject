package kr.co.nc.web.form;

import lombok.Setter;
import lombok.ToString;

import org.springframework.util.StringUtils;

import lombok.Getter;

@Getter
@Setter
@ToString
public class KakaoLoginForm {

	private String id;
	private String nickname;
	private String email;
}
