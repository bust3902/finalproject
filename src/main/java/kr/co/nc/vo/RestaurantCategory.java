package kr.co.nc.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("RestaurantCategory")
public class RestaurantCategory {

	private int restaurantNo;
	private Category category;
	
	public RestaurantCategory(int restaurantNo, String categoryId) {
		this.restaurantNo = restaurantNo;
		this.category = new Category(categoryId);
	}
}
