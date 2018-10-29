package com.java.web.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

public interface ServiceBoardInterface {
	
	public ModelAndView boardlist(HttpServletResponse response) throws IOException;
	
	public ModelAndView insertboard(HttpServletRequest request, HttpSession session);
	
	public ModelAndView deleteboard(HttpServletRequest request, HttpSession session);
	
	public ModelAndView updateboard(HttpServletRequest request, HttpSession session);
	
	public ModelAndView sendsessage(HttpServletRequest request, HttpSession session);
	
	public ModelAndView messagelist_to(HttpServletRequest request,HttpServletResponse response) throws IOException;
	
	public ModelAndView messagelist_from(HttpServletRequest request,HttpServletResponse response) throws IOException;
	
	public ModelAndView deletemessage(HttpServletRequest request,HttpServletResponse response) throws IOException;
}
