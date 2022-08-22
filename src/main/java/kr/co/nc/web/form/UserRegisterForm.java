package kr.co.nc.web.form;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserRegisterForm {

	@NotBlank(message = "아이디는 필수입력값입니다.")
	@Pattern(regexp = "/^[a-z]+[a-z0-9]{5,19}$", message = "아이디는 영문자로 시작하며, 영문자 또는 숫자 6~20자만 허용됩니다.")
	private String id;
	
	@NotBlank(message = "비밀번호는 필수입력값입니다.")
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[~!@#$%^&*()+|=])[A-Za-z\\d~!@#$%^&*()+|=]{8,16}$", message = "비밀번호는 숫자,영어대소문자, 특수문자가 1개 이상, 8글자 ~ 16글자까지 허용됩니다.")
	private String password;
	
	@NotBlank(message = "닉네임은 필수입력값입니다.")
	@Pattern(regexp = "^[가-힣]{2,}$", message = "닉네임은 한글로 2글자 이상만 허용됩니다.")
	private String nickname;
	
	@NotBlank(message = "이름은 필수입력값입니다.")
	@Pattern(regexp = "^[가-힣]{2,}$", message = "이름은 한글로 2글자 이상만 허용됩니다.")
	private String name;
	
	@NotBlank(message = "전화번호는 필수입력값입니다.")
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "유효한 전화번호 형식이 아닙니다.")
	private String tel;
	
	@NotBlank(message = "이메일은 필수 입력값입니다.")
	@Email(message = "유효한 이메일 형식이 아닙니다.")
	private String email;
}
