package kr.co.nc.criteria;

import org.apache.ibatis.type.Alias;

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
	
	public LikeCriteria(int userNo, int id) {
		this.userNo = userNo;
		this.id = id;
	}
}
