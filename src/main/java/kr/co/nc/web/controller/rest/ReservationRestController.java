package kr.co.nc.web.controller.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.service.ReservationService;
import kr.co.nc.vo.PaymentRequest;

@RestController
public class ReservationRestController {

	@Autowired
	ReservationService reservationService;
	
	@PostMapping(path ="/reservation/complete/{imp_uid}")
	public void saveReservation(@RequestBody PaymentRequest paymentRequest) {
	}
}
