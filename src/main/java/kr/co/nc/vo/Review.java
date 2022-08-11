package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.co.nc.dto.StarIconForRate;
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
	private AccommodationRoom room; // 객실 정보 (등록할 때는 no 저장, 조회할때는 name 저장)
	private String title;
	private String content;
	private int likeCount;
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private String image;		// 리뷰 사진
	private int point;			// 리뷰 평점
	private int roomNo;			// 방 번호
	
	private List<ReviewRestaurantTag> reviewRestaurantTags;		// 음식점 리뷰 태그
	
	// 화면 표현 시 사용하는 필드
	private StarIconForRate pointIcon; // 리뷰 별점 아이콘을 표현하는 hashMap을 상속받는 객체
	
	// setter메소드를 다시 정의함: 리뷰 조회 시 point를 가져올 때 아이콘 객체를 함께 생성해 저장한다.
	public void setPoint(int point) {
		this.point = point;
		this.pointIcon = new StarIconForRate(point);
	}
	
}
