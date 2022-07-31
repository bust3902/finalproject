package kr.co.nc.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("RestaurantMenu")
public class RestaurantMenu {

	private int restaurantNo;
	private String menuName;
	private int price;
}
