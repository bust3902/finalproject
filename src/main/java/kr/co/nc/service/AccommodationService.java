package kr.co.nc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.criteria.AccoCriteria;
import kr.co.nc.criteria.RoomCriteria;
import kr.co.nc.mapper.AccommodationMapper;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.AccommodationType;
import kr.co.nc.vo.City;
import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.RoomFacility;

@Service
public class AccommodationService {

	@Autowired
	private AccommodationMapper accommodationMapper;
	
	// 모든 숙소유형 정보를 반환
	public List<AccommodationType> getAllTypes() {
		return accommodationMapper.getAllTypes();
	}
	
	// 모든 지역카테고리를 반환
	public List<City> getAllCities() {
		return accommodationMapper.getAllCities();
	}

	// 해당 숙소유형 아이디를 가진 유형명을 반환
	public String getTypeNameById(String typeId) {
		return accommodationMapper.getTypeNameById(typeId);
	}

	// 해당 숙소유형에 해당하는 공용시설 옵션을 모두 반환
	public List<CommonFacility> getCommonFacilityOptions(String typeId) {
		return accommodationMapper.getCommonFacilitiesByAccoType(typeId);
	}

	// 모든 객실시설 옵션을 반환
	public List<RoomFacility> getRoomFacilityOptions() {
		return accommodationMapper.getAllRoomFacilities();
	}

	// 저장되어있는 모든 숙소 태그를 반환
	public List<String> getAllAccoTagOptions() {
		return accommodationMapper.getAllAccoTags();
	}
	
	// 검색조건에 맞는 모든 숙소정보를 반환
	public List<Accommodation> searchAccommodation(AccoCriteria criteria) {
		// TODO : currentLat, currentLong, startDate, endDate 서버에서도 null 처리?
		List<Accommodation> accommodations = accommodationMapper.getAccommodationsByCriteria(criteria);
		return accommodations;
	}
	
	// 해당 고유번호(아이디)를 가진 숙소의 상세정보를 반환 (숙소가 가지는 공용시설, 태그 포함)
	public Accommodation getAccommodationDetailById(int accoId) {
		Accommodation accommodation = accommodationMapper.getAccommodationdDetailById(accoId);
		return accommodation;
	}
	
	// 숙소번호에 따른 모든 객실정보 조회 (예약 가능 여부 포함)
	public List<AccommodationRoom> getAllRoomDetailsByAccoId(RoomCriteria criteria) {
		// 요청파라미터로 획득하는 값: 숙소아이디, 검색기간(시작날짜, 종료날짜)
		int accoId = criteria.getAccoId();
		// getAllRoomsByAccoId로 리스트 획득
		List<AccommodationRoom> rooms = accommodationMapper.getAllRoomsByAccoId(accoId);
		// 각 객실 별로 예약 가능 재고 조회해서 객실 객체에 저장
		for (AccommodationRoom room : rooms) {
			// 객실 별 조회를 위해 기준 객체에 객실 번호를 저장해서 전달 (roomNo가 0이어도 조회결과가 없음으로 나와서 0 반환되므로 문제 x)
			// jsp에서는 stock이 양의 정수인 객실만 예약버튼을 활성화시킨다.
			criteria.setRoomNo(room.getNo());
			int stock = accommodationMapper.getAvailableRoomStock(criteria);
			room.setStock(stock);
		}
		return rooms;
	}

}
