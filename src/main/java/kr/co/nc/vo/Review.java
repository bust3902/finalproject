package kr.co.nc.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Review")
public class Review {

	private int no;
	private User user;
	private Restaurant restaurant;
	private Accommodations acco;
	private String title;
	private String content;
	private int likeCount;
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private String image;
	private int point;
}
