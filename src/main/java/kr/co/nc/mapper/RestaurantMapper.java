package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.nc.vo.Category;
import kr.co.nc.vo.City;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.RestaurantCategory;
import kr.co.nc.vo.RestaurantMenu;
import kr.co.nc.vo.RestaurantTag;
import kr.co.nc.vo.Review;

@Mapper
public interface RestaurantMapper {

	// 카테고리별 음식점 정보를 가져오는 mapper 인터페이스
	List<Restaurant> getRestaurantsByCategoryId(@Param("categoryId") String categoryId);
	
	// 음식점 디테일에 활용할 mapper 인터페이스
	List<RestaurantCategory> getRestaurantCategoriesByRestaurantNo(int restaurantNo);
	List<RestaurantMenu> getRestaurantMenusByRestaurantNo(int restaurantNo);
	List<RestaurantTag> getRestaurantTagsByRestaurantNo(int restaurantNo);
	List<Review> getReviewByRestaurantNo(int restaurantNo);
	Restaurant getRestaurantByNo(int restaurantNo);
	
	// 모든 음식점 리뷰를 가져오는 mapper 인터페이스
	List<Review> getAllReview();
	
	// 리스트 출력시 사용할 태그
	List<String> getAllTags();
	
	List<Category> getAllCategories();
	
	List<City> getAllCities();
}
