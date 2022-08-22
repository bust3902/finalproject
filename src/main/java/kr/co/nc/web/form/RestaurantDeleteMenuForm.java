package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 음식점 메뉴, 메뉴 금액 삭제를 위한 폼
 * RESTAURANT_MENU 테이블에서 삭제
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("RestaurantDeleteMenuForm")
public class RestaurantDeleteMenuForm {

		private int no;						// 음식점 번호
		private String deletMenuName;		// 삭제할 음식점 메뉴
		private String deleteMenuPrice;		// 삭제할 음식점 메뉴 금액
		
		public RestaurantDeleteMenuForm(int no, String deletMenuName, String deleteMenuPrice) {
			this.no = no;
			this.deletMenuName = deletMenuName;
			this.deleteMenuPrice = deleteMenuPrice;
		}
}
