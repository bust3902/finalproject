package kr.co.nc.vo;



import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PaymentRequest {

	private String impUid;
	private String merchantUid;
	private String reserName;
	private String reserTel;
	private String amount;
	private String checkIn;
	private String checkOut;
	private String pgProvider;
	private String paymentStatus;
	private String reservationStatus;
	
}
