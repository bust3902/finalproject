package kr.co.nc.web.controller.rest;

import java.util.List;

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
import kr.co.nc.vo.Review;
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
	public Pagination pagination(int accoId, int currentPage) {
		return accommodationService.generatePagination(accoId, currentPage);
	}
	
	// 해당 숙소에 대한 리뷰 리스트 반환
	@GetMapping(path = "/reviews")
	public List<Review> reviews(int accoId) {
		ReviewCriteria criteria = new ReviewCriteria("accommodation", accoId);
		return reviewService.getReviewsByCriteria(criteria);
	}
	
	// 숙소 찜하기 토글
	@GetMapping(path = "/changelike")
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
