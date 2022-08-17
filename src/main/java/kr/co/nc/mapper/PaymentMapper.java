package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Payment;

@Mapper
public interface PaymentMapper {

	// 결제 상태변경하기 (결제대기 / 결제완료)
	void updatePaymentStatuts(Payment payment);
	
	List<Payment> getPaymentInfo(int reservationNo);
	
}
