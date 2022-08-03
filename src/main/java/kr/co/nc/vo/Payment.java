package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Payment {

	private int paymentId;
	private Date paymentDate;
	private String paymentType;
	private int paymentTotalPrice;
	
	private List<Reservation> reservation;
	
}
