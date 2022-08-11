package kr.co.nc.web.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.deser.impl.CreatorCandidate.Param;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.ReservationService;
import kr.co.nc.vo.PaymentRequest;
import kr.co.nc.vo.User;


@Controller
public class ReservationServerController {

	
	private IamportClient api;
	@Autowired
	private ReservationService reservationService;
	
	public ReservationServerController() {
    	// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("5747455310514176","c4Zu7ERApTEqbHJ7AHrC23jg4AVzfbsRE8NR7PjHwEmpdBEkWkwGD61VFjwI2bjcsTy7n2mzHK8dQpkv");
	}
	
	@ResponseBody
	@RequestMapping(value="/reservation/complete/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(@RequestBody(required=true) PaymentRequest paymentRequest, @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{
	
		System.out.println(paymentRequest);
		
//		reservationService.insertReservate(paymentRequest);	
//		reservationService.insertPayment(paymentRequest);
		return api.paymentByImpUid(imp_uid);
		
		}

	
}
