package kr.co.nc.service;

import java.io.IOException;

import org.springframework.stereotype.Service;

import kr.co.nc.mapper.ReviewMapper;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.User;

@Service
public class ReviewService {

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
}
