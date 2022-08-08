package kr.co.nc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.criteria.AccoCriteria;
import kr.co.nc.criteria.RoomCriteria;
import kr.co.nc.dto.StarIconForRate;
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
		for (Accommodation accommodation : accommodations) {
			// 리뷰 점수에 따라 화면에 표현할 키워드 설정
			initReviewRateKeyword(accommodation);
		}
		
		return accommodations;
	}
	
	// 해당 고유번호(아이디)를 가진 숙소의 상세정보를 반환 (숙소가 가지는 공용시설, 태그 포함)
	public Accommodation getAccommodationDetailById(int accoId) {
		Accommodation accommodation = accommodationMapper.getAccommodationdDetailById(accoId);
		// 리뷰점수 관련 화면 표현 값들 설정
		initReviewRateKeyword(accommodation);
		initReviewRateIcon(accommodation);
		
		return accommodation;
	}
	
	// 숙소번호에 따른 모든 객실정보 조회 (예약 가능 여부 포함)
	public List<AccommodationRoom> getAllRoomDetailsByAccoId(int accoId, RoomCriteria criteria) {
		// TODO getAllRoomsByAccoId로 리스트 획득 후
		// TODO for문 돌려서 예약가능 여부 조회 후 boolean 값 저장
		return null;
	}
	
	//////// 서비스 공통기능 메소드
	// 리뷰점수에 따라 화면에서 표현할 리뷰 관련 값들을 저장한다.
	public void initReviewRateKeyword(Accommodation accommodation) {
		double reviewRate = accommodation.getReviewRate();
		// 리뷰 점수에 따라 화면에서 표현할 키워드를 저장한다.
		if (reviewRate <= 1) {
			accommodation.setReviewRateKeyword("아쉬워요");
		} else if (reviewRate <= 2) {
			accommodation.setReviewRateKeyword("부족해요");
		} else if (reviewRate <= 3) {
			accommodation.setReviewRateKeyword("만족해요");
		} else if (reviewRate <= 4) {
			accommodation.setReviewRateKeyword("추천해요");
		} else if (reviewRate <= 5) {
			accommodation.setReviewRateKeyword("최고에요");
		}
	}
	
	// 리뷰점수를 별점아이콘 5개에 대한 html 클래스 정보로 표현하는 객체를 생성해 숙소객체에 저장한다.
	public void initReviewRateIcon(Accommodation accommodation) {
		accommodation.setReviewRateIcon(new StarIconForRate(accommodation.getReviewRate()));
	}
}
