package kr.co.nc.web.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.AccommodationType;
import kr.co.nc.vo.CommonFacility;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommodationRegisterForm {


	private int id;
	private String name;
	private String district;
	private String address;
	private String latitude;
	private String longitude;
	private String introduceComment;
	private MultipartFile thumbnailImageFile;
	private String thumbnailImageName;
	private String detailDescription;
	private MultipartFile detailImageFile;
	private String detailImageName;
	private String cityId;
	
	private List<MultipartFile> detailImageFiles; // 숙소 상세 이미지
	private List<AccommodationType> types; // 이 숙소가 해당하는 모든 숙소유형
	private List<AccommodationRoom> rooms; // 이 숙소가 가지는 모든 객실정보
	private List<String> commonFacilities; // 이 숙소가 가지는 모든 공용시설 정보
	// private List<CommonFacility> commonFacilities; // 이 숙소가 가지는 모든 공용시설 정보
	private List<String> tags; // 이 숙소가 가지는 모든 부가사항 태그
}
