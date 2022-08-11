package kr.co.nc.mapper;

import kr.co.nc.vo.Payment;

public interface PaymentMapper {

	// 결제 상태변경하기 (결제대기 / 결제완료)
	void updatePaymentStatuts(Payment payment);
	
	
}
