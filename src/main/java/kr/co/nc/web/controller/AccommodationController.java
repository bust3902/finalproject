package kr.co.nc.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.ReviewService;
import kr.co.nc.service.UserService;
import kr.co.nc.vo.User;

@Controller
@RequestMapping("/acco")
@SessionAttributes("LOGIN_USER")
public class AccommodationController {
	
	@Autowired
	private AccommodationService accommodationService;
	@Autowired
	private ReviewService reviewService;

	// 숙소 검색 페이지 뷰 반환
	@GetMapping(path = "")
	public String home(@RequestParam(defaultValue = "") String type, @RequestParam(defaultValue = "") String keyword, Model model) {
		
		// 검색 데이터는 restController에서 제공하기 때문에 이 요청핸들러에서 제공하지 않는다.
		// 그 외의 화면에서 필요한 정보를 이 요청핸들러에서 모두 전달한다. 
		
		// type, keyword를 동시에 전달받은 경우 오류화면으로 이동한다.
		if (!type.isBlank() && !keyword.isBlank()) {
			// TODO : 오류화면 구현해서 연결시키기 (현재는 임시로 홈화면으로 연결함)
			return "home";
		}
		
		// TODO URL에 잘못된 type명을 적은 경우?
		
		// 	모든 숙소유형 정보 전달.
		// type은 최초 화면 요청할 때 쓰는 이름이고 types는 정보 전달하고, 조건검색으로 선택할 때 쓰는 이름
		model.addAttribute("types", accommodationService.getAllTypes());
		// 	모든 지역 정보 전달
		model.addAttribute("cities", accommodationService.getAllCities());
		
		//	type을 전달받은 경우에는 아래 정보도 전달
		if (!type.isBlank()) {
			// 선택한 숙소 유형명 전달
			model.addAttribute("selectedTypeName", accommodationService.getTypeNameById(type));
			// type에 따른 공용시설 옵션 list 전달
			model.addAttribute("cofacilities", accommodationService.getCommonFacilityOptions(type));
			// 객실시설 옵션 list 전달
			model.addAttribute("rofacilities", accommodationService.getRoomFacilityOptions());
			// 기타 태그 옵션 list 전달
			model.addAttribute("tags", accommodationService.getAllAccoTagOptions());
		}
		
		return "accommodation/home";
	}

	// 숙소 상세 페이지 뷰 반환
	@GetMapping(path = "/detail")
	public String detail(@RequestParam("id") int accoId, Model model) {
		// 해당 id를 가진 숙소 상세정보와 리뷰 정보, 찜하기 여부를 전달한다.
		// 숙소의 객실 정보는 restController에서 제공한다.
		
		// 숙소 정보
		model.addAttribute("detail", accommodationService.getAccommodationDetailById(accoId));
		// 리뷰 정보
		ReviewCriteria criteria = new ReviewCriteria("accommodation", accoId);
		model.addAttribute("reviews", reviewService.getReviewsByCriteria(criteria));

		// 로그인 상태일 경우 찜하기 여부를 조회해서 그 값을 전달하고, 로그아웃 상태일 경우 무조건 false를 전달한다.
		User loginUser = (User) model.getAttribute("LOGIN_USER");
		model.addAttribute("isLiked", (loginUser != null ? accommodationService.isLikedAcco(loginUser.getNo(), accoId) : false));
		
		return "/accommodation/detail";
	}
	
}
