package kr.co.nc.vo;




import java.util.Date;


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
	private Date checkIn;
	private Date checkOut;
	private int roomNo;
	private int accoId;
	
	
	private User user;
	private Accommodation acco;
	private AccommodationRoom Room;
}
