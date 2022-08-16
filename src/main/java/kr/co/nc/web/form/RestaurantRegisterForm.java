package kr.co.nc.web.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.vo.RestaurantMenu;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 음식점 입력용 폼
 * RESTAURANT 테이블에 저장
 * @author USER
 *
 */
@Getter
@Setter
@ToString
public class RestaurantRegisterForm {

	private int no;
	private String name;			// 가게명
	private String location;		// 주소
	private MultipartFile imgfile;	// 이미지파일
	private String imgname;			// 이미지 파일명
	private String tel; 			// 전화번호
	private String latitude;		// 위도
	private String longitude; 		// 경도
	private String cityId;			// 지역 아이디
	private String opening;			// 운영시간
	private String breakTime;		// 휴식시간
	private String close;			// 휴무일
	private String district;		// 구역(시/군/구 정보)
	
	private List<String> tags;			// 음식점 태그
	private List<RestaurantMenu> menus;	// 음식점 메뉴
	private List<String> menuNames;		// 음식점 메뉴
	private List<Integer> prices;		// 음식점 메뉴
	private List<String> categories;	// 음식점 카테고리
}
