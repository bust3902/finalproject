package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소 이미지명 삭제를 위한 폼
 * ACCO_DETAIL_IMAGES 테이블에서 삭제
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccommodationDeleteImageNameForm")
public class AccommodationDeleteImageNameForm {

		private int id;					// 숙소 아이디
		private String deleteImgName;	// 삭제할 숙소 상세 이미지명
		
		public AccommodationDeleteImageNameForm(int id, String deleteImgName) {
			this.id = id;
			this.deleteImgName = deleteImgName;
		}
}
