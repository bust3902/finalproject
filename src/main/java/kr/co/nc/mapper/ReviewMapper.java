package kr.co.nc.mapper;

import java.util.List;

import kr.co.nc.vo.Review;

public interface ReviewMapper {

	void insertReview(Review review);
	void updateReview(Review review);
	void deleteReview(Review reivew);
}
