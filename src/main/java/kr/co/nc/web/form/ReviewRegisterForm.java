package kr.co.nc.web.form;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.dto.StarIconForRate;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.ReviewRestaurantTag;
import kr.co.nc.vo.User;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewRegisterForm {

	private int no;
	private User user;
	private Restaurant restaurant;
	private int accoId;
	private AccommodationRoom room;
	private String title;
	private String content;
	private int likeCount;
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private String image;
	private MultipartFile imageFile;
	private int point;
	private int roomNo;
	private List<String> categoryIds;
	
	private List<ReviewRestaurantTag> reviewRestaurantTags;

	private StarIconForRate pointIcon;
	
	public void setPoint(int point) {
		this.point = point;
		this.pointIcon = new StarIconForRate(point);
	}
}