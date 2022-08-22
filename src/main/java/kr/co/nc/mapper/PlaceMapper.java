package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.criteria.PlaceCriteria;
import kr.co.nc.dto.Place;

@Mapper
public interface PlaceMapper {

	// 숙소, 식당을 키워드로 통합검색한 결과를 거리순으로 반환한다. (criteria에서 숙소/식당만 조회 선택 가능)
	public List<Place> getAllPlacesByCriteria(PlaceCriteria criteria);
	
}
