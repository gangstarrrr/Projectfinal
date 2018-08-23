package com.java.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.dao.DaoInterface;
import com.java.web.util.FinalUtil;
import com.java.web.util.HttpUtil;


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
	public String	userInsert(HttpServletRequest request) {
		HashMap<String,Object> param = HttpUtil.getParamMap(request);
		param.put("sqlType","user.userInsert");
		param.put("sql","insert");
		
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
			map.put("msg","PLZ CHECK YOU ID AND PASSWORD");
		}else {
			session.setAttribute("status", FinalUtil.OK);
			map.put("status", FinalUtil.OK);
			map.put("msg","HELLO "+resultMap.get("name")+".");
		}
		session.setAttribute("user", resultMap);
		return HttpUtil.makeJsonView(map);
	}
	
	@RequestMapping("/infoupdate")
	public String infoupdate(HttpServletRequest request,HttpSession session) {
		HashMap<String,Object> param = HttpUtil.getParamMap(request);

		param.put("sqlType","user.userUpdate");
		param.put("sql","update");
		
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
		
		if(id.equals("admin")) {
			param.put("status",0);
			param.put("msg","YOU CANNOT LEAVE");	
		}else {
			int status =(int)di.call(param);
			param.put("status",status);
			param.put("msg","BYE BYE");
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
	
	@RequestMapping("/checkpw")
	public @ResponseBody int checkpw(HttpServletRequest request) {
		HashMap<String,Object> param = HttpUtil.getParamMap(request);
		param.put("sqlType","user.checkpw");
		param.put("sql","selectOne");
		
		int status = (int)di.call(param);
		int result=0;
		
		if(status!=0) result=1;
        return result;
    }
}
