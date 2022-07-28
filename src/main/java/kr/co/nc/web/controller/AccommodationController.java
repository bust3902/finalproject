package kr.co.nc.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/acco")
public class AccommodationController {

	@GetMapping(path = "/search")
	public String search() {
		return "/accommodation/search";
	}

	@GetMapping(path = "/detail")
	public String detail() {
		return "/accommodation/detail";
	}
}
