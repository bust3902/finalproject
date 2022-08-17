package kr.co.nc.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.mapper.ReviewMapper;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.ReviewCategory;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.ReviewRegisterForm;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;
	
	public void addNewReview(User loginUser, ReviewRegisterForm reviewRegisterForm) throws IOException{
		Review review = new Review();
		review.setTitle(review.getTitle());
		review.setContent(review.getContent());
		review.setLikeCount(review.getLikeCount());
		review.setImage(review.getImage());
		review.setUser(loginUser);
		reviewMapper.insertReview(review);
		
		// 리뷰 카테고리 정보 저장
		List<String> categoryIds = reviewRegisterForm.getCategoryIds();
		for(String categoryId : categoryIds) {
			reviewMapper.insertReviewCategory(new ReviewCategory(review.getNo(), categoryId));
		}
		
	}
	
	public List<Review> getReviewsByCriteria(ReviewCriteria criteria) {
		// TODO criteria에 accoId, restaurantNo가 둘 다 있거나 둘 다 없을 경우 예외를 발생시킨다.
		return reviewMapper.getReviewsByCriteria(criteria);
	}
	
}
