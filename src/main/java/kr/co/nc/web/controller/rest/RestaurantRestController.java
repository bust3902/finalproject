package kr.co.nc.web.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.criteria.RestaurantCriteria;
import kr.co.nc.service.RestaurantService;
import kr.co.nc.vo.Restaurant;

/**
 * 음식점 데이터에 관해 서버와 자원을 주고 받는 컨트롤러입니다.
 * @author charles
 *
 */
@RestController
public class RestaurantRestController {

	@Autowired
	private RestaurantService restaurantService;
	
	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping(path = "/restaurants")
	public List<Restaurant> restaurants(RestaurantCriteria criteria) {
		return restaurantService.searchRestaurant(criteria);
	}
}
