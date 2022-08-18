package kr.co.nc.criteria;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RestaurantCriteria {
	// 현재 위도
	private String currentLat; 
	// 현재 경도
	private String currentLong;
	// 카테고리 아이디로 조회했을 경우
	private String categoryId;
	// 검색으로 조회했을 경우
	private String keyword;
	// 선택한 지역으로 검색했을 경우
	private String city;
	// 태그로 검색했을 경우
	private List<String> tags;
	// 정렬기준
	private String sort;
	
	private String minLat;
	
	private String maxLat;
	
	private String minLon;
	
	private String maxLon;
}
