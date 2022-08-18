package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Payment;

@Mapper
public interface PaymentMapper {

	// 결제 상태변경하기 (결제대기 / 결제완료)
	void updatePaymentStatuts(Payment payment);
	
	// 결제정보 가져오기
	List<Payment> getAllPaymentInfo(int userNo);
	
	Payment getPaymentInfo(String reservationNo);
	// 예약완료된
	List<Payment> getReadytoReserveInfoByReserveId(int userNo);
	// 예약취소된 예약정보가져오기
	List<Payment> getRefundReserveInfoByReserveId(int userNo);
	
	// 결제 정보 저장하기
	void insertPayment(Payment payment);
	
}
