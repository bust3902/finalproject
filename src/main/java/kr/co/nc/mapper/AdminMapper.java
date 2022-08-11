package kr.co.nc.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.web.form.AccoCommonFacilityRegisterForm;
import kr.co.nc.web.form.AccoDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomFacilitiesRegisterForm;
import kr.co.nc.web.form.AccoTagRegisterForm;
import kr.co.nc.web.form.AccoTypeRegisterForm;
import kr.co.nc.web.form.AccommodationRegisterForm;

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
}
