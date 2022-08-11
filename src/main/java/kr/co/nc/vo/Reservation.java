package kr.co.nc.vo;

import java.util.List;



import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reservation {

	private String reservationNo;
	private String reserName;
	private String reserTel;
	private String amount;
	private String checkIn;
	private String checkOut;
	private String paymentStatus;
	private String reservationStatus;
	
	
	private User users;
	private Accommodation acco;
	private AccommodationRoom Room;
}
