package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.criteria.AccoCriteria;
import kr.co.nc.vo.Accommodation;
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
	
	// 숙소번호에 따른 숙소정보 상세 조회, 모든 객실정보 조회, 객실번호에 따른 객실상세정보 조회
	
}
