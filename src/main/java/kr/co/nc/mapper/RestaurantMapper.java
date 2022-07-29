package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.RestaurantCategory;
import kr.co.nc.vo.RestaurantMenu;
import kr.co.nc.vo.RestaurantTag;
import kr.co.nc.vo.Review;

@Mapper
public interface RestaurantMapper {

	// 음식점 디테일에 활용할 mapper 인터페이스
	List<RestaurantCategory> getRestaurantCategoriesByRestaurantNo(int restaurantNo);
	List<RestaurantMenu> getRestaurantMenusByRestaurantNo(int restaurantNo);
	List<RestaurantTag> getRestaurantTagsByRestaurantNo(int restaurantNo);
	Restaurant getRestaurantByNo(int restaurantNo);
	
	// 음식점 리뷰 mapper 인터페이스
	List<Review> getAllRestaurantReview();
	
	// 리스트 출력시 사용할 태그
	List<String> getAllTags();
}