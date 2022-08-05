package kr.co.nc.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.web.form.AccommodationRegisterForm;
import kr.co.nc.web.form.RestaurantRegisterForm;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Value("${seoul.restaurant.image.save-directory}")
	String restaurantImageSaveDirectory;
	
	@Value("${seoul.accommodation.image.save-directory}")
	String accommodationImageSaveDirectory;

	@GetMapping(path = "")
	public String search() {
		return "/admin/home";
	}
	
	@GetMapping(path = "/restaurant")
	public String RestaurantRegister(Model model) {
		model.addAttribute("restaurant", new Restaurant());
		
		return "/admin/restaurantregister1";
	}
	
	@PostMapping(path = "/restaurant2")
	public String restaurantdetail(@ModelAttribute("restaurantRegisterForm") RestaurantRegisterForm restaurantRegisterForm) throws IOException {
		// 음식점 이미지 사진 업로드
		if (!restaurantRegisterForm.getImgfile().isEmpty()) {
			MultipartFile imageFile = restaurantRegisterForm.getImgfile();
			String filename = imageFile.getOriginalFilename();
			restaurantRegisterForm.setImgname(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(restaurantImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		return "admin/restaurantregister2";
	}
	
	@GetMapping(path = "/accommodation")
	public String AccommodationRegister() {
		return "admin/accommodationregister1";
	}
	
	@PostMapping(path = "/accommodation2")
	public String accommodationdetail(@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm) throws IOException {
		// 숙소 썸네일 이미지 업로드
		if (!accommodationRegisterForm.getThumbnailImageFile().isEmpty()) {
			MultipartFile imageFile = accommodationRegisterForm.getThumbnailImageFile();
			String filename = imageFile.getOriginalFilename();
			accommodationRegisterForm.setThumbnailImageName(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(accommodationImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		return "admin/accommodationregister2";
	}
}
