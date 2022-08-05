package kr.co.nc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.co.nc.mapper.ReservationMapper;
import kr.co.nc.vo.Payment;
import kr.co.nc.vo.Reservation;

@Service
public class ReservationService {

	@Autowired
	private ReservationMapper reservationMapper;
	
	public List<Reservation>  getReserveInfoByReserveNo(int reservationId){
		return reservationMapper.getReserveInfoByReserveNo(reservationId);
	}
	
	public void updateReservationStatus(Reservation reservation) {
		reservationMapper.updateReservationStatus(reservation);
	}
	public void updatePaymentStatus(Payment payment) {
		reservationMapper.updatePaymentStatuts(payment);
	}
	
	
}
