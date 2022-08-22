package kr.co.nc.web.form;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소 태그 삭제를 위한 폼
 * ACCO_TAGS 테이블에서 삭제
 * @author USER
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("AccommodationDeleteTagForm")
public class AccommodationDeleteTagForm {

		private int id;					// 숙소 아이디
		private String deleteTag;	// 삭제할 숙소 상세 이미지명
		
		public AccommodationDeleteTagForm(int id, String deleteTag) {
			this.id = id;
			this.deleteTag = deleteTag;
		}
}
