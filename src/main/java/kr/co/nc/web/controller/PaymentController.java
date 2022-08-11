package kr.co.nc.web.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.co.nc.service.ReservationService;
import kr.co.nc.web.form.PaymentRequest;


@RestController
public class PaymentController {

	
	private IamportClient api;
	@Autowired
	private ReservationService reservationService;
	
	public PaymentController() {
    	// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("5747455310514176","c4Zu7ERApTEqbHJ7AHrC23jg4AVzfbsRE8NR7PjHwEmpdBEkWkwGD61VFjwI2bjcsTy7n2mzHK8dQpkv");
	}

	@GetMapping("/reservation/complete/{imp_uid}")
	@PostMapping("/reservation")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(@RequestBody(required=false) PaymentRequest paymentRequest, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{
	
		return api.paymentByImpUid(imp_uid);
		}
	
}
