package kr.co.nc.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
@Alias("Category")
public class Category {
	
	private String id;
	private String name;
	
	public Category(String id) {
		this.id = id;
	}
}
