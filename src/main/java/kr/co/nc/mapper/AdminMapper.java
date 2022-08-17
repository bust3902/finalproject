package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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
import kr.co.nc.web.form.RestaurantCategoryRegisterForm;
import kr.co.nc.web.form.RestaurantMenuRegisterForm;
import kr.co.nc.web.form.RestaurantRegisterForm;

@Mapper
public interface AdminMapper {

	// 숙소 정보 저장
	void insertAccommodation(Accommodation accommodation);
	
	// 숙소 타입 저장
	void insertAccommodationTypes(AccoTypeRegisterForm accoTypeRegisterForm);
	
	// 숙소 태그 저장
	void insertAccommodationTags(AccoTagRegisterForm accoTagRegisterForm);
	
	// 숙소 공용시설 저장
	void insertAccommodationCommonFacilities(AccoCommonFacilityRegisterForm accoCommonFacilityRegisterForm);
	
	// 숙소 상세정보 저장
	void insertAccommodationDetailImages(AccoDetailImageNamesRegisterForm accoDetailImageNamesRegisterForm);
	
	// 객실 정보 저장
	void insertAccoRooms(AccommodationRoom accommodationRoom);
	
	// 객실 시설 저장
	void insertAccoRoomFacilities(AccoRoomFacilitiesRegisterForm accoRoomFacilitiesRegisterForm);
	
	// 객실 상세 이미지 저장
	void insertAccoRoomDetailImages(AccoRoomDetailImageNamesRegisterForm accoRoomDetailImageNamesRegisterForm);
	
	// 음식점 정보 저장
	void insertRestaurant(Restaurant restaurant);

	// 음식점 태그 정보 저장
	void insertRestaurantTags(RestaurantTag restaurantTag);
	
	// 음식점 메뉴 정보 저장
	void insertRestaurantMenus(RestaurantMenuRegisterForm restaurantMenuRegisterForm);

	// 음식점 카테고리 정보 저장
	void insertRestaurantCategories(RestaurantCategoryRegisterForm restaurantCategoryRegisterForm);
	
	// 키워드로 숙소 정보 검색
	List<Accommodation> getSearchAccommodations(String keyword);
}
