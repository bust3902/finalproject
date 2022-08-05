package kr.co.nc.web.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.criteria.AccoCriteria;
import kr.co.nc.service.AccommodationService;
import kr.co.nc.vo.Accommodation;

/**
 * 숙소 관련 요청에 대하여 데이터를 json 형식의 응답으로 반환하는 컨트롤러이다.
 * @author doyoung
 *
 */
@RestController
public class AccommodationRestController {
	
	@Autowired
	private AccommodationService accommodationService;
	
	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping(path = "/accommodations")
	@ResponseBody
	public List<Accommodation> accommodations(AccoCriteria criteria) {
		return accommodationService.searchAccommodation(criteria);
	}
}
