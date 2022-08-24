package kr.co.nc.web.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.annotation.LoginUser;
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
	
	// 전체 리뷰를 반환한다.
	@GetMapping(path = "/review")
	public String Review() {
		return "reviews/review";
	}
	
	// 리뷰 입력폼
	@GetMapping(path = "/reviewform")
	public String ReviewForm(@LoginUser User user,@RequestParam(name="restaurantNo",required=false)Integer restaurantNo) {
		return "reviews/form";
	}
	
	@PostMapping(path = "/reviewcomplete")
	public String reviewCompleted(@LoginUser User user ,@RequestParam(name="roomNo",required=false)Integer roomNo,@RequestParam(name="restaurantNo",required=false)Integer restaurantNo,@RequestParam(name="accoId",required=false)Integer accoId, @ModelAttribute("ReviewRegisterForm") ReviewRegisterForm reviewRegisterForm  ) throws IOException {
			
		if (!reviewRegisterForm.getImageFile().isEmpty()) {
			MultipartFile imageFile = reviewRegisterForm.getImageFile();
			String filename = imageFile.getOriginalFilename();
			reviewRegisterForm.setImage(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(ReviewImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		reviewService.addNewReview(user, restaurantNo,roomNo, accoId, reviewRegisterForm);
		return "reviews/reviewcomplete";
	}
	
	// 화면구현하느라 테스트로 넣은 요청핸들러메소드
//	@GetMapping(path = "/reviewcomplete")
//	public String test() {
//		return "reviews/reviewcomplete";
//	}
}
