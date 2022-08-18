package kr.co.nc.web.form;





import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentRequest {

	private String impUid;
	private String merchantUid;
	private int amount;
	private String reserName;
	private String reserTel;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkIn;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkOut;
	private int roomNo;
	private int accoId;
}
