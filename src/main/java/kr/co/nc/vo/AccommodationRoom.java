package kr.co.nc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
/**
 * 객실 정보를 표현하는 클래스. Accommodation 객체에서 이 객체를 타입으로 하는 리스트를 필드로 가진다.
 * @author doyoung
 *
 */
public class AccommodationRoom {

	private String accoId; // 이 객실이 포함된 숙소 아이디
	private int no;
	private String name;
	private int numbers; // 총 객실 수
	private int capacity; // 실별 최대 숙박 인원
	private int dayPrice; //1박 기본 요금
	private String thumbnailImageName; // 객실 대표이미지
	private String description; // 객실이용안내 모달에 출력할 객실소개
	private boolean isAvailable; // db에서 조회 시 기준날짜에 예약 가능 여부 저장할 것
	
	private List<RoomFacility> roomFacilities; // 이 객실이 가지는 모든 객실시설 정보
	private List<String> images; // 객실 이미지 파일명
	
}
