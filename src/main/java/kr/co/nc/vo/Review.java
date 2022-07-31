package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

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
	private User user;				// userNo대신 썼습니다
	private Restaurant restaurant;	// restaurantNo 대신 썼습니다.
	private int accoId;				// 숙소 번호
	private String title;
	private String content;
	private int likeCount;
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private String image;		// 리뷰 사진
	private int point;			// 리뷰 평점
	
	private List<ReviewRestaurantTag> reviewRestaurantTags;		// 음식점 리뷰 태그
}
