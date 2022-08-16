package kr.co.nc.web.controller;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.criteria.RoomCriteria;
import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.ReservationService;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.User;
import kr.co.nc.web.form.PaymentRequest;

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
	public String reservation(@LoginUser User user, RoomCriteria criteria, @RequestParam(name ="id", required =false)Integer accoId, @RequestParam(value ="checkIn") String checkIn, @RequestParam(value ="checkOut") String checkOut ,
	Model model, PaymentRequest paymentRequest) {
		
		//상세페이지에서 온 해당 id를 가지고 숙소예약을한다.
		model.addAttribute("accommodation", accommodationService.getAllRoomDetailsByAccoId(criteria));
		// 체크인 체크아웃 데이터 가져오기...?
		return "reservation/reservation";
	}
	
	/*
	 * 예약취소기능이 있는 나의 상세페이지 요청
	 * 요청URI : /myreservation
	 * 뷰 페이지 : /WEB-INF/views/myreservation.jsp
	 * 마이페이지의 나의 상세예약정보페이지 요청 추후 마이페이지에 보낼예정
	 */
	@GetMapping(path = "/myreservation")
	public String myReservation(@LoginUser User user , @RequestParam(name="reservationNo")String reservationNo ,Model model) {
		
		model.addAttribute("reservation", reservationService.getReserveInfoByReserveId(reservationNo));

		return "reservation/myreservation";
	}
	/*
	
	 * 내 예약내역 리스트페이지 요청
	 * 요청URI : /reservationList
	 * 뷰 페이지 : /WEB-INF/views/reservationList.jsp
	 */
	@GetMapping(path = "/reservationList")
	public String reservationList(@LoginUser User user, Model model) {
		model.addAttribute("reservationList", reservationService.getAllReserveInfo(user.getNo()));
		model.addAttribute("payment",reservationService.getPaymentInfo(user.getNo()));
		return "reservation/reservationList";
	}

	
}
