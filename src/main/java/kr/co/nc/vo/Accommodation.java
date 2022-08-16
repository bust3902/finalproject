package kr.co.nc.vo;

import java.util.Date;
import java.util.List;

import kr.co.nc.dto.StarIconForRate;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Accommodation {

	private int id;
	private String name;
	private String district;
	private String address;
	private String latitude;
	private String longitude;
	private String introduceComment;
	private String thumbnailImageName;
	private String detailDescription;
	private double reviewRate; // (모든 사용자의 평점 합/리뷰 수)를 계산한 평점
	private int reviewCount; 
	private int likeCount; 
	private Date createdDate;
	private Date updatedDate;
	private String deleted;
	private String cityId;
	
	//// 화면 표현 시 사용하는 변수
	private String currentDistance; // 현재 조회한 위치로부터의 거리 (데이터 조회시에만 사용하는 필드)
	private int minPrice; // 현재 조회한 날짜에서 가장 저렴한 객실의 1박 금액 (데이터 조회시에만 사용하는 필드)
	private String reviewRateKeyword; // 리뷰 점수에 따라 화면에 출력할 키워드 (평가없음(리뷰 정보 없을 시)/아쉬워요/부족해요/만족해요/추천해요/최고에요)
	private StarIconForRate reviewRateIcon; // 리뷰 별점 아이콘을 표현하는 hashMap을 상속받는 객체
	
	private List<AccommodationType> types; // 이 숙소가 해당하는 모든 숙소유형
	private List<AccommodationRoom> rooms; // 이 숙소가 가지는 모든 객실정보
	private List<CommonFacility> commonFacilities; // 이 숙소가 가지는 모든 공용시설 정보
	private List<String> tags; // 이 숙소가 가지는 모든 부가사항 태그
	
	private List<String> images; // 숙소 이미지 파일명
	
	// 리뷰 점수에 대한 setter 메소드 재정의
	// * 숙소 정보를 조회해 이 객체를 만들어 리뷰 점수를 저장할 때 reviewRateIcon, reviewRateKeyword에 대한 적절한 값이 저장된다.
	public void setReviewRate(double reviewRate) {
		this.reviewRate = reviewRate;
		initReviewRateIcon(reviewRate);
		initReviewRateKeyword(reviewRate);
	}
	
	// 리뷰 점수에 따라 화면에서 표현할 키워드를 저장한다.
	private void initReviewRateKeyword(double reviewRate) {
		if (reviewRate <= 1) {
			if (reviewCount == 0) {
				this.reviewRateKeyword = "평가정보없음";
				return;
			}
			this.reviewRateKeyword = "아쉬워요";
		} else if (reviewRate <= 2) {
			this.reviewRateKeyword = "부족해요";
		} else if (reviewRate <= 3) {
			this.reviewRateKeyword = "만족해요";
		} else if (reviewRate <= 4) {
			this.reviewRateKeyword = "추천해요";
		} else if (reviewRate <= 5) {
			this.reviewRateKeyword = "최고에요";
		}
	}
	
	// 리뷰점수를 별점아이콘 5개에 대한 html 클래스 정보로 표현하는 객체를 생성해 숙소객체에 저장한다.
	private void initReviewRateIcon(double reviewRate) {
		this.reviewRateIcon = new StarIconForRate(reviewRate);
	}
}
