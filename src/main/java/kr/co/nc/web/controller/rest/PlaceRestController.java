package kr.co.nc.web.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.criteria.PlaceCriteria;
import kr.co.nc.dto.Place;
import kr.co.nc.service.PlaceService;

@RestController
public class PlaceRestController {

	@Autowired
	private PlaceService placeService;
	
	@GetMapping(path = "/places")
	public List<Place> places(PlaceCriteria criteria) {
		return placeService.searchPlacesByCriteria(criteria);
	}
}
