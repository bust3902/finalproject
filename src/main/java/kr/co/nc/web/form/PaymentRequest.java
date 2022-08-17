package kr.co.nc.web.form;





import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentRequest {

	private String impUid;
	private int merchantUid;
	private int amount;
	private String reserName;
	private String reserTel;
	private String checkIn;
	private String checkOut;
	private int roomNo;
	private int accoId;
}
