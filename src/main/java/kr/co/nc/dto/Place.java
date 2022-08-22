package kr.co.nc.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 숙소, 식당 통합검색 시 사용하는 dto
 * @author doyoung
 *
 */
@Getter
@Setter
@ToString
public class Place {

	private int id;
	private String name;
	private String latitude;
	private String longitude;
	private int reviewCount;
	private int likeCount;
	private double reviewRate;
	private String address;
	private double distance;
	private String type; // 숙소는 A, 식당은 R
	private StarIconForRate reviewRateIcon;
	private boolean liked; // 로그인사용자일 경우 service에서 찜 상태 여부를 확인해서 저장

	public void setReviewRate(double reviewRate) {
		this.reviewRate = reviewRate;
		initReviewRateIcon(reviewRate);
	}
	
	// 리뷰점수를 별점아이콘 5개에 대한 html 클래스 정보로 표현하는 객체를 생성해 숙소객체에 저장한다.
	private void initReviewRateIcon(double reviewRate) {
		this.reviewRateIcon = new StarIconForRate(reviewRate);
	}
}
