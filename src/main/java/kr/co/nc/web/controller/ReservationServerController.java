package kr.co.nc.web.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class ReservationServerController {

private IamportClient api;
	
	public ReservationServerController() {
    	// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("5747455310514176","c4Zu7ERApTEqbHJ7AHrC23jg4AVzfbsRE8NR7PjHwEmpdBEkWkwGD61VFjwI2bjcsTy7n2mzHK8dQpkv");
	}
		
	@ResponseBody
	@RequestMapping(value="/reservation/complete/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(
		Model model, 
		Locale locale, 
		HttpSession session, 
		@PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException{	
			return api.paymentByImpUid(imp_uid);
			
	}
	
}
