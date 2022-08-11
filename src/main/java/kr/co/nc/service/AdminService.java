package kr.co.nc.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.mapper.AdminMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.AccommodationType;
import kr.co.nc.web.form.AccoCommonFacilityRegisterForm;
import kr.co.nc.web.form.AccoDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomDetailImageNamesRegisterForm;
import kr.co.nc.web.form.AccoRoomFacilitiesRegisterForm;
import kr.co.nc.web.form.AccoTagRegisterForm;
import kr.co.nc.web.form.AccoTypeRegisterForm;
import kr.co.nc.web.form.AccommodationRegisterForm;
import kr.co.nc.web.form.AccommodationRoomRegisterForm;

@Service
public class AdminService {
	
	@Autowired
	private AdminMapper adminMapper;
	
	public void addNewAccommodation(AccommodationRegisterForm accommodationRegisterForm) throws IOException {
		
		// 숙소정보 저장하기
		Accommodation accommodation = new Accommodation();
		accommodation.setName(accommodationRegisterForm.getName());
		accommodation.setDistrict(accommodationRegisterForm.getDistrict());
		accommodation.setAddress(accommodationRegisterForm.getAddress());
		accommodation.setLatitude(accommodationRegisterForm.getLatitude());
		accommodation.setLongitude(accommodationRegisterForm.getLongitude());
		accommodation.setIntroduceComment(accommodationRegisterForm.getIntroduceComment());
		accommodation.setThumbnailImageName(accommodationRegisterForm.getThumbnailImageName());
		accommodation.setDetailDescription(accommodationRegisterForm.getDetailDescription());
		accommodation.setCityId(accommodationRegisterForm.getCityId());
		
		adminMapper.insertAccommodation(accommodation);

		// 숙소 타입 정보 저장하기
		List<AccommodationType> types = accommodationRegisterForm.getTypes();
		for (AccommodationType type : types) {
			adminMapper.insertAccommodationTypes(new AccoTypeRegisterForm(accommodation.getId(), type.getId()));
		}
		
		// 이 숙소가 가지는 모든 부가사항 태그
		List<String> tags = accommodationRegisterForm.getTags();
		for (String tag : tags) {
			adminMapper.insertAccommodationTags(new AccoTagRegisterForm(accommodation.getId(), tag));
		}
		
		// 이 숙소가 가지는 모든 공용시설 정보
		List<String> commonFacilities = accommodationRegisterForm.getStringCommonFacilities();
		for (String commonFacility : commonFacilities) {
			adminMapper.insertAccommodationCommonFacilities(new AccoCommonFacilityRegisterForm(accommodation.getId(), commonFacility));
		}
		
		// 이 숙소가 가지는 모든 상세이미지 정보
		List<String> detailImageNames = accommodationRegisterForm.getDetailImageNames();
		for (String detailImageName : detailImageNames) {
			adminMapper.insertAccommodationDetailImages(new AccoDetailImageNamesRegisterForm(accommodation.getId(), detailImageName));
		}
		
		// 객실 정보 저장하기
		List<AccommodationRoomRegisterForm> rooms = accommodationRegisterForm.getAccommodationRooms();
		AccommodationRoom accoRoom;
		for (AccommodationRoomRegisterForm room : rooms) {
			for (int index = 0; index < accommodationRegisterForm.getAccommodationRooms().size(); index++) {
				accoRoom = new AccommodationRoom();
				accoRoom.setNo(index);
				accoRoom.setName(room.getName());
				accoRoom.setNumbers(room.getNumbers());
				accoRoom.setCapacity(room.getCapacity());
				accoRoom.setDayPrice(room.getDayPrice());
				accoRoom.setThumbnailImageName(room.getThumbnailImageName());
				accoRoom.setDescription(room.getDescription());
				accoRoom.setAccoId(room.getAccoId());
				accoRoom.setRoomFacilities(room.getRoomFacilities());

			adminMapper.insertAccoRooms(accoRoom);
			accommodation.getRooms().add(accoRoom);
			}
		}
		
		// 이 객실이 가지는 모든 시설 정보
		for (int index = 0; index < accommodation.getRooms().size(); index++) {
			List<String> roomFacilities = accommodationRegisterForm.getAccommodationRooms().get(index).getStringRoomFacilities();
			for (String roomFacility : roomFacilities) {
				adminMapper.insertAccoRoomFacilities(new AccoRoomFacilitiesRegisterForm(accommodation.getRooms().get(index).getNo() , roomFacility));
			}
		}
		
		// 이 객실이 가지는 모든 상세이미지 정보
		for (int index = 0; index < accommodation.getRooms().size(); index++) {
			List<String> roomDetailImageNames = accommodationRegisterForm.getAccommodationRooms().get(index).getDetailImageNames();
			for (String roomDetailImageName : roomDetailImageNames) {
				adminMapper.insertAccoRoomDetailImages(new AccoRoomDetailImageNamesRegisterForm(accommodation.getRooms().get(index).getNo(), roomDetailImageName));
			}
		}
	}
}
