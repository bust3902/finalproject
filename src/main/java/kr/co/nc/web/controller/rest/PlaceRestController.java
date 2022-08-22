package kr.co.nc.web.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.criteria.LikeCriteria;
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
	public List<Place> places(@RequestParam(required = false) Integer userNo, PlaceCriteria criteria) {
		List<Place> places = placeService.searchPlacesByCriteriaWithPagination(criteria);
		// 로그인 사용자 정보를 전달받은 경우, 맛집 홈에서 온 요청으로 찜하기 상태를 조회해 각 아이템에 저장시킨다.
		if (userNo != null) {
			for (Place place : places) {
				place.setLiked(placeService.isLikedPlace(new LikeCriteria(userNo, place.getId(), place.getType())));
			}
		}
		return places;
	}
	
	// 검색 결과에 대한 pagination 객체 반환
	@GetMapping(path = "/places/pagination")
	public Pagination pagination(PlaceCriteria criteria) {
		return placeService.generatePagination(criteria);
	}
}
