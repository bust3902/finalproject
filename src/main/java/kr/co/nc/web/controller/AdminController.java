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
import kr.co.nc.service.RestaurantService;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.CommonFacility;
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
@SessionAttributes({"accommodationRegisterForm", "restaurantRegisterForm"})
public class AdminController {
	
	// 음식점 이미지 저장 디렉토리
	@Value("${seoul.restaurant.image.save-directory}")
	String restaurantImageSaveDirectory;

	// 숙소 메인썸네일 저장 디렉토리
	@Value("${seoul.accommodation.image.save-directory}")
	String accommodationImageSaveDirectory;
	
	// 숙소 상세이미지 저장 디렉토리
	@Value("${seoul.accommodation.detail.image.save-directory}")
	String accommodationDetailImageSaveDirectory;
	
	// 객실 메인이미지 저장 디렉토리
	@Value("${seoul.accommodationRoom.image.save-directory}")
	String accommodationRoomImageSaveDirectory;
	
	// 객실 상세이미지 저장 디렉토리
	@Value("${seoul.accommodationRoom.detail.image.save-directory}")
	String accommodationRoomDetailImageSaveDirectory;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private RestaurantService restaurantService;
	
	@Autowired
	private AccommodationService accommodationService;

	// 관리자 메인화면
	@GetMapping(path = "")
	public String search() {
		return "/admin/home";
	}
	
	// 음식점 입력폼1
	@GetMapping(path = "/restaurant")
	public String RestaurantRegister(Model model) {

		// 화면에 지역정보를 출력시키기 위한 모든 지역정보 전달
		model.addAttribute("cities",restaurantService.getAllCity());
		// 화면에 카테고리를 출력시키기 위한 모든 카테고리정보 전달
		model.addAttribute("categories",restaurantService.getAllCategories());
		
		// 모델객체에 식당 저장폼 담기
		model.addAttribute("restaurantRegisterForm", new RestaurantRegisterForm());
		
		return "/admin/restaurantregister1";
	}
	
