package com.java.web.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

public interface ServiceInterface {
	
	public ModelAndView call(String menu, String type, HttpServletRequest req);

}
