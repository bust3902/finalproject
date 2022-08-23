package kr.co.nc.web.controller;

import java.io.IOException;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.ReviewService;
import kr.co.nc.web.form.ReviewRegisterForm;
import lombok.extern.slf4j.Slf4j;
import kr.co.nc.vo.User;

@Slf4j
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
	public String ReviewForm(Model model)  {

		model.addAttribute("form", new ReviewRegisterForm());
		
		return "reviews/reviewform";
	}
	
	@PostMapping(path = "/reviewcomplete")
	public String reviewCompleted(@LoginUser User user , Model model) {		
		
		return "redirect:/reviews/reviewcomplete";
	}
}
