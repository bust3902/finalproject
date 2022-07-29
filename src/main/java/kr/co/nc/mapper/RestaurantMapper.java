package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Review;

@Mapper
public interface RestaurantMapper {

	// 음식점 mapper인터페이스
	List<Review> getAllRestaurantReview();
}
