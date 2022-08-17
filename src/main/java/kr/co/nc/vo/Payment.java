package kr.co.nc.vo;



import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Payment {

	private String paymentId;
	private String paymentStatus;
	private int paymentTotalPrice;
	private int reservationNo;
	
	private Reservation reservation;
	private User user;
}
