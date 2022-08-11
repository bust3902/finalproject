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
	List<Review> getReviewsByCriteria(ReviewCriteria criteria); // ReviewCriteria의 값에 따라 동적 sql문을 이용해 특정 번호를 가지는 식당리뷰 / 숙소리뷰를 조회할 수 있다.
}
