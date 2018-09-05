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
import com.java.web.util.FinalUtil;
import com.java.web.util.HttpUtil;
import com.sun.xml.internal.ws.wsdl.writer.document.Part;


@Controller
public class UserController {
	
	@Autowired
	DaoInterface di;
	
	@RequestMapping("/logout")
	public String	logout(HttpSession session) {
		session.invalidate();
		return "redirect:/see_something";
	}
	
	@RequestMapping("/userInsert")
	public String	userInsert(HttpServletRequest request, @RequestParam("photo") MultipartFile file) throws IOException {

		HashMap<String,Object> param = HttpUtil.getParamMap(request);
		System.out.println(param);
		
		String fileNm=file.getOriginalFilename();
		System.out.println(fileNm);
		if(fileNm=="") {
			System.out.println("빔");
			param.put("sqlType","user.userInsert");
			param.put("sql","insert");
		}else {
			byte[] bytes = file.getBytes();
			String path = request.getSession().getServletContext().getRealPath("/") +"resources/upload/" + fileNm;
			String dns = "http://gudi.iptime.org:10900/resources/upload/" + fileNm;
			File f = new File(path);
	        OutputStream out = new FileOutputStream(f);
	        out.write(bytes);
	        out.close();	        
			
			param.put("photo_dns",dns);
			param.put("photo_path",path);
			param.put("sqlType","user.userInsert_photo");
			param.put("sql","insert");
		}

		di.call(param);
		
		return "redirect:/see_something";
	}
	
	@RequestMapping(value="/login")
	public ModelAndView login(HttpServletRequest request,HttpSession session) {
		HashMap<String,Object> param = HttpUtil.getParamMap(request);
		param.put("sqlType","user.login");
		param.put("sql","selectOne");
		
		HashMap<String, Object> resultMap = (HashMap<String, Object>)di.call(param);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(resultMap==null) {
			resultMap=new HashMap<String, Object>();
			session.setAttribute("status", FinalUtil.NO);
			map.put("status", FinalUtil.NO);
			map.put("msg","PLZ CHECK YOU ID AND PASSWORD :)");
		}else {
			session.setAttribute("status", FinalUtil.OK);
			map.put("status", FinalUtil.OK);
			map.put("msg","HELLO "+resultMap.get("name")+".");
		}
		session.setAttribute("user", resultMap);
		return HttpUtil.makeJsonView(map);
	}
	
	@RequestMapping("/infoupdate")
	public String infoupdate(HttpServletRequest request,HttpSession session, @RequestParam("photo") MultipartFile file) throws IOException {
		HashMap<String,Object> param = HttpUtil.getParamMap(request);
		System.out.println(param);
		String fileNm=file.getOriginalFilename();
		System.out.println(fileNm);
		HashMap<String, Object> user = (HashMap<String, Object>)session.getAttribute("user");
		String id=user.get("id").toString();
		HashMap<String, Object> up_user = HttpUtil.getParamMap(request);
		up_user.put("id", id);
		if(fileNm=="") {
			System.out.println("빔");
			param.put("id", id);
			param.put("sqlType","user.userUpdate");
			param.put("sql","update");
		}else {
			
			byte[] bytes = file.getBytes();
			String path = request.getSession().getServletContext().getRealPath("/") +"resources/upload/" + fileNm;;
	        String dns = "http://gudi.iptime.org:10900/resources/upload/" + fileNm;
	        URLEncoder.encode(dns, "UTF-8");
	        File f = new File(path);
	        OutputStream out = new FileOutputStream(f);
	        out.write(bytes);
	        out.close();	
	        
	        param.put("id", id);
			param.put("photo_dns",dns);
			param.put("photo_path",path);
			param.put("sqlType","user.userUpdate_photo");
			param.put("sql","update");
			up_user.put("photo_dns",dns);
			
		}
		session.setAttribute("user", up_user);
		di.call(param);
		
		return "redirect:/see_something";
	}
	
	@RequestMapping("/deleteuser")
	public ModelAndView deleteuser(HttpServletRequest request) {
		HashMap<String,Object> param = HttpUtil.getParamMap(request);
		param.put("sqlType","user.deleteuser");
		param.put("sql","update");
		String id = request.getParameter("id");
		param.put("id",id);
		
		if(id.equals("admin123")) {
			param.put("status",0);
			param.put("msg","YOU CANNOT LEAVE");	
		}else {
			int status =(int)di.call(param);
			param.put("status",status);
			param.put("msg","BYE BYE :(");
		}
        return HttpUtil.makeJsonView(param);
    }
	
	@RequestMapping("/checkId")
    public @ResponseBody int idCheck(HttpServletRequest request) {
		HashMap<String,Object> param = HttpUtil.getParamMap(request);
		
		param.put("sqlType","user.checkId");
		param.put("sql","selectOne");
		
		int status = (int)di.call(param);
		
		int result=0;
		
		if(status!=0) result=1;
		
        return result;
    }
	
}
