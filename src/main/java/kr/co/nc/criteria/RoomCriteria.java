package kr.co.nc.criteria;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoomCriteria {

	private int accoId; // 숙소번호
	private int roomNo; // 객실번호
	private String startDate; // 조회하는 기간의 시작 날짜
	private String endDate; // 조회하는 기간의 종료 날짜
}
