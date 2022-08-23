package kr.co.nc.web.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.AdminService;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.Restaurant;

/**
 * 숙소 입출력시 필요한 데이터를 전달하는 컨트롤러
 * @author USER
 *
 */
@RestController
@RequestMapping("/admin")
public class AdminRestController {
	
	@Autowired
	private AdminService adminService;
	@Autowired
	private AccommodationService accommodationService;

	
	// 숙소타입 선택시 공용시설 체크박스 출력을 처리하기 위한 데이터 전달
	@GetMapping("/searchCommonFacilities")
	@ResponseBody
	public List<CommonFacility> searchCommonFacilities(@RequestParam("types[]") List<String> types) {
		// 공용시설 정보 검색
		return adminService.getCommonFacilitiesByAccommodationTypes(types);
	}
	
	// 숙소유형 선택시 공용시설 리스트 출력을 위한 데이터 전달
	@GetMapping("/search")
	@ResponseBody
	public List<CommonFacility> search(@RequestParam("type") String type) {
		// type에 따른 공용시설 옵션 list 전달
		return accommodationService.getCommonFacilityOptions(type);
	}

	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping("/searchAccommodation")
	@ResponseBody
	public List<Accommodation> adminAccommodationSearch(@RequestParam("keyword") String keyword) {
		
		return adminService.searchAccommodation(keyword);
	}
	
	// 검색 조건에 맞는 음식점 리스트 반환
	@GetMapping("/searchRestaurant")
	@ResponseBody
	public List<Restaurant> adminRestaurantSearch(@RequestParam("keyword") String keyword) {
		
		return adminService.searchRestaurant(keyword);
	}
}
