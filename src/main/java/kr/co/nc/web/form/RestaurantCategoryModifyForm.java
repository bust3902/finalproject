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
@Alias("RestaurantCategoryModifyForm")
public class RestaurantCategoryModifyForm {
	
	private int restaurantNo;
	private String category;
	
	public RestaurantCategoryModifyForm(int restaurantNo, String category) {
		this.restaurantNo = restaurantNo;
		this.category = category;
	}
}