	// 음식점 입력폼2
	@PostMapping(path = "/restaurant2")
	public String restaurantdetail(@ModelAttribute("restaurantRegisterForm") RestaurantRegisterForm restaurantRegisterForm,
			Model model) throws IOException {

		// 화면에 태그리스트를 출력시키기 위한 모든 태그정보 전달
		// model.addAttribute("tags",restaurantService.getAlltags());
		
		// 음식점 이미지 사진 업로드
		if (!restaurantRegisterForm.getImgfile().isEmpty()) {
			MultipartFile imageFile = restaurantRegisterForm.getImgfile();
			String filename = imageFile.getOriginalFilename();
			restaurantRegisterForm.setImgname(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(restaurantImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		return "/admin/restaurantregister2";
	}
	
	// 음식점 저장
	@PostMapping(path = "/restauinsert")
	public String restaurantinsert(@ModelAttribute("restaurantRegisterForm") RestaurantRegisterForm restaurantRegisterForm,
			Model model, SessionStatus sessionStatus) throws IOException {
		
		adminService.addNewRestaurant(restaurantRegisterForm);
		
		sessionStatus.setComplete();
		
		return "/admin/restaucompleted";
	}
	
	// 숙소 입력폼1(지역선택 및 숙소 소개) 요청 
	@GetMapping(path = "/accommodation")
	public String AccommodationMapRegister(Model model) {

		// 모델객체에 숙소 저장폼 담기
		model.addAttribute("accommodationRegisterForm", new AccommodationRegisterForm());
		
		return "admin/accommodationregister1";
	}
	
	// 숙소 입력폼2(숙소 입력폼) 요청
	@PostMapping(path = "/accommodation2")
	public String AccommodationRegister(
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm, 
			Model model
			) throws IOException {
		
		// 화면에 숙소유형을 출력시키기 위한 모든 숙소유형 정보 전달
		model.addAttribute("types", accommodationService.getAllTypes());
		// 화면에 지역정보를 출력시키기 위한 모든 지역 정보 전달
		model.addAttribute("cities", accommodationService.getAllCities());
		
		return "admin/accommodationregister2";
	}
	
	// 숙소유형 선택시 공용시설 리스트 출력을 위한 데이터 전달
	@GetMapping("/search")
	@ResponseBody
	public List<CommonFacility> search(@RequestParam("type") String type) {
		// type에 따른 공용시설 옵션 list 전달
		return accommodationService.getCommonFacilityOptions(type);
	}
	
	// 숙소 입력폼3(객실 입력폼) 요청
	@PostMapping(path = "/accommodation3")
	public String accommodation(
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm,
			Model model
	) throws IOException {

		// 객실시설 옵션 출력을 위한 list 전달
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
		if (!accommodationRegisterForm.getDetailImageFiles().isEmpty()) {
			List<MultipartFile> imageFileList = accommodationRegisterForm.getDetailImageFiles();
			List<String> filenames = new ArrayList<>();
			for (MultipartFile imageFile : imageFileList) {
				// 파일명 저장
				String filename = imageFile.getOriginalFilename();
				filenames.add(filename);
				
				InputStream in = imageFile.getInputStream();
				FileOutputStream out = new FileOutputStream(new File(accommodationDetailImageSaveDirectory, filename));
				
				FileCopyUtils.copy(in, out);
			}
			accommodationRegisterForm.setDetailImageNames(filenames);
		}
		
		model.addAttribute("rooms", accommodationRegisterForm.getAccommodationRooms().size());
		// System.out.println(accommodationRegisterForm.getAccommodationRooms().size());
		
		// System.out.println(accommodationRegisterForm.getDetailImageFiles().size());
		
		// model.addAttribute("accommodationRegisterForm", accommodationRegisterForm);
		
		return "admin/accommodationregister3";
	}
	
	// 객실정보 저장시 객실 이미지 처리를 해주는 메소드
	@PostMapping("/accommodation3-room")
	public String accommodataionRoom(AccommodationRoomRegisterForm accommodationRoomRegisterForm,
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm,
			Model model
	) throws IOException {
		
		accommodationRegisterForm.addAccommodationRoomRegisterForm(accommodationRoomRegisterForm);
		
		// 객실 썸네일 이미지 업로드
		if (!accommodationRoomRegisterForm.getThumbnailImageFile().isEmpty()) {
			MultipartFile imageFile = accommodationRoomRegisterForm.getThumbnailImageFile();
			String filename = imageFile.getOriginalFilename();
			
			accommodationRoomRegisterForm.setThumbnailImageName(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(accommodationRoomImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		} 
		
		// 객실 상세 이미지 업로드
		if (!accommodationRoomRegisterForm.getDetailImageFiles().isEmpty()) {
			List<MultipartFile> imageFileList = accommodationRoomRegisterForm.getDetailImageFiles();
			List<String> filenames = new ArrayList<>();
			for (MultipartFile imageFile : imageFileList) {
				// 파일명 저장
				String filename = imageFile.getOriginalFilename();
				filenames.add(filename);
				
				// 파일 저장
				InputStream in = imageFile.getInputStream();
				FileOutputStream out = new FileOutputStream(new File(accommodationRoomDetailImageSaveDirectory, filename));
				
				FileCopyUtils.copy(in, out);
			}
			accommodationRoomRegisterForm.setDetailImageNames(filenames);
		} 

		model.addAttribute("rooms", accommodationRegisterForm.getAccommodationRooms().size());
		
		return "admin/accommodationregister3";
	}
	
	// 숙소 최종 입력
	@PostMapping(path = "/insert")
	public String AccommodationInsert(
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm,
			Model model, SessionStatus sessionStatus
			) throws IOException {
		
		// 객실 정보 저장
		adminService.addNewAccommodation(accommodationRegisterForm);

		sessionStatus.setComplete();
		
		return "admin/accocompleted";
	}
	
	// 관리자 숙소 검색 페이지
	@GetMapping(path = "/accosearch")
	public String AccommodationSearchPage(Model model) throws IOException {
		
		return "admin/search";
	}

	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping("/searchAccommodation")
	@ResponseBody
	public List<Accommodation> adminAccommodationSearch(@RequestParam("keyword") String keyword) {
		
		return adminService.searchAccommodation(keyword);
	}
}
