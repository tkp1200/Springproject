package user.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import lombok.Setter;
import user.bean.UserDTO;
import user.service.UserService;

@Controller
@Component
public class UserController {
	
	@Autowired
	private UserService userService;
	
	
	
	@RequestMapping(value = "/user/writeForm", method = RequestMethod.GET)
	  public String writeForm() {
		
		
	    return "writeForm";
	  }
	@RequestMapping(value = "/user/getExistId", method = RequestMethod.POST)
	@ResponseBody
	 public String getExistId(String id) {
		return userService.getExistId(id); 
	}
	
	@RequestMapping(value = "/user/write", method = RequestMethod.POST)
	@ResponseBody
	 public void write(@ModelAttribute UserDTO userDTO ) {
		
		 userService.write(userDTO); 
	}
	

	@RequestMapping(value = "/user/list", method = RequestMethod.GET)
	  public String list(@RequestParam (required = false,defaultValue = "1")String pg,Model model) {
		
		
		Map<String,Object> map2 =userService.list(pg);
		map2.put("pg", pg);
		model.addAttribute("map2",map2);
		return "list";
	  }
	
	@RequestMapping(value = "/user/updateForm", method = RequestMethod.GET)
	  public String updateForm(@RequestParam("id") String id, @RequestParam(value = "pg", required = false, defaultValue = "1") String pg, Model model) {
		
		UserDTO userDTO = userService.getUser(id); 
		 model.addAttribute("user", userDTO);
		 model.addAttribute("pg", pg); 
		return "updateForm";
	  }

	@RequestMapping(value = "/user/update", method = RequestMethod.POST)
	@ResponseBody
	  public void update( @ModelAttribute UserDTO userDTO) {
		System.out.println(userDTO);
		userService.update(userDTO);
		 
	  }
	
	@RequestMapping(value = "/user/check", method = RequestMethod.POST)
	@ResponseBody
	public String check(String id, String pwd) {
	    boolean isValid = userService.check(id,pwd);
	    return isValid ? "success" : "fail";
	}
	
	@RequestMapping(value = "/user/delete", method = RequestMethod.POST)
	@ResponseBody
	  public void delete(String id) {
		
		userService.delete(id);
		 
	  }
	
}
