package kr.co.nc.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.nc.mapper.PaymentMapper;
import kr.co.nc.mapper.ReservationMapper;
import kr.co.nc.vo.Payment;
import kr.co.nc.vo.Reservation;
import kr.co.nc.web.form.PaymentRequest;

@Service
public class ReservationService {

	@Autowired
	private ReservationMapper reservationMapper;

	@Autowired
	private PaymentMapper paymentMapper;
	/**
	 * 모든 예약정보리스트를 예약번호로 가져오기
	 * @param reservationId 예약번호
	 */
	public List<Reservation>  getAllReserveInfo(int userNo){
		return reservationMapper.getAllReserveInfo(userNo);
	}
	
	public List<Payment> getPaymentStatus(int reservationNo){
		return paymentMapper.getPaymentInfo(reservationNo);
	}
	
	/**
	 * 예약정보를 예약번호로 가져오기
	 * @param uid_imp 예약번호
	 */
	public Reservation  getReserveInfoByReserveId(String reservationNo){
		return reservationMapper.getReserveInfoByReserveId(reservationNo);
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
		Reservation reservation = new Reservation();
		reservation.setReserName(paymentRequest.getReserName());
		reservation.setReserTel(paymentRequest.getReserTel());
		reservation.setCheckIn(paymentRequest.getCheckIn());
		reservation.setCheckOut(paymentRequest.getCheckOut());
		reservation.setReservationNo(paymentRequest.getMerchantUid());
		
		reservationMapper.insertReservation(reservation);
		
		
	}
	/*
	 * 결제정보 저장
	 */
	public void insertPayment(PaymentRequest paymentRequest) {
		Payment payment = new Payment();
		payment.setPaymentId(paymentRequest.getImpUid());
		payment.setPaymentTotalPrice(paymentRequest.getAmount());
		payment.setReservationNo(paymentRequest.getMerchantUid());
		reservationMapper.insertPayment(paymentRequest);
	}
	
}
