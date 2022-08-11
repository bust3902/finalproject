package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.vo.Review;

@Mapper
public interface ReviewMapper {

	void insertReview(Review review);
	void updateReview(Review review);
	void deleteReview(Review reivew);
	// 리뷰 조회
	// ReviewCriteria의 값에 따라 동적 sql문을 이용해 특정 식별번호를 가지는 식당리뷰 / 숙소리뷰를 조회한다.
	List<Review> getReviewsByCriteria(ReviewCriteria criteria);
	// 해당 식당 번호를 가지는 식당 리뷰 태그 조회
	List<String> getAllReviewTagsByRestaurantNo(int no);
}
