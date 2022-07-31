package kr.co.nc.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReviewController {

	@GetMapping(path = "/review")
	public String Review() {
		return "reviews/review";
	}
	
	@GetMapping(path = "/detail")
	public String ReviewDetail() {
		return "reviews/detail";
	}
}
