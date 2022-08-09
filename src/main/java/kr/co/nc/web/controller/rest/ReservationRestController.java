package kr.co.nc.web.controller.rest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.ReservationService;
import kr.co.nc.vo.PaymentRequest;
import kr.co.nc.vo.User;

@RestController
public class ReservationRestController {

	@Autowired
	ReservationService reservationService;
	
	//결제 정보 반환
	@PostMapping(path ="/reservation/complete/{imp_uid}")
	public void saveReservation(@LoginUser User user, @RequestBody PaymentRequest paymentRequest) {
		
		reservationService.insertReservate(paymentRequest);
	}
}
