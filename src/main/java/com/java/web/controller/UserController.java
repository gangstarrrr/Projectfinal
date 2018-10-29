package com.java.web.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.dao.DaoInterface;
import com.java.web.service.ServiceUserInterface;
import com.java.web.util.FinalUtil;
import com.java.web.util.HttpUtil;
import com.sun.xml.internal.ws.wsdl.writer.document.Part;


@Controller
public class UserController {
	
	@Autowired
	ServiceUserInterface sui;
	
	@RequestMapping("/logout")
	public String	logout(HttpSession session) {
		session.invalidate();
		return "redirect:/see_something";
	}
	
	@RequestMapping("/userInsert")
	public String	userInsert(HttpServletRequest request, @RequestParam("photo") MultipartFile file) throws IOException {

		return sui.userInsert(request, file);
	}
	
	@RequestMapping(value="/login")
	public ModelAndView login(HttpServletRequest request,HttpSession session) {
		
		return sui.login(request, session);
	}
	
	@RequestMapping("/infoupdate")
	public String infoupdate(HttpServletRequest request,HttpSession session, @RequestParam("photo") MultipartFile file) throws IOException {
		
		return sui.infoupdate(request, session, file);
	}
	
	@RequestMapping("/deleteuser")
	public ModelAndView deleteuser(HttpServletRequest request) {
		
		return sui.deleteuser(request);
    }
	
	@RequestMapping("/checkId")
    public @ResponseBody int idCheck(HttpServletRequest request) {
		
		return sui.idCheck(request);
    }
	
}
