package kr.co.nc.web.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.RestaurantService;
import kr.co.nc.service.ReviewService;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.ReviewRegisterForm;

@Controller
public class ReviewController {

	// 음식점 이미지 저장 디렉토리
	@Value("${seoul.review.image.save-directory}")
	String ReviewImageSaveDirectory;
	
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private AccommodationService accommodationService;
	@Autowired
	private RestaurantService restaurantService;
	
	// 전체 리뷰를 반환한다.
	@GetMapping(path = "/review")
	public String Review() {
		return "reviews/review";
	}
	
	// 리뷰 입력폼
	@GetMapping(path = "/reviewform")
	public String ReviewForm(@LoginUser User user, @RequestParam(required = false) Integer accoId, @RequestParam(required = false) Integer roomNo, @RequestParam(required = false) Integer restaurantNo,  Model model) {
		
		if (accoId != null && roomNo != null) {
			// TODO 존재하지 않는 아이디일 경우 예외처리
			model.addAttribute("roomName", accommodationService.getNamesByRoomNo(roomNo));
		} else if (restaurantNo != null) {
			model.addAttribute("restaurantName", restaurantService.getNameByNo(restaurantNo));
		}
		
		return "reviews/form";
	}
	
	@PostMapping(path = "/reviewcomplete")
	public String reviewCompleted(@LoginUser User user, @RequestParam(name="roomNo",required=false)Integer roomNo, @RequestParam(name="restaurantNo",required=false)Integer restaurantNo, @RequestParam(name="accoId",required=false)Integer accoId, @ModelAttribute("ReviewRegisterForm") ReviewRegisterForm reviewRegisterForm) throws IOException {
			
		if (!reviewRegisterForm.getImageFile().isEmpty()) {
			MultipartFile imageFile = reviewRegisterForm.getImageFile();
			String filename = imageFile.getOriginalFilename();
			reviewRegisterForm.setImage(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(ReviewImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		reviewService.addNewReview(user, restaurantNo, roomNo, accoId, reviewRegisterForm);
		return "reviews/reviewcomplete";
	}
	
	// 리뷰 수정폼
	@GetMapping(path = "/reviewmodify")
	public String reviewModifyForm(@LoginUser User user, int no,  Model model) {

		// TODO 존재하지 않거나 삭제된 리뷰일 경우 예외처리
		
		model.addAttribute("review", reviewService.getReviewByNo(no));
		
		return "/reviews/modifyform";
	}
	
	@PostMapping(path = "/reviewmodify")
	public String reviewModify(@LoginUser User user, ReviewRegisterForm form) throws IOException {
		
		if (!form.getImageFile().isEmpty()) {
			MultipartFile imageFile = form.getImageFile();
			String filename = imageFile.getOriginalFilename();
			form.setImage(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(ReviewImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		System.out.println(form);
		reviewService.modifyReview(user.getNo(), form);
		
		return "reviews/reviewcomplete";
	}
	
}
