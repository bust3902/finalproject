package kr.co.nc.web.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.AdminService;
import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.web.form.AccommodationRegisterForm;
import kr.co.nc.web.form.AccommodationRoomRegisterForm;
import kr.co.nc.web.form.RestaurantRegisterForm;

/**
 * 관리자 컨트롤러
 * @author USER
 *
 */
@Controller
@RequestMapping("/admin")
@SessionAttributes({"accommodationRegisterForm"})
public class AdminController {

	// 숙소 메인썸네일 저장 디렉토리
	@Value("${seoul.accommodation.image.save-directory}")
	String accommodationImageSaveDirectory;
	
	// 숙소 상세이미지 저장 디렉토리
	@Value("${seoul.accommodation.detail.image.save-directory}")
	String accommodationDetailImageSaveDirectory;
	
	// 객실 메인이미지 저장 디렉토리
	@Value("${seoul.accommodation.image.save-directory}")
	String accommodationRoomImageSaveDirectory;
	
	// 객실 상세이미지 저장 디렉토리
	@Value("${seoul.accommodation.detail.image.save-directory}")
	String accommodationRoomDetailImageSaveDirectory;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private AccommodationService accommodationService;
	
	// 음식점 이미지 저장 디렉토리
	@Value("${seoul.restaurant.image.save-directory}")
	String restaurantImageSaveDirectory;

	// 관리자 메인화면
	@GetMapping(path = "")
	public String search() {
		return "/admin/home";
	}
	
	// 음식점 입력폼1
	@GetMapping(path = "/restaurant")
	public String RestaurantRegister(Model model) {
		model.addAttribute("restaurant", new Restaurant());
		
		return "/admin/restaurantregister1";
	}
	
	// 음식점 입력폼2
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
	
	// 숙소 입력폼1
	@GetMapping(path = "/accommodation")
	public String AccommodationMapRegister(Model model) {

		model.addAttribute("accommodationRegisterForm", new AccommodationRegisterForm());
		
		return "admin/accommodationregister1";
	}
	
	// 숙소 입력폼2
	@PostMapping(path = "/accommodation2")
	public String AccommodationRegister(
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm, 
			Model model
			) throws IOException {
		
		// 	모든 숙소유형 정보 전달
		model.addAttribute("types", accommodationService.getAllTypes());
		// 	모든 지역 정보 전달
		model.addAttribute("cities", accommodationService.getAllCities());
		
		model.addAttribute("accommodationRegisterForm", accommodationRegisterForm);
		
		return "admin/accommodationregister2";
	}
	
	// 공용시설 리스트 전달
	@GetMapping("/search")
	@ResponseBody
	public List<CommonFacility> search(@RequestParam("type") String type) {
		// type에 따른 공용시설 옵션 list 전달
		return accommodationService.getCommonFacilityOptions(type);
	}
	
	// 숙소 입력폼3(객실 입력폼)
	@PostMapping(path = "/accommodation3")
	public String accommodationRoom(
			AccommodationRoomRegisterForm accommodationRoomRegisterForm,
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm,
			Model model
			) throws IOException {

		// 객실시설 옵션 list 전달
		model.addAttribute("rofacilities", accommodationService.getRoomFacilityOptions());
		
		accommodationRegisterForm.addAccommodationRoomRegisterForm(accommodationRoomRegisterForm);

		model.addAttribute("rooms", accommodationRegisterForm.getAccommodationRooms().size());
		System.out.println(accommodationRegisterForm.getAccommodationRooms().size());
		
		// System.out.println(accommodationRegisterForm.getDetailImageFiles().size());
		
		model.addAttribute("accommodationRegisterForm", accommodationRegisterForm);
		return "admin/accommodationregister3";
	}
	
	// 숙소 최종 입력
	@PostMapping(path = "/insert")
	public String AccommodationInsert(
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm,
			SessionStatus sessionStatus
			) throws IOException {
		
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
		if (!accommodationRegisterForm.getDetailImageFiles().isEmpty()) {
			List<MultipartFile> imageFileList = accommodationRegisterForm.getDetailImageFiles();
			for (MultipartFile imageFile : imageFileList) {
				String filename = imageFile.getOriginalFilename();
				List<String> filenames = new ArrayList<>();
				filenames.add(filename);
				accommodationRegisterForm.setDetailImageNames(filenames);
				
				InputStream in = imageFile.getInputStream();
				FileOutputStream out = new FileOutputStream(new File(accommodationDetailImageSaveDirectory, filename));
				
				FileCopyUtils.copy(in, out);
			}
		}
		
		// 객실 썸네일 이미지 업로드
		for (int index=0; index < accommodationRegisterForm.getAccommodationRooms().size(); index++) {
			if (!accommodationRegisterForm.getAccommodationRooms().get(index).getThumbnailImageFile().isEmpty()) {
				MultipartFile imageFile = accommodationRegisterForm.getAccommodationRooms().get(index).getThumbnailImageFile();
				String filename = imageFile.getOriginalFilename();
				
				accommodationRegisterForm.getAccommodationRooms().get(index).setThumbnailImageName(filename);
				
				InputStream in = imageFile.getInputStream();
				FileOutputStream out = new FileOutputStream(new File(accommodationRoomImageSaveDirectory, filename));
				
				FileCopyUtils.copy(in, out);
			}
			
			// 객실 상세 이미지 업로드
			if (!accommodationRegisterForm.getAccommodationRooms().get(index).getDetailImageFiles().isEmpty()) {
				List<MultipartFile> imageFileList = accommodationRegisterForm.getAccommodationRooms().get(index).getDetailImageFiles();
				for (MultipartFile imageFile : imageFileList) {
					String filename = imageFile.getOriginalFilename();
					List<String> filenames = new ArrayList<>();
					filenames.add(filename);
					accommodationRegisterForm.getAccommodationRooms().get(index).setDetailImageNames(filenames);
					
					InputStream in = imageFile.getInputStream();
					FileOutputStream out = new FileOutputStream(new File(accommodationRoomDetailImageSaveDirectory, filename));
					
					FileCopyUtils.copy(in, out);
				}
			}
		}
		
		adminService.addNewAccommodation(accommodationRegisterForm);

		sessionStatus.setComplete();
		
		return "admin/accoCompleted";
	}
}
