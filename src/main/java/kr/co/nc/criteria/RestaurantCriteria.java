package kr.co.nc.criteria;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RestaurantCriteria {

	private String categoryId;
	private String keyword;
	private String sort;
	private List<String> tags;
}
