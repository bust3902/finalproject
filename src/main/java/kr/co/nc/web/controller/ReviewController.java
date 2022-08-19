package kr.co.nc.web.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.ReviewService;
import kr.co.nc.web.form.ReviewRegisterForm;
import kr.co.nc.vo.Review;
import kr.co.nc.vo.User;

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
