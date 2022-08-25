package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.AccommodationRoom;
import kr.co.nc.vo.Reservation;

@Mapper
public interface ReservationMapper {

	// 숙소 예약
	void insertReservation(Reservation reservation);
	
	
	// 로그인번호 모든 예약정보 가져오기.
	List<Reservation> getAllReserveInfo(int userNo);
	

	// 예약번호로 예약정보 가져오기
	Reservation getReserveInfoByReserveId(String reservationNo);

	// 객실번호로 객실정보 가져오기.
	AccommodationRoom getRoomDetailByroomNo(int roomNo);

}
