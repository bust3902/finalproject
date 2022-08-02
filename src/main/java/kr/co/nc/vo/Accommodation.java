package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Accommodation {

	private int id;
	private String name;
	private String district;
	private String address;
	private String latitude;
	private String longitude;
	private String introduceComment;
	private String thumbnailImageName;
	private String detailDescription;
	private String detailImageName1;
	private String detailImageName2;
	private String detailImageName3;
	private double reviewRate; // (모든 사용자의 평점 합/리뷰 수)를 계산한 평점
	private int reviewCount;
	private int likeCount;
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private String cityId;
	
	private List<AccommodationType> types; // 이 숙소가 해당하는 모든 숙소유형
	private List<AccommodationRoom> rooms; // 이 숙소가 가지는 모든 객실정보
	private List<CommonFacility> commonFacilities; // 이 숙소가 가지는 모든 공용시설 정보
	private List<String> tags; // 이 숙소가 가지는 모든 부가사항 태그
	
}
