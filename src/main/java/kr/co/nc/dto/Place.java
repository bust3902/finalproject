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
	private StarIconForRate reviewRateIcon;
	
	public void setType(String type) {
		if ("A".equals(type)) {
			this.type = "숙소";
		} else if ("R".equals(type)) {
			this.type = "식당";
		}
	}

	public void setReviewRate(double reviewRate) {
		this.reviewRate = reviewRate;
		initReviewRateIcon(reviewRate);
	}
	
	// 리뷰점수를 별점아이콘 5개에 대한 html 클래스 정보로 표현하는 객체를 생성해 숙소객체에 저장한다.
	private void initReviewRateIcon(double reviewRate) {
		this.reviewRateIcon = new StarIconForRate(reviewRate);
	}
}
