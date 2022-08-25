package kr.co.nc.web.controller.rest;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.nc.dto.CommonFacilitiesDTO;
import kr.co.nc.dto.QaDto;
import kr.co.nc.dto.ReservationDto;
import kr.co.nc.service.AccommodationService;
import kr.co.nc.service.AdminService;
import kr.co.nc.vo.Accommodation;
import kr.co.nc.vo.CommonFacility;
import kr.co.nc.vo.Payment;
import kr.co.nc.vo.QaAnswer;
import kr.co.nc.vo.Restaurant;
import kr.co.nc.web.form.MonthlySalesDataForm;
import kr.co.nc.web.form.WeeklySalesDataForm;
import kr.co.nc.web.form.YearlySalesDataForm;

/**
 * 숙소 입출력시 필요한 데이터를 전달하는 컨트롤러
 * @author USER
 *
 */
@RestController
@RequestMapping("/admin")
public class AdminRestController {
	
	@Autowired
	private AdminService adminService;
	@Autowired
	private AccommodationService accommodationService;
	
	// 숙소타입 선택시 공용시설 체크박스 출력을 처리하기 위한 데이터 전달
	@GetMapping("/searchCommonFacilities")
	@ResponseBody
	public List<CommonFacility> searchCommonFacilities(@RequestParam("types[]") List<String> types) {
		// 공용시설 정보 검색
		return adminService.getCommonFacilitiesByAccommodationTypes(types);
	}
	
	// 숙소유형 선택시 공용시설 리스트 출력을 위한 데이터 전달
	@GetMapping("/search")
	@ResponseBody
	public List<CommonFacility> search(@RequestParam("type") String type) {
		// type에 따른 공용시설 옵션 list 전달
		return accommodationService.getCommonFacilityOptions(type);
	}

	// 검색 조건에 맞는 숙소 리스트 반환
	@GetMapping("/searchAccommodation")
	@ResponseBody
	public List<Accommodation> adminAccommodationSearch(@RequestParam("keyword") String keyword) {
		
		return adminService.searchAccommodation(keyword);
	}
	
	// 검색 조건에 맞는 음식점 리스트 반환
	@GetMapping("/searchRestaurant")
	@ResponseBody
	public List<Restaurant> adminRestaurantSearch(@RequestParam("keyword") String keyword) {
		
		return adminService.searchRestaurant(keyword);
	}
	
	// 주간 매출 그래프 출력을 위한 데이터
	@GetMapping(path = "/weeklyChartData")
	public List<WeeklySalesDataForm> weeklyChartDatas() {
		return adminService.getWeeklyChartData();
	}
	// 월간 매출 그래프 출력을 위한 데이터
	@GetMapping(path = "/monthlyChartData")
	public List<MonthlySalesDataForm> monthlyChartDatas() {
		return adminService.getMonthlyChartData();
	}
	// 연간 매출 그래프 출력을 위한 데이터
	@GetMapping(path = "/yearlyChartData")
	public List<YearlySalesDataForm> yearlyChartDatas() {
		return adminService.getYearlyChartData();
	}

	// 입실예정 예약현황 출력
	@GetMapping(path = "/searchReservationAdmin")
	public List<ReservationDto> searchReservationAdmin() {
		return adminService.getReservationList();
	}
	// 미답변 문의내역 출력
	@GetMapping(path = "/searchQaAdmin")
	public List<QaDto> searchQaAdmin() {
		return adminService.getQAListByAnswerStatus();
	}

	// 수정시 공용시설 체크상태를 처리하기 위한 데이터 전달
	@GetMapping("/searchFacilitiesChecked")
	@ResponseBody
	public List<CommonFacilitiesDTO> search(@RequestParam("id") int id) {
		// type에 따른 공용시설 옵션 list 전달
		return adminService.getCheckedFacilities(id);
	}
	
	// 문의 답변 저장
	@RequestMapping(value = "/insertQaAnswer", method = { RequestMethod.POST })	
	public void insertQaAnswer(@RequestParam("qaAnswer") String qaAnswer,
	                 @RequestParam("qaNo") int qaNo) throws IOException {
		QaAnswer saveQaAnswer = new QaAnswer();
		saveQaAnswer.setQaNo(qaNo);
		saveQaAnswer.setContent(qaAnswer);
		adminService.insertQaAnswer(saveQaAnswer);
	}
	
	// 사용자 ID로 검색하여 PAYMENT_STATUS 값 '예약취소'로 수정
	@RequestMapping(value = "/deleteReservationByAdmin", method = { RequestMethod.POST })	
	public void deleteReservationByAdmin(@RequestParam("reservationId") String reservationId) throws IOException {
		Payment payment = new Payment();
		payment.setReservationNo(reservationId);
		adminService.deleteReservationByAdmin(payment);
	}
}
