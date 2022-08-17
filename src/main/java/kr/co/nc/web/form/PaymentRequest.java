package kr.co.nc.web.form;





import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentRequest {

	private String impUid;
	private String merchantUid;
	private String reserName;
	private String reserTel;
	private int amount;
	private String checkIn;
	private String checkOut;
	private String paymentStatus;
	private String reservationStatus;
}
