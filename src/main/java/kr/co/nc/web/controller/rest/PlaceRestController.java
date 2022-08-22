package kr.co.nc.web.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.criteria.PlaceCriteria;
import kr.co.nc.dto.Pagination;
import kr.co.nc.dto.Place;
import kr.co.nc.service.PlaceService;

@RestController
public class PlaceRestController {

	@Autowired
	private PlaceService placeService;
	
	// 숙소,식당을 통합하여 키워드로 검색하여 거리순으로 반환
	@GetMapping(path = "/places")
	public List<Place> places(PlaceCriteria criteria) {
		return placeService.searchPlacesByCriteriaWithPagination(criteria);
	}
	
	// 숙소, 식당을 통합하여 거리순으로 사용자가 찜한 정보 반환
	@GetMapping(path = "/places/mylike")
	public List<Place> mylike(PlaceCriteria criteria) {
		// criteria에서 받는 값 : userNo, currentPage
		return placeService.searchMyLikePlacesWithPagination(criteria);
	}
	
	// 검색 결과/찜목록에 대한 pagination 객체 반환 (option = "places" 또는 "mylike")
	@GetMapping(path = "/places/pagination")
	public Pagination pagination(PlaceCriteria criteria, String option) {
		return placeService.generatePagination(criteria, option);
	}
}
