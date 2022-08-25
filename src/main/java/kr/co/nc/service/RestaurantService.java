package kr.co.nc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.nc.criteria.LikeCriteria;
import kr.co.nc.criteria.RestaurantCriteria;
import kr.co.nc.mapper.RestaurantMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.Category;
import kr.co.nc.vo.City;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.User;

/*
 * @Transactional
 * 		- 선언적 트랜잭션 처리를 지원하는 어노테이션이다.
 * 		- @Transactional 어노테이션이 지정된 인터페이스의 구현클래스, @Transactional 어노테이션이 지정된 구현클래스의 모든 메소드들이
 * 			실행될 때마다 트랜잭션처리가 지원된다.
 * 			@Transactional 어노테이션이 지정된 곳의 메소드가 실행되면, 메소드 실행전에 새로운 트랜잭션이 시작된다.
 * 			메소드를 실행하는 동안 오류 없이 메소드가 종료되면 해당 트랜잭션안에서 실행한 모든 작업을 데이터베이스에 반영시키는
 * 			commit이 실행되고, 메소드를 실행하는 동안 오류가 발생하면 해당 트랜잭션안에서 실행한 모든 작업의 데이터베이스를 반영을 취소시키는
 * 			rollback이 실행된다.
 * 			- 선언적 트랜잭션 처리가 필요한 곳은 비즈니스 로직을 수행하기 위해서 여러번의 데이터베이스 엑세스 작업을 실행하는
 * 			서비스 클래스다.
 */

@Service
public class RestaurantService {


	@Autowired
	private RestaurantMapper restaurantMapper;
	
	// 음식점 디테일 service
	public Restaurant getRestaurantDetail(int restaurantNo) {
		return restaurantMapper.getRestaurantByNo(restaurantNo);
	}
	
	// 음식점 디테일 재정의
	public Restaurant getRestaurantDetail(Integer userNo, int restaurantNo) {
		Restaurant restaurant = restaurantMapper.getRestaurantByNo(restaurantNo);
		if (userNo != null) {
			restaurant.setLiked(isLikedRestaurant(new LikeCriteria(userNo, restaurantNo)));
		} else {
		}
		return restaurant;
	}
	
	
	// 음식점 모든 리뷰 service
	public List<Review> getAllRestaurantReview() {
		return restaurantMapper.getAllReview();
	}
	
	
	// 카테고리 아이디를 받아 음식점 검색
	public List<Restaurant> getRestaurantsByCategoryId(String categoryId) {
		return restaurantMapper.getRestaurantsByCategoryId(categoryId);
	}
	
	/**
	 * 검색조건에 따른 식당을 검색하여 리스트를 반환한다.
	 * @param criteria
	 * @return
	 */
	public List<Restaurant> searchRestaurant(RestaurantCriteria criteria) {
		return restaurantMapper.getRestaurantByCriteria(criteria);
	}
	/**
	 * 검색조건에 따른 식당을 검색한뒤, 사용자번호를 이용해 해당 사용자의 찜 여부를 식당 객체에 저장시킨 리스트를 반환한다.
	 * @param userNo
	 * @param criteria
	 * @return
	 */
	public List<Restaurant> searchRestaurant(Integer userNo, RestaurantCriteria criteria) {
		List<Restaurant> restaurants = searchRestaurant(criteria);
		// 로그인 사용자 정보를 전달받은 경우, 맛집 홈에서 온 요청으로 찜하기 상태를 조회해 각 아이템에 저장시킨다.
		if (userNo != null) {
			for (Restaurant restaurant : restaurants) {
				restaurant.setLiked(isLikedRestaurant(new LikeCriteria(userNo, restaurant.getNo())));
			}
		}
		return restaurants;
	}

	
	// 모든 카테고리를 가져오기

	public List<Category> getAllCategories() { 
		return restaurantMapper.getAllCategories();
	}

	
	// 모든 태그를 가져오기
	public List<String> getAlltags() {
		return restaurantMapper.getAllTags();
	}
	
	// 모든 위치를 가져오기
	public List<City> getAllCity() {
		return restaurantMapper.getAllCities();
	}
	
	/**
	 * 해당 번호를 가진 사용자의, 해당 아이디를 가진 식당에 대한 찜하기 상태를 변경한다.
	 * USER_RESTAURANT_LIKES 테이블에 해당 사용자의 해당 식당 찜하기 정보가 있으면 삭제하고, 없으면 추가한다.
	 * 변경에 따라 해당 숙소의 찜하기 개수 정보를 업데이트 한다.
	 * 트랜잭션 처리를 통해 중간에 오류가 발생하면 모든 DB 변경사항을 롤백시킨다.
	 * @param loginUser
	 * @param restaurantNo
	 */
	@Transactional
	public void changeMyRestaurantLikeStatus(User loginUser, int restaurantNo) {
		int userNo = loginUser.getNo();
		LikeCriteria criteria = new LikeCriteria(userNo, restaurantNo);
		
		// 식당 찜 개수 정보를 업데이트 하기 위해 식당 객체 획득
		// **** update할 때 다른 컬럼에 null값 들어가지 않도록 할 것!! **** 
		Restaurant restaurant = restaurantMapper.getRestaurantByNo(restaurantNo);
		int likeCount = restaurant.getLikeCount();
		
		// isExistUserLikeByRestaurantNo(param)는 존재하면 1을, 존재하지 않으면 0을 반환한다.
		if (isLikedRestaurant(criteria)) {
			restaurantMapper.deleteUserLikeByRestaurantNo(criteria);
			likeCount--;
		} else {
			restaurantMapper.insertUserLikeByRestaurantNo(criteria);
			likeCount++;
		}
		
		if (likeCount < 0) {
			//값을 변경한 likeCount가 음수이면 잘못된 정보가 들어가게 되므로 예외를 발생시킨다.
			throw new RuntimeException("숙소의 찜 개수는 음수가 될 수 없습니다.");
		}
		
		// 찜하기 상태 변경을 반영한 숙소 정보 업데이트
		restaurant.setLikeCount(likeCount);
		restaurantMapper.updateRestaurant(restaurant);
	}
	
	/**
	 * 해당 사용자가 해당 식당을 찜하기 눌렀는지 여부를 조회해 boolean타입의 값으로 반환한다.
	 * @param criteria {userNo=사용자번호, id=식당번호}가 담긴 객체
	 * @return
	 */
	public boolean isLikedRestaurant(LikeCriteria criteria) {
		return restaurantMapper.isExistUserLikeByRestaurantNo(criteria) == 1 ? true : false;
	}
	
	/**
	 * 해당 사용자가 찜하기를 누른 모든 식당을 반환한다.
	 * @param userNo
	 * @return
	 */
	public List<Accommodation> getAllLikedItemsByUser(int userNo) {
		return restaurantMapper.getAllLikedRestaurantByUserNo(userNo);
	}

	public String getNameByNo(int restaurantNo) {
		return restaurantMapper.getNameByNo(restaurantNo);
	}
}
