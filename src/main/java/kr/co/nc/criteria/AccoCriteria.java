package kr.co.nc.criteria;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccoCriteria {

	private String currentLat; // 현재 위도
	private String currentLong; // 현재 경도
	private String keyword; // 검색으로 조회했을 경우 (해당 키워드를 숙소명이나 지역으로 가진 경우 조회)
	private String city; // 숙소유형으로 조회했을 경우 선택하는 지역 아이디
	private String startDate; // 검색 날짜 시작일 (요청을 통해 전달받을 때 형변환 복잡하므로 string으로 받을 것)
	private String endDate; // 검색 날짜 종료일
	private int capacity; // 객실의 수용인원
	private int minPrice; // 1박 기준
	private int maxPrice;
	private String sort; // 정렬 기준 'rate', 'dist', 'rowprice', 'highprice'
	private List<String> types; // 숙소유형 중복검색 아이디
	private List<String> commonFacilities; // 검색 시 선택한 공용시설 옵션의 ID 리스트
	private List<String> roomFacilities; // 검색 시 선택한 객실시설 옵션의 ID 리스트
	private List<String> tags; // 검색시 선택한 기타 사항 리스트(문자 그대로 조회)
	
}
