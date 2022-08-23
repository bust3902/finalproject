package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 음식점 태그 삭제를 위한 폼
 * RESTAURANT_TAG 테이블에서 삭제
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("RestaurantDeleteTagForm")
public class RestaurantDeleteTagForm {

		private int no;					// 음식점 번호
		private String deleteTag;		// 삭제할 음식점 태그
		
		public RestaurantDeleteTagForm(int no, String deleteTag) {
			this.no = no;
			this.deleteTag = deleteTag;
		}
}
