package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.criteria.LikeCriteria;
import kr.co.nc.criteria.PlaceCriteria;
import kr.co.nc.dto.Place;

@Mapper
public interface PlaceMapper {

	// 숙소, 식당을 키워드로 통합검색한 결과를 거리순으로 반환한다. (criteria에서 숙소/식당만 조회 선택 가능)
	List<Place> getAllPlacesByCriteria(PlaceCriteria criteria);
	// 검색결과의 행 수 조회
	int getTotalRowsByCriteria(PlaceCriteria criteria);
	// 특정 페이지번호에 맞게 통합검색 결과를 조회(거리순)
	List<Place> getAllPlacesByCriteriaWithPagination(PlaceCriteria criteria);
	// 해당 사용자의, 해당 번호의 장소에 대한 찜하기 정보가 존재하면 1을, 존재하지 않으면 0을 반환
	int isExistUserLikeById(LikeCriteria criteria);
	
	
	
}
