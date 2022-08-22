package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.dto.CommonFacilitiesDTO;
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
import kr.co.nc.web.form.AccommodationRoomDeleteImageNameForm;
import kr.co.nc.web.form.RestaurantCategoryModifyForm;
import kr.co.nc.web.form.RestaurantCategoryRegisterForm;
import kr.co.nc.web.form.RestaurantDeleteMenuForm;
import kr.co.nc.web.form.RestaurantDeleteTagForm;
import kr.co.nc.web.form.RestaurantMenuRegisterForm;

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
	// 키워드로 숙소 정보 검색
	List<Restaurant> getSearchRestaurant(String keyword);
	
	// 숙소 아이디로 숙소 정보 검색
	Accommodation getSearchAccommodationById(int accoId);
	// 숙소 아이디로 숙소 공용시설 정보 검색
	List<String> getAccommodationCommonFacilitiesById(int id);
	// 숙소아이디로 숙소 상세이미지 정보 검색
	List<String> getAccommodationImagesById(int id);
	// 숙소아이디로 숙소 태그 정보 검색
	List<String> getAccommodationTagsById(int id);
	// 숙소아이디로 숙소 타입 정보 검색
	List<String> getAccommodationTypesById(int id);
	// 숙소아이디로 체크된 공용시설 정보 검색
	List<CommonFacilitiesDTO> getCheckedFacilities(int id);
	// 숙소 타입으로 숙소 공용시설 정보 검색
	List<CommonFacility> getCommonFacilitiesByAccommodationTypes(List<String> types);
	
	
	// 숙소아이디로 객실 검색
	List<AccommodationRoom> getAccommodationRoomByaccoId(int id);
	// 객실번호로 객실 검색
	List<AccommodationRoom> getAccommodationRoomByroomNo(int no);
	// 객실번호로 객실 시설 검색
	List<RoomFacility> getAccommodationRoomFacilitiesByroomNo(int no);
	// 객실번호로 객실 상세이미지 검색
	List<String> getAccommodationRoomImagesByroomNo(int no);

	// 음식점 번호로 음식점 검색
	Restaurant getSearchRestaurantByNo(int no);
	// 음식점 번호로 음식점 카테고리 검색
	List<RestaurantCategoryModifyForm> getSearchRestaurantCategoriesByNo(int no);
	// 음식점 번호로 음식점 태그 검색
	List<RestaurantTag> getSearchRestaurantTagsByNo(int no);
	// 음식점 번호로 음식점 메뉴 검색
	List<RestaurantMenu> getSearchRestaurantMenusByNo(int no);
	
	// 숙소 정보 수정
	void updateAccommodation(Accommodation accommodation);
	// 숙소 타입 수정
	void updateAccommodationTypes(AccoTypeRegisterForm accoTypeRegisterForm);
	// 숙소 태그 수정
	void updateAccommodationTags(AccoTagRegisterForm accoTagRegisterForm);
	// 숙소 공용시설 수정
	void updateAccommodationCommonFacilities(AccoCommonFacilityRegisterForm accoCommonFacilityRegisterForm);
	// 숙소 상세정보 수정
	void updateAccommodationDetailImages(AccoDetailImageNamesRegisterForm accoDetailImageNamesRegisterForm);
	
	// 숙소 상세이미지 삭제
	void deleteAccommodationDetailImages(AccommodationDeleteImageNameForm accommodationDeleteImageNameForm);
	// 숙소 태그 삭제
	void deleteAccommodationTags(AccommodationDeleteTagForm accommodationDeleteTagForm);
	// 숙소 공용시설 삭제
	void deleteCommonFacilitiesById(int id);
	// 숙소 숙소타입 삭제
	void deleteAccommodationTypes(int id);
	// 객실 상세이미지 삭제
	void deleteAccommodationRoomDetailImages(AccommodationRoomDeleteImageNameForm accommodationRoomDeleteImageNameForm);
	// 객실 시설 삭제
	void deleteRoomCommonFacilitiesById(int id);
	
	// 객실 수정
	void updateAccoRoom(AccommodationRoom accommodationRoom);
	// 객실 시설 수정
	void updateAccoRoomFacilities(AccoRoomFacilitiesRegisterForm accoRoomFacilitiesRegisterForm);
	// 객실 상세 이미지 수정
	void updateAccoRoomDetailImages(AccoRoomDetailImageNamesRegisterForm accoRoomDetailImageNamesRegisterForm);
	
	// 음식점 태그 삭제
	void deleteRestaurantTags(RestaurantDeleteTagForm restaurantDeleteTagForm);
	// 음식점 메뉴 삭제
	void deleteRestaurantMenus(RestaurantDeleteMenuForm restaurantDeleteMenuForm);
	
	// 음식점 수정
	void updateRestaurant(Restaurant restaurant);

}
