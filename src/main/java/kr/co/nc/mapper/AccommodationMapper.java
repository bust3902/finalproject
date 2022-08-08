package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.criteria.AccoCriteria;
import kr.co.nc.criteria.RoomCriteria;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.AccommodationType;
import kr.co.nc.vo.City;
import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.RoomFacility;

@Mapper
public interface AccommodationMapper {

	// 모든 숙소유형 정보 조회
	List<AccommodationType> getAllTypes();
	// 모든 지역 정보 조회
	List<City> getAllCities();
	// 숙소유형 아이디에 따른 숙소유형명 조회
	String getTypeNameById(String typeId);
	
	// 해당 숙소유형에 따른 공용시설 옵션 조회
	List<CommonFacility> getCommonFacilitiesByAccoType(String typeId);
	// 모든 객실시설 옵션 조회
	List<RoomFacility> getAllRoomFacilities();
	// 모든 부가사항 태그 조회
	List<String> getAllAccoTags();
	
	// 검색조건에 따른 숙소정보 조회
	List<Accommodation> getAccommodationsByCriteria(AccoCriteria criteria);
	
	// 숙소번호에 따른 숙소정보 상세 조회
	Accommodation getAccommodationdDetailById(int accoId);
	// 숙소번호에 따른 공용시설 조회
	List<CommonFacility> getCommonFacilitiesByAccoId(int accoId);
	// 숙소번호에 따른 태그 조회
	List<String> getAccoTagsByAccoId(int accoId);
	// 숙소번호에 따른 이미지(파일명) 조회
	List<String> getImagesByAccoId(int accoId);
	
	// 숙소번호에 따른 모든 객실정보 조회 (예약 가능 여부 제외)
	List<AccommodationRoom> getAllRoomsByAccoId(int accoId);
	// 객실번호에 따른 객실시설 조회
	List<RoomFacility> getRoomFacilitiesByRoomNo(int roomNo);
	// 객실번호에 따른 이미지(파일명) 조회
	List<String> getImagesByRoomNo(int roomNo);
	// 검색 기간에 따른 특정 객실의 예약 가능 여부 조회
	boolean getIsAvailableRoom(RoomCriteria criteria);
}
