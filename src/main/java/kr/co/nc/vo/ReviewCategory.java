package kr.co.nc.vo;

import lombok.ToString;

import lombok.Setter;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("ReviewCategory")
public class ReviewCategory {

	private int reviewNo;
	private Category category;
	
	public ReviewCategory(int reviewNo, String categoryId) {
		this.reviewNo = reviewNo;
		this.category = new Category(categoryId);
	}
}
