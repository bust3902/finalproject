package kr.co.nc.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.co.nc.mapper.ReservationMapper;
import kr.co.nc.vo.Payment;
import kr.co.nc.vo.PaymentRequest;
import kr.co.nc.vo.Reservation;

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
	public void insertReservate(PaymentRequest paymentRequest) {
		
		reservationMapper.insertReservation(paymentRequest);
		
		
	}

	
}
