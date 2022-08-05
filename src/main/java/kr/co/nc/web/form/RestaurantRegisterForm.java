package kr.co.nc.web.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.nc.vo.RestaurantCategory;
import kr.co.nc.vo.RestaurantMenu;
import kr.co.nc.vo.RestaurantTag;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RestaurantRegisterForm {

	private int no;
	private String name;
	private String location;
	private MultipartFile imgfile;
	private String imgname;
	private String tel; 		// 전화번호
	private String latitud;		// 위도
	private String longitude; 	// 경도
	private String cityId;
	private String opening;		// 운영시간
	private String breakTime;	// 휴식시간
	private String close;		// 휴무일
	
	private List<RestaurantTag> tags;				// 음식점 태그
	private List<RestaurantMenu> menus;				// 음식점 메뉴
	private List<RestaurantCategory> categories;	// 음식점 카테고리
}
