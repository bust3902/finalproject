package kr.co.nc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.nc.vo.Payment;
import kr.co.nc.web.form.PaymentRequest;

@Mapper
public interface PaymentMapper {

	// 결제 상태변경하기 (결제대기 / 결제완료)
	void updatePaymentStatuts(Payment payment);
	
	// 결제정보 가져오기
	List<Payment> getPaymentInfo(int userNo);
	
	// 결제 정보 저장하기
	void insertPayment(PaymentRequest paymentRequest);
}
