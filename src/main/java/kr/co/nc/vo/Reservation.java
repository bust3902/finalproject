package kr.co.nc.vo;

import java.util.List;

import org.springframework.beans.BeanUtils;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reservation {

	private String impUid;
	private String merchantUid;
	private String reserName;
	private String reserTel;
	private String amount;
	private String checkIn;
	private String checkOut;
	private String pgProvider;
	private String paymentStatus;
	private String reservationStatus;
	
	public static Reservation saveReservation(PaymentRequest paymentRequest) {
		Reservation reservation = new Reservation();
		BeanUtils.copyProperties(paymentRequest, reservation);
		return reservation;
	}
	
	private List<User> users;
	private List<Accommodation> accomoAccommodations;
	private List<AccommodationRoom> accommodationRooms;
}
