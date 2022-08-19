package kr.co.nc.web.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.criteria.AccoCriteria;
import kr.co.nc.criteria.ReviewCriteria;
import kr.co.nc.criteria.RoomCriteria;
import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.ReviewService;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.Pagination;
import kr.co.nc.vo.User;

/**
 * 숙소 관련 요청에 대하여 데이터를 json 형식의 응답으로 반환하는 컨트롤러이다.
 * @author doyoung
 *
 */
@RestController
public class AccommodationRestController {
	
	@Autowired
	private AccommodationService accommodationService;
	
	@Autowired
	private ReviewService reviewService;
	
	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping(path = "/accommodations")
	public List<Accommodation> accommodations(AccoCriteria criteria) {
		return accommodationService.searchAccommodation(criteria);
	}
	
	// 검색 조건(날짜)에 맞는 객실 리스트 반환
	@GetMapping(path = "/rooms")
	public List<AccommodationRoom> rooms(RoomCriteria roomCriteria) {
		return accommodationService.getRoomDetailsByAccoIdwithPagination(roomCriteria);
	}
	
	// 객실 정보에 대한 pagination 객체 반환
	@GetMapping(path = "/pagination")
	public Pagination pagination(RoomCriteria criteria) {
		return accommodationService.generatePagination(criteria);
	}
	
	// 해당 숙소에 대한 리뷰 리스트, 평점분포 집계결과 반환
	@GetMapping(path = "/reviews")
	public Map<String, Object> reviews(int accoId) {
		// 두 가지 정보를 map객체에 담아 반환한다.
		Map<String, Object> reviewdatas = new HashMap<>();
		// 리뷰 리스트
		ReviewCriteria criteria = new ReviewCriteria("accommodation", accoId);
		reviewdatas.put("reviews", reviewService.getReviewsByCriteria(criteria));
		// 평점분포 집계결과 객체
		reviewdatas.put("chartData", reviewService.getReviewPointChartByAccoId(accoId));
		return reviewdatas;
	}
	
	// 숙소 찜하기 토글
	@GetMapping(path = "/changelike/acco")
	public boolean like(@LoginUser User loginUser, int accoId) {
		try {
			// 서비스에서 비즈니스 로직 수행 : service에서는 user_accommodation_like 테이블에 일치하는 정보가 존재하면 삭제하고, 존재하지 않으면 저장한다.
			accommodationService.changeMyAccoLikeStatus(loginUser, accoId);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
