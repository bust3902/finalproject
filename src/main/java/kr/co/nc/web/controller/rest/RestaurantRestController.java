package kr.co.nc.web.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.criteria.LikeCriteria;
import kr.co.nc.criteria.RestaurantCriteria;
import kr.co.nc.service.RestaurantService;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.User;

/**
 * 음식점 데이터에 관해 서버와 자원을 주고 받는 컨트롤러입니다.
 * @author charles
 *
 */
@SessionAttributes("LOGIN_USER")
@RestController
public class RestaurantRestController {

	@Autowired
	private RestaurantService restaurantService;
	
	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping(path = "/restaurants")
	public List<Restaurant> restaurants(@RequestParam(required = false) Integer userNo, RestaurantCriteria criteria) {
		// userNo는 null이 들어올 수 있는 값이므로 wrapper타입으로 지정
		List<Restaurant> restaurants = restaurantService.searchRestaurant(criteria);
		// 로그인 사용자 정보를 전달받은 경우, 맛집 홈에서 온 요청으로 찜하기 상태를 조회해 각 아이템에 저장시킨다.
		if (userNo != null) {
			for (Restaurant restaurant : restaurants) {
				restaurant.setLiked(restaurantService.isLikedRestaurant(new LikeCriteria(userNo, restaurant.getNo())));
			}
		}
		return restaurants;
	}
	
	// 식당 찜하기 토글
	@GetMapping(path = "/changelike/restaurant")
	public boolean like(@LoginUser User loginUser, int restaurantNo) {
		try {
			// 서비스에서 비즈니스 로직 수행 : service에서는 user_restaurant_like 테이블에 일치하는 정보가 존재하면 삭제하고, 존재하지 않으면 저장한다.
			restaurantService.changeMyRestaurantLikeStatus(loginUser, restaurantNo);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
