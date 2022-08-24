package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("MonthlySalesDataForm")
public class MonthlySalesDataForm {

	private String salesDate;
	private int salesPrice;
	
	public MonthlySalesDataForm(String salesDate, int salesPrice) {
		this.salesDate = salesDate;
		this.salesPrice = salesPrice;
	}
}
