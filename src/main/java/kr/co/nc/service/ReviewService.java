package kr.co.nc.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.dto.ReviewPointChart;
import kr.co.nc.mapper.ReviewMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.ReviewRegisterForm;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;
	
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
		}
		if(restaurantNo !=null) {
			review.setRestaurantNo(restaurantNo);
		}
		reviewMapper.insertReview(review);
	}
		/*
		 * // 리뷰 카테고리 정보 저장 List<String> categoryIds =
		 * reviewRegisterForm.getCategoryIds(); for(String categoryId : categoryIds) {
		 * reviewMapper.insertReviewCategory(new ReviewCategory(review.getNo(),
		 * categoryId)); }
		 */
		
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
	
	public List<Review> getAllReviews(Review review) {
		return reviewMapper.getAllReviews();
	}

}
