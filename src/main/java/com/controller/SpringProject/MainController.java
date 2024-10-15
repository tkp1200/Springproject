package com.controller.SpringProject;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import user.bean.UserDTO;



@Controller
@Component
public class MainController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	  public String index() {
		
	    return "index";
	  }
	
	
	
	

}
