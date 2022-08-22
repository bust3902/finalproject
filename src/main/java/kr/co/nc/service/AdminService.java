package kr.co.nc.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.dto.CommonFacilitiesDTO;
import kr.co.nc.mapper.AdminMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.RestaurantMenu;
import kr.co.nc.vo.RestaurantTag;
import kr.co.nc.vo.RoomFacility;
import kr.co.nc.web.form.AccoCommonFacilityRegisterForm;
import kr.co.nc.web.form.AccoDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomFacilitiesRegisterForm;
import kr.co.nc.web.form.AccoTagRegisterForm;
import kr.co.nc.web.form.AccoTypeRegisterForm;
import kr.co.nc.web.form.AccommodationDeleteImageNameForm;
import kr.co.nc.web.form.AccommodationDeleteTagForm;
import kr.co.nc.web.form.AccommodationRegisterForm;
import kr.co.nc.web.form.AccommodationRoomDeleteImageNameForm;
import kr.co.nc.web.form.AccommodationRoomRegisterForm;
import kr.co.nc.web.form.RestaurantCategoryModifyForm;
import kr.co.nc.web.form.RestaurantCategoryRegisterForm;
import kr.co.nc.web.form.RestaurantDeleteMenuForm;
import kr.co.nc.web.form.RestaurantDeleteTagForm;
import kr.co.nc.web.form.RestaurantMenuRegisterForm;
import kr.co.nc.web.form.RestaurantRegisterForm;

@Service
public class AdminService {
		
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
	private AdminMapper adminMapper;
	
	public void addNewAccommodation(AccommodationRegisterForm accommodationRegisterForm) throws IOException {
		
		// 숙소정보 저장
		Accommodation accommodation = new Accommodation();
		accommodation.setName(accommodationRegisterForm.getAccoName());
		accommodation.setDistrict(accommodationRegisterForm.getDistrict());
		accommodation.setAddress(accommodationRegisterForm.getAddress());
		accommodation.setLatitude(accommodationRegisterForm.getLatitude());
		accommodation.setLongitude(accommodationRegisterForm.getLongitude());
		accommodation.setIntroduceComment(accommodationRegisterForm.getIntroduceComment());
		accommodation.setThumbnailImageName(accommodationRegisterForm.getThumbnailImageName());
		accommodation.setDetailDescription(accommodationRegisterForm.getDetailDescription());
		accommodation.setCityId(accommodationRegisterForm.getCityId());
		
		adminMapper.insertAccommodation(accommodation);

		// 숙소 타입 정보 저장
		List<String> types = accommodationRegisterForm.getTypes();
		for (String type : types) {
			adminMapper.insertAccommodationTypes(new AccoTypeRegisterForm(accommodation.getId(), type));
		}
		
		// 이 숙소가 가지는 모든 부가사항 태그 저장
		List<String> tags = accommodationRegisterForm.getTags();
		for (String tag : tags) {
			adminMapper.insertAccommodationTags(new AccoTagRegisterForm(accommodation.getId(), tag));
		}
		
		// 이 숙소가 가지는 모든 공용시설 정보 저장
		List<String> commonFacilities = accommodationRegisterForm.getStringCommonFacilities();
		for (String commonFacility : commonFacilities) {
			adminMapper.insertAccommodationCommonFacilities(new AccoCommonFacilityRegisterForm(accommodation.getId(), commonFacility));
		}
		
		// 이 숙소가 가지는 모든 상세이미지 정보 저장
		List<String> detailImageNames = accommodationRegisterForm.getDetailImageNames();
		for (String detailImageName : detailImageNames) {
			adminMapper.insertAccommodationDetailImages(new AccoDetailImageNamesRegisterForm(accommodation.getId(), detailImageName));
		}
		
		// 객실 정보 저장
		List<AccommodationRoomRegisterForm> rooms = accommodationRegisterForm.getAccommodationRooms();
		AccommodationRoom accoRoom;
		for (AccommodationRoomRegisterForm room : rooms) {

			// 객실 정보 저장
			accoRoom = new AccommodationRoom();
			accoRoom.setName(room.getName());
			accoRoom.setNumbers(room.getNumbers());
			accoRoom.setCapacity(room.getCapacity());
			accoRoom.setDayPrice(room.getDayPrice());
			accoRoom.setThumbnailImageName(room.getThumbnailImageName());
			accoRoom.setDescription(room.getDescription());
			accoRoom.setAccoId(accommodation.getId());
			accoRoom.setRoomFacilities(room.getRoomFacilities());

			adminMapper.insertAccoRooms(accoRoom);

			// 이 객실이 가지는 모든 시설 정보 저장
			List<String> roomFacilities = room.getStringRoomFacilities();
			for (String roomFacility : roomFacilities) {
				adminMapper.insertAccoRoomFacilities(new AccoRoomFacilitiesRegisterForm(accoRoom.getNo() , roomFacility));
			}

			// 이 객실이 가지는 모든 상세이미지 정보 저장
			List<String> roomDetailImageNames = room.getDetailImageNames();
			for (String roomDetailImageName : roomDetailImageNames) {
				adminMapper.insertAccoRoomDetailImages(new AccoRoomDetailImageNamesRegisterForm(accoRoom.getNo(), roomDetailImageName));
			}
		}
	}
	
