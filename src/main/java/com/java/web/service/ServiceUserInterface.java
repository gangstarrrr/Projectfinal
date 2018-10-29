package com.java.web.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.util.HttpUtil;

public interface ServiceUserInterface {
	
	public ModelAndView call(String menu, String type, HttpServletRequest req);

	public String	userInsert(HttpServletRequest request, @RequestParam("photo") MultipartFile file) throws IOException;

	public ModelAndView login(HttpServletRequest request,HttpSession session);
	
	public String infoupdate(HttpServletRequest request,HttpSession session, @RequestParam("photo") MultipartFile file) throws IOException;
	
	public ModelAndView deleteuser(HttpServletRequest request);
	
	public @ResponseBody int idCheck(HttpServletRequest request);
}
