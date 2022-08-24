package kr.co.nc.web.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.criteria.RestaurantCriteria;
import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.service.RestaurantService;
import kr.co.nc.service.ReviewService;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.User;

@RestController
public class RestaurantRestController {

	@Autowired
	private RestaurantService restaurantService;
	@Autowired
	private ReviewService reviewService;
	
	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping(path = "/restaurants")
	public List<Restaurant> restaurants(@RequestParam(required = false) Integer userNo, RestaurantCriteria criteria) {
		// userNo는 null이 들어올 수 있는 값이므로 wrapper타입으로 지정
		List<Restaurant> restaurants = null; 
		if (userNo == null) {
			restaurants = restaurantService.searchRestaurant(criteria);
		} else {
			// 로그인 사용자 정보를 전달받은 경우, 맛집 홈에서 온 요청으로 찜하기 상태를 조회해 각 아이템에 저장시킨다.
			restaurants = restaurantService.searchRestaurant(userNo, criteria);
		}
		return restaurants;
	}
	
	// 해당 식당에 대한 리뷰 리스트, 평점분포 집계결과 반환
	@GetMapping(path = "/reviews/restaurant")
	public Map<String, Object> reviews(int restaurantNo) {
		// 두 가지 정보를 map객체에 담아 반환한다.
		Map<String, Object> reviewdatas = new HashMap<>();
		// 리뷰 리스트
		ReviewCriteria criteria = new ReviewCriteria("restaurant", restaurantNo);
		reviewdatas.put("reviews", reviewService.getReviewsByCriteria(criteria));
		// 평점분포 집계결과 객체
		reviewdatas.put("chartData", reviewService.getReviewPointChart(criteria));
		return reviewdatas;
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