	public void addNewRestaurant(RestaurantRegisterForm restaurantRegisterForm) {
		
		// 음식점 정보 저장
		Restaurant restaurant = new Restaurant();
		restaurant.setName(restaurantRegisterForm.getName());
		restaurant.setLocation(restaurantRegisterForm.getLocation());
		restaurant.setImgname(restaurantRegisterForm.getImgname());
		restaurant.setTel(restaurantRegisterForm.getTel());
		restaurant.setLatitud(restaurantRegisterForm.getLatitude());
		restaurant.setLongitude(restaurantRegisterForm.getLongitude());
		restaurant.setCityId(restaurantRegisterForm.getCityId());
		restaurant.setOpening(restaurantRegisterForm.getOpening());
		restaurant.setBreakTime(restaurantRegisterForm.getBreakTime());
		restaurant.setClose(restaurantRegisterForm.getClose());
		restaurant.setDistrict(restaurantRegisterForm.getDistrict());
		
		adminMapper.insertRestaurant(restaurant);

		// 음식점 태그 정보 저장
		List<String> tags = restaurantRegisterForm.getTags();
		for (String tag : tags) {
			adminMapper.insertRestaurantTags(new RestaurantTag(restaurant.getNo(), tag));
		}
		
		// 음식점 메뉴 정보 저장
		List<String> menuNames = restaurantRegisterForm.getMenuNames();
		List<Integer> prices = restaurantRegisterForm.getPrices();
		for (int index = 0; index < menuNames.size(); index++) {
			// restaurantMenu.setMenuName(menuNames.get(index));
			// restaurantMenu.setPrice(prices.get(index));
			
			adminMapper.insertRestaurantMenus(new RestaurantMenuRegisterForm(restaurant.getNo(), menuNames.get(index), prices.get(index)));
		}

		// 음식점 카테고리 정보 저장
		List<String> categories = restaurantRegisterForm.getCategories();
		for (String category : categories) {
			adminMapper.insertRestaurantCategories(new RestaurantCategoryRegisterForm(restaurant.getNo(), category));
		}
	}
	
	// 검색조건에 맞는 모든 숙소정보를 반환
	public List<Accommodation> searchAccommodation(String keyword) {
		return adminMapper.getSearchAccommodations(keyword);
	}
	// 검색조건에 맞는 모든 숙소정보를 반환
	public List<Restaurant> searchRestaurant(String keyword) {
		return adminMapper.getSearchRestaurant(keyword);
	}
	
	// 숙소 아이디로 숙소 정보 검색
	public Accommodation getSearchAccommodationById(int id) {
		return adminMapper.getSearchAccommodationById(id);
	}
	// 숙소 아이디로 숙소 공용시설 정보 검색
	public List<String> getAccommodationCommonFacilitiesById(int id) {
		return adminMapper.getAccommodationCommonFacilitiesById(id);
	}
	// 숙소 타입으로 숙소 공용시설 정보 검색
	public List<CommonFacility> getCommonFacilitiesByAccommodationTypes(List<String> types) {
		return adminMapper.getCommonFacilitiesByAccommodationTypes(types);
	}
	// 숙소 아이디로 숙소 공용시설 체크 상태 검색
	public List<CommonFacilitiesDTO> getCheckedFacilities(int id) {
		return adminMapper.getCheckedFacilities(id);
	}
	// 숙소아이디로 숙소 상세이미지 정보 검색
	public List<String> getAccommodationImagesById(int id) {
		return adminMapper.getAccommodationImagesById(id);
	}
	// 숙소아이디로 숙소 태그 정보 검색
	public List<String> getAccommodationTagsById(int id) {
		return adminMapper.getAccommodationTagsById(id);
	}
	// 숙소아이디로 숙소 타입 정보 검색
	public List<String> getAccommodationTypesById(int id) {
		return adminMapper.getAccommodationTypesById(id);
	}
	
