package kr.co.nc.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/acco")
public class AccommodationController {

	@GetMapping(path = "")
	public String home(String type, String city, String keyword, Model model) {
		
		// 숙소 유형을 선택했을 경우
		//		선택한 숙소 유형명 전달
		// 		해당 유형의 모든 숙소 조회 결과 전달
		// 		지역 정보 전달
		// 		공용시설 옵션 list 전달
		// 		객실시설 옵션 list 전달
		// 		기타 태그 옵션 list 전달
		
		// 키워드 검색했을 경우
		//		해당 키워드의 모든 숙소 조회 결과
		// 		숙소유형 정보 전달
		
		// 위 경우 중 어디에도 해당하지 않는 요청일 경우?
		return "accommodation/home";
	}

	@GetMapping(path = "/detail")
	public String detail() {
		return "/accommodation/detail";
	}
}
