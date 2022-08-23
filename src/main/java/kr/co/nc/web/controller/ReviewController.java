package kr.co.nc.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.ReviewService;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.ReviewRegisterForm;

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
	public String ReviewForm(@LoginUser User user,@RequestParam(name="restaurantNo",required=false)Integer restaurantNo) {
		return "reviews/form";
	}
	
	@PostMapping(path = "/reviewcomplete")
	public String reviewCompleted(@LoginUser User user ,@RequestParam(name="restaurantNo",required=false)Integer restaurantNo,@RequestParam(name="accoId",required=false)Integer accoId, ReviewRegisterForm reviewRegisterForm) {
//			reviewService.addNewReview(user, restaurantNo, accoId, reviewRegisterForm);
		return "reviews/reviewcomplete";
	}
}
