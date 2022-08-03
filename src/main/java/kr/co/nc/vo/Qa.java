package kr.co.nc.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Qa")
public class Qa {

	private int no;
	private User user;
	private String content;
	private String title;
	private Date createdDate;
	private String image;
	private boolean answerStatus;
}
