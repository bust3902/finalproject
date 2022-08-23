package kr.co.nc.web.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.nc.service.RestaurantService;
import kr.co.nc.service.ReviewService;
import kr.co.nc.vo.User;

@Controller
@RequestMapping("/restaurant")
@SessionAttributes("LOGIN_USER")
public class RestaurantController {

	@Autowired
	private RestaurantService restaurantService;
	@Autowired
	private ReviewService reviewService; 
	
	@GetMapping(path="/searchlist")
	public String searchList(@RequestParam(name="keyword",required=false) String keyword, @RequestParam(name="categoryId",required=false) String categoryId,Model model ) {
		
		model.addAttribute("categories",restaurantService.getAllCategories());
		model.addAttribute("cities",restaurantService.getAllCity());
		model.addAttribute("tags",restaurantService.getAlltags());
		model.addAttribute("restaurant",restaurantService.getRestaurantsByCategoryId(categoryId));
		
		return "restaurant/searchlist";
	}
	
	@GetMapping(path = "/detail")
	public String detail(int no, Model model) {
		User loginUser = (User) model.getAttribute("LOGIN_USER");
		// 로그인 상태이면 사용자번호도 전달해서 사용자의 찜 상태를 restaurant 객체에 반영한다.
		if (loginUser != null) {
			model.addAttribute("restaurant",restaurantService.getRestaurantDetail(loginUser.getNo(), no));
		} else {
			model.addAttribute("restaurant",restaurantService.getRestaurantDetail(no));
		}
//		model.addAttribute("categoryId",restaurantService.getRestaurantsByCategoryId(categoryId));
		model.addAttribute("review",restaurantService.getRestaurantReview(no));

		return "restaurant/detail";
	}
	
	@GetMapping()
	public String home(Model model) {
		model.addAttribute("reviews", reviewService.getLatestRestaurantReviews());
		return "restaurant/home";
	}
}
