package kr.co.nc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.criteria.PlaceCriteria;
import kr.co.nc.dto.Place;
import kr.co.nc.mapper.PlaceMapper;

@Service
public class PlaceService {

	@Autowired
	private PlaceMapper placeMapper;
	
	public List<Place> searchPlacesByCriteria(PlaceCriteria criteria) {
		return placeMapper.getAllPlacesByCriteria(criteria);
	}
}
