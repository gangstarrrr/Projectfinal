package com.java.web.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.dao.DaoInterface;
import com.java.web.service.ServiceBoardInterface;
import com.java.web.util.FinalUtil;
import com.java.web.util.HttpUtil;


@Controller
public class BoardController {
	
	@Autowired
	ServiceBoardInterface sbi;
	
	@RequestMapping("/boardlist")
	public ModelAndView boardlist(HttpServletResponse response) throws IOException{
		
		return sbi.boardlist(response);
		
	}
	
	@RequestMapping(value="/insertboard", method=RequestMethod.POST)
	public ModelAndView insertboard(HttpServletRequest request, HttpSession session) {
		
		return sbi.insertboard(request, session);
		
	}
	
	@RequestMapping("/deleteboard")
	public ModelAndView deleteboard(HttpServletRequest request, HttpSession session) {
		
		return sbi.deleteboard(request, session);
		
	}
	
	@RequestMapping("/updateboard")
	public ModelAndView updateboard(HttpServletRequest request, HttpSession session) {
		
		return sbi.updateboard(request, session);
		
	}
	
	@RequestMapping("/sendmessage")
	public ModelAndView sendsessage(HttpServletRequest request, HttpSession session) {
		
		return sbi.sendsessage(request, session);
		
	}
	
	@RequestMapping("messagelist_to")
	public ModelAndView messagelist_to(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		return sbi.messagelist_to(request, response);
		
	}
	
	@RequestMapping("messagelist_from")
	public ModelAndView messagelist_from(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		return sbi.messagelist_from(request, response);
		
	}
	
	@RequestMapping("deletemessage")
	public ModelAndView deletemessage(HttpServletRequest request,HttpServletResponse response) throws IOException{
		
		return sbi.deletemessage(request, response);
		
	}
	
}
