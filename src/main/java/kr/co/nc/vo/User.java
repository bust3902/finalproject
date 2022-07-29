package kr.co.nc.vo;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("User")
public class User {

	int no;
	String id;
	String password;
	String name;
	String email;
	String tel;
	String address;
	Date updatedDate;
	Date createdDate;
	
}