	// 숙소아이디로 객실 검색
	public List<AccommodationRoom> getAccommodationRoomByaccoId(int accoId) {
		return adminMapper.getAccommodationRoomByaccoId(accoId);
	}
	// 객실번호로 객실 검색
	public List<AccommodationRoom> getAccommodationRoomByroomNo(int no) {
		// System.out.println(no);
		// System.out.println(adminMapper.getAccommodationRoomByroomNo(no));
		return adminMapper.getAccommodationRoomByroomNo(no);
	}
	// 객실번호로 객실 시설 검색
	public List<RoomFacility> getAccommodationRoomFacilitiesByroomNo(int no) {
		return adminMapper.getAccommodationRoomFacilitiesByroomNo(no);
	}
	// 객실번호로 객실 상세이미지 검색
	public List<String> getAccommodationRoomImagesByroomNo(int no) {
		// System.out.println("서비스"+adminMapper.getAccommodationRoomImagesByroomNo(no));
		return adminMapper.getAccommodationRoomImagesByroomNo(no);
	}
	
	// 음식점 번호로 음식점 검색
	public Restaurant getSearchRestaurantByNo(int no) {
		return adminMapper.getSearchRestaurantByNo(no);
	}
	// 음식점 번호로 음식점 카테고리 검색
	public List<RestaurantCategoryModifyForm> getSearchRestaurantCategoriesByNo(int no) {
		return adminMapper.getSearchRestaurantCategoriesByNo(no);
	}
	// 음식점 번호로 음식점 태그 검색
	public List<RestaurantTag> getSearchRestaurantTagsByNo(int no) {
		return adminMapper.getSearchRestaurantTagsByNo(no);
	}
	// 음식점 번호로 음식점 메뉴 검색
	public List<RestaurantMenu> getSearchRestaurantMenusByNo(int no) {
		return adminMapper.getSearchRestaurantMenusByNo(no);
	}
	
