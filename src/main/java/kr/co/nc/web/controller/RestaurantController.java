package kr.co.nc.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.nc.service.RestaurantService;

@Controller
@RequestMapping("/restaurant")
public class RestaurantController {

	@Autowired
	private RestaurantService restaurantService;
	
	@GetMapping
	public String home(Model model) {
		// 변수 따로 만들지 않고 reviews안에 넣었습니다.
		model.addAttribute("reviews",restaurantService.getAllRestaurantReview());
		return "restaurant/restaurant";
	}
	
	@GetMapping(path = "/detail")
	public String detail(@RequestParam("no") int restaurantNo, Model model) {
		model.addAttribute("restaurant",restaurantService.getRestaurantDetail(restaurantNo));
		
		return "restaurant/detail";
	}
}