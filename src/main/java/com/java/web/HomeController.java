package com.java.web;

import java.util.Locale;
import javax.annotation.Resource;
import org.apache.hadoop.conf.Configuration;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController {
	
	@Resource(name="hdConf")
	Configuration conf;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "home";
	}

	@RequestMapping(value = "/see_something", method = RequestMethod.GET)
	public String see_something(Locale locale, Model model) {
		return "see_something";
	}
	
	@RequestMapping(value = "/chart", method = RequestMethod.GET)
	public String chart(Locale locale, Model model) {
		return "chart";
	}
	
	@RequestMapping(value = "/month_chart", method = RequestMethod.GET)
	public String month_(Locale locale, Model model) {
		return "month_";
	}
}
