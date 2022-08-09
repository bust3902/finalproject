package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Payment {

	private String paymentId;
	private Date paymentDate;
	private String paymentType;
	private String paymentStatus;
	private int paymentTotalPrice;
	
	public static Payment savePaymnet(PaymentRequest paymentRequest) {
		Payment payment = new Payment();
		BeanUtils.copyProperties(paymentRequest, payment);
		return payment;
	}
	private List<Reservation> reservation;
	
}
