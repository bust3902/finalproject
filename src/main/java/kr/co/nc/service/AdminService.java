package kr.co.nc.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.mapper.AdminMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.vo.RestaurantCategory;
import kr.co.nc.vo.RestaurantMenu;
import kr.co.nc.vo.RestaurantTag;
import kr.co.nc.web.form.AccoCommonFacilityRegisterForm;
import kr.co.nc.web.form.AccoDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomFacilitiesRegisterForm;
import kr.co.nc.web.form.AccoTagRegisterForm;
import kr.co.nc.web.form.AccoTypeRegisterForm;
import kr.co.nc.web.form.AccommodationRegisterForm;
import kr.co.nc.web.form.AccommodationRoomRegisterForm;
import kr.co.nc.web.form.RestaurantCategoryRegisterForm;
import kr.co.nc.web.form.RestaurantMenuRegisterForm;
import kr.co.nc.web.form.RestaurantRegisterForm;

@Service
public class AdminService {
	
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
}
