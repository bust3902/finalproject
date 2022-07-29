package kr.co.nc.mapper;

import java.util.List;

import kr.co.nc.vo.Review;

public interface RestaurantMapper {

	// 음식점 mapper인터페이스
	List<Review> getAllRestaurantReview();
}
