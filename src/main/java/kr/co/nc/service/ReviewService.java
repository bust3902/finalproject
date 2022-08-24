package kr.co.nc.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.dto.ReviewPointChart;
import kr.co.nc.mapper.AccommodationMapper;
import kr.co.nc.mapper.RestaurantMapper;
import kr.co.nc.mapper.ReviewMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.ReviewRegisterForm;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;
	@Autowired
	private AccommodationMapper accommodationMapper;
	@Autowired
	private RestaurantMapper restaurantMapper;
	
	/**
	 * 새 리뷰정보를 등록하는 메소드. accoId, restaurantNo의 값에 따라 숙소 또는 식당에 대한 리뷰를 등록한다.
	 * 리뷰정보를 리뷰테이블에 저장한 뒤 숙소 또는 식당 테이블의 리뷰개수, 리뷰평점을 변경시킨다.
	 * 모든 DB 액세스 작업 중 하나라도 오류가 나면 모두 롤백시킨다.
	 * @param user
	 * @param restaurantNo
	 * @param roomNo
	 * @param accoId
	 * @param reviewRegisterForm
	 */
	@Transactional
	public void addNewReview(@LoginUser User user,@RequestParam(name="restaurantNo",required=false)Integer restaurantNo,@RequestParam(name="roomNo",required=false)Integer roomNo,@RequestParam(name="accoId",required=false)Integer accoId,  ReviewRegisterForm reviewRegisterForm ) {
		Review review = new Review();
		review.setTitle(reviewRegisterForm.getTitle());
		review.setContent(reviewRegisterForm.getContent());
		review.setLikeCount(reviewRegisterForm.getLikeCount());
		review.setImage(reviewRegisterForm.getImage());
		review.setPoint(reviewRegisterForm.getPoint());
		review.setUser(user);
		if(accoId != null) {
			review.setAccoId(accoId);
			review.setRoomNo(roomNo);
			reviewMapper.insertAccommodationReview(review);
			
			// 정상적으로 insert되면 해당 장소의 리뷰개수를 1 증가시키고, 평점을 변경시킨다.
			Accommodation accommodation = accommodationMapper.getAccommodationById(accoId);
			// 리뷰개수
			int previousReviewCount = accommodation.getReviewCount();
			int reviewCount = previousReviewCount + 1;
			accommodation.setReviewCount(reviewCount);
			//리뷰평점
			double originalReviewRate = accommodation.getReviewRate();
			double reviewRate = 0;
			// 업무로직 때문이 아니라, 데이터베이스에 리뷰정보는 0개인데 크롤링데이터에서 가져온 숙소평점은 존재하는 숙소정보를 위한 if문
			if (originalReviewRate != 0 && reviewCount == 0) {
				reviewRate = originalReviewRate;
			} else {
				reviewRate = (originalReviewRate*previousReviewCount + review.getPoint())/reviewCount;
			}
			accommodation.setReviewRate(reviewRate);
			accommodationMapper.updateAccommodation(accommodation);
		} else if(restaurantNo != null) {
			review.setRestaurantNo(restaurantNo);
			reviewMapper.insertRestaurantReview(review);
			
			// 정상적으로 insert되면 해당 장소의 리뷰개수를 1 증가시키고, 평점을 변경시킨다.
			Restaurant restaurant = restaurantMapper.getRestaurantByNo(restaurantNo);
			// 리뷰개수
			int previousReviewCount = restaurant.getReviewCount();
			int reviewCount = previousReviewCount + 1;
			restaurant.setReviewCount(reviewCount);
			// 리뷰평점
			double originalReviewRate = restaurant.getReviewPoint();
			double reviewRate = (originalReviewRate*previousReviewCount + review.getPoint())/reviewCount;
			restaurant.setReviewPoint(reviewRate);
			restaurantMapper.updateRestaurant(restaurant);
		}
		
	}
		
	/**
	 * 숙소 또는 식당 리뷰를 반환 (원하는 대상에 따라 criteria의 값을 set해서 전달할 것)
	 * @param criteria
	 * @return
	 */
	public List<Review> getReviewsByCriteria(ReviewCriteria criteria) {
		// TODO criteria에 accoId, restaurantNo가 둘 다 있거나 둘 다 없을 경우 예외를 발생시킨다.
		return reviewMapper.getReviewsByCriteria(criteria);
	}
	
	/**
	 * 리뷰 평점 분포 집계결과를 이용해 적절한 객체에 값을 저장해 반환
	 * @param accoId1
	 * @return
	 */
	public ReviewPointChart getReviewPointChart(ReviewCriteria criteria) {
		List<Map<String, Integer>> countResults = reviewMapper.countReviewPoints(criteria);
		// 생성자메소드에서 countResults를 이용해 hashMap 구현객체인 ReviewPointChart에 각 평점의 개수를 저장한다.
		return new ReviewPointChart(countResults);
	}
		
	/**
	 * 특정 숙소들이 담겨있는 리스트를 전달받아서, 해당 숙소들의 리뷰 중 가장 최근에 작성된 리뷰를 최대 10건 반환한다.
	 * @return
	 */
	public List<Review> getLatestReviewsByAccos(List<Accommodation> bestAccos) {
		List<Integer> accoIds = new ArrayList<>();
		for (Accommodation acco : bestAccos) {
			accoIds.add(acco.getId());
		}
		return reviewMapper.getLatestReviewsByAccos(accoIds);
	}
	
	/**
	 * 모든 식당 리뷰 중 가장 최신의 리뷰를 최대 3건 반환한다.
	 * @return
	 */
	public List<Review> getLatestRestaurantReviews() {
		return reviewMapper.getLatestRestaurantReviews();
	}
	
//	public List<Review> getAllReviews(Review review) {
//		return reviewMapper.getAllReviews();
//	}

	public List<Review> getMyAccoReviews(int userNo) {
		return reviewMapper.getAccommodationReviewsByUserNo(userNo);
	}

	public List<Review> getMyRestaurantReviews(int userNo) {
		return reviewMapper.getRestaurantReviewsByUserNo(userNo);
	}
}
