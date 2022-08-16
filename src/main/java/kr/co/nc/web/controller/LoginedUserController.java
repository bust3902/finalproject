package kr.co.nc.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.nc.service.LoginedUserService;
import kr.co.nc.util.SessionUtils;
import kr.co.nc.vo.Category;
import kr.co.nc.vo.User;

@SessionAttributes("userRegisterForm")
@Controller
@RequestMapping("/user")
public class LoginedUserController {
   
   @Autowired
   private LoginedUserService loginedService;
   
   /*
    * @RequestParam
    *       요청파라미터값을 매핑시키는 어노테이션이다.
    *       name: 요청파라미터의 이름을 지정한다.
    *       required: 필수 요청파라미터값인지 여부를 설정한다. 기본값은 true다. 
    *               false로 지정하면 해당 요청파라미터값이 없어도 상관없다.
    *       defaultValue: 요청파라미터값이 존재하지 않을 때 변수에 저장될 기본값을 지정한다.
    */
   @GetMapping(path = "/imformation")
   public String home(@RequestParam(name ="cat", required = false) String categoryId, Model model) {
      List<Category> categories = loginedService.getAllCategories();
      model.addAttribute("categories",categories);
      
      return "user/imformation";
   }
   
   @GetMapping(path = "/updateNickname")
   public String updateNickname(@RequestParam(name = "nickname") String nickname) {
	   User user =  (User) SessionUtils.getAttribute("LOGIN_USER");
	   
	   user = loginedService.updateNickname(user.getId(), nickname);
	   SessionUtils.addAttribute("LOGIN_USER", user);
	   
	   return "redirect:/user/imformation?cat=CAT_001";
   }
   
   @GetMapping(path = "/updateName")
   public String updateName(@RequestParam(name = "name") String name) {
	   User user =  (User) SessionUtils.getAttribute("LOGIN_USER");
	   
	   user = loginedService.updateName(user.getId(), name);
	   SessionUtils.addAttribute("LOGIN_USER", user);
	   
	   return "redirect:/user/imformation?cat=CAT_001";
   }
   
   @GetMapping(path = "/updateTel")
   public String updateTel(@RequestParam(name = "tel") String tel) {
	   User user =  (User) SessionUtils.getAttribute("LOGIN_USER");
	   
	   user = loginedService.updateTel(user.getId(), tel);
	   SessionUtils.addAttribute("LOGIN_USER", user);
	   
	   return "redirect:/user/imformation?cat=CAT_001";
   }
}