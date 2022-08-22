package kr.co.nc.dto;

import lombok.Getter;
import lombok.Setter;

/**
 * 숙소, 식당 통합검색 시 사용하는 dto
 * @author doyoung
 *
 */
@Getter
@Setter
public class Place {

	private String name;
	private int reviewCount;
	private int likeCount;
	private double reviewRate;
	private String address;
	private double distance;
	private String type; // 숙소는 A, 식당은 R

}
