package kr.co.nc.criteria;

import lombok.Getter;

/**
 * 찜하기 여부를 조회할 때 사용하는 검색기준
 * 사용자 번호와, 해당 시설(숙소/식당)에 대한 식별번호를 멤버변수로 가진다.
 * 두 값에 대한 초기화를 강제하기 위해 setter메소드를 정의하지 않고, 생성자메소드를 재정의함.
 * @author doyoung
 *
 */
@Getter
public class LikeCriteria {
	int userNo;
	int id; // 숙소의 찜하기 여부를 조회할때는 accoId를, 식당의 찜하기 여부를 조회할때는 restaurantNo를 저장
	String type; // 숙소/식당 A/R
	
	// 숙소 서비스, 식당서비스에서 각각 분리된 mapper 호출 시 사용하는 생성자
	public LikeCriteria(int userNo, int id) {
		this.userNo = userNo;
		this.id = id;
	}
	
	// 통합검색에서 사용하는 생성자 
	public LikeCriteria(int userNo, int id, String type) {
		this.userNo = userNo;
		this.id = id;
		this.type = type;
	}
}
