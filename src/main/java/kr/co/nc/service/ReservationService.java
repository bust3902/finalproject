package kr.co.nc.service;

import java.util.Date;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.co.nc.mapper.ReservationMapper;
import kr.co.nc.vo.Payment;
import kr.co.nc.vo.Reservation;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class ReservationService {

	@Autowired
	private ReservationMapper reservationMapper;

	/**
	 * 모든 예약정보리스트를 예약번호로 가져오기
	 * @param reservationId 예약번호
	 */
	public List<Reservation>  getAllReserveInfoByReserveId(int reservationId){
		return reservationMapper.getAllReserveInfoByReserveId(reservationId);
	}
	/**
	 * 예약정보를 예약번호로 가져오기
	 * @param uid_imp 예약번호
	 */
	public String  getReserveInfoByReserveId(String uid_imp){
		return reservationMapper.getReserveInfoByReserveId(uid_imp);
	}

	/**
	 * 예약상태 변경하기 (예약가능 -> 만실)
	 * @param reservation 예약정보
	 */
	public void updateReservationStatus(Reservation reservation) {
		reservationMapper.updateReservationStatus(reservation);
	}
	/**
	 * 결재상태 변경하기 (결제대기 -> 결제완료)
	 * @param payment 결제정보
	 */
	public void updatePaymentStatus(Payment payment) {
		reservationMapper.updatePaymentStatuts(payment);
	}
	
	/*
	 * 예약정보 저장
	 */
	public void insertReservate(String buyerName, String buyerTel, String impUid, String merchantUid, String paidAmount, Date checkIn, Date checkOut, String reservationStatus ,String paymentStatus, String pgProvider ) {
		
		log.info("예약자이름 : " + buyerName);
		log.info("예약자번호 : " + buyerTel);
		log.info("결제번호 : " + impUid);
		log.info("주문번호 : " + merchantUid);
		log.info("결제금액 : " + paidAmount);
		log.info("체크인 : " + checkIn);
		log.info("체크아웃 : " + checkOut);
		log.info("예약상태 : " + reservationStatus);
		log.info("결제상태 : " + paymentStatus);
		log.info("결제타입 : " + pgProvider);
		
		Reservation reservation = new Reservation();
		reservation.setReservationId(merchantUid);
		reservation.setReserName(buyerName);
		reservation.setReserTel(buyerTel);
		reservation.setCheckIn(checkIn);
		reservation.setCheckOut(checkOut);
		
		Payment payment = new Payment();
		payment.setPaymentId(impUid);
		payment.setPaymentStatus(paymentStatus);
		payment.setPaymentType(pgProvider);
		
		reservationMapper.insertReservation(reservation);
		
		
	}

	
}
