package kr.co.nc.web.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.nc.service.RestaurantService;
import kr.co.nc.vo.RestaurantCategory;

@Controller
@RequestMapping("/restaurant")
public class RestaurantController {

	@Autowired
	private RestaurantService restaurantService;
	
	@GetMapping(path="/searchlist")
	public String searchList(@RequestParam(name = "cat",required = false) String categoryId,Model model ) {
		List<RestaurantCategory> categories = restaurantService.getAllCategories();
		model.addAttribute("categories",categories);
		
		model.addAttribute("tags",restaurantService.getAlltags());
		
		return "restaurant/searchlist";
	}
	
	@GetMapping(path = "/detail")
	public String detail(@RequestParam("no") int restaurantNo, Model model) {
		// 변수 따로 만들지 않고 reviews안에 넣었습니다.
		model.addAttribute("restaurant",restaurantService.getRestaurantDetail(restaurantNo));
		model.addAttribute("reviews",restaurantService.getRestaurantReview(restaurantNo));
		return "restaurant/detail";
	}
	
	@GetMapping()
	public String home(Model model) {
		model.addAttribute("reviews",restaurantService.getAllRestaurantReview());
		
		return "restaurant/home";
	}
}
