package kr.co.nc.vo;




import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reservation {

	private int reservationNo;
	private String reserName;
	private String reserTel;
	private String amount;
	private String checkIn;
	private String checkOut;
	private int roomNo;
	private int accoId;
	
	
	private User user;
	private Accommodation acco;
	private AccommodationRoom Room;
}
