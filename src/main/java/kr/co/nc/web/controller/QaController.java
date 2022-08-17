package kr.co.nc.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QaController {

	@GetMapping(path = "/qa")
	public String Qa() {
		return "qa/qa";
	}
	
	@GetMapping(path = "/qaform")
	public String QaForm() {
		return "qa/qaform";
	}
	
}
