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
		Pagination pagination = generatePagination(criteria);
		criteria.setBeginIndex(pagination.getBeginIndex());
		criteria.setEndIndex(pagination.getEndIndex());
		System.out.println(criteria.toString());
		return placeMapper.getAllPlacesByCriteriaWithPagination(criteria);
	}
	
	public boolean isLikedPlace(LikeCriteria criteria) {
		return placeMapper.isExistUserLikeById(criteria) == 1 ? true : false;
	}

	public Pagination generatePagination(PlaceCriteria criteria) {
		int totalRows = placeMapper.getTotalRowsByCriteria(criteria);
		Pagination pagination = new Pagination(5, 5, totalRows, criteria.getCurrentPage());
		pagination.init();
		return pagination;
	}
}
