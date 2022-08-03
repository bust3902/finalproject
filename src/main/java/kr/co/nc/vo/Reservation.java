package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reservation {

	private int reservationId;
	private String reservationMemo;
	private String status;
	private Date checkIn;
	private Date checkOut;
	private int HeadCount;
	
	private List<User> users;
	private List<Accommodation> accomoAccommodations;
	private List<AccommodationRoom> accommodationRooms;
}
