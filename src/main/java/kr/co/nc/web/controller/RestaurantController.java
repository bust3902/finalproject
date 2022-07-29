package kr.co.nc.web.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.nc.mapper.RestaurantMapper;

@Controller
@RequestMapping("/restaurant")
public class RestaurantController {

	private RestaurantMapper restaurantMapper;
	
	@GetMapping
	public String home(Model model) {
		// 변수 따로 만들지 않고 reviews안에 넣었습니다.
		model.addAttribute("reviews",restaurantMapper.getAllRestaurantReview());
		return null;
	}
}
