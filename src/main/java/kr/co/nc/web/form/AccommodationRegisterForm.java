package kr.co.nc.web.form;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.vo.CommonFacility;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소정보 저장용 폼
 * ACCOMMODATIONS 테이블에 저장
 * @author USER
 *
 */
@Getter
@Setter
@ToString
@Alias("AccommodationRegisterForm")
public class AccommodationRegisterForm {


	private int id;				// 숙소 아이디
	private String accoName;	// 숙소명
	private String district;	// 지역(시/군/구)명
	private String address;		// 주소
	private String latitude;	// 위도
	private String longitude;	// 경도
	private String introduceComment;			// 한줄소개
	private MultipartFile thumbnailImageFile;	// 메인 썸네일
	private String thumbnailImageName;			// 메인 썸네일 파일명
	private String detailDescription;			// 숙소 상세설명
	private String cityId;						// 지역 아이디
	
	private List<MultipartFile> detailImageFiles = new ArrayList<>();	// 숙소 상세 이미지
	private List<String> detailImageNames = new ArrayList<>(); 			// 숙소 상세 이미지 파일명
	private List<String> types;											// 이 숙소가 해당하는 모든 숙소유형
	private List<AccommodationRoomRegisterForm> accommodationRooms = new ArrayList<>(); // 이 숙소가 가지는 모든 객실정보
	private List<String> stringCommonFacilities = new ArrayList<>();	// 이 숙소가 가지는 모든 공용시설 정보
	private List<CommonFacility> commonFacilities = new ArrayList<>();	// 이 숙소가 가지는 모든 공용시설 정보
	private List<String> tags;											// 이 숙소가 가지는 모든 부가사항 태그

	private List<String> deleteImgNames = new ArrayList<>(); 			// 삭제할 숙소 상세 이미지 파일명
	private List<String> deleteTags = new ArrayList<>(); 				// 삭제할 태그명
	private List<String> deleteCommonFacilities = new ArrayList<>(); 	// 삭제할 공용시설타입
	
	public void addAccommodationRoomRegisterForm(AccommodationRoomRegisterForm accommodationRoomRegisterForm) {
		accommodationRooms.add(accommodationRoomRegisterForm);
	}
}
