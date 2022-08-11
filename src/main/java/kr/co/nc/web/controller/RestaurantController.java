package kr.co.nc.web.controller;



import java.util.HashMap;

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
	public String searchList(
			@RequestParam(name = "cat",required = false) String categoryId,
			@RequestParam(name = "keyword",required = false) String keyword,
			@RequestParam(name = "categories",required = false) String categories,
			@RequestParam(name = "order",required = false) String order,
			Model model ) {
		model.addAttribute("categories",restaurantService.getAllCategories());
		
		model.addAttribute("tags",restaurantService.getAlltags());
		model.addAttribute("cities",restaurantService.getAllCity());
		
		HashMap params = new HashMap();	
		if(keyword != null) {
			model.addAttribute("keyword",keyword);
			params.put("keyword", keyword);
		}
		if(categories != null)params.put("categories", categories);
		if(order != null)params.put("order", order);
		
		if( !params.isEmpty() ) {
			model.addAttribute("searchKeyword",restaurantService.searchKeyword(params));
		}
		
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
