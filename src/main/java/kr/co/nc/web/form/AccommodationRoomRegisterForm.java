package kr.co.nc.web.form;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.RoomFacility;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 객실정보 저장용 폼
 * ACCO_ROOMS 테이블에 저장
 * @author USER
 *
 */
@Getter
@Setter
@ToString
@Alias("AccommodationRoomRegisterForm")
public class AccommodationRoomRegisterForm {

	private int no;
	private String name;
	private int numbers;				// 총 객실 수
	private int capacity;				// 실별 최대 숙박 인원
	private int dayPrice;				//1박 기본 요금
	private String thumbnailImageName;	// 객실 대표이미지
	private MultipartFile thumbnailImageFile; // 객실 대표이미지
	private String description;			// 객실 소개
	private String accoId;				// 이 객실이 포함된 숙소 아이디
	
	private List<String> detailImageNames = new ArrayList<>();			// 상세이미지 파일명 리스트
	private List<MultipartFile> detailImageFiles = new ArrayList<>();	// 상세이미지 파일 리스트
	private List<String> stringRoomFacilities = new ArrayList<>();		// 이 객실이 가지는 모든 객실시설 정보
	private List<RoomFacility> roomFacilities = new ArrayList<>();		// 이 객실이 가지는 모든 공용시설 정보
}
