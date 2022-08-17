package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Payment;
import kr.co.nc.vo.Reservation;
import kr.co.nc.web.form.PaymentRequest;

@Mapper
public interface ReservationMapper {

	// 숙소 예약
	void insertReservation(Reservation reservation);
	
	// 숙소 예약 / 체크인-아웃에 따른 날짜 예약
	void ReservateRoom(Reservation reservation);
	/*
	 * 	날짜에따른 방검색
		SELECT room_no
		  FROM acco_rooms AR
		  WEHRE room_no not in( SELECT room_no
		 						FROM reservation
		 						WHERE reservation_check_in < 종료일
		   						AND reservation_check_out   > 시작일);
	 */
	
	
	
	// 예약번호로 모든 예약정보 가져오기.
	List<Reservation> getAllReserveInfo(int userNo);
	
	// 예약 상태변경하기 (예약가능 / 만실)
	void updateReservationStatus(Reservation reservation);
	
	// 결제 상태변경하기 (결제대기 / 결제완료)
	void updatePaymentStatuts(Payment payment);

	// 예약번호로 예약정보 가져오기
	Reservation getReserveInfoByReserveId(String reservationId);
	// 결제 정보 저장하기
	void insertPayment(PaymentRequest paymentRequest);



}
