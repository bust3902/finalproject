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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.AdminService;
import kr.co.nc.service.RestaurantService;
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
		
		return "admin/accommodationsearch";
	}
	
	// 관리자 음식점 검색 페이지
	@GetMapping(path = "/restausearch")
	public String RestaurantSearchPage(Model model) throws IOException {
		
		return "admin/restaurantsearch";
	}
	
	// 수정폼 메인 페이지
	@GetMapping(path = "/accommodationModifyMain")
	public String AccommodationModifyMain(Model model, @RequestParam("id") int id) throws IOException {

		// 숙소아이디로 숙소 검색
		model.addAttribute("accommodations", adminService.getSearchAccommodationById(id));
		// 숙소아이디로 객실 검색
		model.addAttribute("accommodationrooms", adminService.getAccommodationRoomByaccoId(id));
		return "admin/modifymain";
	}
	
	// 숙소 수정폼 요청 
	@GetMapping(path = "/modifyAccommodation")
	public String AccommodationModify(Model model,AccommodationRegisterForm accommodationRegisterForm, @RequestParam("id") int id) {
		
		// 화면에 숙소유형을 출력시키기 위한 모든 숙소유형 정보 전달
		model.addAttribute("types", accommodationService.getAllTypes());
		// 화면에 지역정보를 출력시키기 위한 모든 지역 정보 전달
		model.addAttribute("cities", accommodationService.getAllCities());
		
		// 수정폼에 숙소정보를 출력시키기 위해 숙소아이디로 검색
		// 숙소 검색
		model.addAttribute("accommodations", adminService.getSearchAccommodationById(id));
		// 상세이미지 정보 검색
		model.addAttribute("accommodationImages", adminService.getAccommodationImagesById(id));
		// 태그 정보 검색
		model.addAttribute("accommodationTags", adminService.getAccommodationTagsById(id));
		// 숙소 타입 정보 검색
		model.addAttribute("accommodationTypes", adminService.getAccommodationTypesById(id));
		// 숙소 공용시설 정보 검색
		model.addAttribute("accommodationCommonFacilities", adminService.getAccommodationCommonFacilitiesById(id));

		// 모델객체에 숙소 저장폼 담기
		model.addAttribute("accommodationRegisterForm", new AccommodationRegisterForm());

		return "admin/accommodationmodify";
	}
	
	// 수정된 숙소 정보 저장
	@PostMapping(path = "/modifyAccommdation")
	public String AccommodationModifyCompleted(
			@ModelAttribute("accommodationRegisterForm") AccommodationRegisterForm accommodationRegisterForm,
			Model model, SessionStatus sessionStatus) throws IOException {
		System.out.println(accommodationRegisterForm);
		// 객실 정보 수정
		adminService.updateAccommodation(accommodationRegisterForm);

		sessionStatus.setComplete();
		
		return "admin/modifycompleted";
	}
	
	// 객실 수정폼 요청 
	@GetMapping(path = "/modifyAccommodationRoom")
	public String AccommodationRoomModify(Model model,AccommodationRoomRegisterForm accommodationRoomRegisterForm, @RequestParam("no") int no) {
		// 객실번호로 객실 검색
		model.addAttribute("accommodationRooms", adminService.getAccommodationRoomByroomNo(no));
		// 객실번호로 객실 시설 검색 (페이지 로딩시 객실시설 체크용)
		model.addAttribute("roomFacilities", adminService.getAccommodationRoomFacilitiesByroomNo(no));
		// 객실번호로 객실 상세이미지 검색
		// System.out.println(no);
		// System.out.println(adminService.getAccommodationRoomImagesByroomNo(no));
		model.addAttribute("roomImages", adminService.getAccommodationRoomImagesByroomNo(no));

		// 객실시설 출력을 위한 list 전달
		model.addAttribute("rofacilities", accommodationService.getRoomFacilityOptions());
		
		return "admin/accommodationroommodify";
	}
	// 수정된 객실 정보 저장
	@PostMapping(path = "/roommodifycompleted")
	public String AccommodationroomModifyCompleted(
			@ModelAttribute("accommodationRoomRegisterForm") AccommodationRoomRegisterForm accommodationRoomRegisterForm,
			SessionStatus sessionStatus) throws IOException {
		// 객실 정보 수정
		adminService.updateAccommodationRoom(accommodationRoomRegisterForm);

		sessionStatus.setComplete();
		
		return "admin/modifycompleted";
	}
	
	// 음식점 수정폼 요청 
	@GetMapping(path = "/modifyRestaurant")
	public String RestaurantModify(Model model,RestaurantRegisterForm restaurantRegisterForm, @RequestParam("no") int no) {

		// 화면에 지역정보를 출력시키기 위한 모든 지역정보 전달
		model.addAttribute("cities",restaurantService.getAllCity());
		// 화면에 카테고리를 출력시키기 위한 모든 카테고리정보 전달
		model.addAttribute("categories",restaurantService.getAllCategories());
		
		// 수정폼에 음식점 정보를 출력시키기 위해 음식점 번호로 검색
		// 음식점 정보 검색
		model.addAttribute("restaurant", adminService.getSearchRestaurantByNo(no));
		// 음식점 카테고리 검색
		model.addAttribute("restaurantCategories", adminService.getSearchRestaurantCategoriesByNo(no));
		// 음식점 태그 검색
		model.addAttribute("restaurantTags", adminService.getSearchRestaurantTagsByNo(no));
		// 음식점 메뉴 검색
		System.out.println(adminService.getSearchRestaurantMenusByNo(no));
		model.addAttribute("restaurantMenus", adminService.getSearchRestaurantMenusByNo(no));

		// 모델객체에 음식점 저장폼 담기
		model.addAttribute("restaurantRegisterForm", new RestaurantRegisterForm());

		return "admin/restaurantmodify";
	}
	// 수정된 음식점 정보 저장
	@PostMapping(path = "/restaurantmodifycompleted")
	public String RestaurantModifyCompleted(
			@ModelAttribute("restaurantRegisterForm") RestaurantRegisterForm restaurantRegisterForm,
			SessionStatus sessionStatus) throws IOException {
		System.out.println(restaurantRegisterForm);
		// 객실 정보 수정
		adminService.updateRestaurant(restaurantRegisterForm);

		sessionStatus.setComplete();
		
		return "admin/modifycompleted";
	}
}
