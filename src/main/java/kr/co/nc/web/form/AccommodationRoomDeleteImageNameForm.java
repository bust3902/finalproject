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
@Alias("AccommodationRoomDeleteImageNameForm")
public class AccommodationRoomDeleteImageNameForm {

		private int no;								// 객실 번호
		private String deleteRoomDetailImgNames;	// 삭제할 객실 상세 이미지명
		
		public AccommodationRoomDeleteImageNameForm(int no, String deleteRoomDetailImgNames) {
			this.no = no;
			this.deleteRoomDetailImgNames = deleteRoomDetailImgNames;
		}
}
