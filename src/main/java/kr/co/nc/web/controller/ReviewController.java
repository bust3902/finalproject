package kr.co.nc.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.nc.service.ReviewService;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	// 전체 리뷰를 반환한다.
	@GetMapping(path = "/review")
	public String Review() {
		return "reviews/review";
	}
	
	// 리뷰 입력폼
	@GetMapping(path = "/reviewform")
	public String ReviewForm() {
		return "reviews/form";
	}
	
	@GetMapping(path = "/reviewcomplete")
	public String reviewCompleted() {
		return "reviews/reviewcomplete";
	}
}
