package com.java.web.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.java.web.dao.DaoInterface;
import com.java.web.util.FinalUtil;
import com.java.web.util.HttpUtil;

@Service
public class ServiceBoard {

	@Autowired
	DaoInterface di;
	
	public ModelAndView boardlist(HttpServletResponse response) throws IOException{
		HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("sqlType", "board.boardlist");
    	param.put("sql", "selectList");
    	List list = (List) di.call(param);
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("list", list);
		
		return HttpUtil.makeJsonView(resultMap);
	}
	
	public ModelAndView insertboard(HttpServletRequest request, HttpSession session) {
		HashMap<String, Object> param = HttpUtil.getParamMap(request);
		param.put("sqlType","board.boardinsert");
		param.put("sql","insert");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		try {
			String ret_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date(request.getParameter("ret_date")));
			String dep_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date(request.getParameter("dep_date")));
			
			param.put("ret_date", ret_date);
			param.put("dep_date", dep_date);
			
			int status = (int)di.call(param);
			
			
			if(status==1) {
				map.put("status", FinalUtil.OK);
				map.put("msg","SUCCESS TO INSERT YOUR BOARD :)");
			}else {
				map.put("status", FinalUtil.NO);
				map.put("msg","FAIL TO INSERT YOUR BOARD :(");
			}
		}catch (Exception e) {
			map.put("status", "");
			map.put("msg","INSERT EXCALTLY YOUR DATE :(");
		}
		

		return HttpUtil.makeJsonView(map);
	}
	
	public ModelAndView deleteboard(HttpServletRequest request, HttpSession session) {
		String no = request.getParameter("no");
		
		HashMap<String, Object> param = (HashMap<String, Object>)session.getAttribute("user");
		String id=param.get("id").toString();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("no", no);
		
		if(id.equals("admin123")) {
			map.put("sqlType","board.deleteboardadmin");
			map.put("sql","update");
		}else {
			map.put("id", id);
			map.put("sqlType","board.deleteboard");
			map.put("sql","update");
		}
		int status =  (int) di.call(map);
		
		if(status==0) {
			map.put("status", FinalUtil.NO);
			map.put("msg","NOT YOUR PERMITTION :(");
		}else if(status==1) {
			map.put("status", FinalUtil.OK);
			map.put("msg","SUCCESS TO DELETE :)");
		}
		
		
		return HttpUtil.makeJsonView(map);
	}
	
	public ModelAndView updateboard(HttpServletRequest request, HttpSession session) {
		
		HashMap<String, Object> map = HttpUtil.getParamMap(request);
		HashMap<String, Object> param = (HashMap<String, Object>)session.getAttribute("user");
		String id=param.get("id").toString();
		String no =request.getParameter("no");
		try {
			String ret_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date(request.getParameter("ret_date")));
			String dep_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date(request.getParameter("dep_date")));
			
			map.put("ret_date", ret_date);
			map.put("dep_date", dep_date);
			
			map.put("no", no);
			map.put("id", id);
			
			map.put("sqlType","board.updateboard");
			map.put("sql","update");

			
			int status =  (int) di.call(map);
			
			if(status==1) {
				map.put("status", FinalUtil.OK);
				map.put("msg","SUCCESS TO UPDATE YOUR BOARD :)");
			}else {
				map.put("status", FinalUtil.NO);
				map.put("msg","NOT YOUR PERMITTION :(");
			}
		}catch (Exception e) {
			map.put("status", "");
			map.put("msg","INSERT EXCALTLY YOUR DATE :(");
		}
	
		return HttpUtil.makeJsonView(map);
	}
	
	public ModelAndView sendsessage(HttpServletRequest request, HttpSession session) {
		HashMap<String, Object> map = HttpUtil.getParamMap(request);

		map.put("sqlType","board.sendmessage");
		map.put("sql","update");
		
		int status =  (int) di.call(map);
		if(status==1) {
			map.put("status", FinalUtil.OK);
			map.put("msg","SUCCESS TO SEND A MESSAGE :)");
		}else {
			map.put("status", FinalUtil.NO);
			map.put("msg","FAIL TO SEND A MESSAGE :(");
		}
		
		return HttpUtil.makeJsonView(map);
	}
	
	public ModelAndView messagelist_to(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HashMap<String, Object> param = new HashMap<String, Object>();
    	String id =request.getParameter("id");
    	param.put("to_",id);
		param.put("sqlType", "board.messagelist_to");
    	param.put("sql", "selectList");
    	List list = (List) di.call(param);
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("list", list);
		
		return HttpUtil.makeJsonView(resultMap);
	}
	
	public ModelAndView messagelist_from(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HashMap<String, Object> param = new HashMap<String, Object>();
    	String id =request.getParameter("id");
    	param.put("from_",id);
		param.put("sqlType", "board.messagelist_from");
    	param.put("sql", "selectList");
    	List list = (List) di.call(param);
    	HashMap<String, Object> resultMap = new HashMap<String, Object>();
    	resultMap.put("list", list);
		
		return HttpUtil.makeJsonView(resultMap);
	}
	
	public ModelAndView deletemessage(HttpServletRequest request,HttpServletResponse response) throws IOException{
		HashMap<String, Object> param = new HashMap<String, Object>();
    	String no =request.getParameter("no");
    	param.put("no",no);
		param.put("sqlType", "board.deletemessage");
    	param.put("sql", "update");
    	di.call(param);
    	param.put("msg","SUCCESS TO DELETE :)");
		
		return HttpUtil.makeJsonView(param);
	}
	
}
