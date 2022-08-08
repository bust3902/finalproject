package kr.co.nc.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.service.AccommodationService;
import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.web.form.AccommodationRegisterForm;
import kr.co.nc.web.form.RestaurantRegisterForm;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AccommodationService accommodationService;
	
	@Value("${seoul.restaurant.image.save-directory}")
	String restaurantImageSaveDirectory;
	
	@Value("${seoul.accommodation.image.save-directory}")
	String accommodationImageSaveDirectory;
	
	@Value("${seoul.accommodation.detail.image.save-directory}")
	String accommodationDetailImageSaveDirectory;

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
	public String AccommodationMapRegister(Model model) {
		
		return "admin/accommodationregister1";
	}
	
	@PostMapping(path = "/accommodation2")
	public String AccommodationRegister(Model model) {
		
		// 	모든 숙소유형 정보 전달
		model.addAttribute("types", accommodationService.getAllTypes());
		// 	모든 지역 정보 전달
		model.addAttribute("cities", accommodationService.getAllCities());
		
		return "admin/accommodationregister2";
	}
	
	@GetMapping("/search")
	@ResponseBody
	public List<CommonFacility> search(@RequestParam("type") String type) {
		// type에 따른 공용시설 옵션 list 전달
		return accommodationService.getCommonFacilityOptions(type);
	}
	
	@PostMapping(path = "/accommodation3")
	public String accommodationdetail(@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm, Model model) throws IOException {

		// 객실시설 옵션 list 전달
		model.addAttribute("rofacilities", accommodationService.getRoomFacilityOptions());
		// 숙소 썸네일 이미지 업로드
		if (!accommodationRegisterForm.getThumbnailImageFile().isEmpty()) {
			MultipartFile imageFile = accommodationRegisterForm.getThumbnailImageFile();
			String filename = imageFile.getOriginalFilename();
			accommodationRegisterForm.setThumbnailImageName(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(accommodationImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		// 숙소 상세 이미지 업로드
		if (!accommodationRegisterForm.getDetailImageFile().isEmpty()) {
			MultipartFile imageFile = accommodationRegisterForm.getDetailImageFile();
			String filename = imageFile.getOriginalFilename();
			accommodationRegisterForm.setThumbnailImageName(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(accommodationDetailImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		return "admin/accommodationregister3";
	}
}
