package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("Qa")
public class Qa {

	private int no;
	private User user;
	private String content;
	private String title;
	private Date createdDate;
	private String image;
	private boolean answerStatus;
	
	List<QaCategory> qaCategories;		// 문의사항 카테고리 (숙소, 객실, 음식점)
	List<QaType> qaTypes;					// 문의사항 유형 (취소/환불, 예약/결제, 환불신청, 예약문의)
}
