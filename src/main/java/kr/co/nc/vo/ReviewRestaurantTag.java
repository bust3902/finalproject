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
@Alias("ReviewRestaurantTag")
public class ReviewRestaurantTag {

	private int reviewNo;
	private String tag;
}
