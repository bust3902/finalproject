package kr.co.nc.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("CommonFacilitiesDTO")
public class CommonFacilitiesDTO {
	
	String id;
	String name;
	String checked;
	
}