	// 숙소 정보 수정
	public void updateAccommodation(AccommodationRegisterForm accommodationRegisterForm) throws IOException {
		// System.out.println(accommodationRegisterForm);
		// 숙소 썸네일 이미지 업로드
		if (!accommodationRegisterForm.getThumbnailImageFile().isEmpty()) {
			MultipartFile imageFile = accommodationRegisterForm.getThumbnailImageFile();
			String filename = imageFile.getOriginalFilename();
			accommodationRegisterForm.setThumbnailImageName(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(accommodationImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		Accommodation accommodation = new Accommodation();
		accommodation.setId(accommodationRegisterForm.getId());
		accommodation.setName(accommodationRegisterForm.getAccoName());
		accommodation.setDistrict(accommodationRegisterForm.getDistrict());
		accommodation.setAddress(accommodationRegisterForm.getAddress());
		accommodation.setLatitude(accommodationRegisterForm.getLatitude());
		accommodation.setLongitude(accommodationRegisterForm.getLongitude());
		accommodation.setIntroduceComment(accommodationRegisterForm.getIntroduceComment());
		accommodation.setThumbnailImageName(accommodationRegisterForm.getThumbnailImageName());
		accommodation.setDetailDescription(accommodationRegisterForm.getDetailDescription());
		accommodation.setCityId(accommodationRegisterForm.getCityId());
		
		adminMapper.updateAccommodation(accommodation);
		
		if (!accommodationRegisterForm.getDeleteImgNames().isEmpty()) {
			// 삭제한 상세이미지 DB에서 삭제
			List<String> deleteImageNames = accommodationRegisterForm.getDeleteImgNames();
			for (String deleteImageName : deleteImageNames) {
				adminMapper.deleteAccommodationDetailImages(new AccommodationDeleteImageNameForm(accommodationRegisterForm.getId(), deleteImageName));
			}
			// 숙소 상세 이미지 업로드
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
		
			// 이 숙소가 가지는 모든 상세이미지 정보 저장
			List<String> detailImageNames = accommodationRegisterForm.getDetailImageNames();
			for (String detailImageName : detailImageNames) {
				adminMapper.insertAccommodationDetailImages(new AccoDetailImageNamesRegisterForm(accommodation.getId(), detailImageName));
			}
		}
		
		// 태그 저장
		if (accommodationRegisterForm.getTags() != null) {
			List<String> tags = accommodationRegisterForm.getTags();
			for (String tag : tags) {
				adminMapper.insertAccommodationTags(new AccoTagRegisterForm(accommodation.getId(), tag));
			}
		}
		// 수정폼에서 제거한 태그 삭제
		List<String> deleteTags = accommodationRegisterForm.getDeleteTags();
		for (String deleteTag : deleteTags) {
			adminMapper.deleteAccommodationTags(new AccommodationDeleteTagForm(accommodation.getId(), deleteTag));
		}
		
		// 수정된 숙소의 공용시설정보 삭제
		adminMapper.deleteCommonFacilitiesById(accommodationRegisterForm.getId());
		
		// 수정폼에 체크된 모든 공용시설 정보 저장
		List<String> commonFacilities = accommodationRegisterForm.getStringCommonFacilities();
		for (String commonFacility : commonFacilities) {
			adminMapper.insertAccommodationCommonFacilities(new AccoCommonFacilityRegisterForm(accommodation.getId(), commonFacility));
		}
		
		// 수정된 숙소타입 삭제
		adminMapper.deleteAccommodationTypes(accommodationRegisterForm.getId());
		
		// 숙소 타입 저장
		List<String> types = accommodationRegisterForm.getTypes();
		for (String type : types) {
			adminMapper.insertAccommodationTypes(new AccoTypeRegisterForm(accommodation.getId(), type));
		}
		
	}
	
	// 객실 정보 수정
	public void updateAccommodationRoom(AccommodationRoomRegisterForm accommodationRoomRegisterForm) throws IOException {
		// System.out.println(accommodationRoomRegisterForm);
		
		// 객실 썸네일 이미지 업로드
		if (!accommodationRoomRegisterForm.getThumbnailImageFile().isEmpty()) {
			MultipartFile imageFile = accommodationRoomRegisterForm.getThumbnailImageFile();
			String filename = imageFile.getOriginalFilename();
			
			accommodationRoomRegisterForm.setThumbnailImageName(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(accommodationRoomImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		AccommodationRoom accommodationRoom = new AccommodationRoom();
		accommodationRoom.setName(accommodationRoomRegisterForm.getName());
		accommodationRoom.setNumbers(accommodationRoomRegisterForm.getNumbers());
		accommodationRoom.setCapacity(accommodationRoomRegisterForm.getCapacity());
		accommodationRoom.setDayPrice(accommodationRoomRegisterForm.getDayPrice());
		accommodationRoom.setDescription(accommodationRoomRegisterForm.getDescription());
		accommodationRoom.setThumbnailImageName(accommodationRoomRegisterForm.getThumbnailImageName());
		accommodationRoom.setNo(accommodationRoomRegisterForm.getNo());
		
		adminMapper.updateAccoRoom(accommodationRoom);

		// 객실번호를 받아 객실 시설 삭제
		adminMapper.deleteRoomCommonFacilitiesById(accommodationRoomRegisterForm.getNo());

		// 이 객실이 가지는 모든 시설 정보 저장
		List<String> roomFacilities = accommodationRoomRegisterForm.getStringRoomFacilities();
		for (String roomFacility : roomFacilities) {
			adminMapper.insertAccoRoomFacilities(new AccoRoomFacilitiesRegisterForm(accommodationRoomRegisterForm.getNo() , roomFacility));
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
		// 객실 상세이미지 저장
		List<String> roomDetailImageNames = accommodationRoomRegisterForm.getDetailImageNames();
		if (!accommodationRoomRegisterForm.getDetailImageNames().isEmpty()) {
			System.out.println("객실명"+accommodationRoomRegisterForm.getNo());
			System.out.println("저장할 이미지명"+accommodationRoomRegisterForm.getDetailImageNames());
			for (String roomDetailImageName : roomDetailImageNames) {
				adminMapper.insertAccoRoomDetailImages(new AccoRoomDetailImageNamesRegisterForm(accommodationRoomRegisterForm.getNo(), roomDetailImageName));
			}
		}
		// 객실 상세이미지 삭제
		List<String> deleteDetailImageNames = accommodationRoomRegisterForm.getDeleteDetailImageNames();
		System.out.println("삭제할 이미지명"+accommodationRoomRegisterForm.getDeleteDetailImageNames());
		System.out.println("삭제할 이미지명 객실번호"+accommodationRoomRegisterForm.getNo());
		for (String deleteDetailImageName : deleteDetailImageNames) {
			adminMapper.deleteAccommodationRoomDetailImages(new AccommodationRoomDeleteImageNameForm(accommodationRoomRegisterForm.getNo(), deleteDetailImageName));
		}

	}
	
	// 음식점 정보 수정
	public void updateRestaurant(RestaurantRegisterForm restaurantRegisterForm) throws IOException {
		System.out.println(restaurantRegisterForm);
		
		// 음식점 메인 이미지 업로드
		if (!restaurantRegisterForm.getImgfile().isEmpty()) {
			MultipartFile imageFile = restaurantRegisterForm.getImgfile();
			String filename = imageFile.getOriginalFilename();
			
			restaurantRegisterForm.setImgname(filename);
			
			InputStream in = imageFile.getInputStream();
			FileOutputStream out = new FileOutputStream(new File(restaurantImageSaveDirectory, filename));
			
			FileCopyUtils.copy(in, out);
		}
		
		Restaurant restaurant = new Restaurant();
		restaurant.setNo(restaurantRegisterForm.getNo());
		restaurant.setName(restaurantRegisterForm.getName());
		restaurant.setLocation(restaurantRegisterForm.getLocation());
		restaurant.setImgname(restaurantRegisterForm.getImgname());
		restaurant.setTel(restaurantRegisterForm.getTel());
		restaurant.setLatitud(restaurantRegisterForm.getLatitude());
		restaurant.setLongitude(restaurantRegisterForm.getLongitude());
		restaurant.setCityId(restaurantRegisterForm.getCityId());
		restaurant.setOpening(restaurantRegisterForm.getOpening());
		restaurant.setBreakTime(restaurantRegisterForm.getBreakTime());
		restaurant.setClose(restaurantRegisterForm.getClose());
		restaurant.setDistrict(restaurantRegisterForm.getDistrict());

		adminMapper.updateRestaurant(restaurant);

		// 수정폼에서 제거한 태그 삭제
		if (restaurantRegisterForm.getDeleteTags() != null) {
			List<String> deleteTags = restaurantRegisterForm.getDeleteTags();
			for (String deleteTag : deleteTags) {
				adminMapper.deleteRestaurantTags(new RestaurantDeleteTagForm(restaurant.getNo(), deleteTag));
			}
		}
		// 음식점 태그 정보 저장
		if (restaurantRegisterForm.getTags() != null) {
			List<String> tags = restaurantRegisterForm.getTags();
			for (String tag : tags) {
				adminMapper.insertRestaurantTags(new RestaurantTag(restaurant.getNo(), tag));
			}
		}
		System.out.println(restaurantRegisterForm.getDeletMenuNames());
		
		// 수정폼에서 제거한 메뉴 삭제
		if (restaurantRegisterForm.getDeletMenuNames() != null) {
			for (int index = 0; index < restaurantRegisterForm.getDeletMenuNames().size(); index++) {
				String deletMenuName = restaurantRegisterForm.getDeletMenuNames().get(index);
				String deleteMenuPrice = restaurantRegisterForm.getDeleteMenuPrices().get(index);
				adminMapper.deleteRestaurantMenus(new RestaurantDeleteMenuForm(restaurant.getNo(), deletMenuName, deleteMenuPrice));
			}
		}
		
		// 음식점 메뉴 정보 저장
		if (restaurantRegisterForm.getMenuNames() != null) {
			List<String> menuNames = restaurantRegisterForm.getMenuNames();
			List<Integer> prices = restaurantRegisterForm.getPrices();
			for (int index = 0; index < menuNames.size(); index++) {
				// restaurantMenu.setMenuName(menuNames.get(index));
				// restaurantMenu.setPrice(prices.get(index));
				
				adminMapper.insertRestaurantMenus(new RestaurantMenuRegisterForm(restaurant.getNo(), menuNames.get(index), prices.get(index)));
			}
		}
		
	}
}
