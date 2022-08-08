package kr.co.nc.criteria;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RoomCriteria {

	private int roomNo; // 객실번호
	private Date startDate; // 조회하는 기간의 시작 날짜
	private Date endDate; // 조회하는 기간의 종료 날짜
}
