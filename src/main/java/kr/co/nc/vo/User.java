package kr.co.nc.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class User {

		// 사용자 번호 - 시퀀스로 부여되는 번호다.
		private int no;
		
		// 사용자 아이디 - 회원가입할 때 입력한 사용자 아이디, 카카오 로그인에서 제공하는 사용자 식별번호다.
		private String nickname;
		private String name;
		private String id;
		private String password;
		private String tel;
		private String address;
		
		// 사용자의 이름 - 회원가입할 때 입력한 사용자 이름, 카카오 로그인에서 제공하는 사용자 닉네임이다.
		private String email;
		
		// 로그운 구분 - 본 사이트에서 가입한 경우:normal, 카카오 로그인으로 가입한 경우: kakao다.
		private String loginType;
		private String disabled;
		private Date updatedDate;
		private Date createdDate;
		
}
