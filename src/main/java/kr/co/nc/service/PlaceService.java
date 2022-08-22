package kr.co.nc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.criteria.LikeCriteria;
import kr.co.nc.criteria.PlaceCriteria;
import kr.co.nc.dto.Pagination;
import kr.co.nc.dto.Place;
import kr.co.nc.mapper.PlaceMapper;

@Service
public class PlaceService {

	@Autowired
	private PlaceMapper placeMapper;
	
	public List<Place> searchPlacesByCriteria(PlaceCriteria criteria) {
		return placeMapper.getAllPlacesByCriteria(criteria);
	}
	
	public List<Place> searchPlacesByCriteriaWithPagination(PlaceCriteria criteria) {
		Pagination pagination = generatePagination(criteria, "places");
		criteria.setBeginIndex(pagination.getBeginIndex());
		criteria.setEndIndex(pagination.getEndIndex());
		
		List<Place> places = placeMapper.getAllPlacesByCriteriaWithPagination(criteria);
		// 로그인 사용자인 경우 찜 상태 확인
		if (criteria.getUserNo() != null) {
			int userNo = (int) criteria.getUserNo();
			for (Place place : places) {
				place.setLiked(isLikedPlace(new LikeCriteria(userNo, place.getId(), place.getType())));
			}
		}
		return places;
	}

	public List<Place> searchMyLikePlacesWithPagination(PlaceCriteria criteria) {
		Pagination pagination = generatePagination(criteria, "mylike");
		criteria.setBeginIndex(pagination.getBeginIndex());
		criteria.setEndIndex(pagination.getEndIndex());
		
		List<Place> places = placeMapper.getMyLikePlacesWithPagination(criteria);
		for (Place place : places) {
			place.setLiked(true);
		}
		
		return places;
	}
	
	public boolean isLikedPlace(LikeCriteria criteria) {
		return placeMapper.isExistUserLikeById(criteria) == 1 ? true : false;
	}
	
	public Pagination generatePagination(PlaceCriteria criteria, String option) {
		int totalRows = 0;
		if ("places".equals(option)) {
			totalRows = placeMapper.getTotalRowsByCriteria(criteria);
		} else if ("mylike".equals(option)) {
			totalRows = placeMapper.getMyLikePlacesTotalRowsByCriteria(criteria);
		}
		Pagination pagination = new Pagination(5, 5, totalRows, criteria.getCurrentPage());
		pagination.init();
		return pagination;
	}
	
}
