package kr.co.nc.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReservationController {

	@GetMapping(path = "/reservation")
	public String reservation() {
		return "reservation/reservation";
	}
}