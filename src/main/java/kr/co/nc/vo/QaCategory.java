package kr.co.nc.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 카테고리 유형을 표현하는 객체
 * @author 82102
 *
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("QaCategory")
public class QaCategory {

	private String qaCatId;
	private Category category;
	
	public QaCategory(String qaCatId, String qaCatName) {
		this.qaCatId = qaCatId;
		this.category = new Category(qaCatName);
	}
}
