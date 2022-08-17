package kr.co.nc.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.dto.ReviewPointChart;
import kr.co.nc.mapper.ReviewMapper;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.User;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;
	
	public void addNewReview(User loginUser) throws IOException{
		Review review = new Review();
		review.setTitle(review.getTitle());
		review.setContent(review.getContent());
		review.setLikeCount(review.getLikeCount());
		review.setImage(review.getImage());
		review.setUser(loginUser);
		reviewMapper.insertReview(review);
	}
	
	// 숙소 또는 식당 리뷰를 반환 (원하는 대상에 따라 criteria의 값을 set해서 전달할 것)
	public List<Review> getReviewsByCriteria(ReviewCriteria criteria) {
		// TODO criteria에 accoId, restaurantNo가 둘 다 있거나 둘 다 없을 경우 예외를 발생시킨다.
		return reviewMapper.getReviewsByCriteria(criteria);
	}
	
	// 리뷰 평점 분포 집계결과를 이용해 적절한 객체에 값을 저장해 반환
	public ReviewPointChart getReviewPointChartByAccoId(int accoId) {
		List<Map<String, Integer>> countResults = reviewMapper.countReviewPointsByAccoId(accoId);
		// 생성자메소드에서 countResults를 이용해 hashMap 구현객체인 ReviewPointChart에 각 평점의 개수를 저장한다.
		return new ReviewPointChart(countResults);
	}
}
