package kr.co.nc.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
@Alias("User")
public class User {

	private int no;
	private String id;
	private String password;
	private String name;
	private String email;
	private String tel;
	private String address;
	private Date updatedDate;
	private Date createdDate;
	private String autority;
}
