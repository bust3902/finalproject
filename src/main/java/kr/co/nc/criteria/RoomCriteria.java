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
	private String onlyAvailable; // 예약가능한 객실만 볼 건지 여부. 체크한 경우 전달받는 값은 "yes"
	private int capacity; // 객실정원
	// 페이징을 위해 요청파라미터로 전달받는 값
	private int currentPage;
	// 페이징을 위해 서비스에서 저장하는 값
	private int beginIndex;
	private int endIndex;
}
