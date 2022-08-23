package kr.co.nc.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.ReviewCategory;

@Mapper
public interface ReviewMapper {

	void insertReview(Review review);
	void updateReview(Review review);
	void deleteReview(Review reivew);
	void insertReviewCategory(ReviewCategory reviewCategory);		// 리뷰 카테고리를 저장한다.
	// 리뷰 조회
	// ReviewCriteria의 값에 따라 동적 sql문을 이용해 특정 식별번호를 가지는 식당리뷰 / 숙소리뷰를 조회한다.
	List<Review> getReviewsByCriteria(ReviewCriteria criteria);
	// 해당 식당 번호를 가지는 식당 리뷰 태그 조회
	List<String> getAllReviewTagsByRestaurantNo(int no);

	// 해당 숙소/식당 번호를 가지는 장소의 리뷰 평점 분포 집계
	// list에는 {POINT=1, COUNT=0}, {POINT=2, COUNT=7}, ... , {POINT=5, COUNT=3} 과 같이 map 객체들이 담겨서 반환된다.
	List<Map<String, Integer>> countReviewPoints(ReviewCriteria criteria);

  // 리스트에 담긴 복수개의 숙소의 최신리뷰 미리보기 정보를 최대 10건 조회
	List<Review> getLatestReviewsByAccos(List<Integer> accoIds);
	// 식당 최신리뷰 정보를 최대 3건 조회
	List<Review> getLatestRestaurantReviews();
	
	// 사용자가 작성한 모든 리뷰를 조회한다.
	List<Review> getAllReviews();

}
