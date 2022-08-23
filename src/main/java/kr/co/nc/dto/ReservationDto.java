package kr.co.nc.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("ReservationDto")
public class ReservationDto {

	private String reservationId;
	private Date checkIn;
	private Date checkOut;
	private int userNo;
	private int roomNo;
	private int accoId;
	private String reservationName;
	private String reservationTel;
	private String accoName;
	private String userName;

}
