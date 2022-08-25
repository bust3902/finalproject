package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.nc.criteria.LikeCriteria;
import kr.co.nc.criteria.RestaurantCriteria;
import kr.co.nc.vo.Accommodation;
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
	
	// 리스트 출력시 모든 태그를 조회
	List<String> getAllTags();
	// 리스트 출력시 모든 카테고리를 조회
	List<Category> getAllCategories();
	// 리스트 출력시 모든 지역정보를 조회
	List<City> getAllCities();
	
	// 검색조건에 따른 맛집 정보를 조회
	List<Restaurant> getRestaurantByCriteria(RestaurantCriteria criteria);
	// 음식점 리뷰
	List<Review> getRestaurantReviewsByRestaurantNo(int restaurantNo);

	
	//// 찜하기 관련
	// 해당 사용자의, 해당 번호의 식당에 대한 찜하기 정보가 존재하면 1을, 존재하지 않으면 0을 반환
	int isExistUserLikeByRestaurantNo(LikeCriteria criteria);
	// 해당 사용자의, 해당 번호의 식당에 대한 찜하기 정보 저장
	void insertUserLikeByRestaurantNo(LikeCriteria criteria);
	// 해당 사용자의, 해당 번호의 식당에 대한 찜하기 정보 삭제
	void deleteUserLikeByRestaurantNo(LikeCriteria criteria);
	// 사용자가 찜하기 누른 모든 식당 정보 반환
	List<Accommodation> getAllLikedRestaurantByUserNo(int no);
	
	// 식당정보 업데이트
	void updateRestaurant(Restaurant restaurant);

	// 해당고유번호로 식당명만 반환
	String getNameByNo(int restaurantNo);
	
}
