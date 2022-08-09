package kr.co.nc.web.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.ReservationService;
import kr.co.nc.vo.User;

@Controller
public class ReservationController {

	@Autowired
	ReservationService reservationService;
	@Autowired
	AccommodationService accommodationService;
	/*
	 * 예약페이지 요청처리 / 상세예약페이지에서 요청처리 옴과 동시의 데이터베이스에서 예약상태를 '결제대기'상태로 변경할것
	 * 요청URI : /reservation
	 * 뷰 페이지 : /WEB-INF/views/home.jsp
	 */
	@GetMapping(path = "/reservation")
	public String reservation(@RequestParam("id") int accoId, Model model) {
		model.addAttribute("detail",accommodationService.getAccommodationDetailById(accoId));

		return "reservation/reservation";
	}
	
	
	/*
	 * 예약취소기능이 있는 나의 상세페이지 요청
	 * 요청URI : /myreservation
	 * 뷰 페이지 : /WEB-INF/views/myreservation.jsp
	 * 마이페이지의 나의 상세예약정보페이지 요청 추후 마이페이지에 보낼예정
	 */
	@GetMapping(path = "/myreservation")
	public String myReservation(@LoginUser User user , String uid_imp ,Model model) {
		
		model.addAttribute(reservationService.getReserveInfoByReserveId(uid_imp));
		return "reservation/myreservation";
	}
	/*
	 * 예약페이지에서 요청이 옴과 동시에 DB의 PAYMENT테이블의 PAYMENT_TYPE을 '결제완료'로 변경
	 * 내 예약내역 리스트페이지 요청
	 * 요청URI : /reservationList
	 * 뷰 페이지 : /WEB-INF/views/reservationList.jsp
	 */
	@GetMapping(path = "/reservationList")
	public String myReservationList(@LoginUser User user, Model model) {
		model.addAttribute(reservationService.getAllReserveInfoByReserveId(user.getNo()));	
		return "reservation/reservationList";
	}

	
}
