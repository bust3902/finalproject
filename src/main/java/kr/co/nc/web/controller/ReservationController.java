package kr.co.nc.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReservationController {

	/*
	 * 예약페이지 요청처리 / 상세예약페이지에서 요청처리 옴과 동시의 데이터베이스에서 예약상태를 '결제대기'상태로 변경할것
	 * 요청URI : /reservation
	 * 뷰 페이지 : /WEB-INF/views/home.jsp
	 */
	@GetMapping(path = "/reservation")
	public String reservation() {
		return "reservation/reservation";
	}
	/*
	 * 예약취소기능이 있는 나의 상세페이지 요청
	 * 요청URI : /myreservation
	 * 뷰 페이지 : /WEB-INF/views/myreservation.jsp
	 * 마이페이지의 나의 상세예약정보페이지 요청 추후 마이페이지에 보낼예정
	 */
	@GetMapping(path = "/myreservation")
	public String myReservation() {
		
		return "reservation/myreservation";
	}
	/*
	 * 예약페이지에서 요청이 옴과 동시에 DB의 PAYMENT테이블의 PAYMENT_TYPE을 '결제완료'로 변경
	 * 내 예약내역 리스트페이지 요청
	 * 요청URI : /reservationList
	 * 뷰 페이지 : /WEB-INF/views/reservationList.jsp
	 */
	@GetMapping(path = "/reservationList")
	public String myReservationList() {
		return "reservation/reservationList";
	}

	
}
