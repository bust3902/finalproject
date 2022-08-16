package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 음식점 메뉴 저장을 위한 폼
 * RESTAURANT_MENU 테이블에 저장
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("RestaurantCategoryRegisterForm")
public class RestaurantCategoryRegisterForm {

	private int no;				// 음식점 고유번호
	private String category;	// 메뉴명
	
	public RestaurantCategoryRegisterForm(int no, String category) {
		this.no = no;
		this.category = category;
	}
}
