package kr.co.nc.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.nc.annotation.LoginUser;
import kr.co.nc.service.UserService;
import kr.co.nc.vo.User;

@Controller
@RequestMapping("/user")
public class UserController {	
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/imformation")
	public String imformation(@LoginUser User user, Model model) {
		System.out.println("로그인된 사용자 정보: " + user);
		
		return "user/imformation";
	}

}
